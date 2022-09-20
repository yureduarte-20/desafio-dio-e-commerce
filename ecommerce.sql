CREATE DATABASE IF NOT EXISTS ecommerce_dio;
USE ecommerce_dio;

CREATE TABLE IF NOT EXISTS clientes(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM ('PJ', 'PF') NOT NULL 
);

CREATE TABLE IF NOT EXISTS pessoa_fisica (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    cliente_id INTEGER NOT NULL UNIQUE,
    f_nome VARCHAR(45) NOT NULL,
    m_nome VARCHAR(45),
    l_nome VARCHAR(45) NOT NULL,
    cpf VARCHAR(11) NOT NULL ,
    CONSTRAINT cpf_unique_constraint UNIQUE(cpf)
);

CREATE TABLE IF NOT EXISTS pessoa_juridica (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    cliente_id INTEGER NOT NULL UNIQUE,
    razao_social VARCHAR(60) NOT NULL,
    nome_fantasia VARCHAR(60),
    cnpj VARCHAR(17) NOT NULL,
    CONSTRAINT pj_cnpj_constraint UNIQUE(cnpj)
);

CREATE TABLE IF NOT EXISTS enderecos (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    logradouro VARCHAR(120) NOT NULL,
    Bairro VARCHAR(60) NOT NULL,
    CEP VARCHAR(9) NOT NULL,
    UF VARCHAR(2) NOT NULL,
    Cidade VARCHAR(40) NOT NULL,
    numero VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS metodo_pagamento(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome_metodo_pagamento VARCHAR(40) NOT NULL,
    ativo BOOLEAN DEFAULT 1,
    cliente_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS cartoes(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    bandeira VARCHAR(45) NOT NULL,
    validade VARCHAR (7) NOT NULL,
    cod VARCHAR(16) NOT NULL,
    nome_frente VARCHAR(40) NOT NULL,
    cpf_responsavel VARCHAR(11) NOT NULL,    
    metodo_pagamento_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS categorias(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(40) NOT NULL,
    descricao TEXT
);

CREATE TABLE IF NOT EXISTS produtos(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    categoria_id INTEGER,
    valor DOUBLE NOT NULL DEFAULT 0.1,
    FOREIGN KEY(categoria_id) REFERENCES categorias(id)
);

CREATE TABLE IF NOT EXISTS estoque(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    local VARCHAR(45) NOT NULL,
    descricao TEXT
);

CREATE TABLE IF NOT EXISTS estoque_produto(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    produto_id INTEGER NOT NULL,
    categoria_id INTEGER NOT NULL,
    quantidade INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS vendedor_terceiro(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(45) NOT NULL,
    cnpj VARCHAR(17) NOT NULL UNIQUE,
    local TEXT,
    nome_fanstasia VARCHAR(45)
);
CREATE TABLE IF NOT EXISTS fornecedor(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(45) NOT NULL,
    cnpj VARCHAR(17) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS vendedor_produto(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    vendedor_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS fornecedor_produto(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    fornecedor_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL
);

#pedidos 
CREATE TABLE IF NOT EXISTS pedidos_status(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(30) NOT NULL,
    descricao text
);

CREATE TABLE IF NOT EXISTS pedidos(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    descricao text,
    cliente_id INTEGER NOT NULL,
    pagamento_id INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS pedidos_produtos(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    pedido_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS entregas(
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    entrega_prevista DATE NOT NULL,
    entrega_realizada TIMESTAMP,
    status_id INTEGER NOT NULL,
    endereco_id INTEGER NOT NULL,
    pedido_id INTEGER NOT NULL
);
#<-- Referências a outras tabelas
ALTER TABLE pessoa_fisica
    ADD CONSTRAINT FK_cliente_pessoaFisica 
        FOREIGN KEY (cliente_id) REFERENCES clientes(id); 
    
ALTER TABLE pessoa_juridica
    ADD CONSTRAINT FK_cliente_pessoaJuridica 
        FOREIGN KEY (cliente_id) REFERENCES clientes(id);

ALTER TABLE enderecos
    ADD CONSTRAINT FK_cliente_enderecos
        FOREIGN KEY (cliente_id) REFERENCES clientes(id);

ALTER TABLE cartoes
    ADD CONSTRAINT FK_cartao_metodo_pagamento
     FOREIGN KEY (metodo_pagamento_id) REFERENCES metodo_pagamento(id);

ALTER TABLE metodo_pagamento
    ADD CONSTRAINT FK_cartao_clientes
        FOREIGN KEY (cliente_id) REFERENCES clientes(id);

ALTER TABLE estoque_produto
    ADD CONSTRAINT FK_estoqueProduto_produtos
        FOREIGN KEY (produto_id) REFERENCES produtos(id),
    ADD CONSTRAINT FK_estoqueProduto_categorias 
        FOREIGN KEY (categoria_id) REFERENCES categorias(id);

ALTER TABLE vendedor_produto
    ADD CONSTRAINT FK_vendedorProduto_produtos
        FOREIGN KEY (produto_id) REFERENCES produtos(id),
    ADD CONSTRAINT FK_vendedorProduto_vendedorTerceiro 
        FOREIGN KEY (vendedor_id) REFERENCES vendedor_terceiro(id);

ALTER TABLE fornecedor_produto
    ADD CONSTRAINT FK_fornecedorProduto_produtos
        FOREIGN KEY (produto_id) REFERENCES produtos(id),
    ADD CONSTRAINT FK_fornecedorProduto_vendedorTerceiro 
        FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id);

ALTER TABLE pedidos_produtos
    ADD CONSTRAINT FK_pedidosProdutos_produtos
        FOREIGN KEY (produto_id) REFERENCES produtos(id),
    ADD CONSTRAINT FK_pedidosProdutos_pedido 
        FOREIGN KEY (pedido_id) REFERENCES pedidos(id);

ALTER TABLE pedidos
    ADD CONSTRAINT FK_pedidos_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    ADD CONSTRAINT FK_pedidosProdutos_metodoPagamento 
        FOREIGN KEY (pagamento_id) REFERENCES metodo_pagamento(id);

ALTER TABLE entregas
    ADD CONSTRAINT FK_entregas_status
        FOREIGN KEY (status_id) REFERENCES pedidos_status(id),
    ADD CONSTRAINT FK_entregas_endereco
        FOREIGN KEY (endereco_id) REFERENCES enderecos(id),
    ADD CONSTRAINT FK_entregas_pedido 
        FOREIGN KEY(pedido_id) REFERENCES pedidos(id);


