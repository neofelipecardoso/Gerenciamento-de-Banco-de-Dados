import requests
import time

OUTPUT_FILE = "urls.txt"

IDS = [
    7138,
    7139,
    7109,
    7110,
    7113,
    7111,
    7126,
    7127,
    7395,
    7128,
    4708,
    4361,
    4666,
    7128,
    7129,
    6407,
    7339,
    7138,
    6407,
    7320,
    7321,
    7307,
    7395,
    9297,
    9311,
    4361,
    7138,
    9552,
    9558,
    9499,
    9506,
    7128,
    7136,
    7161,
    7307,
    7395,
    7126,
    7133,
    7127,
    7134,
    7215,
    6821,
    7219,
    7220,
    7221,
    7222,
    7159,
    7160,
    7161,
    7395,
    7210,
    7211,
    4666,
    7177,
    7178,
    7128,
    7111,
    6409,
    6407,
    7128,
    7135,
    6731,
    6732,
    6733,
    6734,
    6735,
    6736,
    6737,
    7307,
    7146,
    7147,
    6407,
]


def fetch_response(id: int) -> requests.Response:
    time.sleep(0.5)
    resp = requests.get(
        f"https://servicodados.ibge.gov.br/api/v3/agregados/{id}/metadados", timeout=30
    )
    resp.raise_for_status()
    return resp


def get_url(data):
    id = data["id"]
    variavel = data["variaveis"][0]["id"]

    niveis_territoriais = data["nivelTerritorial"]["Administrativo"]
    nivel_territorial = next(
        # Prioridade: estados (N3) > região (N2) > Brasil (N1)
        (nivel for nivel in ("N3", "N2", "N1") if nivel in niveis_territoriais),
        "ERROR",
    )
    if nivel_territorial == "ERROR":
        return f"# ERROR: ID {id} — nível territorial não encontrado"
    else:
        nivel_territorial = nivel_territorial.lower()

    classificacoes = []
    for classificacao in data["classificacoes"]:
        classificacoes.append(classificacao["id"])
    return build_url(id, variavel, nivel_territorial, classificacoes)


def build_url(
    id: int, variavel: str, nivel_territorial: str, classificacoes: list[str]
) -> str:
    base = f"https://sidra.ibge.gov.br/geratabela?format=br.csv&name=tabela{id}.csv&terr=N&rank=-&query=t/{id}/{nivel_territorial}/all/v/{variavel}/p/all"
    query = ""

    qtd_classificacoes = len(classificacoes)
    if not classificacoes:
        query = f"d/v{variavel}%201/l/v,p,t&measurecol=true"
    else:
        c_parts = "/".join(f"c{c}/allxt" for c in classificacoes)
        if qtd_classificacoes == 1:
            l_part = f"l/v,p%2Bc{classificacoes[0]},t"
        elif qtd_classificacoes == 2:
            l_part = f"l/v,p%2Bc{classificacoes[0]},t%2Bc{classificacoes[1]}"
        elif qtd_classificacoes == 3:
            l_part = f"l/v,p%2Bc{classificacoes[0]}%2Bc{classificacoes[1]},t%2Bc{classificacoes[2]}"
        else:
            return "# ERROR"
        query = f"{c_parts}/{l_part}&measurecol=true"

    return f"{base}/{query}"


def main():
    print("Starting...")

    print(f"all IDs ({len(IDS)}): '{IDS}'")

    unique_ids = list(dict.fromkeys(IDS))

    print(f"unique IDs ({len(unique_ids)}): '{unique_ids}'")

    with open(OUTPUT_FILE, "w") as file:
        urls = []
        for id in unique_ids:
            try:
                print(f"Processing ID '{id}'")
                response = fetch_response(id)
                data = response.json()
                url = get_url(data)
                urls.append(url)
            except Exception as e:
                print(f"Error processing ID {id}: {e}")
                urls.append(f"# ERROR (ID {id}): {e}")
        text_to_write = "\n\n".join(urls)
        file.write(text_to_write)
        print("File created")

    print("Done")


if __name__ == "__main__":
    main()
