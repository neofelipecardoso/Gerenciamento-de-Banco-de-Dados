import pandas as pd
import os

# --- Configurações ---
# Diretório onde estão seus arquivos TSV originais
INPUT_DIR = './datasets_tsv' 
# Diretório onde os novos arquivos transformados serão salvos
OUTPUT_DIR = './datasets_output' 
# Extensão de saída, definindo o formato de arquivo (TSV)
OUTPUT_EXTENSION = 'tsv' 

# Cria os diretórios de entrada e saída se não existirem
if not os.path.exists(INPUT_DIR):
    os.makedirs(INPUT_DIR)
    print(f"Diretório de entrada '{INPUT_DIR}' criado. Por favor, coloque seus arquivos TSV nele.")
if not os.path.exists(OUTPUT_DIR):
    os.makedirs(OUTPUT_DIR)

# Coluna de identificação que será mantida no formato 'longo'
ID_COLUMN_NAME = 'Unidade da Federação' 

# --- Função de Transformação ---

def transformar_e_salvar(file_path):
    """
    Lê um arquivo TSV (separador tab), converte para o formato 'longo', extrai o nome da variável
    e salva o resultado em um arquivo TSV separado (separador tab).
    """
    input_filename = os.path.basename(file_path)
    print(f"Processando arquivo: {input_filename}")
    
    # 1. Leitura do cabeçalho para extrair o nome da variável (Lendo com sep='\t')
    try:
        df_header = pd.read_csv(file_path, sep='\t', header=None, nrows=1)
        value_col_name_raw = df_header.iloc[0, 0]
        value_col_name = value_col_name_raw.split(' - ')[-1].split('(')[0].strip().replace(' ', '_').replace('.', '').replace('-', '_')
        value_col_name = value_col_name if value_col_name else 'Valor_Observado'
    except Exception as e:
        print(f"Erro ao extrair o nome da variável de {input_filename}. Usando 'Valor_Observado'. Erro: {e}")
        value_col_name = 'Valor_Observado'
        
    # 2. Leitura dos dados principais (cabeçalho real está na 4ª linha, índice 3) (Lendo com sep='\t')
    try:
        df = pd.read_csv(file_path, sep='\t', header=3)
    except Exception as e:
        print(f"ERRO: Não foi possível ler o arquivo {input_filename}. Pulando. Erro: {e}")
        return

    # 3. Preparação das Colunas
    df = df.rename(columns={df.columns[0]: 'Unidade_da_Federacao'})

    def normalize_col_name(col):
        if isinstance(col, (float, int)):
            return str(int(col))
        elif isinstance(col, str) and col.endswith('.0'):
            return col.replace('.0', '')
        return col

    df.columns = [normalize_col_name(col) for col in df.columns]

    id_vars = ['Unidade_da_Federacao']
    value_vars = [col for col in df.columns if col.isdigit() and len(col) == 4] 

    if not value_vars:
        print(f"Aviso: Nenhuma coluna de ano válida encontrada em {input_filename}. Pulando.")
        return
        
    # 4. Transformação (Wide para Long)
    df_long = pd.melt(
        df,
        id_vars=id_vars,
        value_vars=value_vars,
        var_name='Ano',
        value_name='Valor' 
    )

    # 5. Adiciona a coluna da variável e Limpeza
    df_long['Variavel_Nome'] = value_col_name
    df_long['Ano'] = df_long['Ano'].astype(int)
    df_long['Valor'] = pd.to_numeric(df_long['Valor'], errors='coerce')
    df_long = df_long.dropna(subset=['Valor'])

    # 6. Salvamento do arquivo
    
    base_name = os.path.splitext(input_filename)[0]
    output_filename = f"{base_name}.{OUTPUT_EXTENSION}"
    output_path = os.path.join(OUTPUT_DIR, output_filename)
    
    # *** USANDO O TAB (\t) COMO SEPARADOR NO OUTPUT ***
    df_long.to_csv(output_path, sep='\t', index=False)
        
    print(f"-> Salvo em: {output_path}")


# --- Execução Principal ---

tsv_files = [
    os.path.join(INPUT_DIR, f) 
    for f in os.listdir(INPUT_DIR) 
    if f.endswith('.tsv')
]

if not tsv_files:
    print(f"\nERRO: Nenhum arquivo .tsv encontrado no diretório: {INPUT_DIR}")
    print("Verifique se os arquivos estão na pasta correta e se o nome do diretório está certo.")
else:
    print(f"\nIniciando o processamento de {len(tsv_files)} arquivos...")
    
    for file_path in tsv_files:
        transformar_e_salvar(file_path)

    print("\n--- Processamento em Lote Concluído ---")
    print(f"Verifique os arquivos transformados no diretório: {OUTPUT_DIR}")