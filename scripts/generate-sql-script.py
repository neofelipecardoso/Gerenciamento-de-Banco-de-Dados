from pathlib import Path
import re
import pandas as pd

INPUT_DIR = Path("datasets_tsv")
DELIMITER = "\\t"
OUTPUT_FILE = Path("V0__Insert_raw_tables.sql")
BULK_INSERT_PATH = Path("/datasets")
EXPECTED_PATTERN = re.compile(r"^tabela\d+\.tsv$", re.IGNORECASE)
ENCODING = "utf-8"
ROW_TERMINATOR = "0x0A" # \n
COLUMNS_TYPE = "VARCHAR(MAX) COLLATE Latin1_General_100_CI_AS_SC_UTF8"


def generate_columns(file: Path) -> list[str]:
    df = pd.read_csv(file, sep=DELIMITER, encoding=ENCODING, engine="python")
    num_cols = len(df.columns)

    return [f"[Col{i}] {COLUMNS_TYPE}" for i in range(1, num_cols + 1)]


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
        raise ValueError(f"Name doesn't match with expected pattern: {name!r}.")


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
