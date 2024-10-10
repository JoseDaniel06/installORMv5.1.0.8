select object_type ELEMENTO, count(*) CANTIDAD
from user_objects
group by object_type
UNION
select 'CONSTRAINT ' || DECODE(constraint_type, 'R', 'REFERENTIAL', 'P', 'PRIMARY', 'C', 'CHECK', constraint_type) ELEMENTO, count(*) CANTIDAD
from user_constraints
group by constraint_type
UNION
SELECT  'OBJETOS INVALIDOS' ELEMENTO, count(*) CANTIDAD
         FROM user_objects a
        WHERE status = 'INVALID'
          AND object_type IN
                 ('PACKAGE BODY', 'PACKAGE', 'FUNCTION', 'PROCEDURE',
                  'TRIGGER', 'VIEW')
order by 1


--Resultado esperado
--CONSTRAINT CHECK			22
--CONSTRAINT PRIMARY		21
--CONSTRAINT REFERENTIAL	16
--INDEX						36
--LOB						14
--OBJETOS INVALIDOS		 	 0
--PACKAGE					 1
--PACKAGE BODY				 1
--SEQUENCE					 7
--TABLE						24
--TRIGGER			  		 2
--TYPE						 1