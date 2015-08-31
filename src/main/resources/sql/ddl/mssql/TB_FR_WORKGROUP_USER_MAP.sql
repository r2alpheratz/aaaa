CREATE TABLE TB_FR_WORKGROUP_USER_MAP (
	WORKGROUP_SQ VARCHAR(10) NOT NULL,
	USER_SQ VARCHAR(10) NOT NULL,
	CREATE_DT DATETIME DEFAULT NULL,
	CREATE_USR_ID VARCHAR(20) DEFAULT NULL,
	UPDATE_DT DATETIME DEFAULT NULL,
	UPDATE_USR_ID VARCHAR(20) DEFAULT NULL,
	PRIMARY KEY (WORKGROUP_SQ, USER_SQ),
	FOREIGN KEY (WORKGROUP_SQ) REFERENCES TB_FR_WORKGROUP_INFO(WORKGROUP_SQ),
	FOREIGN KEY (USER_SQ) REFERENCES TB_FR_USER_INFO(USER_SQ)
);