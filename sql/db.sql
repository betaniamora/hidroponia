CREATE DATABASE HIDROPY;
USE HIDROPY;

DROP TABLE IF EXISTS HIDRO_USER;
CREATE TABLE HIDRO_USER(
USER_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL USUARIO',
USER_DESC VARCHAR(50) COMMENT 'NOMBRE COMPLETO DE USUARIO',
USER_LOGI VARCHAR(20) COMMENT 'USUARIO LOGIN',
USER_PASS VARCHAR(200) COMMENT 'CONTRASEÑA DE USUARIO',
USER_DATE_INGR TIMESTAMP DEFAULT 0 COMMENT 'FECHA Y HORA DE INGRESO AL SISTEMA',
USER_DATE_SALI TIMESTAMP DEFAULT 0 COMMENT 'FECHA Y HORA DE SALIDA DEL SISTEMA',
USER_ESTA VARCHAR(1) DEFAULT 'A' COMMENT 'ESTADO DEL USUARIO (ACTIVO-INACTIVO)',
USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
USER_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
USER_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
USER_PERS_CODI INT(10) COMMENT 'FK DE PERSONA ASOCIADA AL USUARIO',
USER_ROLE_CODI INT(10) COMMENT 'FK DE ROLE ASIGNADA AL USUARIO',
PRIMARY KEY (USER_CODI)
);

DROP TABLE IF EXISTS HIDRO_INVE;
CREATE TABLE HIDRO_INVE(
INVE_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL INVERNADERO',
INVE_NAME VARCHAR(50) COMMENT 'NOMBRE DEL INVERNADERO',
INVE_LATI VARCHAR(50) COMMENT 'LATITUD DE UBICACION',
INVE_LONG VARCHAR(50) COMMENT 'LONGITUD DE UBICACION',
INVE_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
INVE_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
INVE_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
INVE_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
INVE_USER_CODI INT(10) COMMENT 'FK USUARIO ASOCIADO AL INVERNADERO',
INVE_CIUD_CODI INT(10) COMMENT 'FK CODIGO DE CIUDAD LOCALIZADO',
PRIMARY KEY (INVE_CODI)
);

DROP TABLE IF EXISTS HIDRO_EQUI;
CREATE TABLE HIDRO_EQUI(
EQUI_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE EQUIPO',
EQUI_MODEL VARCHAR(30) COMMENT 'MODELO DEL EQUIPO',
EQUI_OBSE VARCHAR(100) COMMENT 'OBSERVACION ACERCA DEL EQUIPO',
EQUI_UBIC VARCHAR(30) COMMENT 'UBICACION DEL SENSOR',
EQUI_PIN INT(10) COMMENT 'PIN DEL ARDUINO O RASPBERRY',
EQUI_GPIO INT(10) COMMENT 'GPIO DEL RASPBERRY',
EQUI_ESTA VARCHAR(1) COMMENT 'ESTADO DEL EQUIPO (A=ACTIVO, I=INACTIVO)',
EQUI_FOLD VARCHAR(100) COMMENT 'DIRECCION DE CARPETA GENERADA POR SENSORES EN RASPBERRY',
EQUI_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
EQUI_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
EQUI_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
EQUI_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
EQUI_INVE_CODI INT(10) COMMENT 'FK DE INVERNADERO',
EQUI_TIPO_CODI INT(10) COMMENT 'FK TIPO DE EQUIPO (SENSOR, ACTUADOR, OTROS)',
PRIMARY KEY(EQUI_CODI)
);

DROP TABLE IF EXISTS HIDRO_EQUI_ESTA;
CREATE TABLE HIDRO_EQUI_ESTA(
ESTA_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE ESTADOS DE EQUIPOS',
ESTA_DATE_INI TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA Y HORA DE ACTIVACION DE EQUIPO',
ESTA_DATE_FIN TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA Y HORA DE APAGADO DE EQUIPO',
ESTA_RELE VARCHAR(1) COMMENT 'DIFERENTES ESTADOS QUE PUEDE TENER UN RELE',
ESTA_EQUI_CODI INT(10) COMMENT  'FK HIDRO EQUIPO',
PRIMARY KEY (ESTA_CODI)
);

DROP TABLE IF EXISTS HIDRO_PERS;
CREATE TABLE HIDRO_PERS(
PERS_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE PERSONAS',
PERS_CEDU VARCHAR(20) COMMENT 'IDENTIFICACION NUMERO',
PERS_NAME VARCHAR(100) COMMENT 'NOMBRES DE LA PERSONA',
PERS_LAST VARCHAR(100) COMMENT 'APELLIDOS DE LA PERSONA',
PERS_TELE VARCHAR(20) COMMENT 'TELEFONO',
PERS_DIRE VARCHAR(100) COMMENT 'DIRECCION DOMICILIARIA',
PERS_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
PERS_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
PERS_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
PERS_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
PRIMARY KEY (PERS_CODI)
);

DROP TABLE IF EXISTS HIDRO_USER_ROLE;
CREATE TABLE HIDRO_USER_ROLE(
ROLE_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL ROL DE USUARIO',
ROLE_DESC VARCHAR(100) COMMENT 'DESCRIPCION DE ROL DE USUARIO',
PRIMARY KEY (ROLE_CODI)
);

DROP TABLE IF EXISTS HIDRO_CIUD;
CREATE TABLE HIDRO_CIUD(
CIUD_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE LA CIUDAD',
CIUD_DESC VARCHAR(100) COMMENT 'CIUDAD',
CIUD_DEPT_CODI INT(10) COMMENT 'FK DEL DEPARTAMENTO QUE PERTENECE',
PRIMARY KEY (CIUD_CODI)
);

DROP TABLE IF EXISTS HIDRO_DEPT;
CREATE TABLE HIDRO_DEPT(
DEPT_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE DEPARTAMENTO',
DEPT_DESC VARCHAR(50) COMMENT 'DEPARTAMENTO',
PRIMARY KEY (DEPT_CODI) 
);

DROP TABLE IF EXISTS HIDRO_MODU;
CREATE TABLE HIDRO_MODU(
MODU_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL MODULO',
MODU_DESC VARCHAR(50) COMMENT 'MODULOS (AGUA,CLIMA,INFORMACION)',
PRIMARY KEY (MODU_CODI)
);

DROP TABLE IF EXISTS HIDRO_INVE_MODU;
CREATE TABLE HIDRO_INVE_MODU(
INMO_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL INVE_MODU TABLA DE DETALLE',
INMO_INVE_CODI INT(10) COMMENT 'FK DEL INVERNADERO',
INMO_MODU_CODI INT(10) COMMENT 'FK DEL MODULO',
PRIMARY KEY (INMO_CODI)
);

DROP TABLE IF EXISTS HIDRO_EQUI_TIPO;
CREATE TABLE HIDRO_EQUI_TIPO(
TIPO_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL TIPO DE EQUIPO',
TIPO_DESC VARCHAR(100) COMMENT 'DESCRIPCION DE EQUIPO (TEMPERATURA,HUMEDAD,PH,OTROS)',
TIPO_SENS_ACTU VARCHAR(1) COMMENT 'S=SENSOR, A=ACTUADOR',
TIPO_MEDI_CODI INT(10) COMMENT 'FK DE UNIDAD DE MEDIDA',
TIPO_MODU_CODI INT(10) COMMENT 'FK DEL MODULO',
PRIMARY KEY (TIPO_CODI)
);

DROP TABLE IF EXISTS HIDRO_EQUI_DETA;
CREATE TABLE HIDRO_EQUI_DETA(
DETA_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DETALLE DE LECTURA DE EQUIPOS',
DETA_VALUE_LEID FLOAT(10,4) COMMENT 'VALOR LEIDO EN NUMEROS',
DETA_DATE_LEID TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA Y HORA DE LECTURA',
DETA_EQUI_CODI INT(10) COMMENT 'FK CODIGO DEL EQUIPO',
PRIMARY KEY (DETA_CODI)
);

DROP TABLE IF EXISTS HIDRO_EQUI_CONF;
CREATE TABLE HIDRO_EQUI_CONF(
CONF_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE LA CONFIGURACION DE EQUIPOS',
CONF_TIME_INI TIME COMMENT 'HORA DE INCIO DE EQUIPO',
CONF_TIME_FIN TIME COMMENT 'HORA DE APAGADO DE EQUIPO',
CONF_DURA FLOAT(10,4) COMMENT 'DURACION EN HS',
CONF_ESTA VARCHAR(1) COMMENT 'ESTADO DE LA CONFIGURACION (A=ACTIVO, I=INACTIVO)',
CONF_AUTO_MANU VARCHAR(1) COMMENT 'INDICA SI LA CONFIGURACION ES A=AUTO O M=MANUAL',
CONF_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
CONF_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
CONF_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
CONF_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
CONF_EQUI_CODI INT(10) COMMENT 'FK DE CODIGO DE EQUIPO',
PRIMARY KEY (CONF_CODI)
);

DROP TABLE IF EXISTS HIDRO_METE_INVE;
CREATE TABLE HIDRO_METE_INVE(
METE_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE METEOROLOGIA',
METE_VALUE FLOAT(10,4) COMMENT 'VALOR OBTENIDO SOBRE LA METEOROLOGIA',
METE_TIPO_LECT ENUM('TEMPERATURA','HUMEDAD','LLUVIA','OTROS') COMMENT 'TIPO DE LECTURA METEOROLOGICA',
METE_DATE_LECT TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA Y HORA DE LECTURA',
METE_MEDI_CODI INT COMMENT 'FK DE UNIDAD DE MEDIDA',
METE_INVE_CODI INT COMMENT 'FK DEL INVERNADERO',
PRIMARY KEY (METE_CODI)
);

DROP TABLE IF EXISTS HIDRO_UNID_MEDI;
CREATE TABLE HIDRO_UNID_MEDI(
MEDI_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE LA UNIDAD DE MEDIDA',
MEDI_DESC VARCHAR(20) COMMENT 'ESCRITURA COMPLETA DE LA MEDIDA (KILOS, GRADOS, LITROS, ETC)',
MEDI_DESC_ABRE VARCHAR(5) COMMENT 'ABREVIATURA DE LA MEDIDA',
PRIMARY KEY (MEDI_CODI)
);

DROP TABLE IF EXISTS HIDRO_PLANT;
CREATE TABLE HIDRO_PLANT(                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
PLANT_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE LA PLANTACION',
PLANT_ESTA VARCHAR(1) COMMENT 'DIFERENTES ESTADOS DE LA PLANTACION (S=SEMILLERO, P=PLANTULAS, C=C0SECHAS, OTROS)',
PLANT_OBSE VARCHAR(200) COMMENT 'OBSERVACION ACERCA DE LA PLANTACION',
PLANT_CANT INT(10) COMMENT 'CANTIDAD DE PLANTAS',
PLANT_DATE_INIC TIMESTAMP DEFAULT 0 COMMENT 'FECHA EN QUE INICIA LA NUEVA PLANTACION',
PLANT_DATE_FASE1 TIMESTAMP DEFAULT 0 COMMENT 'FECHA Y HORA DE PRIMERA FASE (SEMILLERO)',
PLANT_DATE_FASE2 TIMESTAMP DEFAULT 0 COMMENT 'FECHA Y HORA DE PRIMER TRANSPLANTE (INTERMEDIO)',
PLANT_DATE_FASE3 TIMESTAMP DEFAULT 0 COMMENT 'FECHA Y HORA DE SEGUNDO TRANSPLANTE (FINAL)',
PLANT_DATE_FASE4 TIMESTAMP DEFAULT 0 COMMENT 'FECHA Y HORA DE COSECHA',
PLANT_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
PLANT_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
PLANT_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
PLANT_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
PLANT_TIPLA_CODI INT(10) COMMENT 'FK TIPO DE PLANTA',
PLANT_INVE_CODI INT(10) COMMENT 'FK DE INVERNADERO',
PRIMARY KEY (PLANT_CODI)
);

DROP TABLE IF EXISTS HIDRO_MATE;
CREATE TABLE HIDRO_MATE(
MATE_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE MATERIALES',
MATE_DESC VARCHAR(100) COMMENT 'DESCRIPCION DEL MATERIAL',
MATE_ESTA VARCHAR(1) COMMENT 'ESTADOS DEL MATERIAL',
MATE_MEDI_CODI INT(10) COMMENT 'FK DE UNIDAD DE MEDIDA',
PRIMARY KEY (MATE_CODI)
);

DROP TABLE IF EXISTS HIDRO_COMP_MATE;
CREATE TABLE HIDRO_COMP_MATE(
COMP_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE COMPRAS REALIZADAS',
COMP_PREC_UNIT FLOAT(10,4) COMMENT 'PRECIO UNITARIO DEL MATERIAL COMPRADO',
COMP_CANT FLOAT(10,4) COMMENT 'CANTIDAD',
COMP_OBSE VARCHAR(200) COMMENT 'OBSERVACION DEL MATERIAL COMPRADO',
COMP_DATE_INGR TIMESTAMP DEFAULT 0 COMMENT 'FECHA Y HORA DE COMPRA, (PUEDE SER UNA FECHA DISTINTA AL ACTUAL)',
COMP_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
COMP_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
COMP_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
COMP_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
COMP_MATE_CODI INT(10) COMMENT 'FK DEL MATERIAL',
PRIMARY KEY (COMP_CODI)
);

DROP TABLE IF EXISTS HIDRO_STOCK_MATE;
CREATE TABLE HIDRO_STOCK_MATE(
STOMA_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL STOCK DE MATERIAL',
STOMA_CANT FLOAT(10,4) COMMENT 'CANTIDAD',
STOMA_MATE_CODI INT(10) COMMENT 'FK DEL CODIGO DE MATERIAL',
PRIMARY KEY (STOMA_CODI)
);

DROP TABLE IF EXISTS HIDRO_TIPO_PLANT;
CREATE TABLE HIDRO_TIPO_PLANT(
TIPLA_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE TIPO DE PLANTA',
TIPLA_DESC VARCHAR(100) COMMENT 'DESCRIPCION DE TIPO DE PLANTA',
TIPLA_OBSE VARCHAR(200) COMMENT 'OBSERVACIONES',
PRIMARY KEY (TIPLA_CODI)
);

DROP TABLE IF EXISTS HIDRO_CONF_PLANT;
CREATE TABLE HIDRO_CONF_PLANT(
CONPLA_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE CONFIGURACION DE PLANTAS',
CONPLA_TEMP ENUM('ALTA','BAJA') COMMENT 'TEMPORADA DEL TIPO DE CULTIVO',
CONPLA_DURA_FASE1 INT(10) COMMENT 'CANTIDAD EN DIAS DE LA DURACION DE LA FASE1 DEL CULTIVO',
CONPLA_DURA_FASE2 INT(10) COMMENT 'CANTIDAD EN DIAS DE LA DURACION DE LA FASE2 DEL CULTIVO',
CONPLA_DURA_FASE3 INT(10) COMMENT 'CANTIDAD EN DIAS DE LA DURACION DE LA FASE3 DEL CULTIVO',
CONPLA_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
CONPLA_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
CONPLA_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
CONPLA_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
CONPLA_TIPLA_CODI INT(10) COMMENT 'FK DEL TIPO DE PLANTACION',
PRIMARY KEY (CONPLA_CODI)
);

DROP TABLE IF EXISTS HIDRO_LOTE_PLANT;
CREATE TABLE HIDRO_LOTE_PLANT(
LOTE_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL LOTE',
LOTE_CANT INT(10) COMMENT 'CANTIDAD DE PLANTAS',
LOTE_NUME INT(10) COMMENT 'NUMERO DE LOTE',
LOTE_ESTA VARCHAR(1) COMMENT 'ESTADO DEL LOTE',
LOTE_OBSE VARCHAR(200) COMMENT 'OBSERVACION DEL LOTE',
LOTE_DATE_ELAB TIMESTAMP DEFAULT 0 COMMENT 'FECHA Y HORA DE ELABORACION',
LOTE_DATE_VENC TIMESTAMP DEFAULT 0 COMMENT 'FECHA Y HORA DE VENCIMIENTO',
LOTE_COST FLOAT(10,4) COMMENT 'COSTO DE PRODUCCION',
LOTE_VENT FLOAT (10,4) COMMENT 'COSTO PARA LA VENTA',
LOTE_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
LOTE_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
LOTE_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
LOTE_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
LOTE_PLANT_CODI INT(10) COMMENT 'FK DE LA PLANTACION',
PRIMARY KEY (LOTE_CODI)
);

DROP TABLE IF EXISTS HIDRO_MATE_PLANT;
CREATE TABLE HIDRO_MATE_PLANT(
MAPLA_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE MATERIALES UTILZADOS EN LA PLANTACION',
MAPLA_CANT FLOAT(10,4) COMMENT 'CANTIDAD DE MATERIAL',
MAPLA_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
MAPLA_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
MAPLA_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
MAPLA_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
MAPLA_MATE_CODI INT(10) COMMENT 'FK DEL MATERIAL',
MAPLA_PLANT_CODI INT(10) COMMENT 'FK DEL LA PLANTACION',
PRIMARY KEY (MAPLA_CODI)
);

DROP TABLE IF EXISTS HIDRO_MOVI_STOCK;
CREATE TABLE HIDRO_MOVI_STOCK(
MOVI_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL MOVIMIENTO',
MOVI_CANT FLOAT(10,4) COMMENT 'CANTIDAD',
MOVI_TIPO VARCHAR(1) COMMENT 'I=INGRESO, E=EGRESO',
MOVI_OBSE VARCHAR(200) COMMENT 'OBSERVACION DEL MOVIMIENTO',
MOVI_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
MOVI_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
MOVI_MATE_CODI INT(10) COMMENT 'FK DEL MATERIAL',
PRIMARY KEY (MOVI_CODI)
);

DROP TABLE IF EXISTS HIDRO_TIPO_COSTO;
CREATE TABLE HIDRO_TIPO_COSTO(
TICO_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DEL TIPO DE COSTO',
TICO_DESC VARCHAR(100) COMMENT 'DESCRIPCION DEL TIPO DE COSTO',
TICO_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
TICO_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
TICO_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
TICO_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
TICO_MEDI_CODI INT(10) COMMENT 'FK DE UNIDAD DE MEDIDA',
PRIMARY KEY (TICO_CODI)
);

DROP TABLE IF EXISTS HIDRO_DATA_COSTO;
CREATE TABLE HIDRO_DATA_COSTO(
DACO_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE DATO DE COSTO',
DACO_PREC FLOAT(10,4) COMMENT 'PRECIO',
DACO_ESTA VARCHAR(1) COMMENT 'A=ACTIVO, I=INACTIVO',
DACO_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
DACO_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
DACO_TICO_CODI INT(10) COMMENT 'FK DE TIPO DE COSTO',
PRIMARY KEY (DACO_CODI)
);

DROP TABLE IF EXISTS HIDRO_CALC_COSTO;
CREATE TABLE HIDRO_CALC_COSTO(
CALC_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE CALCULO DE COSTO',
CALC_CANT FLOAT(10,4) COMMENT 'CANTIDAD',
CALC_TOTA_UNIT FLOAT(10,4) COMMENT 'TOTAL COSTO',
CALC_PERI VARCHAR(10) COMMENT 'PERIODO DE CALCULO EJ= 07/2020',
CALC_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
CALC_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
CALC_TICO_CODI INT(10) COMMENT 'FK DE TIPO DE COSTO',
CALC_PLANT_CODI INT(10) COMMENT 'FK DE PLANTACION',
PRIMARY KEY (CALC_CODI)
);

DROP TABLE IF EXISTS HIDRO_ALERT;
CREATE TABLE HIDRO_ALERT(
ALERT_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE ALERTA',
ALERT_DESC VARCHAR(100) COMMENT 'DESCRIPCION DE LA ALERTA EJ=POTENCIAL GENERACION DE HONGOS EN CULTIVO', 
ALERT_ESTA VARCHAR(1) COMMENT 'ESTADO A=ACTIVO, I=INACTIVO',
ALERT_TIPO ENUM('EQUIPO','CULTIVO','OTROS') COMMENT 'TIPO DE ALERTA',
ALERT_RIES ENUM('ALTA','MEDIA','BAJA') COMMENT 'NIVEL DE RIESGO DE LA ALERTA',
ALERT_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
ALERT_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
ALERT_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
ALERT_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
ALERT_TIPO_CODI INT(10) COMMENT 'FK DE TIPO DE EQUIPO',
PRIMARY KEY (ALERT_CODI)
);

/*DETALLE DE ALERTA A ACTIVARSE EN DISTINTOS INVERNADEROS SELECCIONADOS DE UN CLIENTE*/
DROP TABLE IF EXISTS HIDRO_ALERT_INVE;
CREATE TABLE HIDRO_ALERT_INVE(
ALIN_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE DETALLE DE ALERTA POR INVERNADERO',
ALIN_ALERT_CODI INT(10) COMMENT 'FK DE ALERTA',
ALIN_INVE_CODI INT(10) COMMENT 'FK DE INVERNADERO',
PRIMARY KEY (ALIN_CODI)
);

DROP TABLE IF EXISTS HIDRO_ALERT_DETA;
CREATE TABLE HIDRO_ALERT_DETA(
ALDE_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'CODIGO DE DETALLE DE ALERTA',
ALDE_VALUE FLOAT(10,4) COMMENT 'VALOR QUE ACTIVA LA ALERTA',
ALDE_ESTA VARCHAR(1) COMMENT 'ESTADO DE ALERTA SEGUN EQUIPO',
ALDE_USER_REGI VARCHAR(20) COMMENT 'USUARIO QUE REGISTRA',
ALDE_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO',
ALDE_USER_MODI VARCHAR(20) COMMENT 'USUARIO QUE MODIFICA',
ALDE_DATE_MODI TIMESTAMP DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP COMMENT 'FECHA DE MODIFICACION',
ALDE_ALERT_CODI INT(10) COMMENT 'FK DE ALERTA',
ALDE_EQUI_CODI INT(10) COMMENT 'FK DE EQUIPO',
PRIMARY KEY (ALDE_CODI)
);

DROP TABLE IF EXISTS HIDRO_ALERT_NOTI;
CREATE TABLE HIDRO_ALERT_NOTI(
ALNO_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE NOTIFICACION',
ALNO_MENS VARCHAR(300) COMMENT 'MENSAJE A NOTIFICAR A USUARIOS',
ALNO_ESTA VARCHAR(1) COMMENT 'ESTADO A NOTIFICAR P=PENDIENTE, N=NOTIFICADO',
ALNO_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA DE REGISTRO DE LA NOTIFICACION',
ALNO_ALERT_CODI INT(10) COMMENT 'FK DE ALERTA',
PRIMARY KEY (ALNO_CODI)
);

DROP TABLE IF EXISTS HIDRO_ALERT_CANT;
CREATE TABLE HIDRO_ALERT_CANT(
ALCA_CODI INT(10) NOT NULL AUTO_INCREMENT COMMENT 'PK DE CANTIDAD DE ALERTA',
ALCA_DATE_REGI TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT 'FECHA Y HORA DE REGISTRO DE ALERTA POR DIA EJ=18/04/2020 HUBO 20 COINCIDENCIA DE LA ALERTA',
ALCA_ALERT_CODI INT(10) COMMENT 'FK DE ALERTA ACTIVADA',
PRIMARY KEY (ALCA_CODI)
);


ALTER TABLE HIDRO_USER ADD CONSTRAINT FK_USERPERS FOREIGN KEY (USER_PERS_CODI) REFERENCES HIDRO_PERS(PERS_CODI);
ALTER TABLE HIDRO_USER ADD CONSTRAINT FK_USERROLE FOREIGN KEY (USER_ROLE_CODI) REFERENCES HIDRO_USER_ROLE(ROLE_CODI);

ALTER TABLE HIDRO_INVE ADD CONSTRAINT FK_INVEUSER FOREIGN KEY (INVE_USER_CODI) REFERENCES HIDRO_USER(USER_CODI);
ALTER TABLE HIDRO_INVE ADD CONSTRAINT FK_INVECIUD FOREIGN KEY (INVE_CIUD_CODI) REFERENCES HIDRO_CIUD(CIUD_CODI);

ALTER TABLE HIDRO_EQUI ADD CONSTRAINT FK_EQUIINVE FOREIGN KEY (EQUI_INVE_CODI) REFERENCES HIDRO_INVE(INVE_CODI);
ALTER TABLE HIDRO_EQUI ADD CONSTRAINT FK_EQUITIPO FOREIGN KEY (EQUI_TIPO_CODI) REFERENCES HIDRO_EQUI_TIPO(TIPO_CODI);

ALTER TABLE HIDRO_CIUD ADD CONSTRAINT FK_CIUDDEPT FOREIGN KEY (CIUD_DEPT_CODI) REFERENCES HIDRO_DEPT(DEPT_CODI);

ALTER TABLE HIDRO_INVE_MODU ADD CONSTRAINT FK_INVE FOREIGN KEY (INMO_INVE_CODI) REFERENCES HIDRO_INVE(INVE_CODI);
ALTER TABLE HIDRO_INVE_MODU ADD CONSTRAINT FK_MODU FOREIGN KEY (INMO_MODU_CODI) REFERENCES HIDRO_MODU(MODU_CODI);

ALTER TABLE HIDRO_EQUI_TIPO ADD CONSTRAINT FK_EQUITIPOMEDI FOREIGN KEY (TIPO_MEDI_CODI) REFERENCES HIDRO_UNID_MEDI(MEDI_CODI);
ALTER TABLE HIDRO_EQUI_TIPO ADD CONSTRAINT FK_EQUITIPOMODU FOREIGN KEY (TIPO_MODU_CODI) REFERENCES HIDRO_MODU(MODU_CODI);

ALTER TABLE HIDRO_EQUI_DETA ADD CONSTRAINT FK_EQUIDETAEQUI FOREIGN KEY (DETA_EQUI_CODI) REFERENCES HIDRO_EQUI(EQUI_CODI);

ALTER TABLE HIDRO_EQUI_CONF ADD CONSTRAINT FK_EQUICONFEQUI FOREIGN KEY (CONF_EQUI_CODI) REFERENCES HIDRO_EQUI(EQUI_CODI);

ALTER TABLE HIDRO_METE_INVE ADD CONSTRAINT FK_METEINVEMEDI FOREIGN KEY (METE_MEDI_CODI) REFERENCES HIDRO_UNID_MEDI(MEDI_CODI);
ALTER TABLE HIDRO_METE_INVE ADD CONSTRAINT FK_METEINVE FOREIGN KEY (METE_INVE_CODI) REFERENCES HIDRO_INVE(INVE_CODI);

ALTER TABLE HIDRO_PLANT ADD CONSTRAINT FK_PLANTIPO FOREIGN KEY (PLANT_TIPLA_CODI) REFERENCES HIDRO_TIPO_PLANT(TIPLA_CODI);
ALTER TABLE HIDRO_PLANT ADD CONSTRAINT FK_PLANINVE FOREIGN KEY (PLANT_INVE_CODI) REFERENCES HIDRO_INVE(INVE_CODI);

ALTER TABLE HIDRO_MATE ADD CONSTRAINT FK_MATEMEDI FOREIGN KEY (MATE_MEDI_CODI) REFERENCES HIDRO_UNID_MEDI(MEDI_CODI);

ALTER TABLE HIDRO_COMP_MATE ADD CONSTRAINT FK_MATECOMP FOREIGN KEY (COMP_MATE_CODI) REFERENCES HIDRO_MATE(MATE_CODI);

ALTER TABLE HIDRO_STOCK_MATE ADD CONSTRAINT FK_MATESTOCK FOREIGN KEY (STOMA_MATE_CODI) REFERENCES HIDRO_MATE(MATE_CODI);

ALTER TABLE HIDRO_CONF_PLANT ADD CONSTRAINT FK_CONFPLANTTIPOPLANT FOREIGN KEY (CONPLA_TIPLA_CODI) REFERENCES HIDRO_TIPO_PLANT(TIPLA_CODI);

ALTER TABLE HIDRO_LOTE_PLANT ADD CONSTRAINT FK_PLANTLOTETIPOPLANT FOREIGN KEY (LOTE_PLANT_CODI) REFERENCES HIDRO_PLANT(PLANT_CODI);

ALTER TABLE HIDRO_MATE_PLANT ADD CONSTRAINT FK_PLANTMATE FOREIGN KEY (MAPLA_MATE_CODI) REFERENCES HIDRO_MATE(MATE_CODI);
ALTER TABLE HIDRO_MATE_PLANT ADD CONSTRAINT FK_PLANTMATEPLANT FOREIGN KEY (MAPLA_PLANT_CODI) REFERENCES HIDRO_PLANT(PLANT_CODI);

ALTER TABLE HIDRO_MOVI_STOCK ADD CONSTRAINT FK_MOVIMATE FOREIGN KEY (MOVI_MATE_CODI) REFERENCES HIDRO_MATE(MATE_CODI);

ALTER TABLE HIDRO_TIPO_COSTO ADD CONSTRAINT FK_MOVITIPOCOSTO FOREIGN KEY (TICO_MEDI_CODI) REFERENCES HIDRO_UNID_MEDI(MEDI_CODI);

ALTER TABLE HIDRO_DATA_COSTO ADD CONSTRAINT FK_DATACOSTOTIPOCOSTO FOREIGN KEY (DACO_TICO_CODI) REFERENCES HIDRO_TIPO_COSTO(TICO_CODI);

ALTER TABLE HIDRO_CALC_COSTO ADD CONSTRAINT FK_CALCCOSTOTIPOCOSTO FOREIGN KEY (CALC_TICO_CODI) REFERENCES HIDRO_TIPO_COSTO(TICO_CODI);
ALTER TABLE HIDRO_CALC_COSTO ADD CONSTRAINT FK_CALCCOSTOPLANT FOREIGN KEY (CALC_PLANT_CODI) REFERENCES HIDRO_PLANT(PLANT_CODI);

ALTER TABLE HIDRO_ALERT ADD CONSTRAINT FK_ALERTTIPOEQUI FOREIGN KEY (ALERT_TIPO_CODI) REFERENCES HIDRO_EQUI_TIPO(TIPO_CODI);

ALTER TABLE HIDRO_ALERT_INVE ADD CONSTRAINT FK_INVEALERTHIDROALERT FOREIGN KEY (ALIN_ALERT_CODI) REFERENCES HIDRO_ALERT(ALERT_CODI);
ALTER TABLE HIDRO_ALERT_INVE ADD CONSTRAINT FK_ALERTINVEDETA FOREIGN KEY (ALIN_INVE_CODI) REFERENCES HIDRO_INVE(INVE_CODI);

ALTER TABLE HIDRO_ALERT_DETA ADD CONSTRAINT FK_ALERTDETAALERT FOREIGN KEY (ALDE_ALERT_CODI) REFERENCES HIDRO_ALERT(ALERT_CODI);
ALTER TABLE HIDRO_ALERT_DETA ADD CONSTRAINT FK_ALERTDETAEQUI FOREIGN KEY (ALDE_EQUI_CODI) REFERENCES HIDRO_EQUI(EQUI_CODI);

ALTER TABLE HIDRO_ALERT_NOTI ADD CONSTRAINT FK_ALERTNOTIALERT FOREIGN KEY (ALNO_ALERT_CODI) REFERENCES HIDRO_ALERT(ALERT_CODI);

ALTER TABLE HIDRO_ALERT_CANT ADD CONSTRAINT FK_ALERTCANTALERT FOREIGN KEY (ALCA_ALERT_CODI) REFERENCES HIDRO_ALERT(ALERT_CODI);

ALTER TABLE HIDRO_EQUI_ESTA ADD CONSTRAINT FK_HIDROEQUIESTA FOREIGN KEY (ESTA_CODI) REFERENCES HIDRO_EQUI(EQUI_CODI);
