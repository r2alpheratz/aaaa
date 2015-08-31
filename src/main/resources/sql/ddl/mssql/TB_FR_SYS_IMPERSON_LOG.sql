CREATE TABLE TB_FR_SYS_IMPERSON_LOG (
  LOG_SQ VARCHAR(20)   PRIMARY KEY  NOT NULL,
  EVENT_IP VARCHAR(45) NOT NULL,
  REAL_USER_ID VARCHAR(20) NOT NULL,
  USER_ID VARCHAR(20) NOT NULL,
  EVENT_DT DATETIME NOT NULL,
  EVENT_CD varchar(10) DEFAULT NULL,
  LOG_MSG VARCHAR(4000) DEFAULT NULL
);

