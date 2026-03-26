# Gráfico de Moedas

Aplicação Rails para visualizar cotações de moedas em gráficos, consumindo dados da API AwesomeAPI.

## Funcionalidades

- Exibe cotações de múltiplas moedas (USD/BRL, EUR/BRL e BTC/BRL).
- Gráfico com cor diferente para cada moeda.
- Título por gráfico com nome da moeda.
- Duas formas de visualização:
	- Linha
	- Coluna
- Alternância de visualização na página sem recarregar.

## Stack do projeto

- Ruby on Rails 8
- Importmap
- Chartkick
- Chart.js
- SQLite



## Acesso ao projeto:
https://analise-financeira-em-gr-ficos.onrender.com/



## Fonte dos dados

- API: `https://economia.awesomeapi.com.br/`
- Endpoint usado no projeto:
	- `https://economia.awesomeapi.com.br/json/daily/USD-BRL/30`
	- mesmo padrão para as demais moedas

## Como rodar o projeto

### 1) Pré-requisitos

- Ruby (versão compatível com o projeto)
- Bundler
- Node.js (para dependências JS já presentes no projeto)

### 2) Instalar dependências

```bash
bundle install
```

### 3) Iniciar o servidor

```bash
bin/rails server
```

Abra no navegador:

- `http://localhost:3000`

## Estrutura principal

- `app/controllers/home_controller.rb`
	- Busca os dados da API e prepara as séries para os gráficos.
- `app/views/home/index.html.erb`
	- Renderiza os gráficos e os botões de troca de visualização.
- `app/javascript/application.js`
	- Carrega Chart.js e Chartkick.
- `config/importmap.rb`
	- Mapeamento dos pacotes JavaScript.

## Decisões técnicas importantes

- O gráfico está em modo categórico (`discrete: true`) para estabilidade no eixo X sem adapter de data.
- Datas são formatadas como texto (`dd/mm/yyyy`) e valores convertidos para número (`to_f`) antes de renderizar.

## Documentações internas criadas durante o projeto

- `erro 1 (grafico)/RESUMO_CORRECOES_GRAFICO.md`
- `erro 2 (data)/RESUMO_ERRO_DATA.md`
- `melhorias visuais e interativas/RESUMO_MELHORIAS.md`

## Próximos passos (opcional)

- Adicionar filtro de período (7, 15, 30 dias).
- Permitir selecionar moedas dinamicamente.
- Adicionar testes para controller e integração da página inicial.
