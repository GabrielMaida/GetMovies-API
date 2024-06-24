USE GetMovies;
GO

-- Criação da stored procedure para alterar um filme com tratamento de erros
CREATE PROCEDURE alterarFilme
    @id_filme INT,
    @nome_filme NVARCHAR(100),
    @foto_capa VARCHAR(200),
    @data_lancamento DATE,
    @sinopse NVARCHAR(500),
    @id_classificacao INT

AS
BEGIN;
    -- Verifica se o filme existe
    IF NOT EXISTS (SELECT 1 FROM filme WHERE id_filme = @id_filme)
    BEGIN;
        THROW 50003, 'O filme informado não existe.', 1;
    END;

    -- Atualiza o filme
    UPDATE filme
    SET nome_filme = @nome_filme,
        foto_capa = @foto_capa,
        data_lancamento = @data_lancamento,
        sinopse = @sinopse,
        id_classificacao = @id_classificacao
    WHERE id_filme = @id_filme;
END;

/*
EXEC alterarFilme 8,
                'Um Lugar Nada Silencioso: Dia Um',
                'https://m.media-amazon.com/images/M/MV5BNGZmODU3ZDEtMjQwZC00NTA5LThmNWYtYzk5MmY5ZmM4NGIxXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg',
                '2024-06-27',
                'Uma mulher vive os aterrorizantes primeiros minutos de uma invasão alienígena na cidade de Nova York.',
                '7';

SELECT * FROM filme;
*/
