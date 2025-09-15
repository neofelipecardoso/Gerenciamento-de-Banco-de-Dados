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
