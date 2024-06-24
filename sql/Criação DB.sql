CREATE DATABASE GetMovies;
GO

USE GetMovies;
GO

CREATE TABLE classificacaoIndicativa (
	id_classificacao INT PRIMARY KEY IDENTITY(1,1),
	descricao_classificacao NVARCHAR(60) NOT NULL
);
GO

CREATE TABLE filme (
    id_filme INT PRIMARY KEY IDENTITY(1,1),
    nome_filme NVARCHAR(100) NOT NULL,
    foto_capa VARCHAR(200) NOT NULL,
    data_lancamento DATE NULL,
	sinopse NVARCHAR(500) NULL,
    id_classificacao INT NULL,
    CONSTRAINT FK_filme_classificacao FOREIGN KEY (id_classificacao) REFERENCES classificacaoIndicativa(id_classificacao),
);
GO
