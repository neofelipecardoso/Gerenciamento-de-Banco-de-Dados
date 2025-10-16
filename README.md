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

16. A desigualdade de renda afeta o desempenho médio em exames padronizados?(Saeb, PNAD Continua e Censo Demografico)

17. Estados com maior gasto em educação apresentam estudantes com desempenho melhor? (Portal da Transparência e Saeb)

18. A taxa de distorção idade-série  é maior em regiões com menor nível socioeconômico? (Censo Escolar e Censo Demográfico)

19. O número de alunos por turma  está correlacionado com o desempenho escolar? (Censo Escolar e Saeb)

20. Períodos com maior investimento público em educação por estudante apresentam correlação com menores taxas de abandono escolar? (Censo Escolar e Portal da Transparência)

21. O consumo de álcool e cigarro entre estudantes afeta diretamente a taxa de reprovação? (PENSE e Censo Escolar)

22. Estudantes com pior qualidade de sono apresentam menor desempenho escolar? (PENSE e Saeb)

23. Há relação entre indicadores de saúde mental e evasão escolar?(PENSE e Censo Escolar)

24. O nível socioeconômico dos candidatos influencia a nota média por área de conhecimento? (SAEB e ENEM)

25. O tipo de escola (pública x privada) explica diferenças de desempenho no ENEM? (ENEM e Censo Escolar)

26. Estados/regiões com menor taxa de distorção idade-série apresentam melhores resultados no IDEB? (Censo Escolar e Saeb)

27. O nível socioeconômico e escolar impacta o IDEB de forma consistente entre regiões? (Saeb, Censo Demografico e PNAD Continua)

28. Há relação clara entre nível socioeconômico escolare taxa de reprovação? (Censo Escolar e Saeb)

29. Quais fatores socioeconômicos mais explicam a alta distorção idade-série em determinadas regiões? (Censo Escolar, Censo Demográfico e PNAD Continua)

30. Qual é a relação temporal entre o investimento público em educação por estudante e o IDEB nacional? (Portal da Transparência e Saeb)

31. O crescimento do IDEB em determinadas regiões pode ser explicado pela melhoria nas condições socioeconômicas?(Saeb, Censo Demografico e PNAD Continua)


## Datasets Utilizados

Disponível no diretório `tabelas`.
