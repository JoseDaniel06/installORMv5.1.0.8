Insert into OPT_DIRECTORIO (ID_DIRECTORIO, NOMBRE) values  (0, 'CONSULTAS ORM');

Insert into OPT_USUARIO(ID_USUARIO, NOMBRE, TIPO, ADMIN_PERMISOS, GUARDA_RESULTADOS, PROGRAMA_REPORTES, ESTADO, FECHA_ESTADO, CONS_SIMULTANEAS, PASSWORD)
 Values('ORM', 'ORM - Optima Reports Manager', 1, 'S', 'S', 'S', 'ACTIVO', SYSDATE, 1, 'optima');

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION)
 Values('ALTERNATE_BD', 'Nombre de la BD Alterna desde donde se cargará la información requerida en cada consulta. (Si este parámetro se deja en NULL la consulta se ejecutará en la BD a la que originalmente se conectó el usuario)');

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values('MENSAJE_ALTERNATE_BD', 'Determina si se despliega el mensaje sobre la carga de la información desde la BD Alterna (S/N)', 'N');

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values('MAX_SEGS_DIF_BD_ALTERNA', 'Diferencia máxima en segundos que puede tener la BD Alterna antes de pasar las consultas registradas como directas a producción', '60');

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values('METADATA_EXCLUDED_SCHEMAS', 'Esquemas que se exluyen en el proceso de carga de metadata', 'SYS|SYSTEM|PUBLIC|SYSMAN|OUTLN|ORACLE|ANONYMOUS|CTXSYS|DBSNMP|MDDATA|MDSYS|DMSYS|OLAPSYS|ORDPLUGINS|ORDSYS|OUTLN|SI_INFORMTN_SCHEMA|DIP|FLOWS_FILES|HR|TSMSYS|XDB|EXFSYS|SCOTT|MGMT_VIEW|WMSYS|WKSYS|WKPROXY|OE|PM|SH|OLAPDBA|OLAPSVR|OLAPSYS|OSE$HTTP$ADMIN|QS|QS_ADM|QS_CB|QS_CBADM|QS_CS|QS_ES|QS_OS|QS_WS|PORTAL30|PORTAL30_DEMO|PORTAL30_PUBLIC|PORTAL30_SSO|PORTAL30_SSO_PS|PORTAL30_SSO_PUBLIC|ODM|ODM_MTR|IX|BI|RMAN');

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values('FORCE_GARBAGE_COLLECTION', 'Determina si se requiere realizar el llamado al Gargabe Collector de .NET al finalizar el programa (S/N)', 'N');

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values('LIST_SEPARATOR', 'Define el simbolo a utilizar como separador de elementos al exportar a formato CSV (por defecto se toma el definido en configuración regional)', null);

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values('QUOTE_STRINGS_WITH_SEPARATORS', 'Define si al exportar a CSV se encierran en doble comilla las cadenas que contengan el separador utilizado (S/N)', 'S');

Insert into OPT_CONFIGURATION (PARAMETER, DESCRIPTION, VALUE)
 Values ('INICIAR_POST_EXEC_DISPATCHER', 'Permite indicar si el despachador de tareas post-ejecución de lanza en forma automática (S - Si, N - No, P - Preguntar)', 'N');

Insert into OPT_CONFIGURATION (PARAMETER, DESCRIPTION, VALUE)
 Values ('POST_EXEC_DISPATCHER_INTERVAL', 'Permite indicar el intervalo de ejecución del despachador de tareas post-ejecución (en segundos)', '60');

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values ('DEFAULT_MAX_CONCURRENT_EXEC', 'Permite indicar el máximo número de ejecuciones concurrentes por defecto con el que se crearán la nuevas consultas (0 indica que no se limitan las ejeuciones concurrentes)', '0');
   
Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values ('SHOW_TASK_ALERTS', 'Permite indicar si se despliegan o no las alerta por cada tarea programada ejecutada (S - Si, N - No, E - Solo se despliegan las alertas de error)','E');
   
Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values ('AUTO_RECOVER_SESSION', 'Permite indicar si se realiza recuperación automática de las sesiones en la bd luego de que se presenten errores ORA-03113 end-of-file on communication channel o ORA-03114: not connected to ORACLE','N');

Insert into OPT_CONFIGURATION (PARAMETER, DESCRIPTION, VALUE)
 Values ('ANALYSTS_ALLOWED_TO_VIEW_ALL', 'Permite indicar si los analistas están habilitados para ver todas las consultas (S) o sólo las consultas autorizadas (N)', 'S');

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values ('VALIDATE_QUERY_SYNTAX', 'Permite indicar si se realiza o no la validación de la sintaxis de los queries antes de ejecutarlos (E), antes de guardarlos (G), en ambos eventos (A) o no realizar ninguna validación (N)', 'N');

Insert into OPT_CONFIGURATION(PARAMETER, DESCRIPTION, VALUE)
 Values ('ORACLE_SERVER_SYNTAX_VERSION', 'Permite indicar la versión de servidor de Oracle que se utilizará para validar la sintaxis de los queries: Oracle7, Oracle8, Oracle9, Oracle10 u Oracle11', 'Oracle10');

Insert into OPT_CONFIGURATION (PARAMETER, DESCRIPTION, VALUE)
 Values ('ALLOW_SAVE_QUERY_WITH_INVALID_SYNTAX', 'Permite indicar si se permite o no guardar un query que no haya pasado la validación de sintaxis', 'S');

Insert into OPT_CONFIGURATION (PARAMETER, DESCRIPTION, VALUE)
 Values ('AUTOSAVE_DEFAULT_PATH', 'Permite indicar la ruta por defecto para los archivos generados al autoguardar las consultas marcadas con el flag GUARDADO_AUTOMATICO', null);

Insert into OPT_CONFIGURATION (PARAMETER, DESCRIPTION, VALUE)
 Values ('AUTOSAVE_GENERATED_FILE_MESSAGE', 'Permite indicar si se despliega o no el mensaje de que el archivo ha sido generado con éxito si la consulta ejecutada tiene activo el flag GUARDADO_AUTOMATICO', 'S');

Insert into OPT_CONFIGURATION (PARAMETER, DESCRIPTION, VALUE)
 Values ('ORM_AUTO_UPDATE', 'Permite indicar si la aplicación realiza el proceso de actualización automática al iniciarse (S/N)', 'N');


UPDATE OPT_PARAMETROS
   SET MASCOPCIONES = 'NSSSN' 
 WHERE MASCOPCIONES IS NULL;
 
COMMIT;
