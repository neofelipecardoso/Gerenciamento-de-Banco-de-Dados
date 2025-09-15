# Contexto do projeto

Este documento apresenta o projeto desenvolvido para a disciplina de Gerenciamento de Banco de Dados. O trabalho foi realizado por alunos do 6º semestre do curso de Engenharia da Computação do UNASP.
​O objetivo principal é a criação de um sistema de banco de dados no ambiente SQL Server. A partir desse sistema, serão realizadas análises para responder a questões específicas relacionadas a um conjunto de datasets sobre o tema Educação.
​A seguir, você encontrará todos os detalhes do projeto, incluindo as perguntas a serem respondidas, os datasets utilizados e o dicionário de dados

## Trello
https://trello.com/b/A56DuRJG/gerenciamento-de-banco-de-dados

# Perguntas a serem respondidas

Após longos momentos de pesquisa, definimos quais são as seguintes perguntas a serem respondidas:

1. Existe relação entre a renda familiar per capita e a taxa de conclusão do ensino médio?
2. De que forma a infraestrutura de saneamento básico (SNIS) se correlaciona com as taxas de abandono escolar (Censo Escolar) em municípios com alta concentração de população de baixa renda (Censo Demográfico)?
3. Existe uma correlação entre o acesso a banda larga fixa por domicílio (ANATEL) e o Indicador de Nível Socioeconômico (INSE) do Saeb, e como isso afeta a proficiência dos alunos?
4. Como a taxa de homicídios por estado (Atlas da Violência) impacta o bem-estar psicológico dos adolescentes (PeNSE) e seu desempenho acadêmico (SAEB)?
5. Qual a relação entre o investimento estadual em ciência e tecnologia (Portal da Transparência) e o número de patentes registradas (INPI), e como ambos se correlacionam com a qualidade da formação dos professores (SAEB)?
6. A presença de profissionais de saúde em escolas (PeNSE) tem um efeito mensurável na taxa de reprovação e evasão escolar (Censo Escolar)?
7. Como a composição étnica da população escolar (Censo Escolar/SAEB) se correlaciona com a distorção idade-série, controlando por fatores de saneamento (SNIS)?
8. Há uma correlação entre a disponibilidade de bibliotecas e quadras de esporte nas escolas (Censo Escolar) e o nível de sedentarismo e leitura entre os alunos (PeNSE)?
9. Como a taxa de desemprego por estado (PNAD Contínua) afeta a taxa de matrículas na educação de jovens e adultos (EJA) em cada Unidade da Federação?
10. A incidência de doenças transmissíveis por município (DATASUS) se correlaciona com o fluxo escolar (Censo Escolar) em áreas de alta vulnerabilidade social?
11. Existe uma relação entre o Indicador de Adequação da Formação Docente (SAEB) e o índice de desenvolvimento humano municipal (IBGE), e qual é o impacto no desempenho dos alunos?
12. Qual a correlação entre a percepção dos estudantes sobre o ambiente escolar (PeNSE) e o fluxo escolar (Censo Escolar), considerando a infraestrutura da escola?
13. Como a concentração de microempresas e instituições de pesquisa por estado (INPI) se relaciona com a taxa de evasão do ensino médio (Censo Escolar)?
14. A incidência de agravos de notificação por estado (SINAN) se correlaciona com a presença de profissionais escolares em sala de aula (Censo Escolar)?
15. Como o acesso à internet (ANATEL) em áreas rurais se correlaciona com a nota de proficiência em matemática (SAEB) dos alunos de escolas localizadas nessas áreas, controlando pela renda familiar (Censo Demográfico)?
16 - A desigualdade de renda afeta o desempenho médio em exames padronizados?(Saeb, PNAD Continua e Censo Demografico)
17 - Estados com maior gasto em educação apresentam estudantes com desempenho melhor? (Portal da Transparência e Saeb)
18 - A taxa de distorção idade-série  é maior em regiões com menor nível socioeconômico? (Censo Escolar e Censo Demográfico)
19 - O número de alunos por turma  está correlacionado com o desempenho escolar? (Censo Escolar e Saeb)
20 - Períodos com maior investimento público em educação por estudante apresentam correlação com menores taxas de abandono escolar? (Censo Escolar e Portal da Transparência)
21 - O consumo de álcool e cigarro entre estudantes afeta diretamente a taxa de reprovação? (PENSE e Censo Escolar)
22 - Estudantes com pior qualidade de sono apresentam menor desempenho escolar? (PENSE e Saeb)
23 - Há relação entre indicadores de saúde mental e evasão escolar?(PENSE e Censo Escolar)
24 - O nível socioeconômico dos candidatos influencia a nota média por área de conhecimento? (SAEB e ENEM)
25 - O tipo de escola (pública x privada) explica diferenças de desempenho no ENEM? (ENEM e Censo Escolar)
26 - Estados/regiões com menor taxa de distorção idade-série apresentam melhores resultados no IDEB? (Censo Escolar e Saeb)
27 - O nível socioeconômico e escolar impacta o IDEB de forma consistente entre regiões? (Saeb, Censo Demografico e PNAD Continua)
28 - Há relação clara entre nível socioeconômico escolare taxa de reprovação? (Censo Escolar e Saeb)
29 - Quais fatores socioeconômicos mais explicam a alta distorção idade-série em determinadas regiões? (Censo Escolar, Censo Demográfico e PNAD Continua)
30 - Qual é a relação temporal entre o investimento público em educação por estudante e o IDEB nacional? (Portal da Transparência e Saeb)
31 - O crescimento do IDEB em determinadas regiões pode ser explicado pela melhoria nas condições socioeconômicas?(Saeb, Censo Demografico e PNAD Continua)


## Datasets Utilizados

### Informações e passo a passo dos Datasets

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
| Dados de Investimento em C&T       | Portal da Transparência        | [Acessar](https://portaldatransparencia.gov.br/funcoes/19-ciencia-e-tecnologia)           | Passo a passo: Para dados federais, use o portal, navegando até a seção de "Despesas" > "Por Função" e selecionando "19 - Ciência e Tecnologia". Os dados podem ser filtrados e exportados para download. Para dados estaduais, é preciso acessar o Portal da Transparência de cada estado, já que cada um tem o seu próprio sistema de divulgação.   Fontes e conteúdo relacionado |


## Dicionário de dados
[Rota para o dicionario](./dicionario-de-dados)

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
