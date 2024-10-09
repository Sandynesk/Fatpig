# Relatório de Lógica e Insights para o Projeto FatPig

**Autores**: Cadu e Emanuel  
**Data**: Outubro de 2024

---

### 1. **Estrutura do Banco de Dados**

Neste relatório, apresentamos a estrutura do banco de dados que projetamos para o gerenciamento de clientes, produtos, vendas e logs do sistema. Abaixo estão as principais entidades e seus relacionamentos:

- **Clientes**: Cada cliente possui um identificador único (ID_Cliente), além de nome, email, telefone e endereço. A data de cadastro dos clientes é registrada, permitindo o controle do tempo de relacionamento com a empresa.
  
- **Produtos**: Esta tabela armazena informações sobre os produtos disponíveis para venda, como nome, preço, categoria e quantidade em estoque. A relação com a tabela ItensVenda possibilita que o estoque seja atualizado automaticamente a cada venda.

- **Vendas**: Cada venda é registrada com um identificador único e referencia o cliente que a realizou. A tabela contém a data e o valor total da venda, que pode ser ajustado por descontos aplicáveis a clientes fidelizados.

- **ItensVenda**: Esta tabela atua como uma tabela associativa, armazenando os produtos vendidos em cada transação, juntamente com a quantidade e o preço unitário. Isso facilita a análise detalhada de cada venda.

- **Logs**: A tabela de logs registra informações de auditoria de vendas, incluindo o momento em que a venda foi realizada e uma descrição do evento.

Os principais relacionamentos são:
- **Clientes - Vendas**: Um cliente pode realizar várias vendas ao longo do tempo (relação um-para-muitos).
- **Vendas - Produtos (via ItensVenda)**: Uma venda pode incluir vários produtos, e um produto pode aparecer em várias vendas (relação muitos-para-muitos).

---

### 2. **Triggers**

Implementamos dois triggers para otimizar o gerenciamento do sistema de vendas:

1. **Trigger AtualizaEstoque**:
   - Esse trigger é acionado automaticamente após a inserção de um item na tabela **ItensVenda**, atualizando o estoque do produto correspondente ao subtrair a quantidade vendida. Isso garante a atualização consistente do estoque, evitando vendas de produtos fora de estoque.

2. **Trigger RegistraLogVenda**:
   - Acionado após a inserção de uma nova venda na tabela **Vendas**, esse trigger insere automaticamente um registro na tabela **Logs**, documentando o evento da venda. Essa prática facilita a auditoria e o monitoramento de todas as transações, proporcionando maior transparência nas operações.

---

### 3. **Procedure: AplicaDesconto**

Desenvolvemos a procedure **AplicaDesconto** com o objetivo de fidelizar os clientes que fazem compras recorrentes. A lógica dessa procedure verifica quantas compras o cliente já realizou; se o total for maior ou igual a 10, um desconto de 5% é aplicado na próxima compra realizada no mesmo dia. 

Esse mecanismo não só incentiva a continuidade das compras, mas também recompensa a lealdade dos clientes, fortalecendo o relacionamento com a empresa.

---

### 4. **Insights Baseados nas Consultas de Relatórios**

A seguir, apresentamos alguns insights obtidos através das consultas realizadas no banco de dados:

- **Relatório de vendas no ano de 2023**:
  - Ao calcular o total de vendas realizadas em 2023, notamos que a empresa teve um desempenho positivo, gerando um montante significativo. Isso oferece uma visão clara do volume de transações e possibilita uma análise detalhada do fluxo de caixa anual.

- **Média de gastos por cliente**:
  - A consulta que calcula a média de gastos por cliente fornece informações valiosas sobre o perfil de consumo. Identificar clientes que gastam acima da média pode abrir oportunidades para ações promocionais e estratégias de retenção.

- **Quantidade de vendas por produto**:
  - Identificar quais produtos foram mais vendidos permite que a empresa ajuste seu estoque conforme a demanda. Produtos com vendas consistentes podem ter o estoque aumentado, enquanto aqueles com menor desempenho podem ser analisados para promoções.

- **Total vendido por categoria e produto**:
  - Essa análise ajuda a identificar as categorias de produtos mais populares e os produtos mais vendidos dentro delas. A ordenação por quantidade vendida fornece uma visão clara dos produtos mais lucrativos, permitindo ajustes nas estratégias de marketing e vendas.

---

### 5. **Conclusão**

A estrutura do banco de dados, juntamente com os triggers, procedures e consultas otimizadas, garante um sistema eficiente e escalável. As lógicas implementadas não só automatizam processos como atualização de estoque e registro de vendas, mas também oferecem insights valiosos que podem orientar decisões estratégicas para o futuro da empresa.

Cadu e Emanuel
