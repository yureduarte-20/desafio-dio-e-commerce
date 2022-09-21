#Quantos pedidos tem cada cliente?
SELECT COUNT(p.id), _clientes.nome FROM pedidos AS p 
INNER JOIN (
	SELECT c.id AS id, 
    (
    	CASE	
        	WHEN c.tipo = 'PF' THEN pf.f_nome
        	WHEN c.tipo = 'PJ' THEN pj.razao_social
        	ELSE ''
        END
    ) AS nome FROM clientes AS c
    LEFT JOIN pessoa_juridica pj ON pj.cliente_id = c.id
    LEFT JOIN pessoa_fisica pf ON pf.cliente_id = c.id
) AS _clientes
ON _clientes.id = p.cliente_id
GROUP BY p.cliente_id;

#Algum vendedor também é fornecedor?
SELECT v.id, v.razao_social, v.cnpj FROM vendedor_terceiro as v WHERE EXISTS(
     SELECT f.id 
     FROM fornecedor AS f WHERE f.cnpj = v.cnpj
);

#produtos fornecedores e estoque

SELECT 
	p.id AS produto_id, f.cnpj AS fornecedor_cnpj,
	p.nome AS nome_produto, p.valor AS produto_valor,
    ca.nome AS produto_categoria, ep.quantidade AS quantidade_estoque
FROM fornecedor_produto AS fp
INNER JOIN produtos AS p ON p.id = fp.produto_id
INNER JOIN fornecedor AS f ON f.id = fp.fornecedor_id
LEFT JOIN categorias AS ca ON ca.id = p.categoria_id
INNER JOIN estoque_produto AS ep ON ep.produto_id = fp.produto_id;