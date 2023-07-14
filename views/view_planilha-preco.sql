CREATE OR REPLACE VIEW public.v_venda_produto
 AS
SELECT sum(preco_venda_liq) as total, 
date_part('month'::text, wsvendaprd.data) as mes,
pro_codigo as codigo,
loj_codigo as loja
FROM wsvendaprd 
GROUP BY  mes, codigo, loja