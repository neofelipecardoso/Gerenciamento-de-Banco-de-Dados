-- DDL para a tabela DimRegiao
CREATE TABLE DimRegiao (
    sk_regiao INT NOT NULL,
    id_regiao INT NOT NULL,
    nome_regiao NVARCHAR(255) NOT NULL,
    -- Chave primária da tabela
    CONSTRAINT pk_DimRegiao PRIMARY KEY (sk_regiao)
);
GO

-- DDL para a tabela DimEstado
CREATE TABLE DimEstado (
    sk_estado INT NOT NULL,
    id_estado INT NOT NULL,
    nome_estado NVARCHAR(255) NOT NULL,
    sk_regiao INT NOT NULL,
    -- Chave primária da tabela
    CONSTRAINT pk_DimEstado PRIMARY KEY (sk_estado),
    -- Chave estrangeira referenciando DimRegiao
    CONSTRAINT fk_DimEstado_DimRegiao FOREIGN KEY (sk_regiao) REFERENCES DimRegiao (sk_regiao)
);
GO

-- DDL para a tabela DimMunicipio
CREATE TABLE DimMunicipio (
    sk_municipio INT NOT NULL,
    id_municipio INT NOT NULL,
    nome_municipio NVARCHAR(255) NOT NULL,
    sk_estado INT NOT NULL,
    -- Chave primária da tabela
    CONSTRAINT pk_DimMunicipio PRIMARY KEY (sk_municipio),
    -- Chave estrangeira referenciando DimEstado
    CONSTRAINT fk_DimMunicipio_DimEstado FOREIGN KEY (sk_estado) REFERENCES DimEstado (sk_estado)
);
GO

-- DDL para a tabela DimEscola
CREATE TABLE DimEscola (
    sk_escola INT NOT NULL,
    id_escola INT NOT NULL,
    id_municipio INT NOT NULL,
    nome_escola NVARCHAR(500) NOT NULL,
    id_tipo_localizacao_escola INT,
    tipo_localizacao_escola NVARCHAR(255),
    id_referencia_censo_escola INT,
    referencia_censo_escola NVARCHAR(255),
    ano_referencia INT,
    -- Chave primária da tabela
    CONSTRAINT pk_DimEscola PRIMARY KEY (sk_escola),
    -- Chave estrangeira referenciando DimMunicipio
    CONSTRAINT fk_DimEscola_DimMunicipio FOREIGN KEY (id_municipio) REFERENCES DimMunicipio (sk_municipio)
);
GO

-- DDL para a tabela FatoResultadosBRIndividual
CREATE TABLE FatoResultadosBRIndividual (
    sk_resultado_br INT NOT NULL,
    id_resultado_br INT NOT NULL,
    sk_escola INT NOT NULL,
    id_aluno INT,
    nota_saeb_2021 DECIMAL(10, 2),
    id_proficiencia_simulacao DECIMAL(10, 2),
    id_nivel_saeb_2021 INT,
    proficiencia_protesto_2003 DECIMAL(10, 2),
    nivel_saeb_2021_descricao NVARCHAR(255),
    desempenho_professor DECIMAL(10, 2),
    nivel_saeb_2021_faixa_descricao NVARCHAR(255),
    escores_saeb_2021 DECIMAL(10, 2),
    escores_saeb_2021_descricao NVARCHAR(255),
    -- Chave primária da tabela
    CONSTRAINT pk_FatoResultadosBRIndividual PRIMARY KEY (sk_resultado_br),
    -- Chave estrangeira referenciando DimEscola
    CONSTRAINT fk_FatoResultadosBRIndividual_DimEscola FOREIGN KEY (sk_escola) REFERENCES DimEscola (sk_escola)
);
GO

-- DDL para a tabela FatoInfraestruturaEscolar
CREATE TABLE FatoInfraestruturaEscolar (
    sk_infraestrutura_escolar INT NOT NULL,
    sk_escola INT NOT NULL,
    id_infraestrutura INT,
    id_tipo_infraestrutura INT,
    id_disponibilidade_infraestrutura INT,
    possui_internet NVARCHAR(10),
    possui_laboratorio NVARCHAR(10),
    possui_biblioteca NVARCHAR(10),
    nivel_infraestrutura_escola DECIMAL(10, 2),
    nivel_infraestrutura_escola_faixa_descricao NVARCHAR(255),
    -- Chave primária da tabela
    CONSTRAINT pk_FatoInfraestruturaEscolar PRIMARY KEY (sk_infraestrutura_escolar),
    -- Chave estrangeira referenciando DimEscola
    CONSTRAINT fk_FatoInfraestruturaEscolar_DimEscola FOREIGN KEY (sk_escola) REFERENCES DimEscola (sk_escola)
);
GO

-- DDL para a tabela FatoIndicadoresEducacionais
CREATE TABLE FatoIndicadoresEducacionais (
    sk_indicadores_educacionais INT NOT NULL,
    sk_escola INT NOT NULL,
    id_indicador_tipo INT,
    id_indicador_disponibilidade INT,
    nivel_socioeconomico_escola DECIMAL(10, 2),
    taxa_distorcao_idade_ano_escolar DECIMAL(10, 2),
    nivel_socioeconomico_escola_faixa_descricao NVARCHAR(255),
    taxa_aprovacao_escola DECIMAL(10, 2),
    taxa_reprovacao_escola DECIMAL(10, 2),
    taxa_evasao_escola DECIMAL(10, 2),
    -- Chave primária da tabela
    CONSTRAINT pk_FatoIndicadoresEducacionais PRIMARY KEY (sk_indicadores_educacionais),
    -- Chave estrangeira referenciando DimEscola
    CONSTRAINT fk_FatoIndicadoresEducacionais_DimEscola FOREIGN KEY (sk_escola) REFERENCES DimEscola (sk_escola)
);
GO

-- DDL para a tabela FatoSaebEscolar
CREATE TABLE FatoSaebEscolar (
    sk_saeb_escolar INT NOT NULL,
    sk_escola INT NOT NULL,
    id_saeb_tipo INT,
    id_saeb_disponibilidade INT,
    escores_saeb_2021 DECIMAL(10, 2),
    escores_saeb_2021_faixa_descricao NVARCHAR(255),
    media_saeb_2021_geral DECIMAL(10, 2),
    media_proficiencia_simulada DECIMAL(10, 2),
    nivel_saeb_2021 INT,
    nivel_saeb_2021_faixa_descricao NVARCHAR(255),
    -- Chave primária da tabela
    CONSTRAINT pk_FatoSaebEscolar PRIMARY KEY (sk_saeb_escolar),
    -- Chave estrangeira referenciando DimEscola
    CONSTRAINT fk_FatoSaebEscolar_DimEscola FOREIGN KEY (sk_escola) REFERENCES DimEscola (sk_escola)
);
GO

-- DDL para a tabela FatoIndicadoresSocioeconomicos
CREATE TABLE FatoIndicadoresSocioeconomicos (
    sk_indicadores_socioeconomicos INT NOT NULL,
    sk_municipio INT NOT NULL,
    id_indicador_tipo INT,
    id_indicador_disponibilidade INT,
    renda_per_capita DECIMAL(10, 2),
    idh DECIMAL(10, 2),
    investimento_per_capita_educacao DECIMAL(10, 2),
    -- Chave primária da tabela
    CONSTRAINT pk_FatoIndicadoresSocioeconomicos PRIMARY KEY (sk_indicadores_socioeconomicos),
    -- Chave estrangeira referenciando DimMunicipio
    CONSTRAINT fk_FatoIndicadoresSocioeconomicos_DimMunicipio FOREIGN KEY (sk_municipio) REFERENCES DimMunicipio (sk_municipio)
);
GO

-- DDL para a tabela FatoInvestimentoEducacao
CREATE TABLE FatoInvestimentoEducacao (
    sk_investimento_educacao INT NOT NULL,
    sk_estado INT NOT NULL,
    id_investimento_tipo INT,
    id_investimento_disponibilidade INT,
    taxa_investimento_educacao_2021 DECIMAL(10, 2),
    investimento_per_capita_educacao DECIMAL(10, 2),
    -- Chave primária da tabela
    CONSTRAINT pk_FatoInvestimentoEducacao PRIMARY KEY (sk_investimento_educacao),
    -- Chave estrangeira referenciando DimEstado
    CONSTRAINT fk_FatoInvestimentoEducacao_DimEstado FOREIGN KEY (sk_estado) REFERENCES DimEstado (sk_estado)
);
GO
