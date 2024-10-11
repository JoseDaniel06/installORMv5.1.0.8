CREATE SEQUENCE OPTSEQ_CONSULTA
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM OPTSEQ_CONSULTA FOR OPTSEQ_CONSULTA;


GRANT SELECT ON OPTSEQ_CONSULTA TO ORM_USER_ROLE;


CREATE SEQUENCE OPTSEQ_DIRECTORIO
  START WITH 100000
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM OPTSEQ_DIRECTORIO FOR OPTSEQ_DIRECTORIO;


GRANT SELECT ON OPTSEQ_DIRECTORIO TO ORM_USER_ROLE;


CREATE SEQUENCE OPTSEQ_LAYOUT
  START WITH 150000
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM OPTSEQ_LAYOUT FOR OPTSEQ_LAYOUT;


GRANT SELECT ON OPTSEQ_LAYOUT TO ORM_USER_ROLE;


CREATE SEQUENCE OPTSEQ_CONSULTA_EJEC
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM OPTSEQ_CONSULTA_EJEC FOR OPTSEQ_CONSULTA_EJEC;


GRANT SELECT ON OPTSEQ_CONSULTA_EJEC TO ORM_USER_ROLE;


CREATE SEQUENCE OPTSEQ_CONSULTA_PROG
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM OPTSEQ_CONSULTA_PROG FOR OPTSEQ_CONSULTA_PROG;

GRANT SELECT ON OPTSEQ_CONSULTA_PROG TO ORM_USER_ROLE;


CREATE SEQUENCE OPTSEQ_CONSULTA_RESTRICT
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 0
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE OR REPLACE PUBLIC SYNONYM OPTSEQ_CONSULTA_RESTRICT FOR OPTSEQ_CONSULTA_RESTRICT;


GRANT SELECT ON OPTSEQ_CONSULTA_RESTRICT TO ORM_USER_ROLE;


CREATE SEQUENCE OPTSEQ_CONEXION
  START WITH 1
  MAXVALUE 999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

CREATE OR REPLACE PUBLIC SYNONYM OPTSEQ_CONSULTA_PROG FOR OPTSEQ_CONSULTA_PROG;

GRANT SELECT ON OPTSEQ_CONEXION TO ORM_USER_ROLE;