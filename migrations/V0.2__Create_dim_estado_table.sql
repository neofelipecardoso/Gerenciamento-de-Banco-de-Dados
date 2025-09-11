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
