CREATE OR REPLACE PACKAGE ORM_UTILS
AS
   /******************************************************************************
      NAME:       ORM_UTILS
      PURPOSE:

      REVISIONS:
      Ver        Date               Author                               Description
      ---------  ----------         ---------------                     ------------------------------------
      1.0        03/05/2012      OPTIMA CONSULTING       1. Created this package.
      4.1        11/11/2014      OPTIMA CONSULTING       Version 4.1 - Tareas programadas
      4.1.0.3   16/06/2016      OPTIMA CONSULTING       Version 4.1.0.3 - Creación de job con el usuario dueño del package
      4.2        21/01/2017      OPTIMA CONSULTING       Versión 4.2 Se incluye la autorización a los usuarios analistas para ejecutar las consultas que han creado
      4.2.0.4  15/12/2017      OPTIMA CONSULTING       Versión 4.2.0.4 Se incluye el procedimiento ORM_UTILS.updateJob para realizar modificaciones a los jobs de consultas programadas y
                                                                              se ajusta el proceso que valida las resticciones de ejecución de consultas ConsultaConRestriccion para que devuelva siempre los 
                                                                              mismos valores sin importar el parámetro NLS_TERRITORY
   ******************************************************************************/
   TYPE csGetResultSet IS REF CURSOR;

   FUNCTION ConsultaAutorizada (pIDConsulta IN NUMBER, pUsuario IN VARCHAR2)
      RETURN NUMBER;

   FUNCTION DIRCONSREC (pDirectorio IN NUMBER)
      RETURN VARCHAR2;

   FUNCTION DIRPATH (pDirectorio IN NUMBER)
      RETURN VARCHAR2;

   FUNCTION DIRPATHCOMAS (pDirectorio IN NUMBER)
      RETURN VARCHAR2;

   FUNCTION join (p_cursor SYS_REFCURSOR, p_del VARCHAR2 := ',')
      RETURN VARCHAR2;

   FUNCTION split (p_list VARCHAR2, p_del VARCHAR2 := ',')
      RETURN split_tbl
      PIPELINED;

   FUNCTION VALIDADIRCONSREC (pDirectorio1 IN NUMBER, pDirectorio2 IN NUMBER)
      RETURN INT;

   PROCEDURE EjecutarConsulta (pIdConsulta   IN NUMBER,
                               pParametros   IN VARCHAR2);

   PROCEDURE EjecutarConsulta (pIdConsulta   IN NUMBER,
                               pParametros   IN VARCHAR2,
                               pJobId        IN NUMBER);

   PROCEDURE EjecutarConsulta (pIdConsulta   IN NUMBER,
                               pParametros   IN VARCHAR2,
                               pJobId        IN NUMBER,
                               pConsProg     IN NUMBER);

   PROCEDURE getJobInfo (pidjob IN NUMBER, pcursor OUT csGetResultSet);

   PROCEDURE validateJobExists (pidjob IN NUMBER, pexists OUT VARCHAR2);

   FUNCTION validateJobExists (pidjob IN NUMBER)
      RETURN VARCHAR2;

   FUNCTION getJobStatus (pidjob IN NUMBER)
      RETURN VARCHAR2;

   PROCEDURE createJob (idconsulta IN VARCHAR2, cons_prog IN NUMBER, params IN VARCHAR2, nextdate IN DATE, intervalo IN VARCHAR2);
   
   PROCEDURE updateJob (pidjob IN NUMBER, nextdate IN DATE, intervalo IN VARCHAR2);
   
   PROCEDURE removeJob (pidjob IN NUMBER);

   PROCEDURE brokeJob (pidjob IN NUMBER);

   PROCEDURE unbrokeJob (pidjob IN NUMBER);

   PROCEDURE analyzeQuery (pstatementid IN VARCHAR2, pquery IN VARCHAR2);

   PROCEDURE analyzeQuery2 (pstatementid   IN VARCHAR2,
                            pquery1        IN VARCHAR2,
                            pquery2        IN VARCHAR2,
                            pquery3        IN VARCHAR2);

   FUNCTION ConsultaConRestriccion (pidconsulta IN NUMBER)
      RETURN VARCHAR2;

   PROCEDURE getDatabaseInfo (pcursor OUT csGetResultSet);

   PROCEDURE getORMUsersCount (pcount OUT NUMBER);

   PROCEDURE getParametersProg (pIdConsProg   IN     NUMBER,
                                pcursor          OUT csGetResultSet);
                                
   FUNCTION ValidaEjecConcurrentes (pIDConsulta IN NUMBER)
      RETURN NUMBER;                                
END ORM_UTILS;
/


CREATE OR REPLACE PACKAGE BODY ORM_UTILS
AS
   /******************************************************************************
      NAME:       ORM_UTILS
      PURPOSE:

      REVISIONS:
      Ver        Date               Author                               Description
      ---------  ----------         ---------------                     ------------------------------------
      1.0        03/05/2012      OPTIMA CONSULTING       1. Created this package.
      4.1        11/11/2014      OPTIMA CONSULTING       Version 4.1 - Tareas programadas
      4.1.0.3   16/06/2016     OPTIMA CONSULTING       Version 4.1.0.3 - Creación de job con el usuario dueño del package
      4.2        21/01/2017      OPTIMA CONSULTING       Versión 4.2 Se incluye la autorización a los usuarios analistas para ejecutar las consultas que han creado
      4.2.0.4  15/12/2017      OPTIMA CONSULTING       Versión 4.2.0.4 Se incluye el procedimiento ORM_UTILS.updateJob para realizar modificaciones a los jobs de consultas programadas y
                                                                              se ajusta el proceso que valida las resticciones de ejecución de consultas ConsultaConRestriccion para que devuelva siempre los 
                                                                              mismos valores sin importar el parámetro NLS_TERRITORY
   ******************************************************************************/

   FUNCTION ConsultaAutorizada (pIDConsulta IN NUMBER, pUsuario IN VARCHAR2)
      RETURN NUMBER
   IS
      Cantidad      NUMBER (2) := 0;
      Autorizado    NUMBER (1) := 0;                                  -- false
      ConsPublica   VARCHAR2 (1);
   BEGIN
      SELECT PUBLICA
        INTO ConsPublica
        FROM OPT_CONSULTA
       WHERE ID_CONSULTA = pIDConsulta;

      IF ConsPublica = 'S'
      THEN
         Autorizado := 1;
      ELSE
          -- Se valida si el usuario indicado es el autor de la consulta
          SELECT COUNT (*)
              INTO Cantidad
            FROM OPT_CONSULTA
          WHERE ID_CONSULTA = pIDConsulta
              AND ID_USUARIO =  UPPER (pUsuario);
       
            IF Cantidad = 0
            THEN
                 SELECT COUNT (*)
                   INTO Cantidad
                   FROM OPT_ROLES_USUARIO, OPT_CONSULTAS_ROLE
                  WHERE     OPT_ROLES_USUARIO.ID_USUARIO = UPPER (pUsuario)
                        AND OPT_ROLES_USUARIO.ID_ROLE = OPT_CONSULTAS_ROLE.ID_ROLE
                        AND OPT_CONSULTAS_ROLE.ID_CONSULTA = pIDConsulta;

                 IF Cantidad = 0
                 THEN
                    SELECT COUNT (*)
                      INTO Cantidad
                      FROM OPT_ROLES_USUARIO
                     WHERE UPPER (OPT_ROLES_USUARIO.ID_USUARIO) = UPPER (pUsuario)
                           AND OPT_ROLES_USUARIO.ID_ROLE = 'GLOBAL';

                    IF Cantidad = 0
                    THEN
                       Autorizado := 0;                                       -- false
                    ELSE
                       Autorizado := 1;                                        -- true
                    END IF;
                 ELSE
                    Autorizado := 1;                                           -- true
                 END IF;
            ELSE
                Autorizado := 1;                                        -- true
            END IF;
      END IF;
      
      RETURN Autorizado;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;

    FUNCTION DIRCONSREC (pDirectorio IN NUMBER)
      RETURN VARCHAR2
    IS
        Cadena      VARCHAR2 (5000);
    BEGIN
      select  substr(REPLACE(sys_connect_by_path (a.id_dir_padre, '\' ),  '\', '><') || '><' || a.id_directorio||'>', 2, 5000) 
        INTO Cadena
        from OPT_directorio a
        where a.id_directorio = pDirectorio
        and connect_by_root (a.id_dir_padre) = 0
        connect by prior a.id_directorio = a.id_dir_padre;
 
      RETURN Cadena;
   END;
   
    FUNCTION DIRPATH (pDirectorio IN NUMBER)
      RETURN VARCHAR2
    IS
      Cadena       VARCHAR2 (5000);
    BEGIN
      select  SUBSTR (sys_connect_by_path (a.nombre, '\' ), 1, 5000)
        into Cadena  
        from OPT_DIRECTORIO a
      where a.id_directorio = pDirectorio
        and connect_by_root (a.id_dir_padre) is null
        connect by prior a.id_directorio = a.id_dir_padre;
 
      RETURN Cadena;
    END;    
   
    FUNCTION DIRPATHCOMAS (pDirectorio IN NUMBER)
      RETURN VARCHAR2
    IS
        Cadena      VARCHAR2 (5000);
    BEGIN
        select  SUBSTR (sys_connect_by_path (a.id_directorio, ',' ), 1, 5000)
           into Cadena  
         from OPT_DIRECTORIO a
       where a.id_directorio = pDirectorio
           and connect_by_root (a.id_dir_padre) is null
      connect by prior a.id_directorio = a.id_dir_padre;

        RETURN Cadena;
    END;   
   
   FUNCTION join (p_cursor SYS_REFCURSOR, p_del VARCHAR2 := ',')
      RETURN VARCHAR2
   IS
      l_value    VARCHAR2 (32767);
      l_result   VARCHAR2 (32767);
   BEGIN
      LOOP
         FETCH p_cursor INTO l_value;

         EXIT WHEN p_cursor%NOTFOUND;

         IF l_result IS NOT NULL
         THEN
            l_result := SUBSTR (l_result || p_del, 1, 32767);
         END IF;

         l_result := SUBSTR (l_result || l_value, 1, 32767);
      END LOOP;

      RETURN l_result;
   END;

   FUNCTION split (p_list VARCHAR2, p_del VARCHAR2 := ',')
      RETURN split_tbl
      PIPELINED
   IS
      l_idx     PLS_INTEGER;
      l_list    VARCHAR2 (32767) := p_list;
      l_value   VARCHAR2 (32767);
   BEGIN
      LOOP
         l_idx := INSTR (l_list, p_del);

         IF l_idx > 0
         THEN
            PIPE ROW (SUBSTR (l_list, 1, l_idx - 1));
            l_list := SUBSTR (l_list, l_idx + LENGTH (p_del));
         ELSE
            PIPE ROW (l_list);
            EXIT;
         END IF;
      END LOOP;

      RETURN;
   END;

   FUNCTION VALIDADIRCONSREC (pDirectorio1 IN NUMBER, pDirectorio2 IN NUMBER)
      RETURN INT
   IS
   BEGIN
      IF INSTR (DIRCONSREC (pDirectorio1),
                '<' || TO_CHAR (pDirectorio2) || '>') > 0
      THEN
         RETURN 1;
      ELSE
         RETURN 0;
      END IF;
   END;

   PROCEDURE EjecutarConsulta (pIdConsulta   IN NUMBER,
                               pParametros   IN VARCHAR2)
   IS
   BEGIN
      EjecutarConsulta (pIdConsulta,
                        pParametros,
                        NULL,
                        NULL);
   END;

   PROCEDURE EjecutarConsulta (pIdConsulta   IN NUMBER,
                               pParametros   IN VARCHAR2,
                               pJobId        IN NUMBER)
   IS
   BEGIN
      EjecutarConsulta (pIdConsulta,
                        pParametros,
                        pJobId,
                        NULL);
   END;

   PROCEDURE EjecutarConsulta (pIdConsulta   IN NUMBER,
                               pParametros   IN VARCHAR2,
                               pJobId        IN NUMBER,
                               pConsProg     IN NUMBER)
   IS
      CURSOR cVarsSust (pSeq IN NUMBER)
      IS
           SELECT nombre, valor
             FROM OPT_CONSULTA_PROGS_PARAMS
            WHERE ID_CONS_PROG = pConsProg AND secuencia = pSeq
              AND UPPER(nombre) IN (SELECT UPPER(nombre) 
                                          FROM OPT_PARAMETROS
                                         WHERE ID_CONSULTA = pIdConsulta
                                           AND VARSUSTITUCION = 'S')
         ORDER BY posicion;
         
      CURSOR cParametros (pSeq IN NUMBER)
      IS
           SELECT nombre, valor
             FROM OPT_CONSULTA_PROGS_PARAMS
            WHERE ID_CONS_PROG = pConsProg AND secuencia = pSeq
              AND UPPER(nombre) NOT IN (SELECT UPPER(nombre) 
                                          FROM OPT_PARAMETROS
                                         WHERE ID_CONSULTA = pIdConsulta
                                           AND VARSUSTITUCION = 'S')
         ORDER BY posicion;

      --- Query.
      query                   CLOB;
      query_orig              CLOB;
      xmlSchema               CLOB;
      --- Generated XML.
      xmlc                    CLOB;
      --xmlc_temp               CLOB;

      numregs                 NUMBER (10) := 0;
      context                 NUMBER := 0;
      err_msg                 VARCHAR2 (2000);
      restrict_msg            VARCHAR2 (2000);
      param_name              VARCHAR2 (200);
      param_value             VARCHAR2 (2000);
      pos_separator           NUMBER (4);
      fecha_ini               DATE;
      fecha_final             DATE;
      max_seq                 NUMBER (9);
      i                       NUMBER (9);
      a_null                  VARCHAR2 (1) := '';
      consulta_ejec_nextval   NUMBER (10) := 0;
      num_ejec                NUMBER (10);
      intervalo_ejec          VARCHAR2 (500);
      idusrprog               VARCHAR2 (50);
   BEGIN
      fecha_ini := SYSDATE;

      EXECUTE IMMEDIATE
         'alter session set nls_date_format = '''
         || 'yyyy-mm-dd"T"hh24:mi:ss''';

      BEGIN
         SELECT consulta, esquema
           INTO query, xmlSchema
           FROM opt_consulta
          WHERE id_consulta = pIdConsulta;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            err_msg :=
               'Consulta ' || TO_CHAR (pIdConsulta) || ' no encontrada';

            INSERT INTO opt_consulta_ejecs (ID_CONS_EJEC,
                                            ID_CONSULTA,
                                            TIPO,
                                            RESULTADO,
                                            ESQUEMA,
                                            REGISTROS,
                                            PARAMETROS,
                                            ERROR_MSG,
                                            ID_USUARIO,
                                            ID_JOB,
                                            FECHA_EJEC)
                 VALUES (OPTSEQ_CONSULTA_EJEC.NEXTVAL,
                         pIdConsulta,
                         'JOB',
                         xmlc,
                         xmlSchema,
                         0,
                         pParametros,
                         err_msg,
                         USER,
                         pJobId,
                         SYSDATE);

            COMMIT;
            query := 'NO SELECT';
      END;

      IF query <> 'NO SELECT'
      THEN
         restrict_msg := ConsultaConRestriccion (pIdConsulta);

         IF restrict_msg != 'NO'
         THEN
            err_msg :=
                  'Consulta '
               || TO_CHAR (pIdConsulta)
               || ' no ejecutada a las: '
               || TO_CHAR (SYSDATE, 'hh24:mi:ss')
               || '. Tiene '
               || restrict_msg;

            SELECT OPTSEQ_CONSULTA_EJEC.NEXTVAL
              INTO consulta_ejec_nextval
              FROM DUAL;

            INSERT INTO opt_consulta_ejecs (ID_CONS_EJEC,
                                            ID_CONSULTA,
                                            TIPO,
                                            RESULTADO,
                                            ESQUEMA,
                                            REGISTROS,
                                            PARAMETROS,
                                            ERROR_MSG,
                                            ID_USUARIO,
                                            ID_JOB,
                                            FECHA_EJEC)
                 VALUES (consulta_ejec_nextval,
                         pIdConsulta,
                         'JOB',
                         xmlc,
                         xmlSchema,
                         0,
                         pParametros,
                         err_msg,
                         USER,
                         pJobId,
                         SYSDATE);

            IF pConsProg IS NOT NULL
            THEN
               SELECT NUM_EJECUCIONES, INTERVALO, ID_USUARIO
                 INTO num_ejec, intervalo_ejec, idusrprog
                 FROM OPT_CONSULTA_PROGS
                WHERE ID_CONS_PROG = pConsProg;

               fecha_final := SYSDATE;

               UPDATE OPT_CONSULTA_PROGS
                  SET ESTADO = 'ERROR',
                      FECHA_INICIO = fecha_ini,
                      FECHA_FIN = fecha_final,
                      ERROR_MSG = err_msg,
                      NUM_EJECUCIONES = num_ejec + 1
                WHERE ID_CONS_PROG = pConsProg;

               IF intervalo_ejec <> 'null'
               THEN
                  INSERT INTO OPT_CONSULTA_PROGS_DET (ID_CONS_PROG,
                                                      SECUENCIA,
                                                      ID_CONSULTA,
                                                      ID_CONS_EJEC,
                                                      FECHA_INICIO,
                                                      FECHA_FIN,
                                                      ESTADO,
                                                      ERROR_MSG,
                                                      ID_USUARIO,
                                                      FECHA_REG)
                       VALUES (pConsProg,
                               num_ejec + 1,
                               pIdConsulta,
                               consulta_ejec_nextval,
                               fecha_ini,
                               fecha_final,
                               'ERROR',
                               err_msg,
                               idusrprog,
                               SYSDATE);
               END IF;
            END IF;

            COMMIT;
         ELSE
            SELECT NVL (MAX (secuencia), 0)
              INTO max_seq
              FROM OPT_CONSULTA_PROGS_PARAMS
             WHERE ID_CONS_PROG = pConsProg;

            DBMS_LOB.createtemporary (xmlc, TRUE);
            
            IF max_seq > 0
            THEN
               query_orig := query;
                        
               FOR i IN 1 .. max_seq
               LOOP
                  query := query_orig;
                  --No se requiere el clob xmlc_temp, ya que cada vez que se ejecuta
                  --DBMS_XMLGEN.getxml el resultado se agreda (append) a xmlc
                  --DBMS_LOB.createtemporary (xmlc_temp, TRUE);
               
                  FOR regparam IN cVarsSust (i)
                  LOOP
                     IF regparam.valor IS NOT NULL
                     THEN
                        query := regexp_replace(query, ':' || regparam.nombre || '(\W|$)', regparam.valor || '\1', 1, 0, 'i');
                     ELSE
                        query := regexp_replace(query, ':' || regparam.nombre || '(\W|$)', 'NULL\1', 1, 0, 'i');
                     END IF;
                  END LOOP;
                  
                  context := DBMS_XMLGEN.NEWCONTEXT (query);
                  --DBMS_XMLGEN.setnullhandling (context, DBMS_XMLGEN.empty_tag);
                  -- Set the Root Element
                  DBMS_XMLGEN.SETROWSETTAG (context, 'NewDataSet');
                  -- Set the Row Element
                  DBMS_XMLGEN.SETROWTAG (context, 'Table');
            
                  DBMS_XMLGEN.clearBindValues (context);

                  FOR regparam IN cParametros (i)
                  LOOP
                     IF regparam.valor IS NOT NULL
                     THEN
                        DBMS_XMLGEN.setbindvalue (context,
                                                  regparam.nombre,
                                                  regparam.valor);
                     ELSE
                        DBMS_XMLGEN.setbindvalue (context,
                                                  regparam.nombre,
                                                  a_null);
                     END IF;
                  END LOOP;

                  -- Generate XML Output
                  --DBMS_XMLGEN.getxml (context, xmlc_temp, DBMS_XMLGEN.NONE);
                  DBMS_XMLGEN.getxml (context, xmlc, DBMS_XMLGEN.NONE);
                  -- Get the number of processesd rows
                  numregs :=
                     numregs + DBMS_XMLGEN.GETNUMROWSPROCESSED (context);
     
                  --xmlc := CONCAT(xmlc, xmlc_temp);
               END LOOP;
               xmlc :=
                     REPLACE (
                        xmlc,
                           CHR (10)
                        || '</NewDataSet>'
                        || CHR (10)
                        || '<?xml version="1.0"?>'
                        || CHR (10)
                        || '<NewDataSet>'
                        || CHR (10),
                        CHR (10));
            ELSE
               context := DBMS_XMLGEN.NEWCONTEXT (query);
               --DBMS_XMLGEN.setnullhandling (context, DBMS_XMLGEN.empty_tag);
               -- Set the Root Element
               DBMS_XMLGEN.SETROWSETTAG (context, 'NewDataSet');
               -- Set the Row Element
               DBMS_XMLGEN.SETROWTAG (context, 'Table');
               -- Generate XML Output
               DBMS_XMLGEN.getxml (context, xmlc, DBMS_XMLGEN.NONE);
               -- Get the number of processesd rows
               numregs := DBMS_XMLGEN.GETNUMROWSPROCESSED (context);
            END IF;

            fecha_final := SYSDATE;

            SELECT OPTSEQ_CONSULTA_EJEC.NEXTVAL
              INTO consulta_ejec_nextval
              FROM DUAL;

            INSERT INTO opt_consulta_ejecs (ID_CONS_EJEC,
                                            ID_CONSULTA,
                                            TIPO,
                                            RESULTADO,
                                            ESQUEMA,
                                            REGISTROS,
                                            PARAMETROS,
                                            ERROR_MSG,
                                            ID_USUARIO,
                                            ID_JOB,
                                            FECHA_EJEC)
                 VALUES (consulta_ejec_nextval,
                         pIdConsulta,
                         'JOB',
                         xmlc,
                         xmlSchema,
                         numregs,
                         pParametros,
                         NULL,
                         USER,
                         pJobId,
                         SYSDATE);

            IF pConsProg IS NOT NULL
            THEN
               SELECT NUM_EJECUCIONES, INTERVALO, ID_USUARIO
                 INTO num_ejec, intervalo_ejec, idusrprog
                 FROM OPT_CONSULTA_PROGS
                WHERE ID_CONS_PROG = pConsProg;

               UPDATE OPT_CONSULTA_PROGS
                  SET ESTADO = 'EJECUTADA',
                      FECHA_INICIO = fecha_ini,
                      FECHA_FIN = fecha_final,
                      ERROR_MSG = NULL,
                      ID_JOB = pJobId,
                      NUM_EJECUCIONES = num_ejec + 1
                WHERE ID_CONS_PROG = pConsProg;

               IF intervalo_ejec <> 'null'
               THEN
                  INSERT INTO OPT_CONSULTA_PROGS_DET (ID_CONS_PROG,
                                                      SECUENCIA,
                                                      ID_CONSULTA,
                                                      ID_CONS_EJEC,
                                                      FECHA_INICIO,
                                                      FECHA_FIN,
                                                      ESTADO,
                                                      ERROR_MSG,
                                                      ID_USUARIO,
                                                      FECHA_REG)
                       VALUES (pConsProg,
                               num_ejec + 1,
                               pIdConsulta,
                               consulta_ejec_nextval,
                               fecha_ini,
                               fecha_final,
                               'EJECUTADA',
                               err_msg,
                               idusrprog,
                               SYSDATE);
               END IF;

               INSERT INTO OPT_CONSULTA_TAREASPOST_PROG (ID_CONS_PROG,
                                                         SECUENCIA,
                                                         ORDEN,
                                                         TIPO,
                                                         ESTADO,
                                                         MENSAJE,
                                                         FECHA_ESTADO,
                                                         ID_LAYOUT,
                                                         CONTROL,
                                                         FILETYPE,
                                                         FILEPATH,
                                                         FILENAME,
                                                         COMPRESSFILE,
                                                         DELETEFILE,
                                                         MAIL_SOURCE,
                                                         MAIL_DEST,
                                                         MAIL_CC,
                                                         MAIL_SUBJECT,
                                                         MAIL_TEXT,
                                                         ID_USUARIO)
                  SELECT ID_CONS_PROG,
                         num_ejec + 1,
                         ORDEN,
                         TIPO,
                         'PENDIENTE',
                         NULL,
                         SYSDATE,
                         ID_LAYOUT,
                         CONTROL,
                         FILETYPE,
                         FILEPATH,
                         REPLACE(REPLACE(FILENAME, '[FECHA-HORA]', '[' || to_char(sysdate, 'yyyymmdd_hh24miss') || ']'), '[FECHA]', '[' || to_char(sysdate, 'yyyymmdd') || ']') FILENAME,
                         COMPRESSFILE,
                         DELETEFILE,
                         MAIL_SOURCE,
                         MAIL_DEST,
                         MAIL_CC,
                         REPLACE(MAIL_SUBJECT, '[SYSDATE]', '[' || to_char(sysdate, 'dd-mm-yyyy hh24:mi') || ']') MAIL_SUBJECT,
                         REPLACE(MAIL_TEXT, '[SYSDATE]', '[' || to_char(sysdate, 'dd-mm-yyyy hh24:mi') || ']') MAIL_TEXT,
                         ID_USUARIO
                    FROM OPT_CONSULTA_TAREASPOST
                   WHERE ID_CONS_PROG = pConsProg AND activo = 'S';
            END IF;

            COMMIT;
            -- Close the Context
            DBMS_XMLGEN.CLOSECONTEXT (context);
         END IF;
      ELSE
         err_msg :=
            'No se pudo cargar el texto del query para la consulta '
            || pidConsulta;

         SELECT OPTSEQ_CONSULTA_EJEC.NEXTVAL
           INTO consulta_ejec_nextval
           FROM DUAL;

         fecha_final := SYSDATE;

         INSERT INTO opt_consulta_ejecs (ID_CONS_EJEC,
                                         ID_CONSULTA,
                                         TIPO,
                                         RESULTADO,
                                         ESQUEMA,
                                         REGISTROS,
                                         PARAMETROS,
                                         ERROR_MSG,
                                         ID_USUARIO,
                                         ID_JOB,
                                         FECHA_EJEC)
              VALUES (consulta_ejec_nextval,
                      pIdConsulta,
                      'JOB',
                      xmlc,
                      xmlSchema,
                      0,
                      pParametros,
                      err_msg,
                      USER,
                      pJobId,
                      SYSDATE);

         IF pConsProg IS NOT NULL
         THEN
            SELECT NUM_EJECUCIONES, INTERVALO, ID_USUARIO
              INTO num_ejec, intervalo_ejec, idusrprog
              FROM OPT_CONSULTA_PROGS
             WHERE ID_CONS_PROG = pConsProg;

            UPDATE OPT_CONSULTA_PROGS
               SET ESTADO = 'ERROR',
                   FECHA_INICIO = fecha_ini,
                   FECHA_FIN = fecha_final,
                   ERROR_MSG = err_msg,
                   NUM_EJECUCIONES = num_ejec + 1
             WHERE ID_CONS_PROG = pConsProg;

            IF intervalo_ejec <> 'null'
            THEN
               INSERT INTO OPT_CONSULTA_PROGS_DET (ID_CONS_PROG,
                                                   SECUENCIA,
                                                   ID_CONSULTA,
                                                   ID_CONS_EJEC,
                                                   FECHA_INICIO,
                                                   FECHA_FIN,
                                                   ESTADO,
                                                   ERROR_MSG,
                                                   ID_USUARIO,
                                                   FECHA_REG)
                    VALUES (pConsProg,
                            num_ejec + 1,
                            pIdConsulta,
                            consulta_ejec_nextval,
                            fecha_ini,
                            fecha_final,
                            'ERROR',
                            err_msg,
                            idusrprog,
                            SYSDATE);
            END IF;
         END IF;

         COMMIT;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         err_msg := SUBSTR (SQLERRM, 1, 2000);

         SELECT OPTSEQ_CONSULTA_EJEC.NEXTVAL
           INTO consulta_ejec_nextval
           FROM DUAL;

         fecha_final := SYSDATE;

         INSERT INTO opt_consulta_ejecs (ID_CONS_EJEC,
                                         ID_CONSULTA,
                                         TIPO,
                                         RESULTADO,
                                         ESQUEMA,
                                         REGISTROS,
                                         PARAMETROS,
                                         ERROR_MSG,
                                         ID_USUARIO,
                                         ID_JOB,
                                         FECHA_EJEC)
              VALUES (consulta_ejec_nextval,
                      pIdConsulta,
                      'JOB',
                      xmlc,
                      xmlSchema,
                      0,
                      pParametros,
                      err_msg,
                      USER,
                      pJobId,
                      SYSDATE);

         IF pConsProg IS NOT NULL
         THEN
            SELECT NUM_EJECUCIONES, INTERVALO, ID_USUARIO
              INTO num_ejec, intervalo_ejec, idusrprog
              FROM OPT_CONSULTA_PROGS
             WHERE ID_CONS_PROG = pConsProg;

            UPDATE OPT_CONSULTA_PROGS
               SET ESTADO = 'ERROR',
                   FECHA_INICIO = fecha_ini,
                   FECHA_FIN = fecha_final,
                   ERROR_MSG = err_msg,
                   NUM_EJECUCIONES = num_ejec + 1
             WHERE ID_CONS_PROG = pConsProg;

            IF intervalo_ejec <> 'null'
            THEN
               INSERT INTO OPT_CONSULTA_PROGS_DET (ID_CONS_PROG,
                                                   SECUENCIA,
                                                   ID_CONSULTA,
                                                   ID_CONS_EJEC,
                                                   FECHA_INICIO,
                                                   FECHA_FIN,
                                                   ESTADO,
                                                   ERROR_MSG,
                                                   ID_USUARIO,
                                                   FECHA_REG)
                    VALUES (pConsProg,
                            num_ejec + 1,
                            pIdConsulta,
                            consulta_ejec_nextval,
                            fecha_ini,
                            fecha_final,
                            'ERROR',
                            err_msg,
                            USER,
                            SYSDATE);
            END IF;
         END IF;

         COMMIT;
   END;

   PROCEDURE getJobInfo (pidjob IN NUMBER, pcursor OUT csGetResultSet)
   IS
      cursorjobinfo   csGetResultSet;
   BEGIN
      OPEN cursorjobinfo FOR
         SELECT TRUNC (JOB, 0) JOB,
                LOG_USER,
                PRIV_USER,
                SCHEMA_USER,
                LAST_DATE,
                LAST_SEC,
                THIS_DATE,
                THIS_SEC,
                NEXT_DATE,
                NEXT_SEC,
                TRUNC (TOTAL_TIME, 0) TOTAL_TIME,
                BROKEN,
                INTERVAL,
                TRUNC (FAILURES, 0) FAILURES,
                WHAT,
                NLS_ENV
           FROM user_jobs
          WHERE job = pidjob;

      pcursor := cursorjobinfo;
   END;

   PROCEDURE validateJobExists (pidjob IN NUMBER, pexists OUT VARCHAR2)
   IS
      cant   NUMBER (2);
   BEGIN
      cant := 0;

      SELECT COUNT (*)
        INTO cant
        FROM user_jobs
       WHERE job = pidjob;

      IF cant = 0
      THEN
         pExists := 'N';
      ELSE
         pExists := 'S';
      END IF;
   END;

   FUNCTION validateJobExists (pidjob IN NUMBER)
      RETURN VARCHAR2
   IS
      cant   NUMBER (2);
   BEGIN
      cant := 0;

      SELECT COUNT (*)
        INTO cant
        FROM user_jobs
       WHERE job = pidjob;

      IF cant = 0
      THEN
         RETURN 'N';
      ELSE
         RETURN 'S';
      END IF;
   END;

   FUNCTION getJobStatus (pidjob IN NUMBER)
      RETURN VARCHAR2
   IS
      estado   VARCHAR2 (20);
   BEGIN
      SELECT DECODE (BROKEN, 'N', 'Programado', 'Detenido')
        INTO estado
        FROM user_jobs
       WHERE job = pidjob;

      RETURN estado;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN 'Terminado';
   END;

   PROCEDURE createJob (idconsulta IN VARCHAR2, cons_prog IN NUMBER, params IN VARCHAR2, nextdate IN DATE, intervalo IN VARCHAR2)
   IS
      X NUMBER; 
   BEGIN
      DBMS_JOB.SUBMIT  ( job       => X,
                                        what     => 'ORM_UTILS.EjecutarConsulta(' ||  idconsulta || ', ''' || params || ''' , JOB, ' || to_char(cons_prog) || ');' ,
                                        next_date => nextdate,
                                        interval  => intervalo,
                                        no_parse  => FALSE); 
      COMMIT; 
      UPDATE OPT_CONSULTA_PROGS SET ID_JOB = X WHERE ID_CONS_PROG = cons_prog;  
      COMMIT;
   END;           
   
   PROCEDURE updateJob (pidjob IN NUMBER, nextdate IN DATE, intervalo IN VARCHAR2)
   IS
   BEGIN
      DBMS_JOB.NEXT_DATE (pidjob,  nextdate);
      DBMS_JOB.INTERVAL (pidjob, intervalo);
      COMMIT; 
   END;           
                      
   PROCEDURE removeJob (pidjob IN NUMBER)
   IS
   BEGIN
      DBMS_JOB.REMOVE (pidjob);
      COMMIT;
   END;

   PROCEDURE brokeJob (pidjob IN NUMBER)
   IS
   BEGIN
      DBMS_JOB.BROKEN (pidjob, TRUE);
      COMMIT;
   END;

   PROCEDURE unbrokeJob (pidjob IN NUMBER)
   IS
   BEGIN
      DBMS_JOB.BROKEN (pidjob, FALSE);
      COMMIT;
   END;

   PROCEDURE analyzeQuery (pstatementid IN VARCHAR2, pquery IN VARCHAR2)
   IS
   BEGIN
      DELETE FROM OPT_PLAN_TABLE
            WHERE statement_id = pstatementid;

      EXECUTE IMMEDIATE
            'explain plan set statement_id = '''
         || pstatementid
         || ''' into OPT_PLAN_TABLE for '
         || pquery;

      COMMIT;
   END;

   PROCEDURE analyzeQuery2 (pstatementid   IN VARCHAR2,
                            pquery1        IN VARCHAR2,
                            pquery2        IN VARCHAR2,
                            pquery3        IN VARCHAR2)
   IS
   BEGIN
      DELETE FROM OPT_PLAN_TABLE
            WHERE statement_id = pstatementid;

      EXECUTE IMMEDIATE
            'explain plan set statement_id = '''
         || pstatementid
         || ''' into OPT_PLAN_TABLE for '
         || pquery1
         || pquery2
         || pquery3;

      COMMIT;
   END;

   FUNCTION ConsultaConRestriccion (pidconsulta IN NUMBER)
      RETURN VARCHAR2
   IS
      TYPE cur_typ IS REF CURSOR;

      c_cursor      CUR_TYP;

      restriccion   VARCHAR2 (200);

      CURSOR cporfechas
      IS
         SELECT    'Restricción de Ejecución entre:  '
                || TO_CHAR (fecha_inic, 'dd-mm-yyyy hh24:mi:ss am')
                || ' y:  '
                || TO_CHAR (fecha_fin, 'dd-mm-yyyy hh24:mi:ss am')
                   restric
           FROM OPT_CONSULTA_RESTRICT
          WHERE     id_consulta = pidconsulta
                AND activo = 'S'
                AND SYSDATE BETWEEN fecha_inic AND fecha_fin
                AND ROWNUM = 1;

      CURSOR cpordias
      IS
         SELECT 'Restricción de Ejecución entre:  '
                || TO_CHAR (
                      TRUNC (SYSDATE) + hora_inic / 24 + minuto_inic / 1440,
                      'hh24:mi am')
                || ' y:  '
                || TO_CHAR (
                      TRUNC (SYSDATE) + hora_fin / 24 + minuto_fin / 1440,
                      'hh24:mi am')
                   restric
           FROM OPT_CONSULTA_RESTRICT
          WHERE id_consulta = pidconsulta AND activo = 'S'
                AND SYSDATE BETWEEN (  TRUNC (SYSDATE)
                                     + hora_inic / 24
                                     + minuto_inic / 1440)
                                AND (  TRUNC (SYSDATE)
                                     + hora_fin / 24
                                     + minuto_fin / 1440)
                AND ( (    LUNES = 'N'
                       AND MARTES = 'N'
                       AND MIERCOLES = 'N'
                       AND JUEVES = 'N'
                       AND VIERNES = 'N'
                       AND SABADO = 'N'
                       AND DOMINGO = 'N')
                     /*OR (LUNES = 'S' AND TO_CHAR (SYSDATE, 'd') = '1')
                     OR (MARTES = 'S' AND TO_CHAR (SYSDATE, 'd') = '2')
                     OR (MIERCOLES = 'S' AND TO_CHAR (SYSDATE, 'd') = '3')
                     OR (JUEVES = 'S' AND TO_CHAR (SYSDATE, 'd') = '4')
                     OR (VIERNES = 'S' AND TO_CHAR (SYSDATE, 'd') = '5')
                     OR (SABADO = 'S' AND TO_CHAR (SYSDATE, 'd') = '6')
                     OR (DOMINGO = 'S' AND TO_CHAR (SYSDATE, 'd') = '7'))*/
                     -- JAGUDELO 15-12-2017: Se ajusta la conversión de fecha para determinar el día utilizando
                     -- NLS_DATE_LANGUAGE para asegurar el mismo resultado sin importar la configuración de la bd
                     -- En este caso domingo es día 1 y sábado es día 7
                     OR (LUNES = 'S' AND TO_CHAR (SYSDATE, 'd', 'NLS_DATE_LANGUAGE = american') = '2')
                     OR (MARTES = 'S' AND TO_CHAR (SYSDATE, 'd', 'NLS_DATE_LANGUAGE = american') = '3')
                     OR (MIERCOLES = 'S' AND TO_CHAR (SYSDATE, 'd', 'NLS_DATE_LANGUAGE = american') = '4')
                     OR (JUEVES = 'S' AND TO_CHAR (SYSDATE, 'd', 'NLS_DATE_LANGUAGE = american') = '5')
                     OR (VIERNES = 'S' AND TO_CHAR (SYSDATE, 'd', 'NLS_DATE_LANGUAGE = american') = '6')
                     OR (SABADO = 'S' AND TO_CHAR (SYSDATE, 'd', 'NLS_DATE_LANGUAGE = american') = '7')
                     OR (DOMINGO = 'S' AND TO_CHAR (SYSDATE, 'd', 'NLS_DATE_LANGUAGE = american') = '1'))
                AND ROWNUM = 1;

      CURSOR cporexpresion
      IS
         SELECT expresion
           FROM OPT_CONSULTA_RESTRICT
          WHERE     id_consulta = pidconsulta
                AND activo = 'S'
                AND expresion IS NOT NULL
                AND ROWNUM = 1;

      fila          VARCHAR2 (500);
      vqueryexp     VARCHAR2 (4000)
         := 'SELECT '''
            || 'Restricción de Ejecución de tipo expresión aplica en este momento!'
            || ''''
            || ' restric '
            || ' FROM OPT_CONSULTA_RESTRICT '
            || ' WHERE id_consulta = :pidconsulta AND activo = '
            || '''S'''
            || '  AND ROWNUM = 1 '
            || '  AND EXISTS(SELECT 1 FROM DUAL WHERE ';
   BEGIN
      restriccion := 'NO';

      FOR reg IN cporfechas
      LOOP
         restriccion := reg.restric;
      END LOOP;

      IF restriccion = 'NO'
      THEN
         FOR reg IN cpordias
         LOOP
            restriccion := reg.restric;
         END LOOP;

         IF restriccion = 'NO'
         THEN
            FOR reg IN cporexpresion
            LOOP
               --DBMS_OUTPUT.put_line (reg.expresion);
               --DBMS_OUTPUT.put_line (vqueryexp || reg.expresion || ')');

               OPEN c_cursor FOR vqueryexp || reg.expresion || ')'
                  USING pidconsulta;

               FETCH c_cursor INTO fila;

               IF c_cursor%FOUND
               THEN
                  restriccion := fila;
                  RETURN restriccion;
               END IF;

               CLOSE c_cursor;
            END LOOP;
         END IF;
      END IF;

      RETURN restriccion;
   EXCEPTION
      WHEN OTHERS
      THEN
         DBMS_OUTPUT.put_line (SQLERRM);
         RETURN 'NO';
   END;

   PROCEDURE getDatabaseInfo (pcursor OUT csGetResultSet)
   IS
      cursordbinfo   csGetResultSet;
   BEGIN
      OPEN cursordbinfo FOR
         SELECT a.*, TO_CHAR (SYSDATE, 'dd-mm-yyyy') fecha_actual
           FROM v$database a;

      pcursor := cursordbinfo;
   END;

   PROCEDURE getORMUsersCount (pcount OUT NUMBER)
   IS
   BEGIN
      SELECT COUNT (UNIQUE username)
        INTO pcount
        FROM v$session
       WHERE UPPER (program) LIKE 'ORM%.EXE';
   END;

   PROCEDURE getParametersProg (pIdConsProg   IN     NUMBER,
                                pcursor          OUT csGetResultSet)
   IS
      parametersinfo   csGetResultSet;
   BEGIN
      OPEN parametersinfo FOR
           SELECT *
             FROM OPT_CONSULTA_PROGS_PARAMS
            WHERE ID_CONS_PROG = pIdConsProg
         ORDER BY SECUENCIA, POSICION;

      pcursor := parametersinfo;
   END;
   
   FUNCTION ValidaEjecConcurrentes (pIDConsulta IN NUMBER)
      RETURN NUMBER
   IS
      Cantidad      NUMBER (4) := 0;
      Autorizado    NUMBER (1) := 0;                                  -- false
      MaxEjecConc   NUMBER (4) := 0;
   BEGIN
      SELECT EJEC_CONCURRENTES
        INTO MaxEjecConc
        FROM OPT_CONSULTA
       WHERE ID_CONSULTA = pIDConsulta;

      IF MaxEjecConc = 0
      THEN
         Autorizado := 1;
      ELSE
         SELECT COUNT (*)
           INTO Cantidad
           FROM v$session
          WHERE module = 'ORM ' || to_char(pIDConsulta);

         IF Cantidad = 0
         THEN
            Autorizado := 1;                                        -- true
         ELSE
            IF Cantidad < MaxEjecConc
            THEN
               Autorizado := 1;
            ELSE
               Autorizado := 0;                                        -- true
            END IF;
         END IF;
      END IF;

      RETURN Autorizado;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;
END ORM_UTILS;
/

CREATE OR REPLACE PUBLIC SYNONYM ORM_UTILS FOR ORM_UTILS;
GRANT EXECUTE ON ORM_UTILS TO ORM_USER_ROLE;