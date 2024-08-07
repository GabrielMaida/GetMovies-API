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
EXEC alterarFilme 1,
                'Deadpool & Wolverine',
                'https://m.media-amazon.com/images/M/MV5BNDA3MmYzOWEtYWZhNS00ZmU3LWJkYmUtODBjMzQyNzMxYmZhXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
                '2024-07-25',
                'Wolverine está se recuperando de seus ferimentos quando cruza o caminho do tagarela Deadpool. Eles se unem para derrotar um inimigo em comum.',
                '6';

EXEC alterarFilme 2,
                'O Corvo',
                'https://m.media-amazon.com/images/M/MV5BNTNhOTQ3YjMtZGZhNS00NTE0LWEzZGEtYWJhOTU0ZWQ5MTg2XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_FMjpg_UX1000_.jpg',
                '2024-06-07',
                'Eric Draven e Shelly Webster são almas gêmeas conectadas por um passado sombrio. Após o brutal assassinato do casal, é concedido a Eric uma chance de salvar seu verdadeiro amor. Ele, então, embarca em uma jornada implacável por vingança.',
                '5';

EXEC alterarFilme 13,
                'Um Lugar Silencioso: Dia Um',
                'https://m.media-amazon.com/images/M/MV5BNGZmODU3ZDEtMjQwZC00NTA5LThmNWYtYzk5MmY5ZmM4NGIxXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg',
                '2024-06-27',
                'Uma mulher vive os aterrorizantes primeiros minutos de uma invasão alienígena na cidade de Nova York.',
                '7';

SELECT * FROM filme;
*/
