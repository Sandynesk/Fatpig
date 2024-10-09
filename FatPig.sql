CREATE DATABASE FatPig;
USE FatPig;


-- Criação de tabelas
CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Email VARCHAR(100),
    Telefone VARCHAR(20),
    Endereco VARCHAR(200),
    DataCadastro DATE
);


CREATE TABLE Produtos (
    ID_Produto INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100),
    Preco DECIMAL(10, 2),
    Categoria VARCHAR(50),
    Estoque INT
);


CREATE TABLE Vendas (
    ID_Venda INT PRIMARY KEY AUTO_INCREMENT,
    ID_Cliente INT,
    DataVenda DATE,
    ValorTotal DECIMAL(10, 2),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
);


CREATE TABLE ItensVenda (
    ID_ItemVenda INT PRIMARY KEY AUTO_INCREMENT,
    ID_Venda INT,
    ID_Produto INT,
    Quantidade INT,
    PrecoUnitario DECIMAL(10, 2),
    FOREIGN KEY (ID_Venda) REFERENCES Vendas(ID_Venda),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID_Produto)
);

CREATE TABLE Logs (
    ID_Log INT PRIMARY KEY AUTO_INCREMENT,
    ID_Venda INT,
    DataHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Descricao VARCHAR(255),
    FOREIGN KEY (ID_Venda) REFERENCES Vendas(ID_Venda)
);

-- Trigger para atualizar o estoque automaticamente após uma venda
DELIMITER $$

CREATE TRIGGER AtualizaEstoque AFTER INSERT ON ItensVenda
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET Estoque = Estoque - NEW.Quantidade
    WHERE ID_Produto = NEW.ID_Produto;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER RegistraLogVenda AFTER INSERT ON Vendas
FOR EACH ROW
BEGIN
    INSERT INTO Logs (ID_Venda, Descricao)
    VALUES (NEW.ID_Venda, CONCAT('Venda realizada: ', NEW.ID_Venda));
END$$

DELIMITER ;


-- Procedure para aplicar desconto a clientes que atingirem um certo número de compras
DELIMITER $$

CREATE PROCEDURE AplicaDesconto(IN p_ID_Cliente INT)
BEGIN
    DECLARE qtdCompras INT;

    -- Verifica a quantidade de compras do cliente
    SELECT COUNT(*) INTO qtdCompras 
    FROM Vendas 
    WHERE ID_Cliente = p_ID_Cliente;

    -- Se o cliente tiver mais de 10 compras, aplica um desconto de 5%
    IF qtdCompras >= 10 THEN
        UPDATE Vendas
        SET ValorTotal = ValorTotal * 0.95
        WHERE ID_Cliente = p_ID_Cliente 
        AND DataVenda = CURDATE();
    END IF;
END$$

DELIMITER ;


-- Consultas para gerar relatórios

-- Relatório de vendas no ano de 2023
SELECT SUM(ValorTotal) AS TotalVendas
FROM Vendas
WHERE DataVenda BETWEEN '2023-01-01' AND '2023-12-31';

-- Média de gastos por cliente
SELECT ID_Cliente, AVG(ValorTotal) AS MediaGastos
FROM Vendas
GROUP BY ID_Cliente;

-- Quantidade de vendas por produto
SELECT P.Nome, COUNT(IV.ID_ItemVenda) AS QuantidadeVendas
FROM Produtos P
JOIN ItensVenda IV ON P.ID_Produto = IV.ID_Produto
GROUP BY P.Nome;

-- Total vendido por categoria e produto, ordenado do mais vendido
SELECT P.Categoria, P.Nome, SUM(IV.Quantidade) AS TotalVendido
FROM Produtos P
JOIN ItensVenda IV ON P.ID_Produto = IV.ID_Produto
GROUP BY P.Categoria, P.Nome
ORDER BY TotalVendido DESC;

-- Consultas de Integração e Análise de Dados

SELECT SUM(ValorTotal) AS TotalVendas
FROM Vendas
WHERE DataVenda BETWEEN '2023-01-01' AND '2023-12-31';

SELECT ID_Cliente, AVG(ValorTotal) AS MediaGastos
FROM Vendas
GROUP BY ID_Cliente;

SELECT P.Nome, COUNT(IV.ID_ItemVenda) AS QuantidadeVendas
FROM Produtos P
JOIN ItensVenda IV ON P.ID_Produto = IV.ID_Produto
GROUP BY P.Nome;

SELECT P.Categoria, P.Nome, SUM(IV.Quantidade) AS TotalVendido
FROM Produtos P
JOIN ItensVenda IV ON P.ID_Produto = IV.ID_Produto
GROUP BY P.Categoria, P.Nome
ORDER BY TotalVendido DESC;

-- Inserts
INSERT INTO Clientes (Nome, Email, Telefone, Endereco, DataCadastro) VALUES
('Ana Silva', 'ana.silva@email.com', '1234-5678', 'Rua A, 123', '2023-01-15'),
('Carlos Oliveira', 'carlos.oliveira@email.com', '2345-6789', 'Rua B, 456', '2023-02-20'),
('Fernanda Souza', 'fernanda.souza@email.com', '3456-7890', 'Rua C, 789', '2023-03-10');


INSERT INTO Produtos (Nome, Preco, Categoria, Estoque) VALUES
('Produto A', 10.00, 'Categoria 1', 100),
('Produto B', 20.00, 'Categoria 1', 50),
('Produto C', 15.00, 'Categoria 2', 200),
('Produto D', 25.00, 'Categoria 2', 75),
('Produto E', 30.00, 'Categoria 3', 30);


INSERT INTO Vendas (ID_Cliente, DataVenda, ValorTotal) VALUES
(1, '2023-04-01', 50.00),
(2, '2023-04-02', 75.00),
(1, '2023-04-05', 40.00);


INSERT INTO ItensVenda (ID_Venda, ID_Produto, Quantidade, PrecoUnitario) VALUES
(1, 1, 2, 10.00), -- 2 unidades do Produto A
(1, 2, 1, 20.00), -- 1 unidade do Produto B
(2, 3, 3, 15.00), -- 3 unidades do Produto C
(2, 4, 1, 25.00), -- 1 unidade do Produto D
(3, 1, 1, 10.00), -- 1 unidade do Produto A
(3, 5, 2, 30.00); -- 2 unidades do Produto E


INSERT INTO Logs (ID_Venda, Descricao) VALUES
(1, 'Venda realizada: 1'),
(2, 'Venda realizada: 2'),
(3, 'Venda realizada: 3');

-- Selects
SELECT * FROM Clientes;

SELECT * FROM Produtos;

SELECT * FROM Vendas;

SELECT * FROM ItensVenda;

SELECT * FROM Logs;


