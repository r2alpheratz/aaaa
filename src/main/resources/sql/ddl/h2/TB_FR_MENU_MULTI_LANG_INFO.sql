DROP TABLE TB_FR_MENU_MULTI_LANG_INFO IF EXISTS;
CREATE TABLE IF NOT EXISTS TB_FR_MENU_MULTI_LANG_INFO (
  MENU_SQ VARCHAR(10)   NOT NULL  ,
  COUNTRY_CD VARCHAR(2) NOT NULL ,
  MESSAGE_VALUE VARCHAR(50) NOT NULL ,
  CREATE_USR_ID VARCHAR(20) DEFAULT NULL,
  CREATE_DT TIMESTAMP DEFAULT NULL,
  UPDATE_USR_ID VARCHAR(20) DEFAULT NULL,
  UPDATE_DT TIMESTAMP DEFAULT NULL,
     PRIMARY KEY (MENU_SQ, COUNTRY_CD),
    FOREIGN KEY (MENU_SQ) REFERENCES TB_FR_MENU_INFO (MENU_SQ),
    FOREIGN KEY (COUNTRY_CD)   REFERENCES TB_FR_LANGUAGE_INFO (LANGUAGE_ID)
);