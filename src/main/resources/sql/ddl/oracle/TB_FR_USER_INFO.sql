CREATE TABLE TB_FR_USER_INFO (
  USER_SQ VARCHAR(10) NOT NULL,
  USER_ID VARCHAR(20) NOT NULL,
  USER_NM VARCHAR(50) NOT NULL,
  PASSWORD VARCHAR(128) DEFAULT  NULL,
  EMAIL VARCHAR(100) DEFAULT NULL,
  PW_FAIL_CNT INT  DEFAULT NULL,
  PHONE_NUMBER VARCHAR(18)  DEFAULT NULL,
  RECENT_LOGIN_DT DATE NULL,
  RECENT_LOGIN_IP VARCHAR(30) DEFAULT NULL,
  GRD_CD VARCHAR(10) DEFAULT NULL,
  STATUS_CD VARCHAR(10)  NOT NULL,
  CREATE_DT DATE DEFAULT NULL,
  CREATE_USR_ID VARCHAR(20) NULL,
  UPDATE_DT DATE DEFAULT NULL,
  UPDATE_USR_ID VARCHAR(20)  DEFAULT NULL,
  PW_CHANGE_DT DATE NULL,
  PRIMARY KEY (USER_SQ),
   CONSTRAINT unq_userId UNIQUE (USER_ID),
  FOREIGN KEY (GRD_CD) REFERENCES TB_FR_CODE_INFO(CODE_SQ),
  FOREIGN KEY (STATUS_CD) REFERENCES TB_FR_CODE_INFO(CODE_SQ)
);

