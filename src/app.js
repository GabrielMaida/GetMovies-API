// Importação de módulos
const express = require('express');
const sql = require('mssql');
const cors = require('cors');

// Inicialização do express
const app = express();
const port = 3000;
app.use(express.json());
app.use(cors());

// Configuração da conexão com o banco de dados
const config = {
    server: 'localhost',
    database: 'GetMovies',
    port: 1433,
    user: 'sa',
    password: 'cesusc2024',
    trustServerCertificate:true,
    options: {
        cryptoCredentialsDetails: {
            minVersion: 'TLSv1',
            trustServerCertificate: true,
        }
    }   
}

//fazendo a conexão global
sql.connect(config)
	.then(conn => global.conn = conn)
	.catch(err => console.log(err))

// Função para executar as queries
function execSQLQuery(sqlQry, res){
    global.conn.request()
                .query(sqlQry)
                .then(result => res.json(result.recordset))
                .catch(err => res.json(err));
}

// Método GET para retornar todas as seleções
app.get('/api/filmes', (req, res) => {
    try{
        execSQLQuery('EXEC listarFilmes 4', res);
    }
    catch (error){
        if(error) {
            console.log(error);
        }
    }
})

// Método GET para retornar um filme específico
app.get('/api/filme/:id_filme', (req, res) => {
    let filter = '';
    try{
        if(req.params.id_filme) {
            filter = ' WHERE id_filme = ' + parseInt(req.params.id_filme);
        } 
        execSQLQuery('SELECT * FROM filme' + filter, res);
    }
	catch (error){
        if(error) {
            console.log(error);
        }
    }
})

// Método GET para retornar filmes de uma seleção específica
app.get('/api/filmes/:id_selecao', (req, res) => {
    const id_selecao = parseInt(req.params.id_selecao);
    if (isNaN(id_selecao) || id_selecao < 1 || id_selecao > 3) {
        res.status(400).json({ error: "id_selecao inválido. Deve ser 1, 2 ou 3." });
        return;
    }
    try {
        execSQLQuery(`EXEC listarFilmes ${id_selecao}`, res);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: error.message });
    }
});

// Método POST para inserir um novo filme
app.post('/api/filmes', (req, res) => {
    try{
        execSQLQuery(`EXEC inserirFilme
            '${req.body.nome_filme}',
            '${req.body.foto_capa}',
            '${req.body.data_lancamento}',
            '${req.body.sinopse}',
            ${req.body.id_classificacao};`, res);
    }
	catch (error){
        if(error) {
            console.log(error);
        }
    }
})

// Método PUT para alterar um filme
app.put('/api/filme/:id_filme', (req, res) => {
    try{
        execSQLQuery(`EXEC alterarFilme ${req.params.id_filme},
                '${req.params.nome_filme}',
                '${req.params.foto_capa}',
                '${req.params.data_lancamento}',
                '${req.params.sinopse}',
                '${req.params.id_classificacao}';`, res);
    }
	catch (error){
        if(error) {
            console.log(error);
        }
    }
})

// Método DELETE para deletar um filme
app.delete('/api/filme/:id_filme', (req, res) => {
    try{
        execSQLQuery('EXEC deletarFilme ' + parseInt(req.params.id_filme), res);
    }
	catch (error){
        if(error) {
            console.log(error);
        }
    }
})

// Inicializa o servidor
app.listen(port, () => {
	console.log('Servidor rodando na porta: ' + port);
})
