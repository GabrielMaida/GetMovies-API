USE GetMovies;
GO

-- Criação da stored procedure para listar todos os filmes
CREATE PROCEDURE listarFilmes
    @codigo_lista INT
AS
BEGIN;
    -- Codigo da lista igual a 1: Listar filmes ainda não lançados
    IF @codigo_lista = 1
    BEGIN;
        SELECT * FROM filme 
        WHERE data_lancamento > GETDATE()
        ORDER BY data_lancamento ASC;
    END;

    -- Codigo da lista igual a 2: Listar filmes lançados em 2024 até a data atual
    ELSE IF @codigo_lista = 2
    BEGIN;
        SELECT * FROM filme 
        WHERE data_lancamento BETWEEN '2024-01-01' AND GETDATE() 
        ORDER BY data_lancamento DESC;
    END;

    -- Codigo da lista igual a 3: Listar filmes lançados em 2023
    ELSE IF @codigo_lista = 3
    BEGIN;
        SELECT * FROM filme 
        WHERE data_lancamento BETWEEN '2023-01-01' AND '2023-12-31' 
        ORDER BY data_lancamento ASC;
    END;

    -- Codigo da lista igual a 4: Listar todos os filmes
    ELSE IF @codigo_lista = 4
    BEGIN;
        SELECT * FROM filme 
        ORDER BY nome_filme ASC;
    END;

    ELSE
    BEGIN;
        THROW 50004, 'Código de lista inválido.', 1;
    END;
END;

/*
EXEC listarFilmes 1;
EXEC listarFilmes 2;
EXEC listarFilmes 3;
EXEC listarFilmes 4;


DROP PROCEDURE IF EXISTS listarFilmes;
*/
