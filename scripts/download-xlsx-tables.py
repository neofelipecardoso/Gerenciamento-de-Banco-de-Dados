import re
from pathlib import Path
import requests
import time
from typing import Iterator

URLS_FILE = "urls.txt"
DOWNLOAD_DIR = Path("datasets_xlsx")

EXPECTED_FILENAME_PATTERN = re.compile(r"^tabela\d+\.xlsx$", re.IGNORECASE)
ENCODING = "utf-8"

REQUEST_DELAY_SEC = 0.1
TIMEOUT = 30
CHUNK_SIZE_BYTES = 64 * 1024


def extract_filename_from_cd_header(content_disposition: str | None) -> str | None:
    if not content_disposition or "filename=" not in content_disposition:
        return None

    name = content_disposition.split("filename=", 1)[1]
    name = name.split(";")[0].strip()
    name = name.strip().strip("\"'")

    return name if name else None


def validate_filename(name: str) -> str:
    basename = Path(name).name

    if EXPECTED_FILENAME_PATTERN.match(basename):
        return basename

    raise ValueError(f"Filename doesn't match with expected pattern: '{basename}'.")


def get_safe_filename_from_response(response: requests.Response) -> str:
    content_disposition = response.headers.get("content-disposition")
    raw_filename = extract_filename_from_cd_header(content_disposition)

    if not raw_filename:
        raise ValueError(
            f"Could not determine filename from response headers for: '{response.url}'"
        )

    return validate_filename(raw_filename)


def fetch_response(url: str) -> requests.Response:
    time.sleep(REQUEST_DELAY_SEC)

    resp = requests.get(url, timeout=TIMEOUT, stream=True)
    resp.raise_for_status()

    return resp


def save_response_to_file(response: requests.Response, output_path: Path) -> None:
    with open(output_path, "wb") as f:
        chunk_iter: Iterator[bytes] = response.iter_content(chunk_size=CHUNK_SIZE_BYTES)
        for chunk in chunk_iter:
            if chunk:
                f.write(chunk)


def download_file_from_url(url: str) -> None:
    try:
        response = fetch_response(url)
        safe_filename = get_safe_filename_from_response(response)
        output_path = Path(DOWNLOAD_DIR / safe_filename)

        if output_path.exists():
            print(f"⚠️  File already exists, skipping: '{output_path.name}'")
            return

        save_response_to_file(response, output_path)
        print(f"✅ '{output_path.name}'")

    except Exception as e:
        print(f"❌ {url}: {e}")
        raise


def ensure_url_file_exists(filepath: str) -> None:
    if not Path(filepath).is_file():
        raise FileNotFoundError(f"Missing required file: '{filepath}'")


def parse_and_validate_urls(lines: list[str]) -> list[str]:
    urls: list[str] = []
    invalid_urls: list[str] = []

    for line in lines:
        stripped = line.strip()

        if stripped and not stripped.startswith("#"):
            if stripped.startswith(("http://", "https://")):
                urls.append(stripped)
            else:
                invalid_urls.append(stripped)

    if not urls:
        raise ValueError("No URLs to download")

    if invalid_urls:
        invalid_urls_list = "'\n  - '".join(sorted(invalid_urls))
        raise ValueError(f"Invalid URLs found:\n  - '{invalid_urls_list}'")

    seen: set[str] = set()
    duplicates: list[str] = [url for url in urls if url in seen or seen.add(url)]

    if duplicates:
        duplicates_list = "'\n  - '".join(sorted(duplicates))
        raise ValueError(f"Duplicate URLs found:\n  - '{duplicates_list}'")

    return urls


def main():
    print("Starting 'download-tables.py'...")

    ensure_url_file_exists(URLS_FILE)

    with open(URLS_FILE, encoding=ENCODING) as f:
        lines = f.readlines()

    urls = parse_and_validate_urls(lines)

    Path(DOWNLOAD_DIR).mkdir(exist_ok=True)

    for url in urls:
        download_file_from_url(url)

    print("Done")


if __name__ == "__main__":
    main()
