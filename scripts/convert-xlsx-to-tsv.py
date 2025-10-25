from pathlib import Path
import pandas as pd
import csv

INPUT_DIR = Path("datasets_xlsx")
ENCODING = "utf-8"
LINETERMINATOR = "\n"
OUTPUT_DIR = Path("datasets_tsv")


def main():
    print("Starting 'convert-xlsx-to-tsv.py'...")
    
    files = sorted(INPUT_DIR.glob("*"))
    
    OUTPUT_DIR.mkdir(exist_ok=True)
    
    for file in files:
        if not file.suffix.lower() == ".xlsx" or not file.is_file():
            raise ValueError(
                f"The input directory must contain only XLSX files.: {file}"
            )
            
        output_file = OUTPUT_DIR / file.name.replace(".xlsx", ".tsv")
        
        print(f"Converting '{file}' to '{output_file}'")
        
        df = pd.read_excel(file, sheet_name=0)
        
        df.to_csv(
            output_file,
            sep="\t",
            index=False,
            encoding=ENCODING,
            lineterminator=LINETERMINATOR,
            quoting=csv.QUOTE_MINIMAL,
        )
    
    print("Done")    


if __name__ == "__main__":
    main()
