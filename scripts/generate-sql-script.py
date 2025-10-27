from pathlib import Path
import re
import pandas as pd

INPUT_DIR = Path("datasets_tsv")
DELIMITER = "\t"
OUTPUT_FILE = Path("V0__Insert_raw_tables.sql")
BULK_INSERT_PATH = Path("/datasets")
EXPECTED_PATTERN = re.compile(r"^tabela\d+\.tsv$", re.IGNORECASE)
ENCODING = "utf-8"
ROW_TERMINATOR = "0x0A"  # \n
COLUMNS_TYPE = "VARCHAR(MAX) COLLATE Latin1_General_100_CI_AS_SC_UTF8"


def sanitize_column_name(name: str) -> str:
    sanitized = "".join(c for c in name if c.isprintable())
    sanitized = re.sub(r"[^\w]", "_", sanitized)
    if not sanitized:
        raise ValueError(f"Invalid column name: '{name}'")
    if sanitized[0].isdigit():
        sanitized = "_" + sanitized
    return sanitized


def extract_multilevel_header(file: Path) -> list[str]:
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

    finals_headers = []
    for col_idx, col in enumerate(columns):
        parts = []
        for value in col:
            value = value.strip()
            if value and (not parts or value != parts[-1]):
                parts.append(value)
        if col_idx == 0 and is_national and not parts:
            parts = ["País"]
        finals_headers.append(" x ".join(parts))

    return finals_headers


def generate_columns(file: Path) -> list[str]:
    raw_headers = extract_multilevel_header(file)
    sanitized_headers = [sanitize_column_name(header) for header in raw_headers]
    return [f"[{name}] {COLUMNS_TYPE}" for name in sanitized_headers]


def generate_script(file: Path, col: list[str]) -> str:
    table_name = file.stem.lower()
    return f"""
CREATE TABLE [{table_name}] (
    {",\n    ".join(col)}
);
GO

BULK INSERT [{table_name}]
FROM '{Path(BULK_INSERT_PATH / file.name)}'
WITH (
    FIELDTERMINATOR = '{DELIMITER}',
    ROWTERMINATOR = '{ROW_TERMINATOR}',
    FIRSTROW = 1,
    CODEPAGE = 'RAW',
    TABLOCK
);
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

                validate_file_name(file.name)

                sql_col_list = generate_columns(file)
                sql_script = generate_script(file, sql_col_list)

                print(f"Processing {file}")

                f.write(sql_script)

            except Exception as e:
                raise RuntimeError(f"Error processing the file {file}: {e}")

    print("Done")


if __name__ == "__main__":
    main()
