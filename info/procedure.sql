DROP PROCEDURE IF EXISTS PA_DEVU_LOGIN;
DELIMITER $$
CREATE OR REPLACE PROCEDURE PA_DEVU_LOGIN(
    IN  P_LOGIN VARCHAR(11), 
    IN  P_PASS VARCHAR(20), 
    OUT P_CODI_RESP INT(5),
    OUT P_DESC_RESP VARCHAR(50))
BEGIN
    DECLARE V_LOGIN VARCHAR(20) DEFAULT NULL;
    DECLARE V_PASS VARCHAR(50) DEFAULT NULL;
    DECLARE V_PASS1 VARCHAR(50) DEFAULT NULL;
    DECLARE V_CODI INT(10) DEFAULT NULL;

    SELECT USER_LOGI, USER_PASS, USER_CODI 
    INTO V_LOGIN, V_PASS, V_CODI
    FROM HIDRO_USER 
    WHERE TRIM(UPPER(USER_LOGI)) = TRIM(UPPER(P_LOGIN));

    IF V_LOGIN IS NOT NULL THEN
	SELECT SHA(TRIM(P_PASS)) INTO V_PASS1;
      IF V_PASS = V_PASS1 THEN
        SET P_CODI_RESP = 1;
	SET P_DESC_RESP = 'Datos correctos';

	SELECT USER_CODI, 
	IFNULL(USER_DESC, PERS_NAME||' '||PERS_LAST) USER_DESC, 
	INVE_CODI,
	INVE_NAME,
	MODU_CODI,
	MODU_DESC
	FROM HIDRO_USER U, 
	     HIDRO_PERS P,
	     HIDRO_INVE I,
	     HIDRO_MODU M, 
	     HIDRO_INVE_MODU IM
	WHERE U.USER_PERS_CODI = P.PERS_CODI
	AND   I.INVE_USER_CODI = U.USER_CODI
	AND   I.INVE_CODI = IM.INMO_INVE_CODI
	AND   M.MODU_CODI = IM.INMO_MODU_CODI
        AND USER_CODI = V_CODI;
      ELSE
	SET P_CODI_RESP = 2;
	SET P_DESC_RESP = 'Datos incorrectos';
      END IF;
    ELSE
        SET P_CODI_RESP = 2;
	SET P_DESC_RESP = 'Datos incorrectos';
    END IF;

END$$


------------------------------------------------

CALL PA_DEVU_LOGIN('RPORTILLO','12345678', @CODI_RESP, @DESC_RESP);

SELECT @CODI_RESP CODI, @DESC_RESP RESP;

----------------------------------------------------
--Dashboard
DROP PROCEDURE IF EXISTS PA_DEVU_DATA_MODU;
DELIMITER $$
CREATE OR REPLACE PROCEDURE PA_DEVU_DATA_MODU(
    IN  P_INVE_CODI INT(10),
    OUT P_CODI_RESP INT(5),
    OUT P_DESC_RESP VARCHAR(50))
BEGIN
    DECLARE V_COUNT INT(10) DEFAULT NULL;

    SELECT COUNT(*) INTO V_COUNT FROM V_DATA_SENS WHERE EQUI_INVE_CODI = P_INVE_CODI;

    IF V_COUNT = 0 THEN
	SET P_CODI_RESP = 2;
	SET P_DESC_RESP = 'No hay datos';
    ELSE
        SELECT * FROM V_DATA_SENS WHERE EQUI_INVE_CODI = P_INVE_CODI;
        SET P_CODI_RESP = 1;
	SET P_DESC_RESP = 'Datos correctos';
    END IF;

END$$


CALL PA_DEVU_DATA_MODU(2, @CODI_RESP, @DESC_RESP);

SELECT @CODI_RESP CODI, @DESC_RESP RESP;


DROP PROCEDURE IF EXISTS PA_DEVU_DATA_MODU_DAY;
DELIMITER $$
CREATE OR REPLACE PROCEDURE PA_DEVU_DATA_MODU_DAY(
    IN  P_DAY INT(10), 
    IN  P_MODU_CODI INT(10), 
    IN  P_INVE_CODI INT(10), 

    OUT P_CODI_RESP INT(5),
    OUT P_DESC_RESP VARCHAR(50))
BEGIN
    DECLARE V_COUNT INT(10) DEFAULT NULL;

    SELECT COUNT(*) INTO V_COUNT FROM V_DATA_SENS_FULL WHERE EQUI_INVE_CODI = P_INVE_CODI;

    IF V_COUNT = 0 THEN
	SET P_CODI_RESP = 2;
	SET P_DESC_RESP = 'No hay datos del invernadero';
    ELSE
        SELECT MODU_DESC, TIPO_CODI, 
	       TIPO_DESC, EQUI_MODEL, 
	       AVG(DETA_VALUE_LEID) DETA_VALUE_LEID, 
	       MEDI_DESC_ABRE, HOUR(DETA_DATE_LEID) DETA_DATE_LEID, 
	       EQUI_INVE_CODI
	FROM V_DATA_SENS_FULL 
	WHERE DETA_DATE_LEID >= NOW() - INTERVAL P_DAY DAY
	AND MODU_CODI = P_MODU_CODI
	AND EQUI_INVE_CODI = P_INVE_CODI
	GROUP BY TIPO_CODI;

        SET P_CODI_RESP = 1;
	SET P_DESC_RESP = 'Datos correctos';
    END IF;

END$$

CALL PA_DEVU_DATA_MODU_DAY(1, 2, 2, @CODI_RESP, @DESC_RESP);

SELECT @CODI_RESP CODI, @DESC_RESP RESP;




DROP PROCEDURE IF EXISTS PA_DEVU_DATA_MODU_WEEK;
DELIMITER $$
CREATE OR REPLACE PROCEDURE PA_DEVU_DATA_MODU_WEEK(
    IN  P_MODU_CODI INT(10), 
    IN  P_INVE_CODI INT(10), 

    OUT P_CODI_RESP INT(5),
    OUT P_DESC_RESP VARCHAR(50))
BEGIN
    DECLARE V_COUNT INT(10) DEFAULT NULL;

    SELECT COUNT(*) INTO V_COUNT FROM V_DATA_SENS_FULL WHERE EQUI_INVE_CODI = P_INVE_CODI;

    IF V_COUNT = 0 THEN
	SET P_CODI_RESP = 2;
	SET P_DESC_RESP = 'No hay datos del invernadero';
    ELSE
        SELECT MODU_DESC, TIPO_CODI, 
	       TIPO_DESC, EQUI_MODEL, 
	       ROUND(AVG(DETA_VALUE_LEID),2) DETA_VALUE_LEID, 
	       MEDI_DESC_ABRE, DATE_FORMAT(DETA_DATE_LEID, '%d/%m/%y') DETA_DATE_LEID, 
	       EQUI_INVE_CODI
	FROM V_DATA_SENS_FULL 
	WHERE DETA_DATE_LEID >= NOW() - INTERVAL 7 DAY
	AND MODU_CODI = P_MODU_CODI
	AND EQUI_INVE_CODI = P_INVE_CODI
	GROUP BY TIPO_CODI, DAY(DETA_DATE_LEID);

        SET P_CODI_RESP = 1;
	SET P_DESC_RESP = 'Datos correctos';
    END IF;

END$$

CALL PA_DEVU_DATA_MODU_WEEK(2, 2, @CODI_RESP, @DESC_RESP);

SELECT @CODI_RESP CODI, @DESC_RESP RESP;

-----------COSECHAS-------------------
DROP PROCEDURE IF EXISTS PA_ABM_PLANT;
DELIMITER $$
CREATE OR REPLACE PROCEDURE PA_ABM_PLANT(
    IN  P_EVEN VARCHAR(1), 
    IN  P_ESTA VARCHAR(1),
    IN  P_OBSE VARCHAR(1000),
    IN  P_FECH_INIC VARCHAR(12),
    IN  P_USER VARCHAR(20),
    IN  P_CONF_PLANT INT(10),
    IN  P_PLANT_CODI INT(10),

    OUT P_CODI_RESP INT(5),
    OUT P_DESC_RESP VARCHAR(50))
BEGIN
    DECLARE V_FASE1 INT(10) DEFAULT NULL;
    DECLARE V_FASE2 INT(10) DEFAULT NULL;
    DECLARE V_FASE3 INT(10) DEFAULT NULL;

    SELECT CONPLA_DURA_FASE1, CONPLA_DURA_FASE2, CONPLA_DURA_FASE3 
    INTO V_FASE1, V_FASE2, V_FASE3
    FROM HIDRO_CONF_PLANT 
    WHERE CONPLA_CODI = P_CONF_PLANT;


    IF P_EVEN = 'I' THEN
      IF V_FASE1 IS NULL OR V_FASE2 IS NULL OR V_FASE3 IS NULL THEN
	 SET P_CODI_RESP = -1;
         SET P_DESC_RESP = 'Configuración inexistente';
      ELSE
	INSERT INTO hidro_plant 
	(PLANT_ESTA, 
        PLANT_OBSE, 
        PLANT_DATE_INIC, 
	PLANT_DATE_FASE1, 
	PLANT_DATE_FASE2, 
	PLANT_DATE_FASE3, 
	PLANT_DATE_FASE4, 
	PLANT_USER_REGI, 
	PLANT_DATE_REGI, 
	PLANT_USER_MODI, 
	PLANT_DATE_MODI, 
	PLANT_TIPLA_CODI, 
	PLANT_CONPLA_CODI
	)
	values
	(P_ESTA,
        P_OBSE, 
        NOW(), 
	STR_TO_DATE(P_FECH_INIC, '%d-%m-%Y'), 
	DATE_ADD(STR_TO_DATE(P_FECH_INIC, '%d-%m-%Y'), INTERVAL V_FASE1 DAY), 
	DATE_ADD(STR_TO_DATE(P_FECH_INIC, '%d-%m-%Y'), INTERVAL V_FASE1 + V_FASE2 DAY), 
	DATE_ADD(STR_TO_DATE(P_FECH_INIC, '%d-%m-%Y'), INTERVAL V_FASE1 + V_FASE2 + V_FASE3 DAY), 
	P_USER, 
	NOW(), 
	NULL, 
	NULL, 
	P_CONF_PLANT, 
	NULL
	);
     SET P_CODI_RESP = 1;
     SET P_DESC_RESP = 'Dato insertado ';
    END IF;

    ELSEIF P_EVEN = 'U' THEN
      UPDATE HIDRO_PLANT SET
      PLANT_ESTA = P_ESTA,
      PLANT_OBSE = P_OBSE,
      PLANT_USER_MODI = P_USER,
      PLANT_DATE_MODI = NOW()
      WHERE PLANT_CODI = P_PLANT_CODI;
     SET P_CODI_RESP = 1;
     SET P_DESC_RESP = 'Dato actualizado';

    ELSE
     SET P_CODI_RESP = -1;
     SET P_DESC_RESP = 'Datos incorrectos';

    END IF;

END$$

CALL PA_ABM_PLANT('I', 'S', 'PRIMERA COSECHA', 210, '07-06-2020', 'RPORTILLO', 1, 1, 2, @CODI_RESP, @DESC_RESP);
SELECT @CODI_RESP CODI, @DESC_RESP RESP;


-------------VIEW
CREATE OR REPLACE VIEW V_DATA_SENS AS
SELECT  M.MODU_CODI, 
	M.MODU_DESC, 
	TIPO_CODI, 
	TIPO_DESC, 
	EQUI_CODI, 
	EQUI_MODEL, 
	EQUI_UBIC, 
	DETA_VALUE_LEID,
	MEDI_DESC,
	MEDI_DESC_ABRE,
	DETA_DATE_LEID,
	EQUI_INVE_CODI
FROM HIDRO_EQUI E,
     (SELECT DETA_CODI,
	     DETA_EQUI_CODI,
	     DETA_VALUE_LEID, 
             DETA_DATE_LEID
      FROM HIDRO_EQUI_DETA 
      WHERE DETA_CODI IN
       (SELECT MAX(DETA_CODI) 
	FROM HIDRO_EQUI_DETA 
	GROUP BY DETA_EQUI_CODI)) ED,
     HIDRO_EQUI_TIPO ET,
     HIDRO_UNID_MEDI UM,
     HIDRO_MODU M
WHERE E.EQUI_CODI = ED.DETA_EQUI_CODI 
AND   E.EQUI_TIPO_CODI = ET.TIPO_CODI 
AND   ET.TIPO_MEDI_CODI = UM.MEDI_CODI
AND   ET.TIPO_MODU_CODI =  M.MODU_CODI
AND   E.EQUI_ESTA = 'A'
AND   ET.TIPO_SENS_ACTU = 'S';




CREATE OR REPLACE VIEW V_DATA_SENS_FULL AS
SELECT  M.MODU_CODI, 
	M.MODU_DESC, 
	TIPO_CODI, 
	TIPO_DESC, 
	EQUI_CODI, 
	EQUI_MODEL, 
	EQUI_UBIC, 
	DETA_VALUE_LEID,
	MEDI_DESC,
	MEDI_DESC_ABRE,
	DETA_DATE_LEID,
	EQUI_INVE_CODI
FROM HIDRO_EQUI E,
     HIDRO_EQUI_DETA ED,
     HIDRO_EQUI_TIPO ET,
     HIDRO_UNID_MEDI UM,
     HIDRO_MODU M
WHERE E.EQUI_CODI = ED.DETA_EQUI_CODI 
AND   E.EQUI_TIPO_CODI = ET.TIPO_CODI 
AND   ET.TIPO_MEDI_CODI = UM.MEDI_CODI
AND   ET.TIPO_MODU_CODI =  M.MODU_CODI
AND   E.EQUI_ESTA = 'A'
AND   ET.TIPO_SENS_ACTU = 'S'