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