-- seleciona todos os produtos que estão com a descrição duplicada
-- jsonb_agg - exibe todos os códigos da descrição duplicada em um unica linha
select 
	pro_descricao ,
	count(pro_codigo) ,
	jsonb_agg(pro_codigo) 
from wsproduto w 
group by 1
having count(pro_descricao) > 1
