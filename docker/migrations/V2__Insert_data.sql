-- Criar faixa etaria caso não tenha.

DECLARE @MaxFaixaId INT;
SELECT @MaxFaixaId = ISNULL(MAX(IdFaixaEtaria), 0) FROM Dim_Faixa_Etaria;

INSERT INTO Dim_Faixa_Etaria (IdFaixaEtaria, nomeFaixaEtaria)
SELECT
    @MaxFaixaId + ROW_NUMBER() OVER (ORDER BY t.[Grupo de idade]) AS NovoIdFaixa,
    t.[Grupo de idade] AS nomeFaixaEtaria
FROM (
    SELECT DISTINCT [Grupo de idade] 
    FROM tabela7126
    WHERE [Grupo de idade] COLLATE Latin1_General_BIN IS NOT NULL
) AS t
WHERE NOT EXISTS (
    SELECT 1 
    FROM Dim_Faixa_Etaria d 
    WHERE d.nomeFaixaEtaria = t.[Grupo de idade] COLLATE Latin1_General_BIN
);

-- Passar dados 7126
ALTER TABLE Fact_Escolaridade alter column NumeroMedioDeAnosDeEstudo varchar(255);


INSERT INTO Fact_Escolaridade (
    IdLocal,
    IdFaixaEtaria,
    IdAno,
    IdGrupoDemo,
    NumeroMedioDeAnosDeEstudo
)
SELECT
    d_loc.IdLocal,
    d_faixa.IdFaixaEtaria,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS NumeroMedioDeAnosDeEstudo 
FROM
    tabela7126 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Faixa_Etaria AS d_faixa 
    ON src.[Grupo de idade] COLLATE Latin1_General_BIN = d_faixa.nomeFaixaEtaria
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo 
    ON src.Sexo = d_demo.nomeGrupoDemo;
GO









DECLARE @MaxFaixaId INT;

-- Criar faixa etaria caso não tenha.
SELECT @MaxFaixaId = ISNULL(MAX(IdFaixaEtaria), 0) FROM Dim_Faixa_Etaria;

INSERT INTO Dim_Faixa_Etaria (IdFaixaEtaria, nomeFaixaEtaria)
SELECT
    @MaxFaixaId + ROW_NUMBER() OVER (ORDER BY t.[Grupos de anos de estudo]) AS NovoIdFaixa,
    t.[Grupos de anos de estudo] AS nomeFaixaEtaria
FROM (
    SELECT DISTINCT [Grupos de anos de estudo] 
    FROM tabela7133
    WHERE [Grupos de anos de estudo] COLLATE Latin1_General_BIN IS NOT NULL
) AS t
WHERE NOT EXISTS (
    SELECT 1 
    FROM Dim_Faixa_Etaria d 
    WHERE d.nomeFaixaEtaria = t.[Grupos de anos de estudo] COLLATE Latin1_General_BIN
);

-- Passar dados 7133
ALTER TABLE Fact_Escolaridade alter column QuantidadeDeEstudantes varchar(255);

INSERT INTO Fact_Escolaridade (
    IdLocal,
    IdFaixaEtaria,
    IdAno,
    IdGrupoDemo,
    QuantidadeDeEstudantes
)
SELECT
    d_loc.IdLocal,
    d_faixa.IdFaixaEtaria,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS QuantidadeDeEstudantes 
FROM
    tabela7133 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Faixa_Etaria AS d_faixa 
    ON src.[Grupos de anos de estudo] COLLATE Latin1_General_BIN = d_faixa.nomeFaixaEtaria
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo 
    ON src.Sexo = d_demo.nomeGrupoDemo;
GO


















-- Criar faixa etaria caso não tenha.

DECLARE @MaxFaixaId INT;
SELECT @MaxFaixaId = ISNULL(MAX(IdFaixaEtaria), 0) FROM Dim_Faixa_Etaria;

INSERT INTO Dim_Faixa_Etaria (IdFaixaEtaria, nomeFaixaEtaria)
SELECT
    @MaxFaixaId + ROW_NUMBER() OVER (ORDER BY t.[Grupo de idade]) AS NovoIdFaixa,
    t.[Grupo de idade] AS nomeFaixaEtaria
FROM (
    SELECT DISTINCT [Grupo de idade] 
    FROM tabela7127
    WHERE [Grupo de idade] COLLATE Latin1_General_BIN IS NOT NULL
) AS t
WHERE NOT EXISTS (
    SELECT 1 
    FROM Dim_Faixa_Etaria d 
    WHERE d.nomeFaixaEtaria = t.[Grupo de idade] COLLATE Latin1_General_BIN
);

-- Passar dados 7127


INSERT INTO Fact_Escolaridade (
    IdLocal,
    IdFaixaEtaria,
    IdAno,
    IdGrupoDemo,
    NumeroMedioDeAnosDeEstudo
)
SELECT
    d_loc.IdLocal,
    d_faixa.IdFaixaEtaria,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS NumeroMedioDeAnosDeEstudo 
FROM
    tabela7127 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Faixa_Etaria AS d_faixa 
    ON src.[Grupo de idade] COLLATE Latin1_General_BIN = d_faixa.nomeFaixaEtaria
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo 
    ON src.[Cor ou raça] = d_demo.nomeGrupoDemo;
GO
















DECLARE @MaxFaixaId INT;

-- Criar faixa etaria caso não tenha.
SELECT @MaxFaixaId = ISNULL(MAX(IdFaixaEtaria), 0) FROM Dim_Faixa_Etaria;

INSERT INTO Dim_Faixa_Etaria (IdFaixaEtaria, nomeFaixaEtaria)
SELECT
    @MaxFaixaId + ROW_NUMBER() OVER (ORDER BY t.[Grupos de anos de estudo]) AS NovoIdFaixa,
    t.[Grupos de anos de estudo] AS nomeFaixaEtaria
FROM (
    SELECT DISTINCT [Grupos de anos de estudo] 
    FROM tabela7134
    WHERE [Grupos de anos de estudo] COLLATE Latin1_General_BIN IS NOT NULL
) AS t
WHERE NOT EXISTS (
    SELECT 1 
    FROM Dim_Faixa_Etaria d 
    WHERE d.nomeFaixaEtaria = t.[Grupos de anos de estudo] COLLATE Latin1_General_BIN
);

-- Passar dados 7134

ALTER TABLE Fact_Escolaridade alter column QuantidadeDeEstudantes varchar(255);

INSERT INTO Fact_Escolaridade (
    IdLocal,
    IdFaixaEtaria,
    IdAno,
    IdGrupoDemo,
    QuantidadeDeEstudantes
)
SELECT
    d_loc.IdLocal,
    d_faixa.IdFaixaEtaria,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS QuantidadeDeEstudantes 
FROM
    tabela7134 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Faixa_Etaria AS d_faixa 
    ON src.[Grupos de anos de estudo] COLLATE Latin1_General_BIN = d_faixa.nomeFaixaEtaria
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo 
    ON src.[Cor ou raça] = d_demo.nomeGrupoDemo;
GO








--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7215 - Pessoas de 14 a 29 anos que não frequentam escola e que frequentaram no máximo o ensino médio ou curso equivalente sem o completar, por sexo e idade que deixou de frequentar escola pela última vez
--  Linha 2: Variável - Pessoas de 14 a 29 anos que não frequentam escola e que frequentaram no máximo o ensino médio ou curso equivalente sem o completar
--  Linha 3: Grande Região;"Idade que deixou de frequentar escola pela última vez";"Ano x Sexo

-- Passar dados 7215

ALTER TABLE Fact_Escolaridade alter column IdadeQueDeixouDeFrequentarEscola varchar(255);

INSERT INTO Fact_Escolaridade (
    IdLocal,
    IdAno,
    IdGrupoDemo,
    IdadeQueDeixouDeFrequentarEscola
)
SELECT
    d_loc.IdLocal,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS IdadeQueDeixouDeFrequentarEscola
FROM
    tabela7215 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Grande Região] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo 
    ON src.Sexo = d_demo.nomeGrupoDemo;
GO










 --Arquivo: tabela6821.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6821 - Domicílios e Moradores, por condição de ocupação do domicílio
--  Linha 2: Variável - Domicílios
--  Linha 3: Unidade da Federação;"Ano x Condição de ocupação do domicílio
-- Criar faixa etaria caso não tenha.


-- Passar dados 6821
ALTER TABLE Fact_Domicilio alter column QuantidadeDeDomicilios varchar(255);


INSERT INTO Fact_Domicilio (
    IdLocal,
    IdAno,
    IdCondDomi,
    QuantidadeDeDomicilios
)
SELECT
    d_loc.IdLocal,
    d_ano.IdAno,
    d_demo.IdCondDomi,
    src.Valor AS QuantidadeDeDomicilios 
FROM
    tabela6821 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_Condicao_Domicilio AS d_demo 
    ON src.[Condição de ocupação do domicílio] = d_demo.nomeDaCondicao;
GO












-- Criar faixa etaria caso não tenha.

DECLARE @MaxFaixaId INT;
SELECT @MaxFaixaId = ISNULL(MAX(IdFaixaEtaria), 0) FROM Dim_Faixa_Etaria;

INSERT INTO Dim_Faixa_Etaria (IdFaixaEtaria, nomeFaixaEtaria)
SELECT
    @MaxFaixaId + ROW_NUMBER() OVER (ORDER BY t.[Grupo de idade]) AS NovoIdFaixa,
    t.[Grupo de idade] AS nomeFaixaEtaria
FROM (
    SELECT DISTINCT [Grupo de idade] 
    FROM tabela7113
    WHERE [Grupo de idade] COLLATE Latin1_General_BIN IS NOT NULL
) AS t
WHERE NOT EXISTS (
    SELECT 1 
    FROM Dim_Faixa_Etaria d 
    WHERE d.nomeFaixaEtaria = t.[Grupo de idade] COLLATE Latin1_General_BIN
);

-- Passar dados 7113
ALTER TABLE Fact_Analfabetismo alter column TaxaDeAnalfabetismo varchar(255);


INSERT INTO Fact_Analfabetismo (
    IdLocal,
    IdFaixaEtaria,
    IdAno,
    IdGrupoDemo,
    TaxaDeAnalfabetismo
)
SELECT
    d_loc.IdLocal,
    d_faixa.IdFaixaEtaria,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS TaxaDeAnalfabetismo
FROM
    tabela7113 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Faixa_Etaria AS d_faixa 
    ON src.[Grupo de idade] COLLATE Latin1_General_BIN = d_faixa.nomeFaixaEtaria
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo 
    ON src.Sexo = d_demo.nomeGrupoDemo;
GO










-- Criar faixa etaria caso não tenha.

DECLARE @MaxFaixaId INT;
SELECT @MaxFaixaId = ISNULL(MAX(IdFaixaEtaria), 0) FROM Dim_Faixa_Etaria;

INSERT INTO Dim_Faixa_Etaria (IdFaixaEtaria, nomeFaixaEtaria)
SELECT
    @MaxFaixaId + ROW_NUMBER() OVER (ORDER BY t.[Grupo de idade]) AS NovoIdFaixa,
    t.[Grupo de idade] AS nomeFaixaEtaria
FROM (
    SELECT DISTINCT [Grupo de idade] 
    FROM tabela7111
    WHERE [Grupo de idade] COLLATE Latin1_General_BIN IS NOT NULL
) AS t
WHERE NOT EXISTS (
    SELECT 1 
    FROM Dim_Faixa_Etaria d 
    WHERE d.nomeFaixaEtaria = t.[Grupo de idade] COLLATE Latin1_General_BIN
);

-- Passar dados 7111
ALTER TABLE Fact_Analfabetismo alter column PessoasAnalfabetas varchar(255);


INSERT INTO Fact_Analfabetismo (
    IdLocal,
    IdFaixaEtaria,
    IdAno,
    IdGrupoDemo,
    PessoasAnalfabetas
)
SELECT
    d_loc.IdLocal,
    d_faixa.IdFaixaEtaria,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS PessoasAnalfabetas
FROM
    tabela7111 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Faixa_Etaria AS d_faixa 
    ON src.[Grupo de idade] COLLATE Latin1_General_BIN = d_faixa.nomeFaixaEtaria
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo 
    ON src.Sexo = d_demo.nomeGrupoDemo;
GO













-- Criar faixa etaria caso não tenha.

-- Passar dados 7395
ALTER TABLE Fact_Rendimento alter column RendimentoMedioMensal varchar(255);


INSERT INTO Fact_Rendimento (
    IdLocal,
    IdAno,
    RendimentoMedioMensal
)
SELECT
    d_loc.IdLocal,
    d_ano.IdAno,
    src.Valor AS RendimentoMedioMensal
FROM
    tabela7395 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
GO







--Arquivo: tabela7128.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7128 - Pessoas de 14 anos ou mais de idade, por sexo e nível de instrução
--  Linha 2: Variável - Pessoas de 14 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Nível de instrução";"Ano x Sexo


-- Criar faixa etaria caso não tenha.

-- Passar dados 7128
ALTER TABLE Fact_Populacao alter column Populacao varchar(255);
ALTER TABLE Fact_Populacao add FaixaEtariaFixa varchar(255);


INSERT INTO Fact_Populacao (
    IdLocal,
    FaixaEtariaFixa,
    IdAno,
    IdGrupoDemo,
    Populacao
)
SELECT
    d_loc.IdLocal,
    '14 anos ou mais de idade',
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS Populacao
FROM
    tabela7128 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo 
    ON src.Sexo = d_demo.nomeGrupoDemo;
GO









--Arquivo: tabela4708.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 4708 - Taxa de informalidade das pessoas de 14 anos ou mais de idade ocupadas na semana de referência
--  Linha 2: Variável - Taxa de informalidade das pessoas de 14 anos ou mais de idade ocupadas na semana de referência
--  Linha 3: Unidade da Federação;"Ano
-- Comentario do Nellaf (joinha) : Vai ter que colocar a faixa etaria manualmente, eu acho.

-- Criar faixa etaria caso não tenha.

-- Passar dados 4708
ALTER TABLE Fact_Informalidade alter column TaxaDeInformalidade varchar(255);
ALTER TABLE Fact_Informalidade add FaixaEtariaFixa varchar(255);


INSERT INTO Fact_Informalidade (
    IdLocal,
    FaixaEtariaFixa,
    IdAno,
    TaxaDeInformalidade
)
SELECT
    d_loc.IdLocal,
    '14 anos ou mais de idade',
    d_ano.IdAno,
    src.Valor AS TaxaDeInformalidade
FROM
    tabela4708 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
GO













--Arquivo: tabela4361.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 4361 - Pessoas de 14 anos ou mais de idade, ocupadas na semana de referência, por posição na ocupação e categoria do emprego no trabalho principal
--  Linha 2: Variável - Pessoas de 14 anos ou mais de idade ocupadas na semana de referência
--  Linha 3: Unidade da Federação;"Ano x Posição na ocupação e categoria do emprego no trabalho principal

-- Criar faixa etaria caso não tenha.

DECLARE @MaxFaixaId INT;
SELECT @MaxFaixaId = ISNULL(MAX(IdEmprego), 0) FROM Dim_Emprego;

INSERT INTO Dim_Emprego (IdEmprego, nomeEmprego)
SELECT
    @MaxFaixaId + ROW_NUMBER() OVER (ORDER BY t.[Posição na ocupação e categoria do emprego no trabalho principal]) AS IdEmprego,
    t.[Posição na ocupação e categoria do emprego no trabalho principal] AS nomeEmprego
FROM (
    SELECT DISTINCT [Posição na ocupação e categoria do emprego no trabalho principal] 
    FROM tabela4361
    WHERE [Posição na ocupação e categoria do emprego no trabalho principal] COLLATE Latin1_General_BIN IS NOT NULL
) AS t
WHERE NOT EXISTS (
    SELECT 1 
    FROM Dim_Emprego d 
    WHERE d.nomeEmprego = t.[Posição na ocupação e categoria do emprego no trabalho principal] COLLATE Latin1_General_BIN
);


-- Passar dados 4361
ALTER TABLE Fact_Ocupacao alter column QuantidadeDePessoas varchar(255);
ALTER TABLE Fact_Ocupacao add FaixaEtariaFixa varchar(255);


INSERT INTO Fact_Ocupacao (
    IdLocal,
    FaixaEtariaFixa,
    IdAno,
    IdEmprego,
    QuantidadeDePessoas
)
SELECT
    d_loc.IdLocal,
    '14 anos ou mais de idade ocupadas na semana de referência',
    d_ano.IdAno,
    d_emprego.IdEmprego,
    src.Valor AS QuantidadeDePessoas
FROM
    tabela4361 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_Emprego AS d_emprego 
    ON src.[Posição na ocupação e categoria do emprego no trabalho principal] = d_emprego.nomeEmprego
GO











