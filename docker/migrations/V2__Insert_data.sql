use SistemaGerenciamento;

INSERT INTO Dim_Local (IdLocal, nome)
VALUES
(1, 'Brasil'),
(2, 'Norte'),
(3, 'Nordeste'),
(4, 'Centro-Oeste'),
(5, 'Sudeste'),
(6, 'Sul'),
(7, 'Acre'),
(8, 'Alagoas'),
(9, 'Amapá'),
(10, 'Amazonas'),
(11, 'Bahia'),
(12, 'Ceará'),
(13, 'Distrito Federal'),
(14, 'Espírito Santo'),
(15, 'Goiás'),
(16, 'Maranhão'),
(17, 'Mato Grosso'),
(18, 'Mato Grosso do Sul'),
(19, 'Minas Gerais'),
(20, 'Pará'),
(21, 'Paraíba'),
(22, 'Paraná'),
(23, 'Pernambuco'),
(24, 'Piauí'),
(25, 'Rio de Janeiro'),
(26, 'Rio Grande do Norte'),
(27, 'Rio Grande do Sul'),
(28, 'Rondônia'),
(29, 'Roraima'),
(30, 'Santa Catarina'),
(31, 'São Paulo'),
(32, 'Sergipe'),
(33, 'Tocantins');
GO





INSERT INTO Dim_GrupoDemografico(IdGrupoDemo, nomeGrupoDemo)
VALUES
(1, 'Homens'),
(2, 'Mulheres'),
(3, 'Branca'),
(4, 'Parda'),
(5, 'Amarela'),
(6, 'Indígena'),
(7, 'Preta'),
(8, 'Urbana'),
(9,'Rural');
GO


 




INSERT INTO Dim_Ano (IdAno,ano)
VALUES
(1, 2012),
(2, 2013),
(3, 2014),
(4, 2015),
(5, 2016),
(6, 2017),
(7, 2018),
(8, 2019),
(9, 2020),
(10, 2021),
(11, 2022),
(12, 2023),
(13, 2024);
GO








INSERT INTO Dim_Instrucao (IdInstru,nomeInstru)
VALUES
(1,'Sem instrução'),
(2, 'Ensino fundamental incompleto ou equivalente'),
(3, 'Ensino fundamental completo ou equivalente'),
(4, 'Ensino médio incompleto ou equivalente'),
(5, 'Ensino médio completo ou equivalente'),
(6, 'Ensino superior incompleto ou equivalente'),
(7, 'Superior completo'),
(8, 'Sem instrução e fundamental incompleto'),
(9, 'Fundamental completo e médio incompleto'),
(10, 'Médio completo e superiro incompleto');
GO








INSERT INTO Dim_Emprego (IdEmprego, nomeEmprego, empregado) 
VALUES
-- Categorias principais
(1, 'Total', NULL),
(2, 'Empregado', 'Sim'),
(3, 'Empregado no setor privado, exclusive trabalhador doméstico', 'Sim'),
(4, 'Empregado no setor privado - com carteira assinada', 'Sim'),
(5, 'Empregado no setor privado - sem carteira assinada', 'Sim'),
(6, 'Trabalhador doméstico', 'Sim'),
(7, 'Trabalhador doméstico - com carteira assinada', 'Sim'),
(8, 'Trabalhador doméstico - sem carteira assinada', 'Sim'),
(9, 'Empregado no setor público', 'Sim'),
(10, 'Empregado no setor público - com carteira assinada', 'Sim'),
(11, 'Empregado no setor público - sem carteira assinada', 'Sim'),
(12, 'Empregado no setor público - militar e funcionário público estatutário', 'Sim'),
(13, 'Empregador', 'Não'),
(14, 'Empregador com CNPJ', 'Não'),
(15, 'Empregador sem CNPJ', 'Não'),
(16, 'Conta própria', 'Não'),
(17, 'Conta própria com CNPJ', 'Não'),
(18, 'Conta própria sem CNPJ', 'Não'),
(19, 'Trabalhador familiar auxiliar', 'Não'),
(20, 'Força de trabalho ampliada', NULL),
(21, 'Força de trabalho ou desalentado', NULL),
(22, 'Desocupado ou na força de trabalho potencial ou subocupado', NULL),
(23, 'Desocupado ou subocupado por insuficiência de horas trabalhadas', NULL),
(24, 'Desocupado', 'Não'),
(25, 'Subocupado por insuficiência de horas trabalhadas', 'Sim'),
(26, 'Desocupado ou na força de trabalho potencial', NULL),
(27, 'Força de trabalho potencial', NULL),
(28, 'Desalentado', NULL),
(29, 'Ocupados', 'Sim'),
(30, 'Desocupados', 'Não'),
(31, 'Fora da força de trabalho', 'Não');
GO








INSERT INTO Dim_Condicao_Domicilio (
    IdCondDomi, 
    nomeDaCondicao, 
    disponibilidadeAgua, 
    AbastecimentoAgua, 
    TipoEsgoto, 
    DestinoLixo, 
    FonteDeEnergia
)
SELECT DISTINCT 
    ROW_NUMBER() OVER (ORDER BY 
        COALESCE(nomeDaCondicao, ''), 
        COALESCE(disponibilidadeAgua, ''), 
        COALESCE(AbastecimentoAgua, ''), 
        COALESCE(TipoEsgoto, ''), 
        COALESCE(DestinoLixo, ''), 
        COALESCE(FonteDeEnergia, '')
    ) as IdCondDomi,
    nomeDaCondicao,
    disponibilidadeAgua,
    AbastecimentoAgua,
    TipoEsgoto,
    DestinoLixo,
    FonteDeEnergia
FROM (
    SELECT DISTINCT 
        [Situação do domicílio] as nomeDaCondicao,
        NULL as disponibilidadeAgua,
        NULL as AbastecimentoAgua,
        NULL as TipoEsgoto,
        NULL as DestinoLixo,
        NULL as FonteDeEnergia
    FROM tabela6731
    
    UNION
    
    SELECT DISTINCT 
        [Situação do domicílio] as nomeDaCondicao,
        [Disponibilidade da rede geral de distribuição de água] as disponibilidadeAgua,
        NULL as AbastecimentoAgua,
        NULL as TipoEsgoto,
        NULL as DestinoLixo,
        NULL as FonteDeEnergia
    FROM tabela6732
    
    UNION
    
    SELECT DISTINCT 
        NULL as nomeDaCondicao,
        NULL as disponibilidadeAgua,
        [Principal fonte de abastecimento de água] as AbastecimentoAgua,
        NULL as TipoEsgoto,
        NULL as DestinoLixo,
        NULL as FonteDeEnergia
    FROM tabela6731
    
    UNION
    
    SELECT DISTINCT 
        NULL as nomeDaCondicao,
        NULL as disponibilidadeAgua,
        NULL as AbastecimentoAgua,
        [Tipo de esgotamento sanitário] as TipoEsgoto,
        NULL as DestinoLixo,
        NULL as FonteDeEnergia
    FROM tabela6735
    
    UNION
    
    SELECT DISTINCT 
        NULL as nomeDaCondicao,
        NULL as disponibilidadeAgua,
        NULL as AbastecimentoAgua,
        NULL as TipoEsgoto,
        [Destino do lixo] as DestinoLixo,
        NULL as FonteDeEnergia
    FROM tabela6736
    
    UNION
    
    SELECT DISTINCT 
        NULL as nomeDaCondicao,
        NULL as disponibilidadeAgua,
        NULL as AbastecimentoAgua,
        NULL as TipoEsgoto,
        NULL as DestinoLixo,
        [Fonte de energia elétrica] as FonteDeEnergia
    FROM tabela6737
    
    UNION
    
    SELECT DISTINCT 
        [Condição de ocupação do domicílio] as nomeDaCondicao,
        NULL as disponibilidadeAgua,
        NULL as AbastecimentoAgua,
        NULL as TipoEsgoto,
        NULL as DestinoLixo,
        NULL as FonteDeEnergia
    FROM tabela6821
) AS AllCondicoes;
GO










INSERT INTO Dim_Saneamento (IdSaneamento, nomeSaneamento)
VALUES
(1, 'Rede geral de abastecimento de água'),
(2, 'Poço profundo ou artesiano'),
(3, 'Poço raso ou cacimba'),
(4, 'Fonte, nascente ou rio'),
(5, 'Carro-pipa ou outro meio de abastecimento'),
(6, 'Sem abastecimento de água'),
(7, 'Rede geral de esgoto ou pluvial'),
(8, 'Fossa séptica'),
(9, 'Fossa rudimentar'),
(10, 'Céu aberto / vala / curso d’água'),
(11, 'Sem esgotamento sanitário'),
(12, 'Coleta pública de lixo'),
(13, 'Queima do lixo no terreno ou quintal'),
(14, 'Enterra o lixo no terreno'),
(15, 'Joga o lixo em terreno baldio'),
(16, 'Joga o lixo em rio, lago ou mar'),
(17, 'Sem destino definido para o lixo'),
(18, 'Saneamento completo (água, esgoto e lixo adequados)'),
(19, 'Saneamento precário (pelo menos um serviço ausente)'),
(20, 'Sem saneamento básico');
GO










INSERT INTO Dim_Condicao_Estudante (IdCondEstudante, nomeDaCondicao)
VALUES
(1, 'Frequentando escola ou creche'),
(2, 'Já frequentou escola'),
(3, 'Nunca frequentou escola'),
(4, 'Frequentando curso técnico ou profissionalizante'),
(5, 'Frequentando curso superior'),
(6, 'Frequentando Educação de Jovens e Adultos (EJA)'),
(7, 'Frequentando curso preparatório ou supletivo'),
(8, 'Não frequenta atualmente, mas concluiu os estudos'),
(9, 'Não frequenta atualmente e não concluiu'),
(10, 'Parou de estudar por trabalho'),
(11, 'Parou de estudar por falta de interesse'),
(12, 'Parou de estudar por dificuldade financeira'),
(13, 'Parou de estudar por distância da escola'),
(14, 'Parou de estudar por motivo de saúde ou deficiência'),
(15, 'Parou de estudar por motivo familiar ou doméstico'),
(16, 'Nunca teve acesso à escola'),
(17, 'Frequenta curso de alfabetização de adultos'),
(18, 'Frequenta outro tipo de curso educacional'),
(19, 'Em idade escolar e não frequenta'),
(20, 'Concluiu a educação básica'),
(21, 'Concluiu curso superior'),
(22, 'Abandono escolar recente'),
(23, 'Retornou aos estudos após pausa');
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
    FROM tabela7126
    WHERE [Grupo de idade] IS NOT NULL
) AS t
WHERE NOT EXISTS (
    SELECT 1 
    FROM Dim_Faixa_Etaria d 
    WHERE d.nomeFaixaEtaria COLLATE Latin1_General_BIN = t.[Grupo de idade] COLLATE Latin1_General_BIN
);
GO

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
GO









-- Passar dados 7133
ALTER TABLE Fact_Escolaridade alter column QuantidadeDeEstudantes varchar(255);
GO

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
GO









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
GO









-- Passar dados 7134

ALTER TABLE Fact_Escolaridade alter column QuantidadeDeEstudantes varchar(255);
GO

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
GO

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
GO

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
GO





















-- Passar dados 7113
ALTER TABLE Fact_Analfabetismo alter column TaxaDeAnalfabetismo varchar(255);
GO

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
GO















-- Passar dados 7111
ALTER TABLE Fact_Analfabetismo alter column PessoasAnalfabetas varchar(255);
GO

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
















-- Passar dados 7146

ALTER TABLE Fact_Estudante ADD IdGrupoDemo INT CONSTRAINT FK_Fact_GrupoDemoEstudante FOREIGN KEY (IdGrupoDemo) REFERENCES Dim_GrupoDemografico (IdGrupoDemo);
GO

ALTER TABLE Fact_Estudante alter column QuantidadeDeEstudantes varchar(255);

INSERT INTO Dim_GrupoDemografico(IdGrupoDemo, nomeGrupoDemo)
VALUES
(10, 'Preta ou parda');

INSERT INTO Fact_Estudante (
    IdLocal,
    TipoDeEnsinoSuperior,
    IdAno,
	IdGrupoDemo,
	QuantidadeDeEstudantes
)
SELECT
    d_loc.IdLocal,
    src.[Tipo de ensino superior] AS TipoDeEnsinoSuperior,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS QuantidadeDeEstudantes
FROM
    tabela7146 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Grande Região] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_GrupoDemografico AS d_demo
    ON src.[Cor ou raça] COLLATE Latin1_General_BIN = d_demo.nomeGrupoDemo
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano;
GO









-- Passar dados 7147

INSERT INTO Fact_Estudante (
    IdLocal,
    TipoDeEnsinoSuperior,
    IdAno,
	IdGrupoDemo,
	QuantidadeDeEstudantes
)
SELECT
    d_loc.IdLocal,
    src.[Tipo de ensino superior] AS TipoDeEnsinoSuperior,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS QuantidadeDeEstudantes
FROM
    tabela7147 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Grande Região] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_GrupoDemografico AS d_demo
    ON src.Sexo COLLATE Latin1_General_BIN = d_demo.nomeGrupoDemo
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano;
GO


















-- Passar dados 6407
ALTER TABLE Fact_Populacao alter column Populacao varchar(255);
INSERT INTO Fact_Populacao (
    IdLocal,
    IdFaixaEtaria,
    IdAno,
	IdGrupoDemo,
	Populacao
)
SELECT
    d_loc.IdLocal,
    d_faixa.IdFaixaEtaria,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS Populacao
FROM
    tabela6407 AS src
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
    ON src.Sexo COLLATE Latin1_General_BIN = d_demo.nomeGrupoDemo;
GO














-- Passar dados 7177

INSERT INTO Dim_Condicao_Estudante (IdCondEstudante, nomeDaCondicao)
VALUES
	(24, 'Frequenta curso de qualificação profissional'),
	(25, 'Não frequenta curso de qualificação profissional');
GO

INSERT INTO Dim_Faixa_Etaria (IdFaixaEtaria, nomeFaixaEtaria)
VALUES
	(15, '14 anos ou mais');
GO
	
INSERT INTO Fact_Escolaridade (
	IdFaixaEtaria,
    IdLocal,
    FrequenciaCursoQualProfissional,
    IdAno,
	IdGrupoDemo,
	QuantidadeDeEstudantes
)
SELECT
	d_faixa.IdFaixaEtaria,
    d_loc.IdLocal,
    d_freq.IdCondEstudante,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS QuantidadeDeEstudantes
FROM
    tabela7177 AS src
LEFT JOIN
	Dim_Faixa_Etaria AS d_faixa
	ON d_faixa.nomeFaixaEtaria COLLATE Latin1_General_BIN = '14 anos ou mais'
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Grande Região] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Condicao_Estudante AS d_freq
    ON src.[Frequência a curso de qualificação profissional] COLLATE Latin1_General_BIN = d_freq.nomeDaCondicao
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo
    ON src.Sexo COLLATE Latin1_General_BIN = d_demo.nomeGrupoDemo;
GO









-- Passar dados 7178
	
INSERT INTO Fact_Escolaridade (
	IdFaixaEtaria,
    IdLocal,
    FrequenciaCursoQualProfissional,
    IdAno,
	IdGrupoDemo,
	QuantidadeDeEstudantes
)
SELECT
	d_faixa.IdFaixaEtaria,
    d_loc.IdLocal,
    d_freq.IdCondEstudante,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS QuantidadeDeEstudantes
FROM
    tabela7178 AS src
LEFT JOIN
	Dim_Faixa_Etaria AS d_faixa
	ON d_faixa.nomeFaixaEtaria COLLATE Latin1_General_BIN = '14 anos ou mais'
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Grande Região] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Condicao_Estudante AS d_freq
    ON src.[Frequência a curso de qualificação profissional] COLLATE Latin1_General_BIN = d_freq.nomeDaCondicao
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo
    ON src.[Cor ou raça] COLLATE Latin1_General_BIN = d_demo.nomeGrupoDemo;
GO












-- Passar dados 7210

INSERT INTO Dim_Condicao_Estudante (IdCondEstudante, nomeDaCondicao)
VALUES
	(26, 'Concluiu curso técnico de nível médio ou curso normal (magistério)'),
	(27, 'Nunca frequentou ou não concluiu curso técnico de nível médio ou curso normal (magistério)');
GO
	
INSERT INTO Fact_Escolaridade (
    IdLocal,
    FrequenciaCursoQualProfissional,
    IdAno,
	IdGrupoDemo,
	QuantidadeDeEstudantes
)
SELECT
    d_loc.IdLocal,
    d_freq.IdCondEstudante,
    d_ano.IdAno,
    d_demo.IdGrupoDemo,
    src.Valor AS QuantidadeDeEstudantes
FROM
    tabela7210 AS src
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Grande Região] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Condicao_Estudante AS d_freq
    ON src.[Conclusão do curso técnico de nível médio ou normal (magistério)] COLLATE Latin1_General_BIN = d_freq.nomeDaCondicao
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_GrupoDemografico AS d_demo
    ON src.Sexo COLLATE Latin1_General_BIN = d_demo.nomeGrupoDemo;
GO









-- Passar dados 4666

INSERT INTO Dim_Emprego (IdEmprego, nomeEmprego)
VALUES
	(32, 'Desocupado ou na força de trabalho potencial ou subocupado por insuficiência de horas trabalhadas')

alter table Fact_Ocupacao alter column QuantidadeDePessoas varchar(255);

INSERT INTO Fact_Ocupacao (
	IdFaixaEtaria,
    IdLocal,
    IdAno,
	IdEmprego,
	QuantidadeDePessoas
)
SELECT
	d_faixa.IdFaixaEtaria,
    d_loc.IdLocal,
    d_ano.IdAno,
    d_empr.IdEmprego,
    src.Valor AS QuantidadeDeEstudantes
FROM
    tabela4666 AS src
LEFT JOIN
	Dim_Faixa_Etaria AS d_faixa
	ON d_faixa.nomeFaixaEtaria COLLATE Latin1_General_BIN = '14 anos ou mais'
LEFT JOIN
    Dim_Local AS d_loc 
    ON src.[Unidade da Federação] COLLATE Latin1_General_BIN = d_loc.nome
LEFT JOIN
    Dim_Ano AS d_ano 
    ON src.Ano = d_ano.ano
LEFT JOIN
    Dim_Emprego AS d_empr
    ON src.[Tipo de medida de subutilização da força de trabalho na semana de referência] COLLATE Latin1_General_BIN = d_empr.nomeEmprego
GO




