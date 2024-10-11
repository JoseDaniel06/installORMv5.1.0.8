CREATE ROLE ORM_USER_ROLE NOT IDENTIFIED;

--------------------------------------------------------------------------------------
--   ___   ____  _____ 
--  / _ \ |  _ \|_   _|
-- | | | || |_)   | | 
-- | |_| ||  __/  | |
--  \___/ |_|     |_| 
--------------------------------------------------------------------------------------
-- Para bds con Open SmartFlex se debe aplicar este permiso
GRANT ORM_USER_ROLE TO CONNECT_ROLE;
--GRANT SELECT ANY TABLE TO ORM_USER_ROLE;

-- Para otras bds se debe aplicar el permiso apropiado por cada usuario creado
-- para manejar la aplicación
--GRANT ORM_USER_ROLE TO [usuario];

--Se debe verificar el manejo de roles para los usuarios de bd
--que van a utilizar la app ORM, en algunos casos de deben ajustar los roles por defecto
--ALTER USER [usuario] DEFAULT ROLE ALL;

--O en caso de no poder asignar todos los roles para que se activen por defecto al conectarse a la bd
--ALTER USER [usuario] DEFAULT ROLE ORM_USER_ROLE, [lista de otros roles a habilitar]

