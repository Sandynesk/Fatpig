# Relatório de Lógica e Insights para o Projeto FatPig

**Autores**: Cadu e Emanuel  
**Data**: Outubro de 2024

---

### 1. **Estrutura do Banco de Dados**

O banco de dados foi cuidadosamente projetado para atender às necessidades de gerenciamento de clientes, produtos, vendas e logs do sistema. Abaixo está uma descrição das principais entidades e seus relacionamentos:

- **Clientes**: Cada cliente possui um identificador único (ID_Cliente), nome, email, telefone e endereço. Clientes são registrados com a data de cadastro, permitindo um controle adequado do tempo de relacionamento com a empresa.
  
- **Produtos**: Armazena informações dos produtos disponíveis para venda, como nome, preço, categoria e quantidade em estoque. A relação direta com a tabela ItensVenda permite que o estoque seja controlado automaticamente sempre que um produto é vendido.

- **Vendas**: Cada venda é registrada com um identificador único, referenciando o cliente que realizou a compra. A venda inclui a data e o valor total, que pode ser modificado pela lógica de descontos aplicada a clientes fidelizados.

- **ItensVenda**: Serve como uma tabela associativa que armazena os produtos vendidos em cada transação, além da quantidade e preço unitário. Ela conecta as vendas aos produtos de forma eficiente, permitindo uma análise detalhada de cada transação.

- **Logs**: A tabela de logs armazena informações de auditoria de vendas, como o momento em que a venda foi realizada e uma descrição do evento.

Os principais relacionamentos incluem:
- **Clientes - Vendas**: Um cliente pode realizar várias vendas ao longo do tempo (relação um-para-muitos).
- **Vendas - Produtos (via ItensVenda)**: Uma venda pode incluir vários produtos, e um produto pode aparecer em várias vendas (relação muitos-para-muitos).

---

### 2. **Triggers**

Dois triggers foram criados para otimizar o gerenciamento do sistema de vendas:

1. **Trigger AtualizaEstoque**:
   - Esse trigger é acionado automaticamente após a inserção de um item na tabela **ItensVenda**. Ele atualiza o estoque do produto correspondente, subtraindo a quantidade vendida. Isso garante que o estoque seja sempre atualizado de forma consistente, evitando problemas como vendas de produtos fora de estoque.

2. **Trigger RegistraLogVenda**:
   - Acionado após a inserção de uma nova venda na tabela **Vendas**, esse trigger insere automaticamente um log na tabela **Logs**, registrando o evento da venda. Isso facilita a auditoria e monitoramento de todas as transações realizadas, possibilitando uma maior transparência nas operações.

---

### 3. **Procedure: AplicaDesconto**

A procedure **AplicaDesconto** foi desenvolvida com o objetivo de fidelizar os clientes que fazem compras recorrentes. A lógica da procedure verifica quantas compras o cliente já realizou e, se o número total de compras for maior ou igual a 10, aplica um desconto de 5% na próxima compra feita no mesmo dia. 

Esse mecanismo não apenas incentiva os clientes a continuar comprando, mas também introduz uma recompensa por sua lealdade, fortalecendo o relacionamento entre a empresa e seus clientes.

---

### 4. **Insights Baseados nas Consultas de Relatórios**

A seguir, apresentamos alguns insights obtidos com base nas consultas realizadas no banco de dados:

- **Relatório de vendas no ano de 2023**:
  - Ao calcular o total de vendas realizadas em 2023, observamos que a empresa gerou um montante significativo, indicando um bom desempenho de vendas ao longo do ano. Isso fornece uma visão clara do volume de transações e permite uma análise detalhada do fluxo de caixa anual.

- **Média de gastos por cliente**:
  - A consulta que calcula a média de gastos por cliente revela informações importantes sobre o perfil de consumo da base de clientes. Identificar clientes que gastam acima da média pode abrir oportunidades para ações promocionais específicas ou estratégias de retenção.

- **Quantidade de vendas por produto**:
  - Ao identificar quais produtos foram mais vendidos, a empresa pode ajustar seu estoque de acordo com a demanda. Produtos com vendas consistentes podem ter seu estoque aumentado, enquanto aqueles com menor desempenho podem ser analisados para promoções ou retiradas.

- **Total vendido por categoria e produto**:
  - Essa análise permite que a empresa identifique as categorias de produtos mais populares e os produtos mais vendidos dentro dessas categorias. A ordenação por quantidade vendida fornece uma visão clara dos produtos mais lucrativos, permitindo um ajuste nas estratégias de marketing e de vendas.

---

### 5. **Conclusão**

A estruturação do banco de dados, combinada com os triggers, procedures e consultas otimizadas, garante um sistema eficiente e escalável. A lógica implementada não só automatiza processos como atualização de estoque e registro de vendas, mas também fornece insights valiosos que podem guiar decisões estratégicas para o futuro da empresa.

Cadu e Emanuel
