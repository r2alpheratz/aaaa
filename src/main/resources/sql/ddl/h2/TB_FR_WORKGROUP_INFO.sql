DROP TABLE TB_FR_WORKGROUP_INFO IF EXISTS;
CREATE TABLE TB_FR_WORKGROUP_INFO (
	WORKGROUP_SQ VARCHAR(10) PRIMARY KEY NOT NULL , 
	WORKGROUP_ID VARCHAR(30) ,		
	WORKGROUP_NM VARCHAR(30) ,	 
	DESCRIPTION VARCHAR(2000) ,
	USE_YN VARCHAR(1) NOT NULL,
	CREATE_DT TIMESTAMP DEFAULT NULL ,
	CREATE_USR_ID VARCHAR(20) DEFAULT NULL ,
	UPDATE_DT TIMESTAMP DEFAULT NULL ,
	UPDATE_USR_ID VARCHAR(20) DEFAULT NULL
);