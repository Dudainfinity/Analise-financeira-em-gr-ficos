# Erro 2 (data) — resumo do problema e da correção

## Erro apresentado
A página mostrou a mensagem:

**Error Loading Chart: This method is not implemented: Check that a complete date adapter is provided.**

## O que esse erro significa
Esse erro aconteceu porque o gráfico estava tentando usar o eixo X como **data/hora real**.

O `Chartkick` enviou os dados para o `Chart.js` como datas, e o `Chart.js 4` precisa de um **date adapter** para entender e formatar datas no eixo temporal.

Como esse adapter não estava instalado/configurado no projeto, o gráfico não conseguia renderizar.

## Onde estava o problema
No controller, os dados do gráfico estavam sendo montados assim:
- a chave do hash era um objeto `Time`
- o valor vinha como string da API

Exemplo do cenário anterior:
- `hash[date] = rate`

Com isso, o gráfico interpretava o eixo como temporal.

## O que foi corrigido

### 1) A data foi transformada em texto
No controller, a data deixou de ser um objeto `Time` e passou a virar string formatada:

- antes: `Time.at(...)`
- depois: `date.strftime("%d/%m/%Y")`

Isso faz o gráfico tratar o eixo X como categoria/texto.

### 2) O valor foi transformado em número
O valor da cotação foi convertido com `to_f`.

- antes: `entry["high"]`
- depois: `entry["high"].to_f`

Isso garante que o gráfico receba números reais para montar a linha.

### 3) O gráfico foi marcado como discreto
Na view, o gráfico passou a usar:

- `discrete: true`

Isso força o `Chartkick` a usar o eixo categórico, evitando a necessidade de um date adapter.

## Arquivos corrigidos
- `app/controllers/home_controller.rb`
- `app/views/home/index.html.erb`

## Resultado da correção
Depois da alteração:
- o eixo X passou a ser categórico
- o `Chart.js` não precisou mais de adapter de datas
- o gráfico pôde ser renderizado sem o erro

## Observação futura
Se a ideia for usar datas reais no eixo do gráfico (com escala de tempo), então será necessário instalar e configurar um adapter compatível com `Chart.js`, como por exemplo:
- `chartjs-adapter-date-fns`
- `chartjs-adapter-luxon`

No estado atual, a correção aplicada foi a mais simples e estável para fazer o gráfico funcionar.
