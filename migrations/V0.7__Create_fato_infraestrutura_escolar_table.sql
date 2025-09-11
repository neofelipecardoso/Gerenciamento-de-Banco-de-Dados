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
