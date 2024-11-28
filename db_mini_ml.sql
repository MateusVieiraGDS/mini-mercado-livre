-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS db_mini_ml;

-- Uso do banco de dados
USE db_mini_ml;

-- Tabela de usuários
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    nome VARCHAR(100) NOT NULL,        -- Nome do usuário
    email VARCHAR(100) NOT NULL UNIQUE, -- Email único
    senha VARCHAR(255) NOT NULL,       -- Senha do usuário
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Data de criação
);

-- Tabela de produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    nome VARCHAR(100) NOT NULL,        -- Nome do produto
    descricao TEXT,                    -- Descrição do produto
    preco DECIMAL(10, 2) NOT NULL,     -- Preço do produto
    quantidade INT DEFAULT 0,          -- Quantidade em estoque
    usuario_id INT NOT NULL,           -- Referência ao usuário que criou o produto
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data de criação
    CONSTRAINT fk_produto_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Tabela de compras (muitos-para-muitos entre usuários e produtos)
CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único da compra
    usuario_id INT NOT NULL,           -- Referência ao usuário que fez a compra
    produto_id INT NOT NULL,           -- Referência ao produto comprado
    quantidade INT NOT NULL,           -- Quantidade comprada
    data_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Data da compra
    CONSTRAINT fk_compra_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_compra_produto FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);
