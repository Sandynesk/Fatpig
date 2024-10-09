# Lógica e Insights do Relatório do Projeto FatPig

**Autores**: Cadu e Emanuel 
**Data**: Outubro de 2024

---

### 1. **Banco de Dados de Arquitetura**

O banco de dados foi estruturado a partir das exigências para o gerenciamento dos clientes, produtos, vendas e logs do sistema. A seguir, são apresentadas as definições das principais entidades e seus relacionamentos:

- **Clientes**: Para cada cliente há um identificador único (ID_Cliente), nome, email, telefone e endereço. Os clientes são cadastrados juntamente com a data do cadastro existente, permitindo-nos ter o controle do tempo de relacionamento da empresa do cliente.
 
- **Produtos**: Contém as informações relativas aos produtos que estão disponíveis para vendas, correspondendo ao nome, preço e categoria e quantidade em estoque. A relação direta com a tabela ItensVenda permite controlar o estoque sempre que algum produto for vendido. 

- **Vendas**: Cada venda é registrada com um identificador único, mapeada para o cliente que fez a compra. A venda tem a data e o total, que podem ser alterados pela lógica de desconto de clientes fidelizados.

- **ItensVenda**: Trabalha como uma tabela associativa que armazena os produtos vendidos em cada venda, além da quantidade e preço unitário. Ela conecta as vendas aos produtos, permitindo uma análise detalhada de uma venda.

- **Logs**: Armazena informações de auditoria de vendas, como o momento que a venda foi realizada e uma descrição do evento.

As principais relações são: 
- **Clientes - vendas**: Um cliente pode fazer várias vendas ao longo do tempo (relação um-para-muitos).
- **Vendas - Produtos (vía ItensVenda)**: Uma venda pode conter vários produtos e um produto pode estar em várias vendas (relação Muitos-para-muitos).

---

### 2. **Triggers**

Dois triggers foram implementados para melhorar a gestão do sistema de vendas: 

1. **Trigger AtualizaEstoque**:
 - O trigger encontra-se programado para se ativar automaticamente após o registro de um item na tabela **ItensVenda**. O destino do seu comportamento é atualizar o estoque do produto, mediante a subtração da respectiva quantidade de itens vendidos. Essa aplicação garante que o estoque esteja sempre apenas atualizado e certo, evitando problemas como vendas de itens que não estão mais no estoque do sistema.

2. **Trigger RegistraLogVenda**:
 - O trigger é gerado após o registro de uma nova venda na tabela **Vendas**, colocando automaticamente um log na tabela **Logs**, que registra a venda. Essa ação facilita as auditorias e monitorações de todas as vendas que foram realizadas, dando uma maior transparência aos negócios realizados.

---

### 3. **Procedure: AplicaDesconto**

Em busca de fidelizar clientes que conferem compras recorrentes, foi realizada a procedure **AplicaDesconto**. O comportamento assegurou que a lógica da procedure verificasse quantas compras um cliente já realizou, e, ocorrendo o número total de compras igual ou maior que 10, aplicasse um desconto de 5% na próxima compra deste cliente, desde que fosse realizada no mesmo dia.

Esse mecanismo não só ajuda a manter os clientes em um ciclo de compras, como também insere uma recompensa pela lealdade, fortalecendo uma relação com os clientes, que se veem obrigados a retornar.

---

### 4. **Insights Baseados nas Consultas de Relatórios**

A seguir são disponibilizados alguns insights obtidos com a execução das consultas no banco de dados:

- **Relatório de vendas de 2023**:
 - Quando calculamos o montante total de vendas que ocorreram este ano, observamos que a empresa obteve um valor robusto, demonstrando um bom desempenho em vendas nesse ano, ao longo do ano. Possibilita uma visão mais clara do volume de transações e da análise do fluxo de caixa anuais.

- **Média de gastos (por cliente)**:
 - A consulta de calcular a média de gastos por cliente traz conselhos importantes sobre o perfil de consumo da base de clientes. Identificar clientes que estão acima da média de gastos poderá gerar oportunidades para encontrar uma promoção específica ou estratégias de retenção. 

- **Volume de vendas, por produto**:
 - O que a empresa pode fazer ao reconhecer quais produtos são mais representativos nas vendas e ajusta seu estoque em função da demanda. Para produtos que têm venda consolidadas, pode aumentar seu stock. Para produtos com desempenho mais fraco, pode ser ou promovido ou retirado.

- **Valor total vendido, por categoria e produto**:
 - Essa análise possibilitará à empresa informá-la das categorias de produtos mais bem-sucedidas e quais produtos mais representaram vendas em cada categoria para a empresa e a empresa consegue ter uma lista de produtos mais atraentes para o estoque, em função da venda. Quando a empresa realiza a ordenação, em unidades vendidas, da horas da determinação dos produtos que apresentam melhores resultados, para o ajuste de marketing e vendas.
