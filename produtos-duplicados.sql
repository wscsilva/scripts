select 
	pro_descricao ,
	count(pro_codigo) ,
	jsonb_agg(pro_codigo) 
from wsproduto w 
group by 1
having count(pro_descricao) > 1
