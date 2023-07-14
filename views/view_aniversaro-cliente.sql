
-- View: public.v_aniversario_cliente

-- DROP VIEW public.v_aniversario_cliente;

CREATE OR REPLACE VIEW public.v_aniversario_cliente
 AS
 SELECT wscliente.cli_codigo,
    wscliente.cli_dat_nascimento,
    (make_date((date_part('year'::text, now()))::integer, (date_part('month'::text, wscliente.cli_dat_nascimento))::integer, (date_part('day'::text, wscliente.cli_dat_nascimento))::integer))::timestamp without time zone AS aniversario,
    wscliente.cli_raz_social
   FROM wscliente
  WHERE ((wscliente.cli_dat_nascimento IS NOT NULL) AND (date_part('month'::text, wscliente.cli_dat_nascimento) = date_part('month'::text, now())) AND (date_part('week'::text, make_date((date_part('year'::text, now()))::integer, (date_part('month'::text, wscliente.cli_dat_nascimento))::integer, (date_part('day'::text, wscliente.cli_dat_nascimento))::integer)) = date_part('week'::text, now())))
  ORDER BY ((make_date((date_part('year'::text, now()))::integer, (date_part('month'::text, wscliente.cli_dat_nascimento))::integer, (date_part('day'::text, wscliente.cli_dat_nascimento))::integer))::timestamp without time zone);

ALTER TABLE public.v_aniversario_cliente
    OWNER TO postgres;
COMMENT ON VIEW public.v_aniversario_cliente
    IS 'Seleciona todos os cliente que fazem aniversario na semana corrente';

-- View: public.v_aniversario_cliente_totalizador

-- DROP VIEW public.v_aniversario_cliente_totalizador;

CREATE OR REPLACE VIEW public.v_aniversario_cliente_totalizador
 AS
 SELECT count(*) AS totalclienteaniversario
   FROM wscliente
  WHERE ((wscliente.cli_dat_nascimento IS NOT NULL) AND (date_part('month'::text, wscliente.cli_dat_nascimento) = date_part('month'::text, now())) AND (date_part('week'::text, make_date((date_part('year'::text, now()))::integer, (date_part('month'::text, wscliente.cli_dat_nascimento))::integer, (date_part('day'::text, wscliente.cli_dat_nascimento))::integer)) = date_part('week'::text, now())));

ALTER TABLE public.v_aniversario_cliente_totalizador
    OWNER TO postgres;
COMMENT ON VIEW public.v_aniversario_cliente_totalizador
    IS 'Total de clientes que fazem aniverario na semana corrente';
