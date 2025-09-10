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