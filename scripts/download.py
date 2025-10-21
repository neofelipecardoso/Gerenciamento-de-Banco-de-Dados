import os
import re
from pathlib import Path
import requests
import time

EXPECTED_PATTERN = re.compile(r"^tabela\d+\.csv$", re.IGNORECASE)
URLS_FILE = "urls.txt"
DOWNLOAD_DIR = "downloads"
TIMEOUT = 30
ENCODING = "utf-8"


def get_filename_from_header(cd: str | None) -> str | None:
    if not cd or "filename=" not in cd:
        return None
    name = cd.split("filename=", 1)[1]
    name = name.split(";")[0].strip()
    name = name.strip().strip("\"'")
    return name if name else None


def validate_filename(name: str) -> str:
    basename = os.path.basename(name)
    if EXPECTED_PATTERN.match(basename):
        return basename
    raise ValueError(f"Filename doesn't match with expected pattern: '{basename}'.")


def fetch_response(url: str) -> requests.Response:
    time.sleep(1)
    resp = requests.get(url, timeout=TIMEOUT, stream=True)
    resp.raise_for_status()
    return resp


def get_filename_from_response(resp: requests.Response) -> str:
    content_disposition = resp.headers.get("content-disposition")
    raw_filename = get_filename_from_header(content_disposition)
    if not raw_filename:
        raise ValueError(
            f"Could not determine filename from response headers for: '{resp.url}'"
        )
    return validate_filename(raw_filename)


def save_response_to_file(resp: requests.Response, output_path: Path) -> None:
    with open(output_path, "wb") as f:
        for chunk in resp.iter_content(chunk_size=8192):
            if chunk:
                _ = f.write(chunk)


def download_one(url: str) -> None:
    try:
        resp = fetch_response(url)
        safe_filename = get_filename_from_response(resp)
        output_path = Path(DOWNLOAD_DIR) / safe_filename

        if output_path.exists():
            print(f"⚠️  File already exists, skipping: '{output_path.name}'")
            return

        output_path.parent.mkdir(parents=True, exist_ok=True)

        save_response_to_file(resp, output_path)

        print(f"✅ '{output_path.name}'")

    except Exception as e:
        print(f"❌ {url}: {e}")
        raise


def ensure_file_exists(filepath: str) -> None:
    if not os.path.isfile(filepath):
        raise FileNotFoundError(f"Missing '{filepath}'")


def parse_urls(lines: list[str]) -> list[str]:
    urls = list[str]()
    invalid_urls = list[str]()
    for line in lines:
        stripped = line.strip()
        if stripped and not stripped.startswith("#"):
            if not stripped.startswith(("http://", "https://")):
                invalid_urls.append(stripped)
            urls.append(stripped)
    if not urls:
        raise ValueError("No URLs to download")
    if invalid_urls:
        invalid_urls_list = "'\n  - '".join(sorted(invalid_urls))
        raise ValueError(f"Remove invalid URLs has found:\n  - '{invalid_urls_list}'")
    return urls


def detect_duplicates(urls: list[str]) -> None:
    seen = set[str]()
    duplicates = list[str]()

    for url in urls:
        if url in seen:
            duplicates.append(url)
        else:
            seen.add(url)

    if duplicates:
        duplicates_list = "'\n  - '".join(sorted(duplicates))
        raise ValueError(f"Remove duplicates URLs:\n  - '{duplicates_list}'")


def main():
    print("Starting...")

    ensure_file_exists(URLS_FILE)

    with open(URLS_FILE, encoding=ENCODING) as f:
        lines = f.readlines()

    urls = parse_urls(lines)

    Path(DOWNLOAD_DIR).mkdir(exist_ok=True)

    detect_duplicates(urls)

    for url in urls:
        download_one(url)

    print("Done.")


if __name__ == "__main__":
    main()
