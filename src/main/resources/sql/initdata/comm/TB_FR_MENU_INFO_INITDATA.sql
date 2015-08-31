INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000001','MENU', '0',  '' , '0',  '1',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000002','시스템관리', 'ADM_000001',  '' , '1',  '1',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000003','사용자관리', 'ADM_000002',  '' , '2',  '1',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000004','메뉴/권한관리', 'ADM_000002',  '' , '2',  '2',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000010','기타관리', 'ADM_000002',  '' , '2',  '3',  'Y',  'superadmin', NOW() );
INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000008','로그관리', 'ADM_000002',  '' , '2',  '4',  'Y',  'superadmin', NOW() );


INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000017','Samples', 'ADM_000002',  '' , '2',  '5',  'Y',  'superadmin', NOW() );


INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000005','메뉴관리', 'ADM_000004',  'admin/menuMgn' , '3',  '1',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000006','역할관리', 'ADM_000004',  'admin/rolemgn' , '3',  '2',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000007','업무그룹관리', 'ADM_000004',  'admin/workgroupmgn' , '3',  '3',  'Y',  'superadmin', NOW() );


INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000009','접속이력관리', 'ADM_000008',  'admin/logmgn/accesslogmgn' , '3',  '2',  'Y',  'superadmin', NOW() );





INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000011','코드관리', 'ADM_000010',  'admin/codeMgn' , '3',  '1',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000012','작업이력관리', 'ADM_000008',  'admin/logmgn/worklogmgn' , '3',  '3',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000013','사용자관리', 'ADM_000003',  'admin/usermgn' , '3',  '1',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000015','사용자 변경', 'ADM_000010',  'admin/impersonation' , '3',  '2',  'Y',  'superadmin', NOW() );

INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000016','메시지 관리', 'ADM_000010',  'admin/messagemgn' , '3',  '2',  'Y',  'superadmin', NOW() );



INSERT INTO TB_FR_MENU_INFO
( MENU_SQ, MENU_NM, PARENT_MENU_SQ, MENU_URL, MENU_LEVEL_NO,   MENU_ORDER_NO, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000018','ESB메일발송', 'ADM_000017',  'common/esb/sendMailPage' , '3',  '1',  'Y',  'superadmin', NOW() );
