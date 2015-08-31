CREATE TABLE TB_FR_MENU_PAGE_INFO  (
  MENU_PAGE_SQ VARCHAR(10)   PRIMARY KEY  NOT NULL  ,
  MENU_SQ VARCHAR(10) NOT NULL ,
  READ_YN INT DEFAULT 0,
  UPDATE_YN INT DEFAULT 0,
  EXECUTE_YN INT DEFAULT 0,
  PAGE_URL VARCHAR(1000) NOT NULL ,
  DESCRIPTION VARCHAR(100),
  USE_YN VARCHAR(1) NOT NULL ,
  CREATE_USR_ID VARCHAR(20) DEFAULT NULL,
  CREATE_DT DATE DEFAULT NULL,
  UPDATE_USR_ID VARCHAR(20) DEFAULT NULL,
  UPDATE_DT DATE DEFAULT NULL,
    FOREIGN KEY (MENU_SQ)  REFERENCES TB_FR_MENU_INFO(MENU_SQ)
);


