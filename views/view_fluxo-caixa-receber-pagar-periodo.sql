-- View: public.v_fluxo_caixa_receber_pagar_periodo

-- DROP VIEW public.v_fluxo_caixa_receber_pagar_periodo;

CREATE OR REPLACE VIEW public.v_fluxo_caixa_receber_pagar_periodo
 AS
 SELECT d.data,
    d.receber,
    d.r_aberto,
    d.pagar,
    d.p_aberto,
    d.saldo,
    d.total_receber,
    d.total_pagar,
    d.total_receber - d.total_pagar AS saldo_final
   FROM ( SELECT d_1.data_vencimento AS data,
            d_1.receber,
            d_1.r_aberto,
            d_1.pagar,
            d_1.p_aberto,
            sum(d_1.receber - d_1.pagar) OVER (ORDER BY d_1.data_vencimento) AS saldo,
            sum(d_1.receber) OVER () AS total_receber,
            sum(d_1.pagar) OVER () AS total_pagar
           FROM ( SELECT d_2.data_vencimento,
                    sum(
                        CASE
                            WHEN d_2.receber = 'R'::text THEN d_2.valor_gerado
                            ELSE 0::numeric
                        END) AS receber,
                    sum(
                        CASE
                            WHEN d_2.receber = 'R'::text THEN d_2.valor_pago
                            ELSE 0::numeric
                        END) AS recebido,
                    sum(
                        CASE
                            WHEN d_2.receber = 'R'::text THEN d_2.valor_aberto
                            ELSE 0::numeric
                        END) AS r_aberto,
                    sum(
                        CASE
                            WHEN d_2.receber = 'P'::text THEN d_2.valor_gerado
                            ELSE 0::numeric
                        END) AS pagar,
                    sum(
                        CASE
                            WHEN d_2.receber = 'P'::text THEN d_2.valor_pago
                            ELSE 0::numeric
                        END) AS pago,
                    sum(
                        CASE
                            WHEN d_2.receber = 'P'::text THEN d_2.valor_aberto
                            ELSE 0::numeric
                        END) AS p_aberto
                   FROM ( WITH receber AS (
                                 SELECT r.data_vencimento,
                                    r.valor_gerado,
                                    r.valor_aberto,
                                    r.valor_pago,
                                    'R'::text AS receber
                                   FROM ( SELECT r_1.ctr_dat_vencto AS data_vencimento,
    sum(r_1.ctr_val_gerado) AS valor_gerado,
    sum(
  CASE
   WHEN r_1.ctr_baixado = 'N'::bpchar THEN r_1.ctr_val_gerado
   ELSE 0::numeric
  END) AS valor_aberto,
    sum(r_1.ctr_val_pagto) AS valor_pago
   FROM wsctrecebe r_1
  WHERE r_1.ctr_codigo IS NULL
  GROUP BY r_1.ctr_dat_vencto
  ORDER BY r_1.ctr_dat_vencto) r
                                ), pagar AS (
                                 SELECT p.data_vencimento,
                                    p.valor_gerado,
                                    p.valor_aberto,
                                    p.valor_pago,
                                    'P'::text AS pagar
                                   FROM ( SELECT p_1.ctp_dat_vencto AS data_vencimento,
    sum(p_1.ctp_val_gerado) AS valor_gerado,
    sum(
  CASE
   WHEN p_1.ctp_baixado = 'N'::bpchar THEN p_1.ctp_val_gerado
   ELSE 0::numeric
  END) AS valor_aberto,
    sum(p_1.ctp_val_pagto) AS valor_pago
   FROM wsctpagar p_1
  WHERE p_1.ctp_codigo IS NULL
  GROUP BY p_1.ctp_dat_vencto
  ORDER BY p_1.ctp_dat_vencto) p
                                )
                         SELECT receber.data_vencimento,
                            receber.valor_gerado,
                            receber.valor_aberto,
                            receber.valor_pago,
                            receber.receber
                           FROM receber
                        UNION
                         SELECT pagar.data_vencimento,
                            pagar.valor_gerado,
                            pagar.valor_aberto,
                            pagar.valor_pago,
                            pagar.pagar
                           FROM pagar) d_2
                  GROUP BY d_2.data_vencimento
                  ORDER BY d_2.data_vencimento) d_1
          ORDER BY d_1.data_vencimento) d;

ALTER TABLE public.v_fluxo_caixa_receber_pagar_periodo
    OWNER TO postgres;
