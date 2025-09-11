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
