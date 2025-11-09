CREATE TABLE Dim_Ano (
    IdAno INT PRIMARY KEY,
    ano int
);

CREATE TABLE Dim_Local (
    IdLocal INT PRIMARY KEY,
    nome varchar(255)
);

-- Etnias/generos/grupos demograficos
CREATE TABLE Dim_GrupoDemografico (
    IdGrupoDemo INT PRIMARY KEY,
    nomeGrupoDemo varchar(255)
);

CREATE TABLE Dim_Faixa_Etaria (
    IdFaixaEtaria INT PRIMARY KEY,
    nomeFaixaEtaria varchar(255)
);


--Existência de microcomputador ou tablet no domicílio / Existência de utilização da Internet no domicílio / Tudo isso entraria aqui
CREATE TABLE Dim_Condicao_Domicilio (
    IdCondDomi INT PRIMARY KEY,
    nomeDaCondicao varchar(255),
    disponibilidadeAgua varchar(255),
    AbastecimentoAgua varchar(255),
    TipoEsgoto varchar(255),
    DestinoLixo varchar(255),
    FonteDeEnergia varchar(255),
);

CREATE TABLE Dim_Condicao_Estudante (
    IdCondEstudante INT PRIMARY KEY,
    nomeDaCondicao varchar(255)
);

CREATE TABLE Dim_Instrucao (
    IdInstru INT PRIMARY KEY,
    nomeInstru varchar(255)
);

CREATE TABLE Dim_Emprego (
    IdEmprego INT PRIMARY KEY,
    nomeEmprego varchar(255),
    empregado varchar(255),
);

CREATE TABLE Dim_Saneamento (
    IdSaneamento INT PRIMARY KEY,
    nomeSaneamento varchar(255)
);




CREATE TABLE Fact_Escolaridade (
    IdEscolaridade INT IDENTITY(1,1) PRIMARY KEY,
    IdLocal INT,
    IdFaixaEtaria INT,
    IdAno INT,
    IdGrupoDemo INT,
    TaxaDeEscolarizacao INT,
    NumeroMedioDeAnosDeEstudo INT,
    QuantidadeDeEstudantes INT,
    GrupoDeAnosDeEstudo varchar(255),
    IdadeQueDeixouDeFrequentarEscola INT,
    PrincipalMotivoNãoFrequentarEscola varchar(255),
    FrequenciaCursoQualProfissional varchar(255),

    CONSTRAINT FK_Fact_Local FOREIGN KEY (IdLocal)
        REFERENCES Dim_Local (IdLocal),

    CONSTRAINT FK_Fact_FaixaEtaria FOREIGN KEY (IdFaixaEtaria)
        REFERENCES Dim_Faixa_Etaria (IdFaixaEtaria),

    CONSTRAINT FK_Fact_Ano FOREIGN KEY (IdAno)
        REFERENCES Dim_Ano (IdAno),

    CONSTRAINT FK_Fact_GrupoDemo FOREIGN KEY (IdGrupoDemo)
        REFERENCES Dim_GrupoDemografico (IdGrupoDemo)
);
-- Arquivo: tabela7138.csv
-- Primeiras linhas:
--  Linha 1: ﻿"Tabela 7138 - Taxa de escolarização, por sexo e grupo de idade
--   Linha 2: Variável - Taxa de escolarização
--   Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Sexo
 
-- Arquivo: tabela7139.csv
-- Primeiras linhas:
--   Linha 1: ﻿"Tabela 7139 - Taxa de escolarização, por cor ou raça e grupo de idade
--   Linha 2: Variável - Taxa de escolarização
--   Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Cor ou raça
--Arquivo: tabela7126.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7126 - Número médio de anos de estudo das pessoas de 15 anos ou mais, por sexo e grupo de idade
--  Linha 2: Variável - Número médio de anos de estudo das pessoas de 15 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Sexo

--Arquivo: tabela7127.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7127 - Número médio de anos de estudo das pessoas de 15 anos ou mais, por cor ou raça e grupo de idade
--  Linha 2: Variável - Número médio de anos de estudo das pessoas de 15 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Cor ou raça
--Arquivo: tabela7126.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7126 - Número médio de anos de estudo das pessoas de 15 anos ou mais, por sexo e grupo de idade
--  Linha 2: Variável - Número médio de anos de estudo das pessoas de 15 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Sexo
--Arquivo: tabela7133.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7133 - Pessoas de 25 anos ou mais de idade, por sexo e grupos de anos de estudo
--  Linha 2: Variável - Pessoas de 25 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Grupos de anos de estudo";"Ano x Sexo
--Arquivo: tabela7134.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7134 - Pessoas de 25 anos ou mais de idade, por cor ou raça e grupos de anos de estudo
--  Linha 2: Variável - Pessoas de 25 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Grupos de anos de estudo";"Ano x Cor ou raça
--Arquivo: tabela7215.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7215 - Pessoas de 14 a 29 anos que não frequentam escola e que frequentaram no máximo o ensino médio ou curso equivalente sem o completar, por sexo e idade que deixou de frequentar escola pela última vez
--  Linha 2: Variável - Pessoas de 14 a 29 anos que não frequentam escola e que frequentaram no máximo o ensino médio ou curso equivalente sem o completar
--  Linha 3: Grande Região;"Idade que deixou de frequentar escola pela última vez";"Ano x Sexo
--Arquivo: tabela7219.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7219 - Pessoas de 15 a 29 anos de idade com nível de instrução inferior ao médio completo e que não frequentam escola, curso técnico, normal (magistério), pré-vestibular ou curso de qualificação profissional, por sexo e principal motivo de atualmente não frequentar
--  Linha 2: Variável - Pessoas de 15 a 29 anos de idade com nível de instrução inferior ao médio completo e que não frequentam escola, curso técnico, normal (magistério), pré-vestibular ou curso de qualificação profissional
--  Linha 3: Grande Região;"Principal motivo de atualmente não frequentar escola ou outro curso";"Ano x Sexo

--Arquivo: tabela7220.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7220 - Pessoas de 15 a 29 anos de idade com nível de instrução inferior ao médio completo e que não frequentam escola, curso técnico, normal (magistério), pré-vestibular ou curso de qualificação profissional, por cor ou raça e principal motivo de atualmente não frequentar
--  Linha 2: Variável - Pessoas de 15 a 29 anos de idade com nível de instrução inferior ao médio completo e que não frequentam escola, curso técnico, normal (magistério), pré-vestibular ou curso de qualificação profissional
--  Linha 3: Grande Região;"Principal motivo de atualmente não frequentar escola ou outro curso";"Ano x Cor ou raça

--Arquivo: tabela7221.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7221 - Pessoas de 15 a 29 anos com o ensino médio completo ou superior incompleto que não frequentam escola, curso técnico, normal (magistério), pré-vestibular ou curso de qualificação profissional, por sexo e principal motivo de atualmente não frequentar
--  Linha 2: Variável - Pessoas de 15 a 29 anos com o ensino médio completo ou superior incompleto que não frequentam escola, curso técnico, normal (magistério), pré-vestibular ou curso de qualificação profissional
--  Linha 3: Grande Região;"Principal motivo de atualmente não frequentar escola ou outro curso";"Ano x Sexo

--Arquivo: tabela7222.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7222 - Pessoas de 15 a 29 anos com o ensino médio completo ou superior incompleto que não frequentam escola, curso técnico, normal (magistério), pré-vestibular ou curso de qualificação profissional, por cor ou raça e principal motivo de atualmente não frequentar
--  Linha 2: Variável - Pessoas de 15 a 29 anos com o ensino médio completo ou superior incompleto que não frequentam escola, curso técnico, normal (magistério), pré-vestibular ou curso de qualificação profissional
--  Linha 3: Grande Região;"Principal motivo de atualmente não frequentar escola ou outro curso";"Ano x Cor ou raça
--Arquivo: tabela7177.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7177 - Pessoas de 14 anos ou mais de idade que estudam até o ensino fundamental (regular ou EJA) e aquelas que frequentaram no máximo o ensino médio ou curso equivalente sem o completar, por sexo e frequência a curso de qualificação profissional
--  Linha 2: Variável - Pessoas de 14 anos ou mais de idade que estudam até o ensino fundamental (regular ou EJA) e aquelas que frequentaram no máximo o ensino médio ou curso equivalente sem o completar
--  Linha 3: Grande Região;"Frequência a curso de qualificação profissional";"Ano x Sexo

--Arquivo: tabela7178.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7178 - Pessoas de 14 anos ou mais de idade que estudam até o ensino fundamental (regular ou EJA) e aquelas que frequentaram no máximo o ensino médio ou curso equivalente sem o completar, por cor ou raça e frequência a curso de qualificação profissional
--  Linha 2: Variável - Pessoas de 14 anos ou mais de idade que estudam até o ensino fundamental (regular ou EJA) e aquelas que frequentaram no máximo o ensino médio ou curso equivalente sem o completar
--  Linha 3: Grande Região;"Frequência a curso de qualificação profissional";"Ano x Cor ou raça

--Arquivo: tabela7210.csv
--Primeiras linhas:
--  Linha 1: ﻿Tabela 7210 - Estudantes do ensino superior, especialização, mestrado ou doutorado, por sexo e conclusão de curso técnico de nível médio ou normal (magistério)
--  Linha 2: Variável - Estudantes do superior, especialização, mestrado ou doutorado (Mil pessoas)
--  Linha 3: Grande Região;Conclusão do curso técnico de nível médio ou normal (magistério);Ano x Sexo

CREATE TABLE Fact_Populacao (
    IdPopulacao INT IDENTITY(1,1) PRIMARY KEY,
    IdLocal INT,
    IdCondDomi INT,
    IdFaixaEtaria INT,
    IdAno INT,
    IdGrupoDemo INT,
    IdInstru INT,
    Populacao INT,
    Deficiencia varchar(255),

    CONSTRAINT FK_Fact_LocalPopulacao FOREIGN KEY (IdLocal)
        REFERENCES Dim_Local (IdLocal),

    CONSTRAINT FK_Fact_FaixaEtariaPopulacao FOREIGN KEY (IdFaixaEtaria)
        REFERENCES Dim_Faixa_Etaria (IdFaixaEtaria),

    CONSTRAINT FK_Fact_AnoPopulacao FOREIGN KEY (IdAno)
        REFERENCES Dim_Ano (IdAno),

    CONSTRAINT FK_Fact_GrupoDemPopulacao FOREIGN KEY (IdGrupoDemo)
        REFERENCES Dim_GrupoDemografico (IdGrupoDemo),

    CONSTRAINT FK_Fact_InstruPopulacao FOREIGN KEY (IdInstru)
        REFERENCES Dim_Instrucao (IdInstru),

    CONSTRAINT FK_Fact_CondDomiPopulacao FOREIGN KEY (IdCondDomi)
        REFERENCES Dim_Condicao_Domicilio (IdCondDomi),
);
--Arquivo: tabela7109.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7109 - População residente, por sexo e grupo de idade
--  Linha 2: Variável - População
--  Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Sexo

--Arquivo: tabela7110.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7110 - População residente, por cor ou raça e grupo de idade
--  Linha 2: Variável - População
--  Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Cor ou raça

--Arquivo: tabela7128.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7128 - Pessoas de 14 anos ou mais de idade, por sexo e nível de instrução
--  Linha 2: Variável - Pessoas de 14 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Nível de instrução";"Ano x Sexo

--Arquivo: tabela7129.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7129 - Pessoas de 14 anos ou mais de idade, por cor ou raça e nível de instrução
--  Linha 2: Variável - Pessoas de 14 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Nível de instrução";"Ano x Cor ou raça

--Arquivo: tabela6407.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6407 - População residente, por sexo e grupos de idade
--  Linha 2: Variável - População
--  Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Sexo

--Arquivo: tabela9297.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 9297 - Pessoas de 25 anos ou mais de idade com deficiência, por nível de instrução
--  Linha 2: Variável - Pessoas de 25 anos ou mais de idade com deficiência
--  Linha 3: Unidade da Federação;"Ano x Nível de instrução

--Arquivo: tabela9311.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 9311 - Pessoas de 25 anos ou mais de idade, por nível de instrução e existência de deficiência
--  Linha 2: Variável - Pessoas de 25 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Existência de deficiência";"Ano x Nível de instrução

--Arquivo: tabela6409.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6409 - População residente, por sexo e condição no domicílio
--  Linha 2: Variável - População
--  Linha 3: Unidade da Federação;"Condição no domicílio";"Ano x Sexo
--Arquivo: tabela7128.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7128 - Pessoas de 14 anos ou mais de idade, por sexo e nível de instrução
--  Linha 2: Variável - Pessoas de 14 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Nível de instrução";"Ano x Sexo
--Arquivo: tabela7135.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7135 - Pessoas de 25 anos ou mais de idade, por cor ou raça e nível de instrução
--  Linha 2: Variável - Pessoas de 25 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Nível de instrução";"Ano x Cor ou raça


CREATE TABLE Fact_Analfabetismo (
    IdAnalfabetismo INT IDENTITY(1,1) PRIMARY KEY,
    IdLocal INT,
    IdFaixaEtaria INT,
    IdAno INT,
    IdGrupoDemo INT,
    TaxaDeAnalfabetismo INT,
    PessoasAnalfabetas INT,

    CONSTRAINT FK_Fact_LocalAnalfabetismo FOREIGN KEY (IdLocal)
        REFERENCES Dim_Local (IdLocal),

    CONSTRAINT FK_Fact_FaixaEtariaAnalfabetismo FOREIGN KEY (IdFaixaEtaria)
        REFERENCES Dim_Faixa_Etaria (IdFaixaEtaria),

    CONSTRAINT FK_Fact_AnoAnalfabetismo FOREIGN KEY (IdAno)
        REFERENCES Dim_Ano (IdAno),

    CONSTRAINT FK_Fact_GrupoDemoAnalfabetismo FOREIGN KEY (IdGrupoDemo)
        REFERENCES Dim_GrupoDemografico (IdGrupoDemo)
);
--Arquivo: tabela7111.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7111 - Pessoas de 15 anos ou mais, analfabetas, por sexo e grupo de idade
--  Linha 2: Variável - Pessoas de 15 anos ou mais de idade, analfabetas
--  Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Sexo

--Arquivo: tabela7113.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7113 - Taxa de analfabetismo das pessoas de 15 anos ou mais de idade, por sexo e grupo de idade
--  Linha 2: Variável - Taxa de analfabetismo das pessoas de 15 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Sexo

CREATE TABLE Fact_Rendimento (
    IdRendimento INT IDENTITY(1,1) PRIMARY KEY,
    IdLocal INT,
    IdAno INT,
    RendimentoMedioMensal INT,

    CONSTRAINT FK_Fact_LocalRendimento FOREIGN KEY (IdLocal)
        REFERENCES Dim_Local (IdLocal),

    CONSTRAINT FK_Fact_AnoRendimento FOREIGN KEY (IdAno)
        REFERENCES Dim_Ano (IdAno),
);
--Arquivo: tabela7395.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7395 - Rendimento médio mensal real domiciliar per capita
--  Linha 2: Variável - Rendimento médio mensal real domiciliar per capita
--  Linha 3: Unidade da Federação;"Ano

CREATE TABLE Fact_Informalidade (
    IdInformalidade INT IDENTITY(1,1) PRIMARY KEY,
    IdLocal INT,
    IdAno INT,
    IdFaixaEtaria INT,
    TaxaDeInformalidade INT,

    CONSTRAINT FK_Fact_LocalInformalidade FOREIGN KEY (IdLocal)
        REFERENCES Dim_Local (IdLocal),

    CONSTRAINT FK_Fact_AnoInformalidade FOREIGN KEY (IdAno)
        REFERENCES Dim_Ano (IdAno),

     CONSTRAINT FK_Fact_FaixaEtariaInformalidade FOREIGN KEY (IdFaixaEtaria)
        REFERENCES Dim_Faixa_Etaria (IdFaixaEtaria),
);
--Arquivo: tabela4708.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 4708 - Taxa de informalidade das pessoas de 14 anos ou mais de idade ocupadas na semana de referência
--  Linha 2: Variável - Taxa de informalidade das pessoas de 14 anos ou mais de idade ocupadas na semana de referência
--  Linha 3: Unidade da Federação;"Ano
-- Comentario do Nellaf (joinha) : Vai ter que colocar a faixa etaria manualmente, eu acho.

CREATE TABLE Fact_Ocupacao (
    IdOcupacao INT IDENTITY(1,1) PRIMARY KEY,
    IdLocal INT,
    IdAno INT,
    IdEmprego INT,
    IdFaixaEtaria INT,
    QuantidadeDePessoas INT,
    Estudante BIT,

    CONSTRAINT FK_Fact_LocalOcupacao FOREIGN KEY (IdLocal)
        REFERENCES Dim_Local (IdLocal),

    CONSTRAINT FK_Fact_AnoOcupacao FOREIGN KEY (IdAno)
        REFERENCES Dim_Ano (IdAno),

     CONSTRAINT FK_Fact_FaixaEtariaOcupacao FOREIGN KEY (IdFaixaEtaria)
        REFERENCES Dim_Faixa_Etaria (IdFaixaEtaria),

    CONSTRAINT FK_Fact_EmpregoOcupacao FOREIGN KEY (IdEmprego)
        REFERENCES Dim_Emprego (IdEmprego)
);

--Arquivo: tabela4361.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 4361 - Pessoas de 14 anos ou mais de idade, ocupadas na semana de referência, por posição na ocupação e categoria do emprego no trabalho principal
--  Linha 2: Variável - Pessoas de 14 anos ou mais de idade ocupadas na semana de referência
--  Linha 3: Unidade da Federação;"Ano x Posição na ocupação e categoria do emprego no trabalho principal

--Arquivo: tabela4666.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 4666 - Pessoas de 14 anos ou mais de idade, por tipo de medida de subutilização da força de trabalho na semana de referência
--  Linha 2: Variável - Pessoas de 14 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Ano x Tipo de medida de subutilização da força de trabalho na semana de referência
--Arquivo: tabela7161.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7161 - Estudantes de 15 anos ou mais de idade, por grupo de idade e situação de ocupação
--  Linha 2: Variável - Estudantes de 15 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Situação de ocupação na semana de referência";"Ano x Grupo de idade
--Arquivo: tabela7159.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7159 - Estudantes de 15 anos ou mais de idade, por sexo e situação de ocupação
--  Linha 2: Variável - Estudantes de 15 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Situação de ocupação na semana de referência";"Ano x Sexo
--Arquivo: tabela7160.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7160 - Estudantes de 15 anos ou mais de idade, por cor ou raça e situação de ocupação
--  Linha 2: Variável - Estudantes de 15 anos ou mais de idade
--  Linha 3: Unidade da Federação;"Situação de ocupação na semana de referência";"Ano x Cor ou raça


CREATE TABLE Fact_Domicilio (
    IdDomicilio INT IDENTITY(1,1) PRIMARY KEY,
    IdLocal INT,
    IdAno INT,
    IdCondDomi INT,
    QuantidadeDeDomicilios INT,
    Rendimento varchar(255),
    OQueTemNoDomicilio varchar(255),

    CONSTRAINT FK_Fact_LocalDomicilio FOREIGN KEY (IdLocal)
        REFERENCES Dim_Local (IdLocal),

    CONSTRAINT FK_Fact_AnoDomicilio FOREIGN KEY (IdAno)
        REFERENCES Dim_Ano (IdAno),

     CONSTRAINT FK_Fact_CondDomiDomicilio FOREIGN KEY (IdCondDomi)
        REFERENCES Dim_Condicao_Domicilio (IdCondDomi),
);

--Arquivo: tabela6821.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6821 - Domicílios e Moradores, por condição de ocupação do domicílio
--  Linha 2: Variável - Domicílios
--  Linha 3: Unidade da Federação;"Ano x Condição de ocupação do domicílio
--Arquivo: tabela7339.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7339 - Domicílios e Moradores, por existência de microcomputador ou tablet no domicílio
--  Linha 2: Variável - Domicílios
--  Linha 3: Grande Região;"Ano x Existência de microcomputador ou tablet no domicílio
--Arquivo: tabela7307.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7307 - Domicílios e Moradores, por situação do domicílio e existência de utilização da internet no domicílio
--  Linha 2: Variável - Domicílios
--  Linha 3: Unidade da Federação;"Existência de utilização da Internet no domicílio";"Ano x Situação do domicílio
--Arquivo: tabela9552.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 9552 - Domicílios e moradores, por situação do domicílio e situação de segurança alimentar existente no domicílio
--  Linha 2: Variável - Domicílios
--  Linha 3: Unidade da Federação;"Situação de segurança alimentar existente no domicílio";"Ano x Situação do domicílio

--Arquivo: tabela9558.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 9558 - Domicílios, por situação de segurança alimentar existente no domicílio, faixas de rendimento mensal domiciliar per capita e situação do domicílio
--  Linha 2: Variável - Domicílios
--  Linha 3: ;"Situação do domicílio";"Ano x Situação de segurança alimentar existente no domicílio x Faixas de rendimento mensal domiciliar per capita
--Arquivo: tabela6731.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6731 - Domicílios e Moradores, por situação do domicílio e principal fonte de abastecimento de água
--  Linha 2: Variável - Domicílios
--  Linha 3: Unidade da Federação;"Principal fonte de abastecimento de água";"Ano x Situação do domicílio

--Arquivo: tabela6732.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6732 - Domicílios e Moradores com rede geral de distribuição de água como principal forma de abastecimento, por situação do domicílio e disponibilidade da rede geral
--  Linha 2: Variável - Domicílios com rede geral de distribuição de água como principal forma de abastecimento de água
--  Linha 3: Unidade da Federação;"Disponibilidade da rede geral de distribuição de água";"Ano x Situação do domicílio

--Arquivo: tabela6733.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6733 - Domicílios e Moradores com água canalizada, por situação do domicílio
--  Linha 2: Variável - Domicílios com água canalizada
--  Linha 3: Unidade da Federação;"Ano x Situação do domicílio

--Arquivo: tabela6734.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6734 - Domicílios e Moradores com banheiro de uso exclusivo, por situação do domicílio
--  Linha 2: Variável - Domicílios com banheiro de uso exclusivo
--  Linha 3: Unidade da Federação;"Ano x Situação do domicílio

--Arquivo: tabela6735.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6735 - Domicílios e Moradores com banheiro, sanitário ou buraco para dejeções, por situação do domicílio e tipo de esgotamento sanitário (de 2016 até 2018)
--  Linha 2: Variável - Domicílios com banheiro, sanitário ou buraco para dejeções
--  Linha 3: Unidade da Federação;"Tipo de esgotamento sanitário";"Ano x Situação do domicílio

--Arquivo: tabela6736.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6736 - Domicílios e Moradores, por situação do domicílio e destino do lixo
--  Linha 2: Variável - Domicílios
--  Linha 3: Unidade da Federação;"Destino do lixo";"Ano x Situação do domicílio

--Arquivo: tabela6737.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 6737 - Domicílios e Moradores com energia elétrica, por situação do domicílio e fonte de energia elétrica
--  Linha 2: Variável - Domicílios com energia elétrica
--  Linha 3: Unidade da Federação;"Fonte de energia elétrica";"Ano x Situação do domicílio


CREATE TABLE Fact_Estudante (
    IdEstudante INT IDENTITY(1,1) PRIMARY KEY,
    IdLocal INT,
    IdAno INT,
    IdCondEstudante INT,
    QuantidadeDeEstudantes INT,
    IdFaixaEtaria INT,
    TipoDeEnsinoSuperior varchar(255),

    CONSTRAINT FK_Fact_LocalEstudante FOREIGN KEY (IdLocal)
        REFERENCES Dim_Local (IdLocal),

    CONSTRAINT FK_Fact_AnoEstudante FOREIGN KEY (IdAno)
        REFERENCES Dim_Ano (IdAno),

     CONSTRAINT FK_Fact_CondEstudanteEstudante FOREIGN KEY (IdCondEstudante)
        REFERENCES Dim_Condicao_Estudante (IdCondEstudante),

     CONSTRAINT FK_Fact_FaixaEtariaEstudante FOREIGN KEY (IdFaixaEtaria)
        REFERENCES Dim_Faixa_Etaria (IdFaixaEtaria),
);

--Arquivo: tabela7320.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7320 - Pessoas de 10 anos ou mais de idade, por sexo, condição de estudante e rede de ensino e curso frequentado
--  Linha 2: Variável - Pessoas de 10 anos ou mais de idade
--  Linha 3: Grande Região;"Condição de estudante, rede de ensino e curso frequentado";"Ano x Sexo
-- Comentario do Nellaf (joinha) : Vai ter que colocar a faixa etaria manualmente isso para o 7321 tbm, eu acho.
--Arquivo: tabela7321.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7321 - Pessoas de 10 anos ou mais de idade que utilizaram Internet no período de referência dos últimos três meses, por sexo, condição de estudante e rede de ensino e curso frequentado
--  Linha 2: Variável - Pessoas de 10 anos ou mais de idade que utilizaram Internet no período de referência dos últimos três meses
--  Linha 3: Grande Região;"Condição de estudante, rede de ensino e curso frequentado";"Ano x Sexo
--Arquivo: tabela7136.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7136 - Estudantes, por sexo e grupo de idade
--  Linha 2: Variável - Estudantes
--  Linha 3: Unidade da Federação;"Grupo de idade";"Ano x Sexo
--Arquivo: tabela7146.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7146 - Estudantes do ensino superior, por cor ou raça e tipo de ensino superior
--  Linha 2: Variável - Estudantes do ensino superior
--  Linha 3: Grande Região;"Tipo de ensino superior";"Ano x Cor ou raça

--Arquivo: tabela7147.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 7147 - Estudantes do ensino superior, por sexo e tipo de ensino superior
--  Linha 2: Variável - Estudantes do ensino superior
--  Linha 3: Grande Região;"Tipo de ensino superior";"Ano x Sexo

CREATE TABLE Fact_TrabalhoInfantil (
    IdTrabalhoInfantil INT IDENTITY(1,1) PRIMARY KEY,
    IdLocal INT,
    IdAno INT,
    IdCondEstudante INT,
    IdFaixaEtaria INT,
    QuantidadePessoas INT,
    TipoDeAtividadesRealizadas varchar(255),

    CONSTRAINT FK_Fact_LocalTrabalhoInfantil FOREIGN KEY (IdLocal)
        REFERENCES Dim_Local (IdLocal),

    CONSTRAINT FK_Fact_AnoTrabalhoInfantil FOREIGN KEY (IdAno)
        REFERENCES Dim_Ano (IdAno),

     CONSTRAINT FK_Fact_CondEstudanteTrabalhoInfantil FOREIGN KEY (IdCondEstudante)
        REFERENCES Dim_Condicao_Estudante (IdCondEstudante),

     CONSTRAINT FK_Fact_FaixaEtariaTrabalhoInfantil FOREIGN KEY (IdFaixaEtaria)
        REFERENCES Dim_Faixa_Etaria (IdFaixaEtaria),
);

--Arquivo: tabela9499.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 9499 - Pessoas de 5 a 17 anos de idade em situação de trabalho infantil, por grupo de idade e tipos de atividades realizadas - Estatísticas experimentais
--  Linha 2: Variável - Pessoas de 5 a 17 anos de idade em situação de trabalho infantil
--  Linha 3: ;"Tipos de atividades realizadas";"Ano x Grupo de idade
--Arquivo: tabela9506.csv
--Primeiras linhas:
--  Linha 1: ﻿"Tabela 9506 - Pessoas de 5 a 17 anos de idade que realizam atividade econômica, por grupo de idade e atividade do trabalho principal - Estatísticas experimentais
--  Linha 2: Variável - Pessoas de 5 a 17 anos de idade que realizam atividade econômica
--  Linha 3: ;"Atividade do trabalho principal";"Ano x Grupo de idade
