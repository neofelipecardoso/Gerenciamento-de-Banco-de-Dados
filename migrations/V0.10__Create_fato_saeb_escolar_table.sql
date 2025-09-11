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
