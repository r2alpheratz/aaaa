CREATE TABLE TB_FR_WORKGROUP_INFO (
	WORKGROUP_SQ VARCHAR(10) PRIMARY KEY NOT NULL ,
	WORKGROUP_ID VARCHAR(30) ,
	WORKGROUP_NM VARCHAR(30) ,
	DESCRIPTION VARCHAR(2000) ,
	USE_YN VARCHAR(1) NOT NULL,
	CREATE_DT DATETIME DEFAULT NULL ,
	CREATE_USR_ID VARCHAR(20) DEFAULT NULL ,
	UPDATE_DT DATETIME DEFAULT NULL ,
	UPDATE_USR_ID VARCHAR(20) DEFAULT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;