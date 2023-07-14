-- View: Rank de Cliente
CREATE OR REPLACE VIEW public.v_rank_cliente_mes
 AS
 SELECT wscliente.cli_raz_social,
    sum(wsvendaprd.preco_venda_liq) AS valor_total
   FROM wsvendaprd
     JOIN wscliente ON wsvendaprd.cli_codigo = wscliente.cli_codigo
  WHERE date_part('month'::text, wsvendaprd.data) = date_part('month'::text, now()) AND date_part('years'::text, wsvendaprd.data) = date_part('year'::text, now()) AND wscliente.cli_codigo <> 2
  GROUP BY wscliente.cli_raz_social
  ORDER BY (sum(wsvendaprd.preco_venda_liq)) DESC
 LIMIT 10;

ALTER TABLE public.v_rank_cliente_mes
    OWNER TO postgres;
