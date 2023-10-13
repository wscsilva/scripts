-- public.v_romaneio_relatoro_listagem_v2 source

CREATE OR REPLACE VIEW public.v_romaneio_relatoro_listagem_v2
AS WITH orc AS (
         SELECT o_1.cli_codigo,
            i.pro_codigo,
            o_1.rom_numero,
            sum(i.ito_qtde) AS qtd_total
           FROM wsorcamento o_1
             JOIN wsitensorcamento i ON o_1.orc_codigo = i.orc_codigo
          WHERE i.ito_qtde > 0::numeric
          GROUP BY o_1.cli_codigo, i.pro_codigo, o_1.rom_numero
          ORDER BY o_1.cli_codigo
        )
 SELECT p.pro_codigo,
    p.pro_descricao,
    o.rom_numero,
    sum(o.qtd_total) AS qtd_total,
    sum(
        CASE
            WHEN c.cli_codigo = 1 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "CITROLANDIA",
    sum(
        CASE
            WHEN c.cli_codigo = 2 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "TEREZOPOLIS",
    sum(
        CASE
            WHEN c.cli_codigo = 3 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "LARANJEIRAS",
    sum(
        CASE
            WHEN c.cli_codigo = 4 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "ABC SUPER",
    sum(
        CASE
            WHEN c.cli_codigo = 5 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "VILA CRISTINA",
    sum(
        CASE
            WHEN c.cli_codigo = 6 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "SAO CAETANO",
    sum(
        CASE
            WHEN c.cli_codigo = 7 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "ALTEROSAS",
    sum(
        CASE
            WHEN c.cli_codigo = 8 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "CEABE",
    sum(
        CASE
            WHEN c.cli_codigo = 9 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "BETANIA",
    sum(
        CASE
            WHEN c.cli_codigo = 10 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "JK",
    sum(
        CASE
            WHEN c.cli_codigo = 11 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "AMERICA",
    sum(
        CASE
            WHEN c.cli_codigo = 12 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "ADILSON",
    sum(
        CASE
            WHEN c.cli_codigo = 13 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "BELA VISTA",
    sum(
        CASE
            WHEN c.cli_codigo = 14 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "GUSTAVO",
    sum(
        CASE
            WHEN c.cli_codigo = 15 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "CAPELINHA",
    sum(
        CASE
            WHEN c.cli_codigo = 16 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "ABC POPULAR",
    sum(
        CASE
            WHEN c.cli_codigo = 17 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "DONA MARIA",
    sum(
        CASE
            WHEN c.cli_codigo = 18 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "PTB2",
    sum(
        CASE
            WHEN c.cli_codigo = 19 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "PTB1",
    sum(
        CASE
            WHEN c.cli_codigo = 20 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "MULTIRAO",
    sum(
        CASE
            WHEN c.cli_codigo = 21 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "ABC ALTEROSAS",
    sum(
        CASE
            WHEN c.cli_codigo = 22 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "VIANOPOLIS",
    sum(
        CASE
            WHEN c.cli_codigo = 23 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "TRAVESSEIRO",
    sum(
        CASE
            WHEN c.cli_codigo = 24 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "SAPAO CONTAGEM",
    sum(
        CASE
            WHEN c.cli_codigo = 25 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "PROCESSADOS",
    sum(
        CASE
            WHEN c.cli_codigo = 26 THEN o.qtd_total
            ELSE 0::numeric
        END) AS "ABC SARANDI"
   FROM orc o
     JOIN wscliente c ON c.cli_codigo = o.cli_codigo
     JOIN wsproduto p ON p.pro_codigo = o.pro_codigo
  GROUP BY p.pro_codigo, o.rom_numero
  ORDER BY p.pro_codigo;