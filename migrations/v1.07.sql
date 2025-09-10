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