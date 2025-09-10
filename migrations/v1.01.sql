CREATE DATABASE SistemaGerenciamento;
GO

USE SistemaGerenciamento;
GO

-- DDL para a tabela DimRegiao
CREATE TABLE DimRegiao (
    sk_regiao INT NOT NULL,
    id_regiao INT NOT NULL,
    nome_regiao NVARCHAR(255) NOT NULL,
    -- Chave primária da tabela
    CONSTRAINT pk_DimRegiao PRIMARY KEY (sk_regiao)
);
GO