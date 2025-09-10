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