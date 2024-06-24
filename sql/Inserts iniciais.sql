USE GetMovies;
GO

-- Inserindo dados na tabela classificacaoIndicativa
INSERT INTO classificacaoIndicativa (descricao_classificacao)
VALUES  ('Livre para todos os públicos'),
		('Não recomendado para menores de 10 anos'),
		('Não recomendado para menores de 12 anos'),
		('Não recomendado para menores de 14 anos'),
		('Não recomendado para menores de 16 anos'),
		('Não recomendado para menores de 18 anos'),
		('Classificação Indicativa não definida');

-- Inserir dados na tabela filme
INSERT INTO filme (nome_filme, foto_capa, data_lancamento, sinopse, id_classificacao)
VALUES  ('Deadpool & Wolverine',
		'https://m.media-amazon.com/images/M/MV5BNDA3MmYzOWEtYWZhNS00ZmU3LWJkYmUtODBjMzQyNzMxYmZhXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg', 
		'2023-07-26',
		'Wolverine está se recuperando quando cruza seu caminho com Deadpool. Juntos, eles formam uma equipe e enfrentam um inimigo em comum.',
		6),

		('The Crow',
		'https://m.media-amazon.com/images/M/MV5BNTNhOTQ3YjMtZGZhNS00NTE0LWEzZGEtYWJhOTU0ZWQ5MTg2XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_FMjpg_UX1000_.jpg', 
		'2023-08-23',
		'As almas gêmeas Eric Draven e Shelly Webster são brutalmente assassinadas quando os demônios de seu passado sombrio os alcançam. Atravessando os mundos dos vivos e dos mortos, Draven retorna em busca de vingança sangrenta contra os assassinos.',
		5),

		('Godzilla x Kong: The New Empire',
		'https://m.media-amazon.com/images/M/MV5BMjVlMWUxZDctMWI2NS00MTcyLTgxNjktOWI3MjQ5N2NmOGIyXkEyXkFqcGdeQXVyMjQwMDg0Ng@@._V1_.jpg', 
		'2023-03-28',
		'Godzilla e o todo-poderoso Kong enfrentam uma ameaça colossal escondida nas profundezas do planeta, desafiando a sua própria existência e a sobrevivência da raça humana.',
		3);


SELECT * FROM classificacaoIndicativa;
SELECT * FROM filme;
