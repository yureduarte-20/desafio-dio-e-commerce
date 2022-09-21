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