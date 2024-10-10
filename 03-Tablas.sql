CREATE TABLE OPT_ARCHAPL
(
  NOMBREARCH  VARCHAR2(300 BYTE),
  CONTENIDO   BLOB,
  ACCION      VARCHAR2(1 BYTE),
  FECARCH     DATE,
  FECREG      DATE                              DEFAULT SYSDATE
)
LOB (CONTENIDO) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          28M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE OPT_CONEXION
(
  ID_CONEXION  NUMBER(6)                        NOT NULL,
  NOMBRE       VARCHAR2(120 BYTE)               NOT NULL,
  ACTIVA       VARCHAR2(1 BYTE)                 NOT NULL,
  PROVEEDOR    VARCHAR2(10 BYTE)                NOT NULL,
  CONEXION     VARCHAR2(2000 BYTE)              NOT NULL,
  PASSWORD     VARCHAR2(500 BYTE)               NOT NULL,
  PARAMSADIC   VARCHAR2(2500 BYTE),
  USRREG       VARCHAR2(30 BYTE)                NOT NULL,
  FECREG       DATE                             DEFAULT sysdate               NOT NULL
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          28M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE OPT_CONFIGURATION
(
  PARAMETER    VARCHAR2(100 BYTE),
  DESCRIPTION  VARCHAR2(1000 BYTE),
  VALUE        VARCHAR2(1000 BYTE)
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONFIGURATION IS 'Parametros de Configuracion';

COMMENT ON COLUMN OPT_CONFIGURATION.PARAMETER IS 'Nombre del Parametro';

COMMENT ON COLUMN OPT_CONFIGURATION.DESCRIPTION IS 'Descripcion';

COMMENT ON COLUMN OPT_CONFIGURATION.VALUE IS 'Valor';



CREATE TABLE OPT_CONSULTA_TAREASPOST
(
  ID_CONS_PROG  NUMBER(9),
  ORDEN         NUMBER(5),
  TIPO          VARCHAR2(10 BYTE),
  ACTIVO        VARCHAR2(1 BYTE)                DEFAULT 'S',
  ID_LAYOUT     NUMBER(6),
  CONTROL       VARCHAR2(5 BYTE),
  FILETYPE      VARCHAR2(20 BYTE),
  FILEPATH      VARCHAR2(4000 BYTE),
  FILENAME      VARCHAR2(4000 BYTE),
  COMPRESSFILE  VARCHAR2(1 BYTE)                DEFAULT 'N',
  DELETEFILE    VARCHAR2(1 BYTE)                DEFAULT 'N',
  MAIL_SOURCE   VARCHAR2(4000 BYTE),
  MAIL_DEST     VARCHAR2(4000 BYTE),
  MAIL_CC       VARCHAR2(4000 BYTE),
  MAIL_SUBJECT  VARCHAR2(4000 BYTE),
  MAIL_TEXT     VARCHAR2(4000 BYTE),
  ID_USUARIO    VARCHAR2(50 BYTE),
  FECHA_REG     DATE
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONSULTA_TAREASPOST IS 'Lista de Tareas a realizar con posterioridad a la ejecución de una consulta programada';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.ID_CONS_PROG IS 'Id de la Programación de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.ORDEN IS 'Orden de ejecución';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.TIPO IS 'Tipo: ARCHIVO - Generación de Archivo, CORREO: Generación de archivo y despacho de correo, ALERTA: Generación de correo con aviso de ejecución, LIMPIEZA: Borrado de la información registrada como resultado de la ejecución (borra el resultado en OPT_CONSULTA_EJEC)';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.ACTIVO IS 'Activo? (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.ID_LAYOUT IS 'Id del Layout que se va a exportar';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.CONTROL IS 'Control que se quiere exportar: Grid (Hoja de Datos), Pivot (Tabla Dinámica)';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.FILETYPE IS 'Tipo de Archivo a generar';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.FILEPATH IS 'Ruta del Archivo a generar';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.FILENAME IS 'Nombre del Archivo a generar';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.COMPRESSFILE IS 'Comprimir el archivo después de generado? (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.DELETEFILE IS 'Borrar el archivo después de enviarlo por correo? (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.MAIL_SOURCE IS 'Usuario origen del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.MAIL_DEST IS 'Destinatarios del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.MAIL_CC IS 'Destinatarios de la copia del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.MAIL_SUBJECT IS 'Asunto del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.MAIL_TEXT IS 'Mensaje del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.ID_USUARIO IS 'Id del Usuario que registra la tarea';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST.FECHA_REG IS 'Fecha de registro de la tarea';



CREATE TABLE OPT_CONSULTA_TAREASPOST_PROG
(
  ID_CONS_PROG  NUMBER(9),
  SECUENCIA     NUMBER(5),
  ORDEN         NUMBER(5),
  TIPO          VARCHAR2(10 BYTE),
  ESTADO        VARCHAR2(20 BYTE),
  MENSAJE       VARCHAR2(4000 BYTE),
  FECHA_ESTADO  DATE,
  ID_LAYOUT     NUMBER(6),
  CONTROL       VARCHAR2(5 BYTE),
  FILETYPE      VARCHAR2(20 BYTE),
  FILEPATH      VARCHAR2(4000 BYTE),
  FILENAME      VARCHAR2(4000 BYTE),
  COMPRESSFILE  VARCHAR2(1 BYTE)                DEFAULT 'N',
  DELETEFILE    VARCHAR2(1 BYTE)                DEFAULT 'N',
  MAIL_SOURCE   VARCHAR2(4000 BYTE),
  MAIL_DEST     VARCHAR2(4000 BYTE),
  MAIL_CC       VARCHAR2(4000 BYTE),
  MAIL_SUBJECT  VARCHAR2(4000 BYTE),
  MAIL_TEXT     VARCHAR2(4000 BYTE),
  ID_USUARIO    VARCHAR2(50 BYTE)
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONSULTA_TAREASPOST_PROG IS 'Lista de Tareas a realizar por cada ejecución de una consulta programada';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.ID_CONS_PROG IS 'Id de la Programación de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.SECUENCIA IS 'Orden secuencial de la ejecución por cada consulta programada';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.ORDEN IS 'Orden de ejecución';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.TIPO IS 'Tipo: ARCHIVO - Generación de Archivo, CORREO: Generación de archivo y despacho de correo, ALERTA: Generación de correo con aviso de ejecución, LIMPIEZA: Borrado de la información registrada como resultado de la ejecución (borra el resultado en OPT_CONSULTA_EJEC)';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.ESTADO IS 'Estado de ejecución de la tarea';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.MENSAJE IS 'Mensaje de ejecución de la tarea';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.FECHA_ESTADO IS 'Fecha del Estado de ejecución de la tarea';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.ID_LAYOUT IS 'Id del Reporte que se va a exportar';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.CONTROL IS 'Control que se quiere exportar: Grid (Hoja de Datos), Pivot (Tabla Dinámica)';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.FILETYPE IS 'Tipo de Archivo a generar';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.FILEPATH IS 'Ruta del Archivo a generar';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.FILENAME IS 'Nombre del Archivo a generar';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.COMPRESSFILE IS 'Comprimir el archivo despues de generado? (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.DELETEFILE IS 'Borrar el archivo despues de enviarlo por correo? (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.MAIL_SOURCE IS 'Usuario origen del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.MAIL_DEST IS 'Destinatarios del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.MAIL_CC IS 'Destinatarios de la copia del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.MAIL_SUBJECT IS 'Asunto del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.MAIL_TEXT IS 'Mensaje del correo';

COMMENT ON COLUMN OPT_CONSULTA_TAREASPOST_PROG.ID_USUARIO IS 'Id del Usuario que registra la tarea';



CREATE TABLE OPT_DIRECTORIO
(
  ID_DIRECTORIO  NUMBER(9),
  NOMBRE         VARCHAR2(500 BYTE),
  ID_DIR_PADRE   NUMBER(9)
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_DIRECTORIO IS 'Estructura de Directorios donde se registran las consultas';

COMMENT ON COLUMN OPT_DIRECTORIO.ID_DIRECTORIO IS 'Id del Directorio';

COMMENT ON COLUMN OPT_DIRECTORIO.NOMBRE IS 'Nombre del Directorio';

COMMENT ON COLUMN OPT_DIRECTORIO.ID_DIR_PADRE IS 'Id del Directorio superior';



CREATE TABLE OPT_ORMLIC
(
  ID            NUMBER(9),
  LIC           CLOB,
  COMPANY_LOGO  BLOB
)
LOB (LIC) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
LOB (COMPANY_LOGO) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE OPT_PLAN_TABLE
(
  STATEMENT_ID       VARCHAR2(30 BYTE),
  PLAN_ID            NUMBER,
  TIMESTAMP          DATE,
  REMARKS            VARCHAR2(4000 BYTE),
  OPERATION          VARCHAR2(30 BYTE),
  OPTIONS            VARCHAR2(255 BYTE),
  OBJECT_NODE        VARCHAR2(128 BYTE),
  OBJECT_OWNER       VARCHAR2(30 BYTE),
  OBJECT_NAME        VARCHAR2(30 BYTE),
  OBJECT_ALIAS       VARCHAR2(65 BYTE),
  OBJECT_INSTANCE    INTEGER,
  OBJECT_TYPE        VARCHAR2(30 BYTE),
  OPTIMIZER          VARCHAR2(255 BYTE),
  SEARCH_COLUMNS     NUMBER,
  ID                 INTEGER,
  PARENT_ID          INTEGER,
  DEPTH              INTEGER,
  POSITION           INTEGER,
  COST               INTEGER,
  CARDINALITY        INTEGER,
  BYTES              INTEGER,
  OTHER_TAG          VARCHAR2(255 BYTE),
  PARTITION_START    VARCHAR2(255 BYTE),
  PARTITION_STOP     VARCHAR2(255 BYTE),
  PARTITION_ID       INTEGER,
  OTHER              LONG,
  DISTRIBUTION       VARCHAR2(30 BYTE),
  CPU_COST           INTEGER,
  IO_COST            INTEGER,
  TEMP_SPACE         INTEGER,
  ACCESS_PREDICATES  VARCHAR2(4000 BYTE),
  FILTER_PREDICATES  VARCHAR2(4000 BYTE),
  PROJECTION         VARCHAR2(4000 BYTE),
  TIME               INTEGER,
  QBLOCK_NAME        VARCHAR2(30 BYTE)
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;


CREATE TABLE OPT_ROLE
(
  ID_ROLE      VARCHAR2(50 BYTE)                NOT NULL,
  DESCRIPCION  VARCHAR2(500 BYTE)
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_ROLE IS 'Roles';

COMMENT ON COLUMN OPT_ROLE.ID_ROLE IS 'Id del Role';

COMMENT ON COLUMN OPT_ROLE.DESCRIPCION IS 'Descripcion del Role';



CREATE TABLE OPT_USUARIO
(
  ID_USUARIO         VARCHAR2(1000 BYTE)        NOT NULL,
  NOMBRE             VARCHAR2(100 BYTE),
  TIPO               NUMBER(1),
  MRU_CONSULTAS      VARCHAR2(4000 BYTE),
  ADMIN_PERMISOS     VARCHAR2(1 BYTE)           DEFAULT 'N'                   NOT NULL,
  GUARDA_RESULTADOS  VARCHAR2(1 BYTE)           DEFAULT 'N'                   NOT NULL,
  PROGRAMA_REPORTES  VARCHAR2(1 BYTE)           DEFAULT 'N'                   NOT NULL,
  ESTADO             VARCHAR2(15 BYTE)          DEFAULT 'ACTIVO',
  FECHA_ESTADO       DATE                       DEFAULT SYSDATE,
  CONS_SIMULTANEAS   NUMBER(3)                  DEFAULT 0,
  PASSWORD           VARCHAR2(100 BYTE),
  FAVORITASWEB       VARCHAR2(2500 BYTE)
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_USUARIO IS 'Usuarios';

COMMENT ON COLUMN OPT_USUARIO.ID_USUARIO IS 'ID del Usuario';

COMMENT ON COLUMN OPT_USUARIO.NOMBRE IS 'Nombre del Usuario';

COMMENT ON COLUMN OPT_USUARIO.TIPO IS 'Tipo de Usuario (0-Generico, 1-Administrador, 2-Analista, 3-Usuario, 4-Consultor)';

COMMENT ON COLUMN OPT_USUARIO.MRU_CONSULTAS IS 'Listado de consultas mas recientes usadas por el usuario';

COMMENT ON COLUMN OPT_USUARIO.ADMIN_PERMISOS IS 'El usuario puede administrar permisos';

COMMENT ON COLUMN OPT_USUARIO.GUARDA_RESULTADOS IS 'El usuario puede guardar resultados en la base de datos';

COMMENT ON COLUMN OPT_USUARIO.PROGRAMA_REPORTES IS 'El usuario puede programar la ejecucion de reportes';

COMMENT ON COLUMN OPT_USUARIO.ESTADO IS 'Estado del usuario (ACTIVO, INACTIVO, RETIRADO)';

COMMENT ON COLUMN OPT_USUARIO.FECHA_ESTADO IS 'Fecha del estado';

COMMENT ON COLUMN OPT_USUARIO.CONS_SIMULTANEAS IS 'Numero maximo de consultas que el usuario puede ejecutar en forma simultanea';

COMMENT ON COLUMN OPT_USUARIO.PASSWORD IS 'Clave del usuario';

COMMENT ON COLUMN OPT_USUARIO.FAVORITASWEB IS 'Listado de documentos favoritos para la versión web';



CREATE UNIQUE INDEX IDX_OPT_ARCHAPL_01 ON OPT_ARCHAPL
(NOMBREARCH)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX IDX_OPT_CONEXION_01 ON OPT_CONEXION
(ID_CONEXION)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          2M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_CONS_TAREAPOST_PROG_01 ON OPT_CONSULTA_TAREASPOST_PROG
(ID_USUARIO, ESTADO)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_CONS_TAREASPOST_001 ON OPT_CONSULTA_TAREASPOST
(ID_USUARIO, ACTIVO)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_DIRECTORIO_001 ON OPT_DIRECTORIO
(ID_DIR_PADRE, ID_DIRECTORIO)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_PLAN_TABLE_01 ON OPT_PLAN_TABLE
(STATEMENT_ID)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONFIGURATION_PK ON OPT_CONFIGURATION
(PARAMETER)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONSULTA_TAREASPOST_PK ON OPT_CONSULTA_TAREASPOST
(ID_CONS_PROG, ORDEN)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONS_TAREASPOST_PROG_PK ON OPT_CONSULTA_TAREASPOST_PROG
(ID_CONS_PROG, SECUENCIA, ORDEN)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_DIRECTORIO_PK ON OPT_DIRECTORIO
(ID_DIRECTORIO)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_ORMLIC_PK ON OPT_ORMLIC
(ID)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_ROLES_PK ON OPT_ROLE
(ID_ROLE)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_USUARIOS_PK ON OPT_USUARIO
(ID_USUARIO)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE OR REPLACE PUBLIC SYNONYM OPT_ARCHAPL FOR OPT_ARCHAPL;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONEXION FOR OPT_CONEXION;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONFIGURATION FOR OPT_CONFIGURATION;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONSULTA_TAREASPOST FOR OPT_CONSULTA_TAREASPOST;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONSULTA_TAREASPOST_PROG FOR OPT_CONSULTA_TAREASPOST_PROG;
CREATE OR REPLACE PUBLIC SYNONYM OPT_DIRECTORIO FOR OPT_DIRECTORIO;
CREATE OR REPLACE PUBLIC SYNONYM OPT_ORMLIC FOR OPT_ORMLIC;
CREATE OR REPLACE PUBLIC SYNONYM OPT_PLAN_TABLE FOR OPT_PLAN_TABLE;
CREATE OR REPLACE PUBLIC SYNONYM OPT_ROLE FOR OPT_ROLE;
CREATE OR REPLACE PUBLIC SYNONYM OPT_USUARIO FOR OPT_USUARIO;


CREATE TABLE OPT_CONSULTA
(
  ID_CONSULTA          NUMBER(9),
  NOMBRE               VARCHAR2(500 BYTE),
  CONSULTA             CLOB,
  DESCRIPCION          VARCHAR2(2000 BYTE),
  FECHA_REG            DATE,
  ID_USUARIO           VARCHAR2(50 BYTE),
  ID_DIRECTORIO        NUMBER(9),
  ID_USUARIO_MOD       VARCHAR2(50 BYTE),
  FECHA_MOD            DATE,
  PUBLICA              VARCHAR2(1 BYTE)         DEFAULT 'N',
  ESQUEMA              CLOB,
  MAX_SEGS_DIF         NUMBER(6)                DEFAULT 0,
  PRODUCCION           VARCHAR2(1 BYTE)         DEFAULT 'N',
  EJEC_CONCURRENTES    NUMBER(4)                DEFAULT 0,
  GUARDADO_AUTOMATICO  VARCHAR2(1 BYTE)         DEFAULT 'N'                   NOT NULL,
  FILETYPE_GUARDADO    VARCHAR2(20 BYTE),
  FILEPATH_GUARDADO    VARCHAR2(4000 BYTE),
  FILENAME_GUARDADO    VARCHAR2(4000 BYTE),
  TIPODOC              VARCHAR2(1 BYTE)         DEFAULT 'Q'                   NOT NULL,
  CNXID                INTEGER,
  HABILWEB             VARCHAR2(1 BYTE)         DEFAULT 'N'                   NOT NULL
)
LOB (CONSULTA) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          96K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          2M
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
LOB (ESQUEMA) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONSULTA IS 'Consultas';

COMMENT ON COLUMN OPT_CONSULTA.ID_CONSULTA IS 'Identificador de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA.NOMBRE IS 'Nombre de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA.CONSULTA IS 'Script de la consulta';

COMMENT ON COLUMN OPT_CONSULTA.DESCRIPCION IS 'Comentarios';

COMMENT ON COLUMN OPT_CONSULTA.FECHA_REG IS 'Fecha de Registro';

COMMENT ON COLUMN OPT_CONSULTA.ID_USUARIO IS 'Id del Usuario Autor de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA.ID_DIRECTORIO IS 'Id del Directorio';

COMMENT ON COLUMN OPT_CONSULTA.ID_USUARIO_MOD IS 'Id del Usuario que modifico la Consulta';

COMMENT ON COLUMN OPT_CONSULTA.FECHA_MOD IS 'Fecha de Modificacion de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA.PUBLICA IS 'Consulta publica (S/N)';

COMMENT ON COLUMN OPT_CONSULTA.ESQUEMA IS 'Esquema XML de la consulta';

COMMENT ON COLUMN OPT_CONSULTA.MAX_SEGS_DIF IS 'Maxima diferencia en segundos valida (con respecto a la bd Alterna) antes de consultar en BD de Produccion';

COMMENT ON COLUMN OPT_CONSULTA.PRODUCCION IS 'Ejecutar Consulta directamente en produccion (S/N)';

COMMENT ON COLUMN OPT_CONSULTA.EJEC_CONCURRENTES IS 'Define el número máximo de ejecuciones concurrentes que un usuario puede lanzar la consulta (0 - sin límite)';

COMMENT ON COLUMN OPT_CONSULTA.GUARDADO_AUTOMATICO IS 'Define si el resultado de la consulta se guarda una vez se haya ejecutado';

COMMENT ON COLUMN OPT_CONSULTA.FILETYPE_GUARDADO IS 'Tipo de Archivo a generar';

COMMENT ON COLUMN OPT_CONSULTA.FILEPATH_GUARDADO IS 'Ruta del Archivo a generar';

COMMENT ON COLUMN OPT_CONSULTA.FILENAME_GUARDADO IS 'Nombre del Archivo a generar';

COMMENT ON COLUMN OPT_CONSULTA.TIPODOC IS 'Tipo de Documento: Q - Consulta, D - Dashboard, R - Reporte';

COMMENT ON COLUMN OPT_CONSULTA.CNXID IS 'Id de la conexión para el documento de tipo Consulta';

COMMENT ON COLUMN OPT_CONSULTA.HABILWEB IS 'Consulta habilitada web: S - Si, N - No';



CREATE TABLE OPT_CONSULTAS_ROLE
(
  ID_ROLE      VARCHAR2(50 BYTE),
  ID_CONSULTA  NUMBER(9)
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONSULTAS_ROLE IS 'Consultas asignadas a los roles';

COMMENT ON COLUMN OPT_CONSULTAS_ROLE.ID_ROLE IS 'Id del Role';

COMMENT ON COLUMN OPT_CONSULTAS_ROLE.ID_CONSULTA IS 'Id de la Consulta';



CREATE TABLE OPT_CONSULTA_EJECS
(
  ID_CONS_EJEC  NUMBER(9),
  ID_CONSULTA   NUMBER(9),
  TIPO          VARCHAR2(10 BYTE),
  RESULTADO     CLOB,
  ESQUEMA       CLOB,
  REGISTROS     NUMBER(9),
  PARAMETROS    VARCHAR2(4000 BYTE),
  ERROR_MSG     VARCHAR2(2000 BYTE),
  ID_USUARIO    VARCHAR2(50 BYTE),
  ID_JOB        NUMBER(12),
  FECHA_EJEC    DATE
)
LOB (RESULTADO) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          96K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          2M
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
LOB (ESQUEMA) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONSULTA_EJECS IS 'Resultados almacenados de Ejecuciones de Consultas';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.ID_CONS_EJEC IS 'Id de Ejecucion de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.ID_CONSULTA IS 'Id de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.TIPO IS 'Tipo de ejecucion de la consulta (USUARIO - Ejecucion manual o JOB - Ejecucion programada)';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.RESULTADO IS 'Informacion devuelta por la consulta';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.ESQUEMA IS 'Esquema del resultado';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.REGISTROS IS 'Numero de registros devueltos en esta ejecucion';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.PARAMETROS IS 'Parametros y Valores usados para esta ejecucion';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.ERROR_MSG IS 'Mensaje de Error';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.ID_USUARIO IS 'Id del usuario que ejecuto la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.ID_JOB IS 'Id del Job que ejecuto la consulta programada';

COMMENT ON COLUMN OPT_CONSULTA_EJECS.FECHA_EJEC IS 'Fecha de ejecucion de la Consulta';



CREATE TABLE OPT_CONSULTA_PROGS
(
  ID_CONS_PROG     NUMBER(9),
  ID_CONSULTA      NUMBER(9),
  FECHA_PROG       DATE,
  FECHA_INICIO     DATE,
  FECHA_FIN        DATE,
  INTERVALO        VARCHAR2(500 BYTE),
  ID_JOB           NUMBER(12),
  PARAMETROS       VARCHAR2(4000 BYTE),
  ESTADO           VARCHAR2(20 BYTE),
  NUM_EJECUCIONES  NUMBER(10)                   DEFAULT 0,
  ERROR_MSG        VARCHAR2(2000 BYTE),
  ID_USUARIO       VARCHAR2(50 BYTE),
  FECHA_REG        DATE
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONSULTA_PROGS IS 'Programacion de Ejecucion de Consultas';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.ID_CONS_PROG IS 'Id de la Programacion de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.ID_CONSULTA IS 'Id de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.FECHA_PROG IS 'Fecha programada para la primera ejecucion';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.FECHA_INICIO IS 'Fecha de inicio de la ultima ejecucion de esta programacion';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.FECHA_FIN IS 'Fecha de finalizacion de la ultima ejecucion de esta programacion';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.INTERVALO IS 'Intervalo para las posteriores ejecuciones';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.ID_JOB IS 'Id del JOB que ejecutara la consulta';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.PARAMETROS IS 'Parametros';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.ESTADO IS 'Estado de la programacion de ejecucion';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.NUM_EJECUCIONES IS 'Numero de veces que se ha ejecutado esta programacion';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.ERROR_MSG IS 'Mensaje de Error';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.ID_USUARIO IS 'Id del usuario que programó la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_PROGS.FECHA_REG IS 'Fecha en que se registra la programacion de la Consulta';



CREATE TABLE OPT_CONSULTA_PROGS_DET
(
  ID_CONS_PROG  NUMBER(9),
  SECUENCIA     NUMBER(9),
  ID_CONSULTA   NUMBER(9),
  ID_CONS_EJEC  NUMBER(9),
  FECHA_INICIO  DATE,
  FECHA_FIN     DATE,
  ESTADO        VARCHAR2(20 BYTE),
  ERROR_MSG     VARCHAR2(2000 BYTE),
  ID_USUARIO    VARCHAR2(50 BYTE),
  FECHA_REG     DATE
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONSULTA_PROGS_DET IS 'Detalle de Ejecucion de Consultas Programadas';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.ID_CONS_PROG IS 'Id de la Programacion de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.SECUENCIA IS 'Orden secuencial de la ejecución por cada consulta programada';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.ID_CONSULTA IS 'Id de la Consulta Programada';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.ID_CONS_EJEC IS 'Id de Ejecucion de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.FECHA_INICIO IS 'Fecha de inicio de la ejecución';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.FECHA_FIN IS 'Fecha de finalización de la ejecución';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.ESTADO IS 'Estado de la ejecución';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.ERROR_MSG IS 'Mensaje de Error';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.ID_USUARIO IS 'Id del usuario que programó la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_DET.FECHA_REG IS 'Fecha en que se registra el detalle de la ejecución de la Consulta';



CREATE TABLE OPT_CONSULTA_PROGS_PARAMS
(
  ID_CONS_PROG  NUMBER(9),
  ID_CONSULTA   NUMBER(9),
  SECUENCIA     NUMBER(9),
  POSICION      NUMBER(5),
  NOMBRE        VARCHAR2(500 BYTE),
  VALOR         VARCHAR2(500 BYTE)
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONSULTA_PROGS_PARAMS IS 'Parametros para Ejecucion de Consultas Programadas';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_PARAMS.ID_CONS_PROG IS 'Id de la Programacion de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_PARAMS.ID_CONSULTA IS 'Id de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_PARAMS.SECUENCIA IS 'Orden de aplicacion de multiples registros 

de parametros';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_PARAMS.POSICION IS 'Orden del parametro dentro de la 

secuencia';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_PARAMS.NOMBRE IS 'Nombre del Parametro';

COMMENT ON COLUMN OPT_CONSULTA_PROGS_PARAMS.VALOR IS 'Valor del Parametro';



CREATE TABLE OPT_CONSULTA_RESTRICT
(
  ID_CONS_RESTRICT  NUMBER(9),
  ID_CONSULTA       NUMBER(9),
  HORA_INIC         NUMBER(2),
  MINUTO_INIC       NUMBER(2),
  HORA_FIN          NUMBER(2),
  MINUTO_FIN        NUMBER(2),
  ACTIVO            VARCHAR2(1 BYTE),
  ID_USUARIO        VARCHAR2(50 BYTE)           DEFAULT USER,
  FECHA_REG         DATE                        DEFAULT SYSDATE,
  FECHA_INIC        DATE,
  FECHA_FIN         DATE,
  EXPRESION         VARCHAR2(4000 BYTE),
  LUNES             VARCHAR2(1 BYTE)            DEFAULT 'N',
  MARTES            VARCHAR2(1 BYTE)            DEFAULT 'N',
  MIERCOLES         VARCHAR2(1 BYTE)            DEFAULT 'N',
  JUEVES            VARCHAR2(1 BYTE)            DEFAULT 'N',
  VIERNES           VARCHAR2(1 BYTE)            DEFAULT 'N',
  SABADO            VARCHAR2(1 BYTE)            DEFAULT 'N',
  DOMINGO           VARCHAR2(1 BYTE)            DEFAULT 'N'
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_CONSULTA_RESTRICT IS 'Restricciones de Horario a la consulta';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.ID_CONS_RESTRICT IS 'Id de Restricción de Horario';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.ID_CONSULTA IS 'Id de la Consulta';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.HORA_INIC IS 'Hora inicial de la restricción';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.MINUTO_INIC IS 'Minuto inicial de la restricción';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.HORA_FIN IS 'Hora final de la restricción';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.MINUTO_FIN IS 'Minuto final de la restricción';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.ACTIVO IS 'Restricción activa? (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.ID_USUARIO IS 'Id del usuario que registró la restricción';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.FECHA_REG IS 'Fecha de registro de la restricción';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.FECHA_INIC IS 'Fecha inicial de la restricción';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.FECHA_FIN IS 'Fecha final de la restricción';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.EXPRESION IS 'Expresión para determinar la restricción';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.LUNES IS 'Restricción aplica el día lunes (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.MARTES IS 'Restricción aplica el día martes  (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.MIERCOLES IS 'Restricción aplica el día miercoles (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.JUEVES IS 'Restricción aplica el día jueves (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.VIERNES IS 'Restricción aplica el día viernes (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.SABADO IS 'Restricción aplica el día sabado (S/N)';

COMMENT ON COLUMN OPT_CONSULTA_RESTRICT.DOMINGO IS 'Restricción aplica el día domingo(S/N)';



CREATE TABLE OPT_HISTORIAL
(
  ID_CONSULTA  NUMBER(9),
  ESTADO       VARCHAR2(20 BYTE),
  INICIO       DATE,
  FINAL        DATE,
  TIEMPO_SEL   NUMBER(15,2),
  TIEMPO_PROC  NUMBER(15,2),
  REGISTROS    NUMBER(15),
  USUARIO      VARCHAR2(100 BYTE),
  TERMINAL     VARCHAR2(100 BYTE),
  PARAMETROS   VARCHAR2(4000 BYTE)
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_HISTORIAL IS 'Historial de Ejecuciones de la consulta';

COMMENT ON COLUMN OPT_HISTORIAL.ID_CONSULTA IS 'Id de la Consulta';

COMMENT ON COLUMN OPT_HISTORIAL.ESTADO IS 'Estado de la ejecucion (TERMINADA, CANCELADA)';

COMMENT ON COLUMN OPT_HISTORIAL.INICIO IS 'Fecha y hora del inicio de la ejecucion';

COMMENT ON COLUMN OPT_HISTORIAL.FINAL IS 'Fecha y hora del final de la ejecucion';

COMMENT ON COLUMN OPT_HISTORIAL.TIEMPO_SEL IS 'Tiempo tomado para que la bd devuelva todos los registros de la consulta';

COMMENT ON COLUMN OPT_HISTORIAL.TIEMPO_PROC IS 'Tiempo tomado por la herrameinta para procesar los datos';

COMMENT ON COLUMN OPT_HISTORIAL.REGISTROS IS 'Numero de registros devueltos por la consulta';

COMMENT ON COLUMN OPT_HISTORIAL.USUARIO IS 'Usuario que ejecuto la consulta';

COMMENT ON COLUMN OPT_HISTORIAL.TERMINAL IS 'Equipo desde el que se ejecuta la consulta';

COMMENT ON COLUMN OPT_HISTORIAL.PARAMETROS IS 'Parametros con los que se ejecuto la consulta (incluye la version de la aplicacion y la bd sobre la que se ejecuto la consulta en caso de estar activo el manejo de bd alterna)';



CREATE TABLE OPT_HIST_CONSULTA
(
  ID_CONSULTA     NUMBER(9),
  CONSULTA        CLOB,
  ID_USUARIO_MOD  VARCHAR2(50 BYTE),
  FECHA_MOD       DATE
)
LOB (CONSULTA) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          96K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          2M
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_HIST_CONSULTA IS 'Historico de Modificaciones al script de la consulta';

COMMENT ON COLUMN OPT_HIST_CONSULTA.ID_CONSULTA IS 'Id de la Consulta';

COMMENT ON COLUMN OPT_HIST_CONSULTA.CONSULTA IS 'Script anterior de la Consulta';

COMMENT ON COLUMN OPT_HIST_CONSULTA.ID_USUARIO_MOD IS 'Id del Usuario que realizo la modificacion';

COMMENT ON COLUMN OPT_HIST_CONSULTA.FECHA_MOD IS 'Fecha de la modificacion';



CREATE TABLE OPT_LAYOUT
(
  ID_CONSULTA     NUMBER(9),
  ID_LAYOUT       NUMBER(6),
  NOMBRE          VARCHAR2(500 BYTE),
  DESCRIPCION     VARCHAR2(2000 BYTE),
  FECHA_REG       DATE,
  ID_USUARIO      VARCHAR2(50 BYTE),
  LAYOUT          CLOB,
  ID_USUARIO_MOD  VARCHAR2(50 BYTE),
  FECHA_MOD       DATE,
  NUMERA_LIN      VARCHAR2(1 BYTE)              DEFAULT 'N',
  LAYOUTWEB       CLOB
)
LOB (LAYOUT) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          96K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          2M
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
LOB (LAYOUTWEB) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_LAYOUT IS 'Reportes';

COMMENT ON COLUMN OPT_LAYOUT.ID_CONSULTA IS 'Id de la Consulta';

COMMENT ON COLUMN OPT_LAYOUT.ID_LAYOUT IS 'Id del Reporte';

COMMENT ON COLUMN OPT_LAYOUT.NOMBRE IS 'Nombre del Reporte';

COMMENT ON COLUMN OPT_LAYOUT.DESCRIPCION IS 'Descripcion del Reporte';

COMMENT ON COLUMN OPT_LAYOUT.FECHA_REG IS 'Fecha de Registro del Reporte';

COMMENT ON COLUMN OPT_LAYOUT.ID_USUARIO IS 'Id del Usuario Autor del Reporte';

COMMENT ON COLUMN OPT_LAYOUT.LAYOUT IS 'Layout del Reporte';

COMMENT ON COLUMN OPT_LAYOUT.ID_USUARIO_MOD IS 'Id del Usuario que modifico el Reporte';

COMMENT ON COLUMN OPT_LAYOUT.FECHA_MOD IS 'Fecha de modificacion del Reporte';

COMMENT ON COLUMN OPT_LAYOUT.NUMERA_LIN IS 'Aplicar numeracion del lineas en el Reporte (S/N)';

COMMENT ON COLUMN OPT_LAYOUT.LAYOUTWEB IS 'Diseño de la visualización de la consulta para despliegue en versión web';



CREATE TABLE OPT_PAGESETTINGS
(
  ID_CONSULTA  NUMBER(9),
  ID_LAYOUT    NUMBER(6),
  LEFT         NUMBER,
  RIGHT        NUMBER,
  TOP          NUMBER,
  BOTTOM       NUMBER,
  LANDSCAPE    VARCHAR2(1 BYTE),
  PAPERKIND    VARCHAR2(200 BYTE),
  PAPERNAME    VARCHAR2(200 BYTE),
  HLEFTCOL     VARCHAR2(500 BYTE),
  HMIDDLECOL   VARCHAR2(500 BYTE),
  HRIGHTCOL    VARCHAR2(500 BYTE),
  HFONT        VARCHAR2(200 BYTE),
  HLINEALIGN   NUMBER(1),
  FLEFTCOL     VARCHAR2(500 BYTE),
  FMIDDLECOL   VARCHAR2(500 BYTE),
  FRIGHTCOL    VARCHAR2(500 BYTE),
  FFONT        VARCHAR2(200 BYTE),
  FLINEALIGN   NUMBER(1),
  FITPAGES     NUMBER(5)                        DEFAULT 0,
  ESCALA       NUMBER(14,8)                     DEFAULT 1
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_PAGESETTINGS IS 'Configuracion de impresion del Reporte';

COMMENT ON COLUMN OPT_PAGESETTINGS.ID_CONSULTA IS 'Id de la Consulta';

COMMENT ON COLUMN OPT_PAGESETTINGS.ID_LAYOUT IS 'Id del Reporte';

COMMENT ON COLUMN OPT_PAGESETTINGS.LEFT IS 'Margen izquierda';

COMMENT ON COLUMN OPT_PAGESETTINGS.RIGHT IS 'Margen derecha';

COMMENT ON COLUMN OPT_PAGESETTINGS.TOP IS 'Margen superior';

COMMENT ON COLUMN OPT_PAGESETTINGS.BOTTOM IS 'Margen inferior';

COMMENT ON COLUMN OPT_PAGESETTINGS.LANDSCAPE IS 'Horizontal (S/N)';

COMMENT ON COLUMN OPT_PAGESETTINGS.PAPERKIND IS 'Tipo del papel';

COMMENT ON COLUMN OPT_PAGESETTINGS.PAPERNAME IS 'Tama?o del papel';

COMMENT ON COLUMN OPT_PAGESETTINGS.HLEFTCOL IS 'Columna izquierda del encabezado';

COMMENT ON COLUMN OPT_PAGESETTINGS.HMIDDLECOL IS 'Columna central del encabezado';

COMMENT ON COLUMN OPT_PAGESETTINGS.HRIGHTCOL IS 'Columna derecha del encabezado';

COMMENT ON COLUMN OPT_PAGESETTINGS.HFONT IS 'Tipo de letra del encabezado';

COMMENT ON COLUMN OPT_PAGESETTINGS.HLINEALIGN IS 'Posicion de la linea en el encabezado';

COMMENT ON COLUMN OPT_PAGESETTINGS.FLEFTCOL IS 'Columna izquierda del pie de pagina';

COMMENT ON COLUMN OPT_PAGESETTINGS.FMIDDLECOL IS 'Columna central del pie de pagina';

COMMENT ON COLUMN OPT_PAGESETTINGS.FRIGHTCOL IS 'Columna derecha pie de pagina';

COMMENT ON COLUMN OPT_PAGESETTINGS.FFONT IS 'Tipo de letra del pie de pagina';

COMMENT ON COLUMN OPT_PAGESETTINGS.FLINEALIGN IS 'Posicion de la linea en el pie de pagina';

COMMENT ON COLUMN OPT_PAGESETTINGS.FITPAGES IS 'Ajuste de paginas';

COMMENT ON COLUMN OPT_PAGESETTINGS.ESCALA IS 'Escala';



CREATE TABLE OPT_PARAMETROS
(
  ID_CONSULTA     NUMBER(9),
  POSICION        NUMBER(5),
  NOMBRE          VARCHAR2(500 BYTE),
  TIPO            VARCHAR2(500 BYTE),
  VALOR           CLOB,
  DESCRIPCION     VARCHAR2(500 BYTE),
  TITULO          VARCHAR2(500 BYTE),
  MENSERROR       VARCHAR2(500 BYTE),
  TIPOMASCARA     VARCHAR2(20 BYTE),
  MASCARA         VARCHAR2(4000 BYTE),
  MARCADORPOS     VARCHAR2(1 BYTE),
  MASCOPCIONES    VARCHAR2(10 BYTE)             DEFAULT 'NSSSN',
  QUERYLISTA      NUMBER(9),
  ITEMSLISTA      CLOB,
  VARSUSTITUCION  VARCHAR2(1 BYTE)              DEFAULT 'N',
  OBLIGATORIO     VARCHAR2(1 BYTE)              DEFAULT 'S'
)
LOB (VALOR) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
LOB (ITEMSLISTA) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_PARAMETROS IS 'Parametros de ejecucion de la consulta';

COMMENT ON COLUMN OPT_PARAMETROS.ID_CONSULTA IS 'Identificador de la Consulta';

COMMENT ON COLUMN OPT_PARAMETROS.POSICION IS 'Posición del Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.NOMBRE IS 'Nombre del Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.TIPO IS 'Tipo del Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.VALOR IS 'Valor del Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.DESCRIPCION IS 'Descripción del Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.TITULO IS 'Titulo del Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.MENSERROR IS 'Mensaje de error a mostrar cuado no se cumplan las condiciones del Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.TIPOMASCARA IS 'Tipo de Máscara que se usa para validar el Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.MASCARA IS 'Máscara que se usa para validar el Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.MARCADORPOS IS 'Caracter a utilizar como marcador de posición al editar el Parámetro';

COMMENT ON COLUMN OPT_PARAMETROS.MASCOPCIONES IS 'Opciones de la máscara de edición:  (BeepOnError, IgnoreMaskBlank, SaveLiteral, ShowPlaceHolders, UseMaskAsDisplayFormat)';

COMMENT ON COLUMN OPT_PARAMETROS.QUERYLISTA IS 'Id de la consulta que genera los datos de la lista';

COMMENT ON COLUMN OPT_PARAMETROS.ITEMSLISTA IS 'Items de la lista (cuando es manual)';

COMMENT ON COLUMN OPT_PARAMETROS.VARSUSTITUCION IS 'Manejar el Parámetro como variable de sustitución (S/N)';

COMMENT ON COLUMN OPT_PARAMETROS.OBLIGATORIO IS 'Determina si el parámetro es obligatorio o no (en este último caso puede recibir nulo como valor)';



CREATE TABLE OPT_PIVOT
(
  ID_CONSULTA  NUMBER(9),
  ID_LAYOUT    NUMBER(6),
  PIVOT        CLOB,
  VIEW_CHART   VARCHAR2(1 BYTE)                 DEFAULT 'N',
  CHART        CLOB
)
LOB (PIVOT) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          96K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          2M
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
LOB (CHART) STORE AS (
  TABLESPACE ORM_DATOS
  ENABLE       STORAGE IN ROW
  CHUNK       8192
  RETENTION
  NOCACHE
  LOGGING
  INDEX       (
        TABLESPACE ORM_DATOS
        STORAGE    (
                    INITIAL          64K
                    NEXT             1M
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   ))
      STORAGE    (
                  INITIAL          64K
                  NEXT             1M
                  MINEXTENTS       1
                  MAXEXTENTS       UNLIMITED
                  PCTINCREASE      0
                  BUFFER_POOL      DEFAULT
                 ))
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_PIVOT IS 'Tablas Dinamicas';

COMMENT ON COLUMN OPT_PIVOT.ID_CONSULTA IS 'Id de la Consulta';

COMMENT ON COLUMN OPT_PIVOT.ID_LAYOUT IS 'Id del Reporte';

COMMENT ON COLUMN OPT_PIVOT.PIVOT IS 'Layout de la Tabla Dinamica';

COMMENT ON COLUMN OPT_PIVOT.VIEW_CHART IS 'Visualizar un grafico a partir de los datos de la tabla dinamica';

COMMENT ON COLUMN OPT_PIVOT.CHART IS 'Layout del Grafico';



CREATE TABLE OPT_ROLES_USUARIO
(
  ID_USUARIO  VARCHAR2(50 BYTE)                 NOT NULL,
  ID_ROLE     VARCHAR2(50 BYTE)                 NOT NULL
)
TABLESPACE ORM_DATOS
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;

COMMENT ON TABLE OPT_ROLES_USUARIO IS 'Roles asignados a los usuarios';

COMMENT ON COLUMN OPT_ROLES_USUARIO.ID_USUARIO IS 'Id del Usuario';

COMMENT ON COLUMN OPT_ROLES_USUARIO.ID_ROLE IS 'Id del Role';



CREATE INDEX IDX_OPT_CONSULTAS_ROLE_001 ON OPT_CONSULTAS_ROLE
(ID_CONSULTA)
NOLOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_CONSULTA_001 ON OPT_CONSULTA
(ID_DIRECTORIO)
NOLOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_CONSULTA_EJECS_001 ON OPT_CONSULTA_EJECS
(ID_CONSULTA)
NOLOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_CONSULTA_PROGS_001 ON OPT_CONSULTA_PROGS
(ID_CONSULTA)
NOLOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_CONSULTA_PROGS_002 ON OPT_CONSULTA_PROGS
(ID_USUARIO)
NOLOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_CONSULTA_PROGS_DET_001 ON OPT_CONSULTA_PROGS_DET
(ID_CONSULTA)
NOLOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_CONSULTA_RESTRICT_001 ON OPT_CONSULTA_RESTRICT
(ID_CONSULTA)
NOLOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_CONS_PROGS_PAR_001 ON OPT_CONSULTA_PROGS_PARAMS
(ID_CONSULTA)
NOLOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_HISTORIAL_001 ON OPT_HISTORIAL
(ID_CONSULTA, INICIO)
NOLOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_HIST_CONSULTA01 ON OPT_HIST_CONSULTA
(ID_CONSULTA)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE INDEX IDX_OPT_ROLES_USUARIO_001 ON OPT_ROLES_USUARIO
(ID_USUARIO)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          128K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONSULTAS_ROLE_PK ON OPT_CONSULTAS_ROLE
(ID_ROLE, ID_CONSULTA)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONSULTA_EJECS_PK ON OPT_CONSULTA_EJECS
(ID_CONS_EJEC)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONSULTA_PK ON OPT_CONSULTA
(ID_CONSULTA)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONSULTA_PROGS_DET_PK ON OPT_CONSULTA_PROGS_DET
(ID_CONS_PROG, SECUENCIA)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONSULTA_PROGS_PARAMS_PK ON OPT_CONSULTA_PROGS_PARAMS
(ID_CONS_PROG, SECUENCIA, POSICION)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONSULTA_PROGS_PK ON OPT_CONSULTA_PROGS
(ID_CONS_PROG)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_CONSULTA_RESTRICT_PK ON OPT_CONSULTA_RESTRICT
(ID_CONS_RESTRICT)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_LAYOUT_PK ON OPT_LAYOUT
(ID_CONSULTA, ID_LAYOUT)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_PAGESETTINGS_PK ON OPT_PAGESETTINGS
(ID_CONSULTA, ID_LAYOUT)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_PARAMETROS_PK ON OPT_PARAMETROS
(ID_CONSULTA, POSICION)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          512K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_PIVOT_PK ON OPT_PIVOT
(ID_CONSULTA, ID_LAYOUT)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE UNIQUE INDEX OPT_ROLES_USUARIO_PK ON OPT_ROLES_USUARIO
(ID_ROLE, ID_USUARIO)
LOGGING
TABLESPACE ORM_INDEX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOPARALLEL;


CREATE OR REPLACE PUBLIC SYNONYM OPT_CONSULTA FOR OPT_CONSULTA;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONSULTAS_ROLE FOR OPT_CONSULTAS_ROLE;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONSULTA_EJECS FOR OPT_CONSULTA_EJECS;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONSULTA_PROGS FOR OPT_CONSULTA_PROGS;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONSULTA_PROGS_DET FOR OPT_CONSULTA_PROGS_DET;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONSULTA_PROGS_PARAMS FOR OPT_CONSULTA_PROGS_PARAMS;
CREATE OR REPLACE PUBLIC SYNONYM OPT_CONSULTA_RESTRICT FOR OPT_CONSULTA_RESTRICT;
CREATE OR REPLACE PUBLIC SYNONYM OPT_HISTORIAL FOR OPT_HISTORIAL;
CREATE OR REPLACE PUBLIC SYNONYM OPT_HIST_CONSULTA FOR OPT_HIST_CONSULTA;
CREATE OR REPLACE PUBLIC SYNONYM OPT_LAYOUT FOR OPT_LAYOUT;
CREATE OR REPLACE PUBLIC SYNONYM OPT_PAGESETTINGS FOR OPT_PAGESETTINGS;
CREATE OR REPLACE PUBLIC SYNONYM OPT_PARAMETROS FOR OPT_PARAMETROS;
CREATE OR REPLACE PUBLIC SYNONYM OPT_PIVOT FOR OPT_PIVOT;
CREATE OR REPLACE PUBLIC SYNONYM OPT_ROLES_USUARIO FOR OPT_ROLES_USUARIO;

ALTER TABLE OPT_DIRECTORIO ADD (
  CONSTRAINT OPT_DIRECTORIO_PK
  PRIMARY KEY
  (ID_DIRECTORIO)
  USING INDEX OPT_DIRECTORIO_PK);

ALTER TABLE OPT_ROLE ADD (
  CONSTRAINT OPT_ROLES_PK
  PRIMARY KEY
  (ID_ROLE)
  USING INDEX OPT_ROLES_PK);
  
ALTER TABLE OPT_CONSULTA ADD (
  CONSTRAINT OPT_CONSULTA_R01 
  FOREIGN KEY (ID_DIRECTORIO) 
  REFERENCES OPT_DIRECTORIO (ID_DIRECTORIO));

ALTER TABLE OPT_ARCHAPL ADD (
  CONSTRAINT PK_OPT_ARCHAPL
  PRIMARY KEY
  (NOMBREARCH)
  USING INDEX IDX_OPT_ARCHAPL_01);

ALTER TABLE OPT_CONEXION ADD (
  CONSTRAINT PK_OPT_CONEXION
  PRIMARY KEY
  (ID_CONEXION)
  USING INDEX IDX_OPT_CONEXION_01);

ALTER TABLE OPT_CONFIGURATION ADD (
  CONSTRAINT OPT_CONFIGURATION_PK
  PRIMARY KEY
  (PARAMETER)
  USING INDEX OPT_CONFIGURATION_PK);

ALTER TABLE OPT_CONSULTA_TAREASPOST ADD (
  CONSTRAINT OPT_CONSULTA_TAREASPOST_PK
  PRIMARY KEY
  (ID_CONS_PROG, ORDEN)
  USING INDEX OPT_CONSULTA_TAREASPOST_PK);

ALTER TABLE OPT_CONSULTA_TAREASPOST_PROG ADD (
  CONSTRAINT OPT_CONS_TAREASPOST_PROG_PK
  PRIMARY KEY
  (ID_CONS_PROG, SECUENCIA, ORDEN)
  USING INDEX OPT_CONS_TAREASPOST_PROG_PK);

ALTER TABLE OPT_ORMLIC ADD (
  CONSTRAINT OPT_ORMLIC_PK
  PRIMARY KEY
  (ID)
  USING INDEX OPT_ORMLIC_PK);

ALTER TABLE OPT_USUARIO ADD (
  CONSTRAINT OPT_USUARIOS_PK
  PRIMARY KEY
  (ID_USUARIO)
  USING INDEX OPT_USUARIOS_PK);

ALTER TABLE OPT_CONSULTA ADD (
  CONSTRAINT OPT_CONSULTA_PK
  PRIMARY KEY
  (ID_CONSULTA)
  USING INDEX OPT_CONSULTA_PK);

ALTER TABLE OPT_CONSULTAS_ROLE ADD (
  CONSTRAINT OPT_CONSULTAS_ROLE_PK
  PRIMARY KEY
  (ID_ROLE, ID_CONSULTA)
  USING INDEX OPT_CONSULTAS_ROLE_PK);

ALTER TABLE OPT_CONSULTA_EJECS ADD (
  CONSTRAINT OPT_CONSULTA_EJECS_PK
  PRIMARY KEY
  (ID_CONS_EJEC)
  USING INDEX OPT_CONSULTA_EJECS_PK);

ALTER TABLE OPT_CONSULTA_PROGS ADD (
  CONSTRAINT OPT_CONSULTA_PROGS_PK
  PRIMARY KEY
  (ID_CONS_PROG)
  USING INDEX OPT_CONSULTA_PROGS_PK);

ALTER TABLE OPT_CONSULTA_PROGS_DET ADD (
  CONSTRAINT OPT_CONSULTA_PROGS_DET_PK
  PRIMARY KEY
  (ID_CONS_PROG, SECUENCIA)
  USING INDEX OPT_CONSULTA_PROGS_DET_PK);

ALTER TABLE OPT_CONSULTA_PROGS_PARAMS ADD (
  CONSTRAINT OPT_CONSULTA_PROGS_PARAMS_PK
  PRIMARY KEY
  (ID_CONS_PROG, SECUENCIA, POSICION)
  USING INDEX OPT_CONSULTA_PROGS_PARAMS_PK);

ALTER TABLE OPT_LAYOUT ADD (
  CONSTRAINT OPT_LAYOUT_PK
  PRIMARY KEY
  (ID_CONSULTA, ID_LAYOUT)
  USING INDEX OPT_LAYOUT_PK);

ALTER TABLE OPT_PAGESETTINGS ADD (
  CONSTRAINT OPT_PAGESETTINGS_PK
  PRIMARY KEY
  (ID_CONSULTA, ID_LAYOUT)
  USING INDEX OPT_PAGESETTINGS_PK);

ALTER TABLE OPT_PARAMETROS ADD (
  CONSTRAINT OPT_PARAMETROS_PK
  PRIMARY KEY
  (ID_CONSULTA, POSICION)
  USING INDEX OPT_PARAMETROS_PK);

ALTER TABLE OPT_PIVOT ADD (
  CONSTRAINT OPT_PIVOT_PK
  PRIMARY KEY
  (ID_CONSULTA, ID_LAYOUT)
  USING INDEX OPT_PIVOT_PK);

ALTER TABLE OPT_ROLES_USUARIO ADD (
  CONSTRAINT OPT_ROLES_USUARIO_PK
  PRIMARY KEY
  (ID_ROLE, ID_USUARIO)
  USING INDEX OPT_ROLES_USUARIO_PK);


ALTER TABLE OPT_CONSULTAS_ROLE ADD (
  CONSTRAINT OPT_CONSULTAS_ROLE_R01 
  FOREIGN KEY (ID_ROLE) 
  REFERENCES OPT_ROLE (ID_ROLE),
  CONSTRAINT OPT_CONSULTAS_ROLE_R02 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_CONSULTA_EJECS ADD (
  CONSTRAINT OPT_CONSULTA_EJECS_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_CONSULTA_PROGS ADD (
  CONSTRAINT OPT_CONSULTA_PROGS_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_CONSULTA_PROGS_DET ADD (
  CONSTRAINT OPT_CONSULTA_PROGS_DET_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_CONSULTA_PROGS_PARAMS ADD (
  CONSTRAINT OPT_CONSULTA_PROGS_PARAMS_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_CONSULTA_RESTRICT ADD (
  CONSTRAINT OPT_CONSULTA_RESTRICT_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_HISTORIAL ADD (
  CONSTRAINT OPT_HISTORIAL_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_HIST_CONSULTA ADD (
  CONSTRAINT OPT_HIST_CONSULTA_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_LAYOUT ADD (
  CONSTRAINT OPT_LAYOUT_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_PAGESETTINGS ADD (
  CONSTRAINT OPT_PAGESETTINGS_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_PARAMETROS ADD (
  CONSTRAINT OPT_PARAMETROS_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_PIVOT ADD (
  CONSTRAINT OPT_PIVOT_R01 
  FOREIGN KEY (ID_CONSULTA) 
  REFERENCES OPT_CONSULTA (ID_CONSULTA));

ALTER TABLE OPT_ROLES_USUARIO ADD (
  CONSTRAINT OPT_ROLES_USUARIO_R01 
  FOREIGN KEY (ID_USUARIO) 
  REFERENCES OPT_USUARIO (ID_USUARIO),
  CONSTRAINT OPT_ROLES_USUARIO_R02 
  FOREIGN KEY (ID_ROLE) 
  REFERENCES OPT_ROLE (ID_ROLE));

ALTER TABLE OPT_CONSULTA_RESTRICT ADD (
  CONSTRAINT OPT_CONSULTA_RESTRICT_C01
  CHECK (HORA_INIC BETWEEN 0 AND 23),
  CONSTRAINT OPT_CONSULTA_RESTRICT_C02
  CHECK (MINUTO_INIC BETWEEN 0 AND 59),
  CONSTRAINT OPT_CONSULTA_RESTRICT_C03
  CHECK (HORA_FIN BETWEEN 0 AND 23),
  CONSTRAINT OPT_CONSULTA_RESTRICT_C04
  CHECK (MINUTO_FIN BETWEEN 0 AND 59),
  CONSTRAINT OPT_CONSULTA_RESTRICT_PK
  PRIMARY KEY
  (ID_CONS_RESTRICT)
  USING INDEX OPT_CONSULTA_RESTRICT_PK);

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_ARCHAPL TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONEXION TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONFIGURATION TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONSULTA_TAREASPOST TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONSULTA_TAREASPOST_PROG TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_DIRECTORIO TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_ORMLIC TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_PLAN_TABLE TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_ROLE TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_USUARIO TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONSULTA TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONSULTAS_ROLE TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONSULTA_EJECS TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONSULTA_PROGS TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONSULTA_PROGS_DET TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONSULTA_PROGS_PARAMS TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_CONSULTA_RESTRICT TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_HISTORIAL TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_HIST_CONSULTA TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_LAYOUT TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_PAGESETTINGS TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_PARAMETROS TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_PIVOT TO ORM_USER_ROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON OPT_ROLES_USUARIO TO ORM_USER_ROLE;


CREATE OR REPLACE TRIGGER TRGBFRUPD_OPT_DIRECTORIO
BEFORE UPDATE
OF ID_DIR_PADRE
ON OPT_DIRECTORIO 
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN
    IF :NEW.ID_DIRECTORIO = 0 AND  :NEW.ID_DIR_PADRE IS NOT NULL THEN
            RAISE_APPLICATION_ERROR(-20010, 'El directorio padre del directorio con código 0 no puede tener un valor diferente a NULO');
    END IF;
    
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TRGBFRUPD_OPT_DIRECTORIO;
/


CREATE OR REPLACE TRIGGER "ORM_AFT_INSERT_OPT_USUARIO" 
   AFTER INSERT
   ON OPT_USUARIO    REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
   CANT   INTEGER;
BEGIN
   IF :NEW.id_usuario IS NOT NULL
   THEN
      SELECT COUNT (*)
        INTO CANT
        FROM OPT_ROLE
       WHERE id_role = UPPER (:NEW.id_usuario);

      IF CANT = 0
      THEN
         INSERT INTO OPT_ROLE (id_role, descripcion)
              VALUES (
                        UPPER (:NEW.id_usuario),
                        'ROLE USUARIO ' || :NEW.id_usuario);
      END IF;

      SELECT COUNT (*)
        INTO CANT
        FROM OPT_ROLES_USUARIO
       WHERE id_usuario = UPPER (:NEW.id_usuario)
             AND id_role = UPPER (:NEW.id_usuario);

      IF CANT = 0
      THEN
         INSERT INTO OPT_ROLES_USUARIO (id_usuario, id_role)
              VALUES (UPPER (:NEW.id_usuario), UPPER (:NEW.id_usuario));
      END IF;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      -- Consider logging the error and then re-raise
      RAISE;
END;
/
