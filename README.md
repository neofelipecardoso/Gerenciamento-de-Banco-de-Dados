# Gerenciamento-de-Banco-de-Dados

Este projeto tem o objetivo de utilizar análise de dados de datasets utilizando T-SQL no SQL Server, a fim de responder perguntas relacionadas a educação no Brasil.

## Trello

https://trello.com/b/A56DuRJG/gerenciamento-de-banco-de-dados

## Perguntas

A seguir estão perguntas as quais a análise de dados usando os datasets deve responder:

1. **Em quais estados há maior proporção de adolescentes de 15 a 17 anos fora da escola, e como isso varia conforme a cor ou raça?**  
   *Tabelas:* 7138, 7139, 7109, 7110

2. **Qual é a taxa de analfabetismo da população com 15 anos ou mais por estado, e como ela varia entre homens e mulheres?**  
   *Tabelas:* 7113, 7111

3. **Qual é o número médio de anos de estudo da população com 25 anos ou mais por estado, e como isso se correlaciona com o rendimento médio domiciliar?**  
   *Tabelas:* 7126, 7127, 7395

4. **Em quais estados a informalidade no trabalho é mais comum entre jovens de 18 a 24 anos sem ensino superior?**  
    *Tabelas:* 7128, 4708, 4361

5. **Qual é o rendimento médio mensal de pessoas com ensino superior completo comparado às com ensino médio incompleto, por estado?**  
    *Tabelas:* 4666, 7128/7129, 6407

6. **Em quais estados há maior acesso a microcomputador ou tablet em domicílios com crianças em idade escolar, e como isso se relaciona com a taxa de escolarização?**  
    *Tabelas:* 7339, 7138, 6407

7. **Qual é a proporção de estudantes de 10 a 17 anos que utilizam a internet para atividades escolares por estado, e como isso varia conforme a renda domiciliar?**  
    *Tabelas:* 7320–7321, 7307, 7395

8. **Em quais estados há maior proporção de pessoas com deficiência com ensino superior completo, e como isso se relaciona com a inserção no mercado formal?**  
    *Tabelas:* 9297, 9311, 4361, 4708

9. **Como a insegurança alimentar moderada ou grave nos domicílios afeta a frequência escolar de crianças de 6 a 14 anos por estado?**  
    *Tabelas:* 7138, 9552, 9558

10. **Em quais estados há maior sobreposição entre trabalho infantil e baixa escolaridade até ensino fundamental incompleto?**  
    *Tabelas:* 9499, 9506, 7128

11. **Como a posse de internet em domicílios com adolescentes de 15 a 17 anos influencia a permanência no ensino médio por estado?**  
    *Tabelas:* 7136, 7161, 7307, 7395

12. **Qual é a diferença no número médio de anos de estudo entre homens e mulheres com 25 anos ou mais por estado, e como isso evoluiu de 2016 a 2024?**  
    *Tabelas:* 7126, 7133

13. **Em quais estados a desigualdade educacional entre brancos e pretos/pardos, em anos de estudo, é mais acentuada?**  
    *Tabelas:* 7127, 7134

14. **Como a condição de ocupação do domicílio se associa à taxa de abandono escolar entre jovens de 15 a 17 anos por estado?**  
    *Tabelas:* 7215, 6821

15. **Qual é a proporção de jovens de 18 a 24 anos que não frequentam escola nem trabalham por estado, e como isso varia com o nível de renda familiar?**  
    *Tabelas:* 7219–7222, 7159–7161, 7395

16. **Em quais estados os concluintes de curso técnico de nível médio têm maior rendimento médio no primeiro emprego?**  
    *Tabelas:* 7210–7211, 4666

17. **Qual é a taxa de participação em cursos de qualificação profissional entre jovens de 18 a 24 anos sem ensino superior por estado?**  
    *Tabelas:* 7177–7178, 7128

18. **Em quais estados há maior proporção de crianças em idade escolar vivendo em domicílios onde o responsável é analfabeto?**  
    *Tabelas:* 7111, 6409, 6407

19. **Qual é a diferença na taxa de conclusão do ensino médio entre as regiões Norte/Nordeste e Sul/Sudeste, e como isso se relaciona com indicadores de infraestrutura?**  
    *Tabelas:* 7128, 7135, 6731–6737, 7307

20. **Como evoluiu o percentual de jovens de 18 a 24 anos matriculados no ensino superior por estado entre 2016 e 2024, e quais estados tiveram crescimento abaixo da média nacional?**  
    *Tabelas:* 7146–7147, 6407

## Datasets Utilizados

Abaixo é descrito como foi obtido as tabelas, porém não é recomendado extrair manualmente por conta da grande quantidade de tabelas, além de que é necessário converter os arquivos. Eles estão disponíveis no repositório e foram baixados usando os scripts também presentes.

A lista de todas as tabelas estão disponíveis em: https://sidra.ibge.gov.br/acervo#/S/B5/T/Q

É possível de acessar diretamente usando `https://sidra.ibge.gov.br/Tabela/`, seguido do número da tabela. Exemplo: https://sidra.ibge.gov.br/Tabela/4361

O número delas são:

7138, 7139, 7109, 7110, 7113, 7111, 7126, 7127, 7395, 7128, 4708, 4361, 4666, 7129, 6407, 7339, 7320, 7321, 7307, 9297, 9311, 9552, 9558, 9499, 9506, 7136, 7161, 7133, 7134, 7215, 6821, 7219, 7220, 7221, 7222, 7159, 7160, 7210, 7211, 7177, 7178, 6409, 7135, 6731, 6732, 6733, 6734, 6735, 6736, 6737, 7146 e 7147

Em todas as tabelas, foi selecionado apenas a primeira varíavel, todas as classificações disponíveis, exceto o total, e todos os anos.

Nem todas as tabelas tem a mesma unidade territorial disponível, então foi selecionado seguindo a preferência abaixo, indo para o seguinte somente caso o anterior não estiver disponível:

- Unidade da Federação
- Grande Região
- Brasil

Foi baixado os dados em XLSX, depois convertido para TSV utilizando a biblioteca Pandas do Python (provavelmente outros conversores funcionarão de maneira semelhante). Não foi possível utilizar o TSV fornecido pelo site por conta de alguns estarem com problemas, possíveis corrupções, nos arquivos que impediam a inserção dos dados no banco.

## Como rodar

O SQL Server está disponível para ser rodado em Docker, estando com todos os datasets dentro.

Caso deseje rodar os scripts para baixar os datasets, siga o primeiro passo a passo. Caso deseje usar os datasets já baixados, pule o primeiro passo a passo.

Abaixo está o passo a passo de como rodar os scripts, e depois está como rodar o banco de dados no Docker.

### Como rodar os scripts

#### Ferramentas adicionais necessárias

- Python 3

#### Passo a passo

#### Preparação

1. Clone o repositório:
  ```
  git clone https://github.com/neofelipecardoso/Gerenciamento-de-Banco-de-Dados.git
  ```

2. Mova para o diretório dos scripts:
  ```
  cd Gerenciamento-de-Banco-de-Dados/scripts
  ```

3. Crie um ambiente virtual:
  ```
  python3 -m venv venv
  ```

4. Ative o ambiente virtual:
  ```
  source venv/bin/activate # Linux/Mac
  venv\Scripts\activate # Windows
  ```

5. Instale as dependências na venv:
  ```
  pip install -r requirements.txt
  ```

### Passos para executar os scripts

6. Dentro da venv, execute os scripts, **UM POR UM**, na seguinte sequência, que deve sobrescrever (caso estiverem presentes) os arquivos `urls.txt` e `V0__Insert_raw_tables.sql`:
  ```
  python3 get-urls.py
  python3 download-xlsx-tables.py
  python3 convert-xlsx-to-tsv.py
  python3 generate-sql-script.py
  ```

7. Copie os arquivos para dentro dos seguintes diretórios (pode sobrescrever somente os que são iguais):
  - `V0__Insert_raw_tables.sql` para dentro de `docker/migrations`
  - Todos os arquivos de dentro de `datasets_tsv` para dentro de `docker/datasets`

Agora pode executar no Docker normalmente.

### Como rodar o SQL Server no Docker

#### Ferramentas necessárias

- Docker

#### Como rodar o SQL Server no Docker

1. Certifique-se de ter o Docker instalado e rodando.

2. Navegue até o diretório `docker` no terminal.

3. Copie o `.env.example` para `.env` e edite-o com as configurações desejadas.

4. Execute um dos seguintes comandos para iniciar o SQL Server:
  ```
  docker compose up # com logs
  docker compose up -d # não mostrar logs
  ```

5. Aguarde o SQL Server estar pronto e todos os scripts do Flyway terem sido rodados com sucesso.

6. Conecte-se ao SQL Server usando o seguinte comando ou algum cliente SQL que suporte SQL Server:
  ```
  docker exec -it sqlserver /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '<YourStrong@Passw0rd>'
  ```
