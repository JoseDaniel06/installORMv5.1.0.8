--En caso de requerirse por parte del cliente no usar ORM como esquema por defecto
--se debe ajustar este script para remplazar el usuaro ORM por el que nombre que pida el cliente
--Los demas scripts deben ser ejecutados en una sesión del usuario definido (ORM o el usuario definido por el cliente)

CREATE USER ORM
  IDENTIFIED BY optima
  DEFAULT TABLESPACE ORM_DATOS
  TEMPORARY TABLESPACE TEMP
  PROFILE DEFAULT
  ACCOUNT UNLOCK;

GRANT CONNECT TO ORM;
GRANT RESOURCE TO ORM;
ALTER USER ORM DEFAULT ROLE ALL;

GRANT CREATE SESSION TO ORM;
GRANT CREATE ANY INDEX TO ORM;
GRANT CREATE ANY TABLE TO ORM;
GRANT CREATE ANY SYNONYM TO ORM;
GRANT CREATE ANY TRIGGER TO ORM;
GRANT CREATE ANY SEQUENCE TO ORM;
GRANT CREATE ANY PROCEDURE TO ORM;
GRANT CREATE PUBLIC SYNONYM TO ORM;

-- Los tres siguientes permisos deben ser validos y acordados
-- con el cliente para cumplir sus politicas de seguridad
GRANT EXECUTE ANY PROCEDURE TO ORM;
GRANT SELECT ANY TABLE TO ORM;
GRANT ALTER USER TO ORM;

ALTER USER ORM QUOTA UNLIMITED ON ORM_DATOS;
ALTER USER ORM QUOTA UNLIMITED ON ORM_INDEX;

-- Estos permisos se requieren para que la app pueda validar
-- los datos de licenciamiento y de la cantidad de sesiones que maneja un usuario
GRANT SELECT  ON sys.v_$database TO ORM;
GRANT SELECT  ON sys.v_$session TO ORM;
