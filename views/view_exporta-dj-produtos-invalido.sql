CREATE OR REPLACE VIEW public.v_exporta_dj_produtos_invalido
AS SELECT p.tipo,
    p.pro_codigo,
    p.pro_descricao,
    p.pro_ncm,
    p.pro_suspenso,
    p.count
   FROM ( SELECT 'ncms'::text AS tipo,
            p_1.pro_codigo,
            p_1.pro_descricao,
            p_1.pro_ncm,
            p_1.pro_suspenso,
            count(p_1.pro_codigo) OVER () AS count
           FROM wsproduto p_1
          WHERE p_1.pro_ncm IS NULL OR p_1.pro_ncm::text = ''::text
        UNION
         SELECT 'suspensos'::text AS tipo,
            p_1.pro_codigo,
            p_1.pro_descricao,
            p_1.pro_ncm,
            p_1.pro_suspenso,
            count(p_1.pro_codigo) OVER () AS count
           FROM wsproduto p_1
          WHERE p_1.pro_suspenso = 'S'::bpchar
  ORDER BY 4 DESC) p
  ORDER BY p.pro_ncm DESC, p.pro_descricao;