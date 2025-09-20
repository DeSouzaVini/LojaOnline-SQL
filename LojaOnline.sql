CREATE DATABASE LojaOnline;
USE LojaOnline;

-- Tabela de clientes
CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    SEXO ENUM('M', 'F') NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Telefone VARCHAR(20),
    Endereco VARCHAR(200),
    DataCadastro DATE DEFAULT CURRENT_DATE
);

-- Tabela de categorias
CREATE TABLE Categorias (
    CategoriaID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

-- Tabela de produtos
CREATE TABLE Produtos (
    ProdutoID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

-- Tabela de estoque
CREATE TABLE Estoque (
    EstoqueID INT AUTO_INCREMENT PRIMARY KEY,
    ProdutoID INT,
    Quantidade INT NOT NULL,
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Tabela de pedidos
CREATE TABLE Pedidos (
    PedidoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    DataPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pendente','Pago','Enviado','Concluído','Cancelado') DEFAULT 'Pendente',
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabela de itens do pedido
CREATE TABLE ItensPedido (
    ItemID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT,
    ProdutoID INT,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Tabela de pagamentos
CREATE TABLE Pagamentos (
    PagamentoID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT,
    Valor DECIMAL(10,2) NOT NULL,
    Metodo ENUM('Cartão','Pix','Boleto') NOT NULL,
    Status ENUM('Aguardando','Aprovado','Recusado') DEFAULT 'Aguardando',
    DataPagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID)
);

-- Clientes (com SEXO adicionado)
INSERT INTO Clientes (Nome, SEXO, Email, Telefone, Endereco) VALUES
('Ana Silva', 'F', 'ana@email.com', '11999999999', 'Rua A, São Paulo'),
('Carlos Souza', 'M', 'carlos@email.com', '11988888888', 'Rua B, Rio de Janeiro'),
('Fernanda Lima', 'F', 'fernanda@email.com', '21977777777', 'Rua C, Belo Horizonte'),
('João Pedro', 'M', 'joao@email.com', '31966666666', 'Rua D, Porto Alegre'),
('Mariana Costa', 'F', 'mariana@email.com', '21955555555', 'Rua E, Salvador'),
('Lucas Almeida', 'M', 'lucas@email.com', '11944444444', 'Rua F, Curitiba'),
('Paula Mendes', 'F', 'paula@email.com', '21933333333', 'Rua G, Recife'),
('Rafael Torres', 'M', 'rafael@email.com', '11922222222', 'Rua H, Brasília'),
('Camila Rocha', 'F', 'camila@email.com', '31911111111', 'Rua I, Florianópolis'),
('Gabriel Santos', 'M', 'gabriel@email.com', '11910101010', 'Rua J, Goiânia'),
('Beatriz Ferreira', 'F', 'beatriz@email.com', '21912121212', 'Rua K, Manaus'),
('Rodrigo Pires', 'M', 'rodrigo@email.com', '31913131313', 'Rua L, Belém'),
('Juliana Martins', 'F', 'juliana@email.com', '11914141414', 'Rua M, Fortaleza'),
('Eduardo Gomes', 'M', 'eduardo@email.com', '21915151515', 'Rua N, Vitória'),
('Tatiane Silva', 'F', 'tatiane@email.com', '11916161616', 'Rua O, Natal'),
('Felipe Costa', 'M', 'felipe@email.com', '21917171717', 'Rua P, João Pessoa'),
('Carolina Dias', 'F', 'carolina@email.com', '31918181818', 'Rua Q, Maceió'),
('Vinicius Oliveira', 'M', 'vinicius@email.com', '11919191919', 'Rua R, Teresina'),
('Patrícia Nunes', 'F', 'patricia@email.com', '21920202020', 'Rua S, Campo Grande'),
('Thiago Barbosa', 'M', 'thiago@email.com', '31921212121', 'Rua T, São Luís');

-- Categorias
INSERT INTO Categorias (Nome) VALUES 
('Eletrônicos'), 
('Livros'), 
('Roupas'),
('Games'),
('Acessórios');

-- Produtos
INSERT INTO Produtos (Nome, Preco, CategoriaID) VALUES
('Notebook Dell', 3500.00, 1),
('Livro SQL Básico', 80.00, 2),
('Camiseta Preta', 50.00, 3),
('PlayStation 5', 4500.00, 4),
('Controle PS5', 400.00, 5),
('Fone de Ouvido Bluetooth', 250.00, 5),
('Livro Python Avançado', 120.00, 2),
('Smartphone Samsung', 2500.00, 1),
('Monitor LG 24"', 900.00, 1),
('Kindle Paperwhite', 600.00, 2),
('Jaqueta Jeans', 150.00, 3),
('Teclado Mecânico', 300.00, 5),
('Mouse Gamer', 200.00, 5),
('Livro Machine Learning', 180.00, 2),
('Headset Gamer', 350.00, 5);

-- Estoque
INSERT INTO Estoque (ProdutoID, Quantidade) VALUES
(1, 10),
(2, 50),
(3, 100),
(4, 5),
(5, 20),
(6, 30),
(7, 40),
(8, 15),
(9, 25),
(10, 40),
(11, 30),
(12, 35),
(13, 50),
(14, 20),
(15, 18);

-- Pedidos (corrigido "Aguardando Pagamento" para "Pendente")
INSERT INTO Pedidos (ClienteID, Status) VALUES 
(1, 'Pago'),
(2, 'Pago'),
(3, 'Pendente'),
(4, 'Pago'),
(5, 'Cancelado'),
(6, 'Pago'),
(7, 'Pago'),
(8, 'Pendente'),
(9, 'Cancelado'),
(10, 'Pago'),
(11, 'Pago'),
(12, 'Pendente'),
(13, 'Pago'),
(14, 'Pago'),
(15, 'Cancelado'),
(16, 'Pago'),
(17, 'Pendente'),
(18, 'Pago'),
(19, 'Pago'),
(20, 'Pago');

-- Itens pedido
INSERT INTO ItensPedido (PedidoID, ProdutoID, Quantidade, PrecoUnitario) VALUES
(1, 1, 1, 3500.00),
(1, 2, 2, 80.00),
(2, 4, 1, 4500.00),
(2, 5, 2, 400.00),
(3, 6, 1, 250.00),
(3, 7, 1, 120.00),
(4, 8, 1, 2500.00),
(5, 2, 1, 80.00),
(6, 9, 2, 900.00),
(7, 10, 1, 600.00),
(8, 11, 2, 150.00),
(9, 3, 2, 50.00),
(10, 5, 1, 400.00),
(11, 6, 1, 250.00),
(11, 7, 1, 120.00),
(12, 12, 1, 300.00),
(13, 13, 2, 200.00),
(14, 14, 1, 180.00),
(15, 15, 1, 350.00),
(16, 3, 3, 50.00),
(17, 1, 1, 3500.00),
(18, 4, 1, 4500.00),
(19, 9, 1, 900.00),
(20, 8, 1, 2500.00);

-- Pagamentos (corrigido: "Pendente" -> "Aguardando", "Cancelado" -> "Recusado")
INSERT INTO Pagamentos (PedidoID, Valor, Metodo, Status) VALUES
(1, 3660.00, 'Cartão', 'Aprovado'),
(2, 5300.00, 'Boleto', 'Aguardando'),
(3, 370.00, 'Pix', 'Aprovado'),
(4, 2500.00, 'Pix', 'Aprovado'),
(5, 80.00, 'Pix', 'Recusado'),
(6, 4300.00, 'Pix', 'Aprovado'),
(7, 600.00, 'Cartão', 'Aprovado'),
(8, 300.00, 'Boleto', 'Aguardando'),
(9, 100.00, 'Cartão', 'Recusado'),
(10, 400.00, 'Cartão', 'Aprovado'),
(11, 370.00, 'Pix', 'Aprovado'),
(12, 300.00, 'Boleto', 'Aguardando'),
(13, 400.00, 'Pix', 'Aprovado'),
(14, 180.00, 'Cartão', 'Aprovado'),
(15, 350.00, 'Pix', 'Aprovado'),
(16, 150.00, 'Cartão', 'Recusado'),
(17, 3500.00, 'Cartão', 'Aprovado'),
(18, 4500.00, 'Boleto', 'Aguardando'),
(19, 900.00, 'Pix', 'Aprovado'),
(20, 2500.00, 'Cartão', 'Aprovado');

-- Listar todos os clientes
SELECT * FROM Clientes;

-- Produtos mais vendidos
SELECT P.Nome, SUM(I.Quantidade) AS TotalVendido
FROM ItensPedido I
JOIN Produtos P ON I.ProdutoID = P.ProdutoID
GROUP BY P.Nome
ORDER BY TotalVendido DESC;

-- Total gasto por cliente
SELECT C.Nome, SUM(Pg.Valor) AS TotalGasto
FROM Clientes C
JOIN Pedidos Pd ON C.ClienteID = Pd.ClienteID
JOIN Pagamentos Pg ON Pd.PedidoID = Pg.PedidoID
WHERE Pg.Status = 'Aprovado'
GROUP BY C.Nome;

-- Estoque atual
SELECT P.Nome, E.Quantidade
FROM Estoque E
JOIN Produtos P ON E.ProdutoID = P.ProdutoID;
