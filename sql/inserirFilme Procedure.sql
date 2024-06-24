USE GetMovies;
GO

-- Criação da stored procedure para inserir um novo filme com tratamento de erros
CREATE PROCEDURE inserirFilme
    @nome_filme NVARCHAR(100),
    @foto_capa VARCHAR(200),
    @data_lancamento DATE,
    @sinopse NVARCHAR(500),
    @id_classificacao INT
AS
BEGIN;
    -- Verifica se já existe um filme com o mesmo nome
    IF EXISTS (SELECT 1 FROM filme WHERE nome_filme = @nome_filme)
    BEGIN;
        THROW 50001, 'Já existe um filme com este nome.', 1;
    END;

    -- Verifica se a classificação indicativa existe
    IF NOT EXISTS (SELECT 1 FROM classificacaoIndicativa WHERE id_classificacao = @id_classificacao)
    BEGIN;
        THROW 50002, 'A classificação indicativa informada não existe.', 1;
    END;

    -- Insere o filme
    INSERT INTO filme (nome_filme, foto_capa, data_lancamento, sinopse, id_classificacao)
    VALUES (@nome_filme, @foto_capa, @data_lancamento, @sinopse, @id_classificacao);
END;

/*
EXEC inserirFilme 
    'Um Lugar Silencioso: Dia Um',
    'https://m.media-amazon.com/images/M/MV5BNGZmODU3ZDEtMjQwZC00NTA5LThmNWYtYzk5MmY5ZmM4NGIxXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg',
    '2024-06-27',
    'Uma mulher vive os aterrorizantes primeiros minutos de uma invasão alienígena na cidade de Nova York.',
    7;
 

SELECT * FROM filme;
SELECT * FROM classificacaoIndicativa;

DELETE FROM filme WHERE id_filme = 14;

UPDATE filme SET id_classificacao = 7 WHERE id_filme = 8;

DROP PROCEDURE IF EXISTS inserirFilme;
*/