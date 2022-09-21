

SET @@autocommit = OFF;
USE ecommerce_dio;
DELIMITER //
CREATE PROCEDURE insere_dados()
BEGIN
DECLARE erro_sql TINYINT DEFAULT FALSE;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET erro_sql = TRUE;
START TRANSACTION;
    

    INSERT INTO clientes( id, tipo ) VALUES (1,'PF');
    INSERT INTO clientes( id, tipo ) VALUES (2,'PF');
    INSERT INTO clientes( id, tipo ) VALUES (3,'PF');
    INSERT INTO clientes( id, tipo ) VALUES (4,'PJ');
    INSERT INTO clientes( id, tipo ) VALUES (5,'PJ');

    INSERT INTO pessoa_fisica(cliente_id, f_nome, m_nome, l_nome, cpf) VALUES (1, 'Ricardo', 'Alfredo', 'Duarte', '523642167');
    INSERT INTO pessoa_fisica(cliente_id, f_nome, m_nome, l_nome, cpf) VALUES (2, 'Jose', '', 'Duarte', '441230692');
    INSERT INTO pessoa_fisica(cliente_id, f_nome, m_nome, l_nome, cpf) VALUES (3, 'Yure', 'Alessando', 'Cunha', '963574125');
    INSERT INTO pessoa_juridica(cliente_id, razao_social, cnpj) VALUES (4, 'peixes LTDA', '554135721000');
    INSERT INTO pessoa_juridica(cliente_id, razao_social, cnpj) VALUES (5, 'Concencio MEI', '5484957154');

    INSERT INTO enderecos ( id, cliente_id, logradouro, Bairro, UF, Cidade, CEP, numero ) VALUES(1, 1, 'Bem Ali 1', 'é ali mesmo','PA','city 1', '552215', NULL ) ;
    INSERT INTO enderecos ( id, cliente_id, logradouro, Bairro, UF, Cidade, CEP, numero ) VALUES(2, 2, 'Bem Ali 2', 'é ali mesmo','PA','city 1', '552215', NULL ) ;
    INSERT INTO enderecos ( id, cliente_id, logradouro, Bairro, UF, Cidade, CEP, numero ) VALUES(3, 3, 'Bem Ali 3', 'é ali mesmo','PA','city 1', '552215', '34' ) ;
    INSERT INTO enderecos ( id, cliente_id, logradouro, Bairro, UF, Cidade, CEP, numero ) VALUES( 4,4, 'Bem Ali 4', 'é ali mesmo','PA','city 1', '552215', '589' ) ;
    INSERT INTO enderecos ( id, cliente_id, logradouro, Bairro, UF, Cidade, CEP, numero ) VALUES( 5,5, 'Bem Ali 5', 'é ali mesmo','PA','city 1', '552215', '12' ) ;

    INSERT INTO metodo_pagamento(id,cliente_id , nome_metodo_pagamento  ) VALUES( 1, 1, 'cartao credito');
    INSERT INTO metodo_pagamento(id,cliente_id , nome_metodo_pagamento  ) VALUES(2,2, 'cartao debito');
    INSERT INTO metodo_pagamento(id,cliente_id , nome_metodo_pagamento  ) VALUES(3,3, 'cartao parcelado');
    INSERT INTO metodo_pagamento(id,cliente_id , nome_metodo_pagamento  ) VALUES(4,4, 'cartao debito');
    INSERT INTO metodo_pagamento(id,cliente_id , nome_metodo_pagamento  ) VALUES(5,5, 'cartao credito');

    INSERT INTO cartoes(id, metodo_pagamento_id, cod, validade, nome_frente, cpf_responsavel, bandeira ) VALUES ( 1,1, '44525855', '08/20','Ninguem',  '0054221', 'Visa' );
    INSERT INTO cartoes(id, metodo_pagamento_id, cod, validade, nome_frente, cpf_responsavel, bandeira ) VALUES ( 2,2, '44545', '04/27', 'Eduardo', '445112', 'MasterCard' );
    INSERT INTO cartoes(id, metodo_pagamento_id, cod, validade, nome_frente, cpf_responsavel, bandeira ) VALUES ( 3,3, '44522147', '01/22', 'Pedro H','7452158', 'Elo' );
    INSERT INTO cartoes(id, metodo_pagamento_id, cod, validade, nome_frente, cpf_responsavel, bandeira ) VALUES ( 4,4, '4778', '01/24', 'Picullo','4584120', 'Visa' );
    INSERT INTO cartoes(id, metodo_pagamento_id, cod, validade, nome_frente, cpf_responsavel, bandeira ) VALUES ( 5,5, '44411', '03/25','Alfredo machado' ,'54109', 'American Express' );

    #Categorias para produtos 
    INSERT INTO categorias(id, nome, descricao) VALUES ( 1,'Eletrônico', NULL );
    INSERT INTO categorias(id, nome, descricao) VALUES ( 2,'Domestico', NULL );
    INSERT INTO categorias(id, nome, descricao) VALUES ( 3,'Lazer', NULL );
    INSERT INTO categorias(id, nome, descricao) VALUES ( 4,'Limpeza', NULL );
    INSERT INTO categorias(id, nome, descricao) VALUES ( 5,'Cosmético', NULL );
    # estoque
    INSERT INTO estoque (id, local) VALUES(1,'Depósito 1');

    INSERT INTO fornecedor(id,razao_social, cnpj) VALUES(1,'Empresa 1 LTDA', '55215');
    INSERT INTO fornecedor(id,razao_social, cnpj) VALUES(2,'Empresa 2 LTDA', '75215');
    INSERT INTO fornecedor(id,razao_social, cnpj) VALUES(3,'Empresa 3 LTDA', '85215');

    INSERT INTO vendedor_terceiro(id,razao_social, cnpj) VALUES(1,'Vendedor Terceiro 1', '5521697');
    INSERT INTO vendedor_terceiro(id,razao_social, cnpj) VALUES(2,'Empresa 1 LTDA', '55215');
    #status da entrega dos pedidos
    INSERT INTO pedidos_status(id,nome) VALUES(1,'Em processamento');
    INSERT INTO pedidos_status(id,nome) VALUES(2,'A Caminho');
    INSERT INTO pedidos_status(id,nome) VALUES(3,'Finalizado');
    INSERT INTO pedidos_status(id,nome) VALUES(4,'Cancelado');

    #produtos
    INSERT INTO produtos(id, nome, valor, categoria_id) VALUES (1,'Laptop', 2000.0, 1);
    INSERT INTO produtos(id, nome, valor, categoria_id) VALUES (2,'Geladeira', 3000.0, 2);
    INSERT INTO produtos(id, nome, valor, categoria_id) VALUES (3,'Cama', 1000.0, 3);
    INSERT INTO produtos(id, nome, valor, categoria_id) VALUES (4,'Esfregão', 25.0, 3);
    INSERT INTO produtos(id, nome, valor, categoria_id) VALUES (5,'Esponja', 4.0, 1);
    INSERT INTO produtos(id, nome, valor, categoria_id) VALUES (6,'Computador Mesa', 3000.0, 1);
    INSERT INTO produtos(id, nome, valor, categoria_id) VALUES (7,'Batom', 2.0, 5);
    INSERT INTO produtos(id, nome, valor, categoria_id) VALUES (8,'Creme', 125.0, 5);
    INSERT INTO produtos(id, nome, valor, categoria_id) VALUES (9,'Colchão', 600.0, 3);

    #Estoque
    INSERT INTO estoque_produto(id, produto_id, estoque_id, quantidade) VALUES (1,1, 1, 3);
    INSERT INTO estoque_produto(id, produto_id, estoque_id, quantidade) VALUES (2,2, 1, 5);
    INSERT INTO estoque_produto(id, produto_id, estoque_id, quantidade) VALUES (3,3, 1, 3);
    INSERT INTO estoque_produto(id, produto_id, estoque_id, quantidade) VALUES (4,4, 1, 7);
    INSERT INTO estoque_produto(id, produto_id, estoque_id, quantidade) VALUES (5,5, 1, 9);
    INSERT INTO estoque_produto(id, produto_id, estoque_id, quantidade) VALUES (6,6, 1, 20);
    INSERT INTO estoque_produto(id, produto_id, estoque_id, quantidade) VALUES (7,7, 1, 30);
    INSERT INTO estoque_produto(id, produto_id, estoque_id, quantidade) VALUES (8,8, 1, 7);
    INSERT INTO estoque_produto(id, produto_id, estoque_id, quantidade) VALUES (9,9, 1, 6);

    INSERT INTO fornecedor_produto( id, fornecedor_id, produto_id ) VALUES( 1,1, 1 );
    INSERT INTO fornecedor_produto( id, fornecedor_id, produto_id ) VALUES( 2,1, 2 );
    INSERT INTO fornecedor_produto( id, fornecedor_id, produto_id ) VALUES( 3,2, 3 );
    INSERT INTO fornecedor_produto( id, fornecedor_id, produto_id ) VALUES( 4,2, 4 );
    INSERT INTO fornecedor_produto( id, fornecedor_id, produto_id ) VALUES( 5,3, 5 );
    INSERT INTO fornecedor_produto( id, fornecedor_id, produto_id ) VALUES( 6,3, 6 );

    INSERT INTO vendedor_produto(id, produto_id, vendedor_id) VALUES(1 , 7, 1);
    INSERT INTO vendedor_produto(id, produto_id, vendedor_id) VALUES(2, 8, 1);
    INSERT INTO vendedor_produto(id, produto_id, vendedor_id) VALUES(3, 9, 2);

    # Criação de pedidos
    INSERT INTO pedidos( id,  cliente_id, pagamento_id) VALUES(1, 1 , 1);
    INSERT INTO  pedidos_produtos(id ,pedido_id, produto_id) VALUES(1, 1 , 2 );
    INSERT INTO  pedidos_produtos(id ,pedido_id, produto_id) VALUES(2, 1 , 3 );
    INSERT INTO  pedidos_produtos(id, pedido_id, produto_id) VALUES(3, 1 , 7 );


    INSERT INTO pedidos(id, cliente_id, pagamento_id) VALUES(2, 2 , 2);
    INSERT INTO  pedidos_produtos(pedido_id, produto_id) VALUES( 2 , 1 );
    INSERT INTO  pedidos_produtos(pedido_id, produto_id) VALUES( 2 , 3 );

    INSERT INTO pedidos(id, cliente_id, pagamento_id) VALUES(3, 4,4);
    INSERT INTO  pedidos_produtos(pedido_id, produto_id) VALUES( 3 , 4 );
    INSERT INTO  pedidos_produtos(pedido_id, produto_id) VALUES( 3 , 8 );

    INSERT INTO pedidos(id, cliente_id, pagamento_id) VALUES(4, 4,4);
    INSERT INTO  pedidos_produtos(pedido_id, produto_id) VALUES( 3 , 9 );
    INSERT INTO  pedidos_produtos(pedido_id, produto_id) VALUES( 3 , 1 );

    INSERT INTO entregas(entrega_prevista, endereco_id, pedido_id, status_id, entrega_realizada, cod_rastreio) VALUES('2020-01-10', 1, 1,3,'2020-01-10 15:14:07', 'BR44574425F');
    INSERT INTO entregas(entrega_prevista, endereco_id, pedido_id, status_id, cod_rastreio) VALUES('2020-01-10', 2, 2, 2, 'BR44575ZF');
    INSERT INTO entregas(entrega_prevista, endereco_id, pedido_id, status_id, cod_rastreio) VALUES('2020-01-10', 4, 3, 1, 'BR44574425F');

  IF erro_sql = FALSE THEN
    COMMIT;
    SELECT 'Transação efetivada com sucesso.' AS Resultado;
  ELSE
    ROLLBACK;
    SELECT 'Erro na transação' AS Resultado;
  END IF;
END//
DELIMITER ;

CALL insere_dados();