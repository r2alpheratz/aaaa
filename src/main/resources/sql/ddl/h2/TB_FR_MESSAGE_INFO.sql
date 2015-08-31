DROP TABLE TB_FR_MESSAGE_INFO IF EXISTS;
CREATE TABLE IF NOT EXISTS TB_FR_MESSAGE_INFO (
  MESSAGE_KEY VARCHAR(100)   PRIMARY KEY  NOT NULL  ,
  LARGE_CATEGORY VARCHAR(5) NOT NULL ,
  MEDIUM_CATEGORY VARCHAR(5) NOT NULL ,
  SMALL_CATEGORY VARCHAR(5) NOT NULL ,
  MESSAGE_VALUE  VARCHAR(300) NOT NULL ,
  CREATE_USR_ID VARCHAR(20) DEFAULT NULL,
  CREATE_DT TIMESTAMP DEFAULT NULL,
  UPDATE_USR_ID VARCHAR(20) DEFAULT NULL,
  UPDATE_DT TIMESTAMP DEFAULT NULL
);