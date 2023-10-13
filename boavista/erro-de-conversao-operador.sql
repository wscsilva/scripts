CREATE OR REPLACE FUNCTION public.int_equal_string(i integer, s character varying)
RETURNS boolean AS
'select cast($1 as varchar(20)) = $2'
LANGUAGE 'sql' VOLATILE
COST 100;

CREATE OPERATOR public.=(
PROCEDURE = "int_equal_string",
LEFTARG = int4,
RIGHTARG = varchar);

---
CREATE OR REPLACE FUNCTION public.bigint_equal_string(i bigint, s character varying)
RETURNS boolean AS
'select cast($1 as varchar(20)) = $2'
LANGUAGE 'sql' VOLATILE
COST 100;

CREATE OPERATOR public.=(
PROCEDURE = "bigint_equal_string",
LEFTARG = bigint,
RIGHTARG = varchar);