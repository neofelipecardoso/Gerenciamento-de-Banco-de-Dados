from pathlib import Path
import re

INPUT_DIR = Path("downloads")
DELIMITER = ";"
OUTPUT_FILE = Path("script.sql")
EXPECTED_PATTERN = re.compile(r"^tabela\d+$", re.IGNORECASE)
ENCODING = "utf-8"
ROW_TERMINATOR = "\\n"


def count_columns(file: Path) -> int:
    max_cols = 0
    try:
        with open(file, "r", encoding=ENCODING) as f:
            for line in f:
                stripped = line.strip()
                if stripped:
                    max_cols = max(max_cols, len(stripped.split(DELIMITER)))
    except Exception as e:
        raise RuntimeError(f"Error processing the file {file}: {e}")
    if max_cols == 0:
        raise ValueError("The file hasn't any columns")
    return max_cols


def generate_columns(max_cols: int) -> list[str]:
    return [
        f"[Col{i}] VARCHAR(MAX) COLLATE Latin1_General_100_BIN2_UTF8"
        for i in range(1, max_cols + 1)
    ]


def generate_script(file: Path, col: list[str], table_name: str) -> str:
    return f"""
CREATE TABLE [{table_name}] (
    {",\n    ".join(col)}
);
GO

BULK INSERT [{table_name}]
FROM '{set_absolute_path(file)}'
WITH (
    FIELDTERMINATOR = '{DELIMITER}',
    ROWTERMINATOR = '{ROW_TERMINATOR}',
    FIRSTROW = 1,
    CODEPAGE = 'RAW'
);
GO
"""


def validate_table_name(name: str):
    if not EXPECTED_PATTERN.match(name):
        raise ValueError(f"Name doesn't match with expected pattern: {name!r}.")


def set_absolute_path(file: Path) -> str:
    absolute_path = str(file.resolve())
    return absolute_path.replace("\\", "\\\\").replace("'", "''")


def main():
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
                table_name = file.stem
                validate_table_name(table_name)
                num_col = count_columns(file)
                col_list = generate_columns(num_col)
                sql_script = generate_script(file, col_list, table_name)
                _ = f.write(sql_script)
            except Exception as e:
                raise RuntimeError(f"Error processing the file {file}: {e}")


if __name__ == "__main__":
    main()
