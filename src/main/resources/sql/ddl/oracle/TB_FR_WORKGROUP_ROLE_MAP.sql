--DROP TABLE   TB_FR_WORKGROUP_ROLE_MAP;
CREATE TABLE TB_FR_WORKGROUP_ROLE_MAP (
  WORKGROUP_SQ VARCHAR(10) NOT NULL,
  ROLE_SQ VARCHAR(10) NOT NULL,
  CREATE_DT DATE NULL,
  CREATE_USR_ID VARCHAR(20) NULL,
  UPDATE_DT DATE NULL,
  UPDATE_USR_ID VARCHAR(20) NULL,
  PRIMARY KEY (WORKGROUP_SQ,ROLE_SQ),
  FOREIGN KEY (WORKGROUP_SQ)
  REFERENCES TB_FR_WORKGROUP_INFO(WORKGROUP_SQ),
  FOREIGN KEY (ROLE_SQ)
  REFERENCES TB_FR_ROLE_INFO(ROLE_SQ)
 );



