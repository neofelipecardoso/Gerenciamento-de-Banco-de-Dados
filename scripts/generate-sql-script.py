from pathlib import Path
import re

INPUT_DIR = Path("datasets_tsv")
DELIMITER = "\t"
OUTPUT_FILE = Path("V0__Insert_raw_tables.sql")
BULK_INSERT_PATH = Path("/datasets")
EXPECTED_PATTERN = re.compile(r"^tabela\d+\.tsv$", re.IGNORECASE)
ENCODING = "utf-8"
ROW_TERMINATOR = "0x0A"  # \n
COLUMNS_TYPE = "VARCHAR(MAX) COLLATE Latin1_General_100_CI_AS_SC_UTF8"


def sanitize_column_name(name: str) -> tuple[str, str]:
    sanitized = "".join(c for c in name if c.isprintable())
    if not sanitized:
        raise ValueError(f"Invalid column name: '{name}'")

    max_length = 128
    if len(sanitized) <= max_length:
        return sanitized, sanitized

    keep_start = max_length // 2
    keep_end = max_length - keep_start - 3
    truncated = f"{sanitized[:keep_start]}...{sanitized[-keep_end:]}"

    return truncated, sanitized


def extract_multilevel_header(file: Path) -> tuple[list[str], list[str]]:
    data_init = {"Rondônia", "Norte", "Brasil"}
    lines = []
    with open(file, "r", encoding=ENCODING) as f:
        for line in f:
            stripped = line.rstrip("\n")
            if stripped.split(DELIMITER)[0] in data_init:
                break
            lines.append(stripped)

    if not lines:
        raise ValueError("No valid header found")

    header = [[col.strip() for col in line.split(DELIMITER)] for line in lines]
    columns = list(zip(*header))

    first_col_set = set(columns[0])
    is_national = first_col_set == {""}

    if is_national:
        if len(columns) < 2:
            raise ValueError("First column has no name and is unique")
        if not all(cell != "" for cell in columns[1]):
            raise ValueError("Only national level can has no name in first column")
    elif first_col_set not in [{"Unidade da Federação"}, {"Grande Região"}]:
        raise ValueError(f"Invalid first column: '{first_col_set}'")

    truncated_headers = []
    full_headers = []
    seen_truncated = {}
    
    for col_idx, col in enumerate(columns):
        parts = []
        for value in col:
            value = value.strip()
            if value and (not parts or value != parts[-1]):
                parts.append(value)

        if col_idx == 0 and is_national and not parts:
            parts = ["País"]

        full_name = " x ".join(parts)

        if len(full_name) > 128:
            truncated, original = sanitize_column_name(full_name)
            
            # Garantir unicidade
            if truncated in seen_truncated:
                counter = seen_truncated[truncated] + 1
                seen_truncated[truncated] = counter
                truncated = f"{truncated[:125]}_{counter}"
            else:
                seen_truncated[truncated] = 1
            
            truncated_headers.append(truncated)
            full_headers.append(original)
        else:
            if full_name in seen_truncated:
                counter = seen_truncated[full_name] + 1
                seen_truncated[full_name] = counter
                truncated_headers.append(f"{full_name[:125]}_{counter}")
            else:
                seen_truncated[full_name] = 1
                truncated_headers.append(full_name)
            full_headers.append(full_name)

    return truncated_headers, full_headers


def unpivot_header(
    truncated_header: list[str], full_header: list[str], table_name: str
) -> str:
    if not truncated_header:
        return ""

    fixed_cols = []
    unpivot_col_truncated = []
    col_name = []
    col_value = []

    for trunc_h, full_h in zip(truncated_header, full_header):
        parts_trunc = trunc_h.split(" x ")
        parts_full = full_h.split(" x ")

        half = len(parts_full) // 2

        if half == 0:
            fixed_cols.append(f"[{parts_trunc[0]}]")
        else:
            unpivot_col_truncated.append(trunc_h)
            col_name.append(parts_full[:half])
            col_value.append(parts_full[half:])

    if not unpivot_col_truncated:
        return ""

    unpivoted_name = [f"[{name}]" for name in col_name[0]]

    unpivoted_table_name = f"{table_name}_unpivoted"

    select_parts = (
        fixed_cols + [f"unpvt.{name}" for name in unpivoted_name] + ["unpvt.[Valor]"]
    )
    select_clause = ",\n    ".join(select_parts)

    values_lines = []
    for idx, values in enumerate(col_value):
        formatted_values = [f"'{v}'" for v in values]
        original_col = unpivot_col_truncated[idx]

        line = f"\t\t({', '.join(formatted_values)}, [{original_col}])"
        values_lines.append(line)

    values_clause = ",\n".join(values_lines)
    unpvt_columns = ", ".join(unpivoted_name + ["[Valor]"])

    where_clause = ""
    if fixed_cols:
        first_fixed = fixed_cols[0]
        where_clause = f"\nWHERE {first_fixed} COLLATE Latin1_General_BIN <> '{first_fixed[1:-1]}';"
    else:
        where_clause = ";"

    return f"""SELECT
    {select_clause}
INTO {unpivoted_table_name}
FROM {table_name}
CROSS APPLY (
    VALUES
{values_clause}
) AS unpvt ({unpvt_columns}){where_clause}"""


def generate_columns(raw_header: list[str]) -> list[str]:
    return [f"[{name}] {COLUMNS_TYPE}" for name in raw_header]


def generate_script(file: Path, col: list[str], unpivoted_header: str) -> str:
    table_name = file.stem.lower()
    return f"""
-- ========================== {table_name} ==========================

CREATE TABLE [{table_name}] (
    {",\n    ".join(col)}
);
GO

BULK INSERT [{table_name}]
FROM '{Path(BULK_INSERT_PATH / file.name)}'
WITH (
    FIELDTERMINATOR = {repr(DELIMITER)},
    ROWTERMINATOR = '{ROW_TERMINATOR}',
    FIRSTROW = 1,
    CODEPAGE = 'RAW',
    TABLOCK
);
GO

{unpivoted_header}
GO
"""


def validate_file_name(name: str):
    if not EXPECTED_PATTERN.match(name):
        raise ValueError(f"Name doesn't match with expected pattern: '{name}'")


def main():
    print("Starting 'generate-sql-script.py'...")

    if not INPUT_DIR.exists():
        raise FileNotFoundError(f"Input directory not found: {INPUT_DIR}")

    files = sorted(INPUT_DIR.glob("*"))
    with open(OUTPUT_FILE, "w", encoding=ENCODING) as f:
        for file in files:
            try:
                if not file.is_file():
                    raise ValueError(
                        "The input directory must contain only table files."
                    )

                print(f"Processing {file}")

                validate_file_name(file.name)

                truncated_header, full_header = extract_multilevel_header(file)
                sql_col_list = generate_columns(truncated_header)
                unpivoted_header = unpivot_header(
                    truncated_header, full_header, file.stem
                )

                sql_script = generate_script(file, sql_col_list, unpivoted_header)

                f.write(sql_script)

            except Exception as e:
                raise RuntimeError(f"Error processing the file {file}: {e}")

    print("Done")


if __name__ == "__main__":
    main()
