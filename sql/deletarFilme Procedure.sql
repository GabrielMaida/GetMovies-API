USE GetMovies;
GO

-- Criação da stored procedure para deletar um filme com tratamento de erros
CREATE PROCEDURE deletarFilme
    @id_filme INT

AS
BEGIN;

    -- Verifica se o filme existe
    IF NOT EXISTS (SELECT 1 FROM filme WHERE id_filme = @id_filme)
    BEGIN;
        THROW 50003, 'O filme informado não existe.', 1;
    END;

    -- Deleta o filme
    DELETE FROM filme WHERE id_filme = @id_filme;
END;

/*
    EXEC deletarFilme 31;

    SELECT * FROM filme;
*/