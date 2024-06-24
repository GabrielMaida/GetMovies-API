document.addEventListener('DOMContentLoaded', function() {
    carregarFilmesLista(1);
    carregarFilmesLista(2);
    carregarFilmesLista(3);
    carregarTodosFilmes();
});

const url_filmes = "http://127.0.0.1:3000/api/filmes";
const url_filme = "http://127.0.0.1:3000/api/filme";
const modalCarregarDados = document.getElementById("modalCarregarDados");
const modalInserirFilme = document.getElementById("modalInserirFilme");

// Carrega filmes das listas 1, 2 e 3
async function carregarFilmesLista(id_lista){
    let proximos = document.getElementById("proximos_filmes");
    let recentes = document.getElementById("recentes_filmes");
    let filmes2023 = document.getElementById("2023_filmes");

    try {
        const response = await fetch(`${url_filmes}/${id_lista}`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        });

        const result = await response.json();
        result.forEach(element => {
            let img = document.createElement('img');
            img.className = 'row__poster';
            img.src = element.foto_capa;
            img.alt = element.nome_filme;
            img.onclick = function() { 
                abrirModalCarregarDados(element.id_filme); 
            };
            if (id_lista === 1) {
                proximos.innerHTML = "";
                proximos.appendChild(img);
            } else if (id_lista === 2) {
                recentes.innerHTML = "";
                recentes.appendChild(img);
            } else if (id_lista === 3) {
                filmes2023.innerHTML = "";
                filmes2023.appendChild(img);
            }
        });
    } catch (error){
        alert("Erro:" + error);
    }
}

// Carrega os filmes da quarta lista -> Todos os filmes
async function carregarTodosFilmes(){
    let todos = document.getElementById("todos_filmes");
    todos.innerHTML = "";

    try {
        const response = await fetch(`${url_filmes}`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        });

        const result = await response.json();
        result.forEach(element => {
            let img = document.createElement('img');
            img.className = 'row__poster';
            img.src = element.foto_capa;
            img.alt = element.nome_filme;
            img.onclick = function(){abrirModalCarregarDados(element.id_filme)};
            todos.appendChild(img);
        });

    } catch (error){
        alert("Erro:" + error);
    }
}

// Abre o modal com as informações do filme específico ao clicar na imagem
async function abrirModalCarregarDados(id_selecionado) {
    modalInserirFilme.style.display = "none";
    modalCarregarDados.style.display = "block";
    let img = document.getElementById("imagem_modal");
    let h2 = document.getElementById("titulo_modal");
    let data = document.getElementById("data_modal");
    let sinopse = document.getElementById("sinopse_modal");
    let classificacao = document.getElementById("classificacao_modal")

    try {
        const response = await fetch(`${url_filme}/${id_selecionado}`, {
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        });

        const result = await response.json();
        
        espaco_botao = document.getElementById("espaco_botao");
        espaco_botao.innerHTML = "";

        // Verifica se o resultado contém os dados esperados
        if (result && result.length > 0 && result[0].foto_capa && result[0].nome_filme && result[0].data_lancamento && result[0].sinopse && result[0].id_classificacao) {
            const filme = result[0];
            img.src = filme.foto_capa;
            h2.innerText = filme.nome_filme;
            data.innerText = new Date(filme.data_lancamento).toLocaleDateString(); // Formata a data
            sinopse.innerText = filme.sinopse;
            classificacao.innerText = filme.id_classificacao;
            let botao_editar = document.createElement("spam");
            botao_editar.innerText = "Alterar Filme";
            botao_editar.className = "botao_modal_editar";
            botao_editar.onclick = function(){editarFilme(filme.id_filme);window.location.reload(true);};
            espaco_botao.appendChild(botao_editar);
            let botao_excluir = document.createElement("spam");
            botao_excluir.innerText = "Excluir Filme";
            botao_excluir.className = "botao_modal_excluir";
            botao_excluir.onclick = function(){excluirFilme(filme.id_filme);window.location.reload(true);};
            espaco_botao.appendChild(botao_excluir);
        } else {
            console.error('Dados do filme estão faltando ou são inválidos', result);
        }
    } catch (error) {
        alert("Erro:" + error);
    }
}

async function abrirModalInserirFilme(){
    modalCarregarDados.style.display = "none";
    modalInserirFilme.style.display = "block";
}

function carregarImagemModal(){
    let imagem = document.getElementById("imagem_modal2");
    let url = document.getElementById("inputImagemModal").value;
    imagem.src = url;
}

function limparModal(){
    let titulo = document.getElementById("titulo_modal2");
    let capa = document.getElementById("inputImagemModal");
    let data = document.getElementById("data_modal2");
    let sinopse = document.getElementById("sinopse_modal2");
    let classificacao = document.getElementById("classificacao_modal2");
    titulo.value = "";
    capa.value = "";
    data.value = "";
    sinopse.value = "";
    classificacao.selectedIndex = 0;
}

async function adicionarFilme(){
    let titulo = document.getElementById("titulo_modal2").value;
    let capa = document.getElementById("inputImagemModal").value;
    let data = document.getElementById("data_modal2").value;
    let sinopse = document.getElementById("sinopse_modal2").value;
    let classificacao = document.getElementById("classificacao_modal2").value;

    try {
        if (titulo === "" || capa === "" || data === "" || classificacao === "") {
            alert("Preencha todos os campos!");
            return;
        }
        fetch(url_filmes, {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                nome_filme: titulo,
                foto_capa: capa,
                data_lancamento: data,
                sinopse: sinopse,
                id_classificacao: classificacao
            })
        });
        window.location.reload(true);
    } catch (error) {
        alert("Erro:" + error);
    }
}

function excluirFilme(id_filme){
    try {
        fetch(`${url_filme}/${id_filme}`, {
            method: 'DELETE',
            headers: {
                'Accept': 'application/json'
            }
        });
    } catch (error) {
        alert("Erro:" + error);
    }
}

// Fecha o modal ao clicar no botão
document.getElementById("closeCarregarDados").onclick = function() {
    modalCarregarDados.style.display = "none";
};

document.getElementById("closeInserirFilme").onclick = function() {
    modalInserirFilme.style.display = "none";
};

// Fecha o modal ao clicar fora dele
window.onclick = function(event) {
    if (event.target == modalCarregarDados) {
        modalCarregarDados.style.display = "none";
    }
    else if (event.target == modalInserirFilme) {
        modalInserirFilme.style.display = "none";
    }
}

// Script para alterar a cor da navbar ao rolar a página
const nav = document.getElementById('nav');
window.addEventListener('scroll', () => {
    if (window.scrollY >= 100) {
        nav.classList.add('nav__black');
    } else {
        nav.classList.remove('nav__black');
    }
});

// Script para navegar horizontalmente pelos filmes
document.querySelectorAll('.row__button').forEach(button => {
    button.addEventListener('click', () => {
        const direction = button.classList.contains('left') ? -1 : 1;
        const container = button.parentElement.querySelector('.row__posters');
        const scrollAmount = container.clientWidth / 2;

        container.scrollBy({
            left: direction * scrollAmount,
            behavior: 'smooth'
        });
    });
});

