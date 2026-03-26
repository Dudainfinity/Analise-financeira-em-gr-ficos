# Melhorias visuais e interativas

Este documento registra as mudanças aplicadas para deixar a tela mais clara, bonita e interativa.

## 1) Organização visual dos gráficos
- Cada moeda passou a ter um bloco próprio.
- Foi adicionado título por gráfico com o nome da moeda.
- O espaçamento entre os blocos foi ajustado para melhorar a leitura.

## 2) Identidade visual por moeda (cores)
Cada gráfico agora usa uma cor específica, facilitando identificação rápida:
- USD/BRL: azul
- EUR/BRL: verde
- BTC/BRL: laranja

## 3) Dados mais consistentes para exibição
- A data foi padronizada como texto (`dd/mm/yyyy`) para evitar problemas no eixo.
- Os valores de cotação foram convertidos para número (`to_f`) antes de montar os gráficos.

## 4) Interatividade adicionada
Foram criadas **2 opções de visualização** com botões:
- Linha
- Coluna

Funcionamento:
- O usuário clica no botão desejado.
- A visualização troca na hora, sem recarregar a página.
- O mesmo conjunto de dados é mostrado em formatos diferentes.

## 5) Estabilidade de renderização
- O gráfico foi configurado para modo discreto (`discrete: true`) no cenário atual.
- Isso evitou erro de adapter de data e manteve renderização estável.

## 6) Arquivos com mudanças principais
- `app/controllers/home_controller.rb`
- `app/views/home/index.html.erb`

## Resultado final
Com essas alterações, a página ficou:
- Mais legível (separação por moeda e títulos)
- Mais bonita (cores por série)
- Mais interativa (troca de tipo de gráfico por botão)
- Mais estável (sem erro de adapter de data no cenário atual)
