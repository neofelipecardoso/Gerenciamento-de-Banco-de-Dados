# Gerenciamento-de-Banco-de-Dados

## Esse arquivo contém a documentação do nosso projeto com informações referentes a datasets, perguntas, membros e mais.

## Trello
https://trello.com/b/A56DuRJG/gerenciamento-de-banco-de-dados

# Datasets

Os datasets que escolhemos foram os logo abaixo:

### PNAD Contínua (IBGE): 
https://www.ibge.gov.br/estatisticas/sociais/rendimento-despesa-e-consumo/17270-pnad-continua.html?edicao=43499&t=resultados

### Censo Escolar (INEP 2022): 
https://www.gov.br/inep/pt-br/areas-de-atuacao/pesquisas-estatisticas-e-indicadores/censo-escolar/resultados
### INEP Indicadores Educacionais
https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/indicadores-educacionais/indicadores-financeiros-educacionais
### PeNSE (IBGE): 
https://www.ibge.gov.br/estatisticas/sociais/educacao/9134-pesquisa-nacional-de-saude-do-escolar.html
### ENEM Microdados: 
https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem
### Indicadores Educacionais – Nível Socioeconômico: 
https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/indicadores-educacionais/nivel-socioeconomico
### Taxas de Distorção Idade-Série (INEP): 
https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/indicadores-educacionais/taxas-de-distorcao-idade-serie
### IDEB (INEP): 
https://www.gov.br/inep/pt-br/areas-de-atuacao/pesquisas-estatisticas-e-indicadores/ideb/resultados

Os datasets informado acima tratam sobre desempenho de alunos no âmbito escolar.


# Perguntas a serem respondidas

Após longos momentos de pesquisa, definimos quais são as seguintes perguntas a serem respondidas:

1. Existe relação entre a renda familiar per capita (PNAD) e a taxa de conclusão do ensino médio (Censo Escolar)?
2. Alunos de famílias em situação de desemprego (PNAD) apresentam maior risco de evasão escolar (Censo Escolar)?
3. A desigualdade de renda (PNAD) afeta o desempenho médio em exames padronizados (ENEM e IDEB)?
4. Famílias com maior gasto em educação (PNAD) têm filhos com desempenho acima da média (ENEM e IDEB)?
5. O tipo de escola (Censo Escolar – pública x privada) influencia a probabilidade de aprovação e desempenho (ENEM)?
6. A taxa de distorção idade-série (INEP) é maior em regiões com menor nível socioeconômico (Indicadores Educacionais)?
7. O número de alunos por turma (Censo Escolar) está correlacionado com o desempenho escolar (IDEB)?
8. Períodos com maior investimento público em educação por estudante apresentam correlação com menores taxas de abandono escolar?
9. A infraestrutura escolar (INEP ATU – laboratórios, bibliotecas, internet) influencia o desempenho (IDEB e ENEM)?
10. O consumo de álcool e cigarro entre estudantes (PeNSE) afeta diretamente a taxa de reprovação (Censo Escolar)?
11. Estudantes com pior qualidade de sono (PeNSE) apresentam menor desempenho escolar (ENEM)?
12. Há relação entre indicadores de saúde mental (PeNSE – ansiedade, depressão) e evasão escolar (Censo Escolar)?
13. O nível socioeconômico dos candidatos (Indicadores Educacionais) influencia a nota média por área de conhecimento (ENEM)?
14. O tipo de escola (pública x privada – Censo Escolar) explica diferenças de desempenho no ENEM?
15. Estados/regiões com menor taxa de distorção idade-série (INEP) apresentam melhores resultados no IDEB?
16. O nível socioeconômico escolar (Indicadores Educacionais) impacta o IDEB de forma consistente entre regiões?
17. Há relação clara entre nível socioeconômico escolar (Indicadores Educacionais) e taxa de reprovação (Censo Escolar)?
18. Quais fatores socioeconômicos (PNAD) mais explicam a alta distorção idade-série em determinadas regiões (INEP)?
19. Qual é a relação temporal entre o investimento público em educação por estudante e o IDEB nacional?
20. O crescimento do IDEB em determinadas regiões pode ser explicado pela melhoria nas condições socioeconômicas (PNAD)?

## Informações e passo a passo dos Datasets

## Datasets Utilizados

| Dataset                        | Fonte de Dados | Link para Acesso | Instruções de Acesso |
|--------------------------------|----------------|------------------|-----------------------|
| Microdados do Censo Demográfico | IBGE           | [Acessar](https://www.ibge.gov.br/estatisticas/sociais/saude/22827-censo-demografico-2022.html) | Ao acessar a página, procure pela seção **"Microdados"**. Dentro dela, você encontrará links para os arquivos de dados. Eles são geralmente separados por Unidade da Federação e contêm arquivos de "Pessoas" e "Domicílios" em pastas separadas. Faça o download dos arquivos compactados (.zip) dos anos e estados desejados. |
| Microdados da Pesquisa Nacional por Amostra de Domicílios (PNAD Contínua)        | IBGE        | [Acessar](https://www.ibge.gov.br/estatisticas/sociais/trabalho/2511-np-pnad-continua/30980-pnadc-divulgacao-pnadc4.html)           | Passo a passo: Na página da PNAD, localize a seção "Microdados". Lá, você encontrará a opção de "Downloads". Dentro do diretório de downloads, selecione os anos de interesse e baixe os arquivos de "Pessoas" e "Domicílios" separadamente.   |
| Microdados do Sistema de Avaliação da Educação Básica (Saeb)        | INEP        | [Acessar](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/saeb)           | Passo a passo: Ao entrar no link, selecione o ano da avaliação que deseja e clique no link para "Microdados". O download geralmente é um arquivo compactado (.zip) que contém várias pastas. Você precisará da pasta "Dados" para os arquivos de microdados e da pasta "Dicionário" para entender as variáveis.    |
| Microdados do Censo Escolar da Educação Básica        | INEP        | [Acessar](https://dados.gov.br/dados/conjuntos-dados/inep-microdados-do-censo-escolar-da-educacao-basica)           | Passo a passo: A página lista os microdados por ano. Selecione o ano desejado e clique no botão de download. É importante também baixar a documentação técnica, que inclui o "Dicionário de Dados" (em formato .xlsx), que é essencial para a leitura dos arquivos.   |
| Microdados do ENEM        | INEP        | [Acessar](https://www.gov.br/inep/pt-br/acesso-a-informacao/dados-abertos/microdados/enem)           | Passo a passo: No portal do ENEM, procure pela seção de microdados e selecione o ano da prova que você precisa. Os arquivos estão disponíveis para download em formato comprimido (.zip)    |
| Microdados da Pesquisa Nacional de Saúde do Escolar (PeNSE)      | Ministério da Saúde, IBGE, MEC        | [Acessar](https://svs.aids.gov.br/daent/acesso-a-informacao/inqueritos-de-saude/pense/)           | Passo a passo: Acesse a página da PeNSE no Ministério da Saúde e procure por "Microdados" ou "Acesso a Informação". Selecione a edição da pesquisa (ano) e baixe os arquivos de dados, que podem estar em formato Excel ou texto.   |
| Dados de Saneamento Básico (SNIS)        | Ministério das Cidades        | [Acessar](https://www.gov.br/cidades/pt-br/acesso-a-informacao/acoes-e-programas/saneamento/snis/painel)           | Passo a passo: A página do SNIS não oferece o download de um banco de dados completo. Em vez disso, você deve usar o painel interativo. Acesse o painel, selecione os filtros desejados (como ano e indicadores de saneamento por UF), e extraia as informações diretamente da visualização, caso a opção de exportação esteja disponível.   |
| Dados de Acessos de Banda Larga (ANATEL) | ANATEL | [Acessar](https://dados.gov.br/dados/conjuntos-dados/meu-municipio---indice-brasileiro-de-conectividade) | Passo a passo: Acesse a plataforma Base dos Dados e filtre por **"Organização: Anatel"**. Em seguida, selecione o conjunto de dados de seu interesse, como **"Acessos de banda larga fixa"** ou **"Índice Brasileiro de Conectividade"**. A plataforma oferece a opção de download dos dados tratados. |
| Dados do Atlas da Violência | IPEA, Fórum Brasileiro de Segurança Pública | [Acessar](https://www.ipea.gov.br/atlasviolencia/publicacoes) | Passo a passo: A página do Atlas da Violência hospeda os relatórios anuais em formato PDF. Clique na capa do relatório do ano desejado (ex: 2024 ou 2025) e faça o download do arquivo. As tabelas de dados estão contidas no corpo do documento PDF. |
| Dados de Mortalidade (SIM) e Agravos (Sinan) | DATASUS | [Acessar](https://datasus.saude.gov.br/informacoes-de-saude-tabnet/) | Passo a passo: No portal, selecione o sistema de informação que você quer usar (por exemplo, **"Mortalidade"** para SIM ou **"Notificação"** para Sinan). Use o sistema de tabulação para filtrar as informações por "Linha", "Coluna" e "Medidas". Após a tabulação, você poderá salvar a tabela em formato **.CSV** para análise. |
| Dados de Cobertura Vacinal (PNI) | DATASUS | [Acessar](http://tabnet.datasus.gov.br/cgi/dhdat.exe?bd_pni/cpnibr.def) | Passo a passo: Este link já leva você para a página de Cobertura Vacinal. Na interface do Tabnet, selecione as vacinas que deseja, os anos de interesse e a "Unidade da Federação" para a Linha da tabela. Clique em "Mostrar" para gerar a tabela e use a opção de salvar como **.CSV**. |
| Dados de Patentes        | INPI        | [Acessar](https://www.gov.br/inpi/pt-br/central-de-conteudo/estatisticas/estatisticas)           | Passo a passo: Acesse a página e procure pela seção "Base de Dados Estatísticos do INPI". Dependendo do ano, você pode encontrar um painel interativo ou arquivos para download (BADEPI). O portal também oferece "Tabelas Completas dos Indicadores de Propriedade Industrial" que podem ser baixadas em formatos de planilhas.   |
| Dados de Investimento em C&T       | Portal da Transparência        | [Acessar](https://portaldatransparencia.gov.br/funcoes/19-ciencia-e-tecnologia)           | Passo a passo: Para dados federais, use o portal, navegando até a seção de "Despesas" > "Por Função" e selecionando "19 - Ciência e Tecnologia". Os dados podem ser filtrados e exportados para download. Para dados estaduais, é preciso acessar o Portal da Transparência de cada estado, já que cada um tem o seu próprio sistema de divulgação.   


Fontes e conteúdo relacionado |


# Dicionário de Dados

Tabelas Dimensão

Tabela: Dim_Regiao

 * Finalidade: Descrever as regiões geográficas do Brasil.
 * Atributos:
   * id_regiao: Chave primária que identifica a região.
   * nome_regiao: O nome da região, como Norte, Nordeste, etc.
 * Relacionamentos:
   * PK (Chave Primária): id_regiao.
   * FKs (Chaves Estrangeiras): Não há chaves estrangeiras.

Tabela: Dim_Estado

 * Finalidade: Descrever os estados brasileiros e relacioná-los com as regiões.
 * Atributos:
   * id_estado: Chave primária que identifica o estado.
   * nome_estado: O nome do estado.
   * id_regiao: Chave estrangeira que se relaciona com Dim_Regiao para indicar a qual região o estado pertence.
 * Relacionamentos:
   * PK (Chave Primária): id_estado.
   * FKs (Chaves Estrangeiras): id_regiao (N-1) → Dim_Regiao.

Tabela: Dim_Municipio

 * Finalidade: Descrever os municípios e relacioná-los com os estados.
 * Atributos:
   * id_municipio: Chave primária que identifica o município.
   * nome_municipio: O nome do município.
   * populacao: O dado de população do município, que pode vir do Censo ou de outra fonte.
   * id_estado: Chave estrangeira que se relaciona com Dim_Estado para indicar em qual estado o município se encontra.
 * Relacionamentos:
   * PK (Chave Primária): id_municipio.
   * FKs (Chaves Estrangeiras): id_estado (N-1) → Dim_Estado.

Tabela: Dim_Escola

 * Finalidade: Descrever as escolas, sendo a dimensão mais granular.
 * Atributos:
   * id_escola: Chave primária que identifica a escola.
   * nome_escola: O nome da escola.
   * tipo_escola: Indica se a escola é pública ou privada.
   * zona_localizacao: Indica se a escola está em uma zona urbana ou rural.
   * id_municipio: Chave estrangeira que se relaciona com Dim_Municipio para indicar em qual município a escola está.
   * ano_referencia: O ano de referência para os dados da escola.
 * Relacionamentos:
   * PK (Chave Primária): id_escola.
   * FKs (Chaves Estrangeiras): id_municipio (N-1) → Dim_Municipio.

Tabelas Fato

Tabela: Fat_InfraestruturaEscolar

 * Finalidade: Armazenar dados de infraestrutura e indicadores por escola.
 * Atributos:
   * id_infraestrutura: Chave primária que identifica cada registro.
   * id_escola: Chave estrangeira que se relaciona com a tabela Dim_Escola.
   * ano_referencia: O ano de referência dos dados.
   * possui_laboratorio: Booleano que indica se a escola possui laboratório.
   * possui_biblioteca: Booleano que indica se a escola possui biblioteca.
   * possui_internet: Booleano que indica se a escola possui internet.
   * num_alunos_por_turma: O número de alunos por turma.
 * Relacionamentos:
   * PK (Chave Primária): id_infraestrutura.
   * FKs (Chaves Estrangeiras): id_escola (N-1) → Dim_Escola.

Tabela: Fat_ResultadosENEM_Individual

 * Finalidade: Armazenar os resultados de cada aluno do ENEM.
 * Atributos:
   * id_estudante: Identificador único do participante do ENEM, originado da coluna NU_INSCRIÇAO do dataset ENEM .
   * ano_enem: Ano em que o exame foi aplicado, da coluna NU_ANO do dataset ENEM.
   * estado_estudante: Unidade federativa de residência do estudante, da coluna SG_UF_RESIDENCIA do dataset ENEM.
   * municipio_estudante: Município de residência do estudante, da coluna CO_MUNICIPIO_RESIDENCIA do dataset ENEM.
   * nota_linguagens: Nota obtida na prova de Linguagens e Códigos, da coluna NU_NOTA_LC do dataset ENEM.
   * nota_matematica: Nota obtida na prova de Matemática, da coluna NU_NOTA_MT do dataset ENEM.
   * nota_ciencias_humanas: Nota obtida na prova de Ciências Humanas, da coluna NU_NOTA_CH do dataset ENEM.
   * nota_ciencias_natureza: Nota obtida na prova de Ciências da Natureza, da coluna NU_NOTA_CN do dataset ENEM.
   * nota_redação: Nota obtida na redação, da coluna NU_NOTA_REDAÇAO do dataset ENEM.
 * Relacionamentos:
   * PK (Chave Primária): id_estudante e ano_enem (chave composta).
   * FKs (Chaves Estrangeiras):
     * estado_estudante (N-1) → Estado.sigla_uf.
     * municipio_estudante (N-1) → Municipio.codigo_ibge.

Tabela: Fat_IndicadoresEducacionais

 * Finalidade: Consolidar dados de diversos datasets do INEP que já vêm agregados por escola, município ou estado.
 * Atributos:
   * ano: Ano de referência, da coluna ANO do Censo Escolar (INEP 2022).
   * id_escola: Identificador único da escola, da coluna ID_ESCOLA do Censo Escolar (INEP 2022).
   * taxa_aprovacao: Proporção de alunos que avançaram de série, da coluna TAXA_APROVACAO do Censo Escolar (INEP 2022).
   * taxa_reprovacao: Proporção de alunos que não avançaram de série, da coluna TAXA_REPROVACAO do Censo Escolar (INEP 2022).
   * taxa_evasao: Proporção de alunos que abandonaram a escola, da coluna TAXA_EVASAO do Censo Escolar (INEP 2022).
   * rendimento_familiar_medio: Rendimento familiar médio dos alunos, da coluna RENDA_MEDIA_DOMICILIAR do PNAD Contínua (IBGE).
   * regiao_uf: Região geográfica da escola, da coluna REGIAO do INEP ATU 2020.
   * uf: Unidade federativa da escola, da coluna UF.
   * frequencia_escolar: Frequência média dos estudantes, da coluna FREQUENCIA_ESCOLAR do PeNSE (IBGE).
   * nivel_socioeconomico: Classificação socioeconômica média dos alunos da escola, da coluna NSE do dataset Indicadores Educacionais – Nível Socioeconômico (INEP).
 * Relacionamentos:
   * PK (Chave Primária): Chave composta por id_escola e ano.
   * FKs (Chaves Estrangeiras):
     * id_escola (1-1) → CensoEscolar.id_escola.
     * uf (1-N) → INEP_ATU.uf.
     * regiao_uf (1-N) → INEP_ATU.regiao.

Tabela: Fat_SaudeEscolar

 * Finalidade: Armazenar dados do PeNSE já agregados por município.
 * Atributos:
   * id_saude: Chave primária que identifica o registro.
   * ano_pesquisa: O período em que a pesquisa foi feita.
   * consumo_alcool: Percentual de escolares que consumiram álcool nos 30 dias anteriores à pesquisa.
   * consumo_cigarro: Percentual de escolares que fumaram nos 30 dias anteriores à pesquisa.
   * saude_mental: Percentual de escolares que não possuem amigos próximos.
   * bullying: Percentual de escolares que sofreram bullying.
   * relacao_pais: Percentual de escolares cujos pais ou responsáveis entendem seus problemas.
 * Relacionamentos:
   * PK (Chave Primária): id_saude.
   * FKs (Chaves Estrangeiras): id_municipio, que se relaciona com Dim_Municipio.

Tabela: Fat_IndicadoresSocioeconomicos

 * Finalidade: Armazenar dados socioeconômicos agregados por município ou estado.
 * Atributos:
   * id_indicador: Chave primária que identifica o registro.
   * ano_pesquisa: O período do ano em que a pesquisa foi feita.
   * taxa_desemprego: Categoria de pessoas não ocupadas e que frequentam ou não a escola, cursos pré-vestibular, técnico de nível médio ou qualificação profissional.
   * nivel_socio_economico: Nível socioeconômico dos estudantes baseado no INSE.
 * Relacionamentos:
   * PK (Chave Primária): id_indicador.
   * FKs (Chaves Estrangeiras): id_municipio, que se relaciona com Dim_Municipio.

Tabela: Fat_InvestimentoEducacao

 * Finalidade: Armazenar dados de investimento público direto nacional em educação por estudante.
 * Atributos:
   * id_investimento: Identificador único sequencial para cada registro.
   * ano_referencia: O ano a que os dados se referem (2000-2021).
   * nivel_ensino: O nível de ensino correspondente.
   * investimento_por_estudante: O valor do investimento público direto por estudante em valores reais (corrigidos pelo IPCA para 2021).
 * Relacionamentos:
   * PK (Chave Primária): id_investimento.
   * FKs (Chaves Estrangeiras): Não há chaves estrangeiras.

# Membros

Segue uma breve lista dos membros presentes nesse grupo:

Prodcut Owner - Fernando de Ávila  
Scrum master - Felipe Campos  
Analista de Dados - Felipe Rodrigo  
Analista de Dados - Bruno  
Engenheiro de dados - Ana eliza  
Engenheiro de dados - Fabio Lütz  
Arquiteto de dados - Pietro  
Arquiteto de dados - Claudia  
