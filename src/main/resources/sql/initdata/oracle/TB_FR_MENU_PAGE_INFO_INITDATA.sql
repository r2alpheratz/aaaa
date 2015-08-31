--메뉴관리
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000001','ADM_000005', 1, 0, 0,  '/admin/menuMgn/viewMenuPopup' , '메뉴 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000002','ADM_000005', 1, 0, 0,  '/admin/menuMgn/searchMenuTreeList' , '메뉴 트리 리스트 불러오기',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000003','ADM_000005', 1, 0, 0,  '/admin/menuMgn/searchMenuInfo' , '메뉴 상세 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000004','ADM_000005', 1, 0, 0,  '/admin/menuMgn/searchMenuInfoLevel' , '메뉴 레벨 상세 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000005','ADM_000005', 0, 1, 0,  '/admin/menuMgn/saveMenuInfo' , '메뉴 저장',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000006','ADM_000005', 0, 1, 0,  '/admin/menuMgn/deleteMenuInfo' , '메뉴 삭제',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000007','ADM_000005', 1, 0, 0,  '/admin/menuPageMgn/searchMenuPageList' , '메뉴 페이지 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000008','ADM_000005', 0, 1, 0,  '/admin/menuPageMgn/saveMenuPageList' , '메뉴 페이지 저장',    'Y',  'superadmin', systimestamp );

--역할 관리
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000009','ADM_000006', 1, 0, 0,  '/admin/rolemgn/searchRoleList' , '역할 관리 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000010','ADM_000006', 0, 1, 0,  '/admin/rolemgn/saveRole' , '역할 저장',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000011','ADM_000006', 0, 1, 0,  '/admin/rolemgn/deleteRole' , '역할 삭제',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000012','ADM_000006', 1, 0, 0,  '/admin/rolemgn/searchRoleWorkgroupList' , '역할/업무그룹 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000013','ADM_000006', 1, 0, 0,  '/admin/rolemgn/searchWorkgroupList' , '업무그룹 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000014','ADM_000006', 0, 1, 0,  '/admin/rolemgn/saveRoleWorkgroup' , '역할/업무그룹 저장',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000015','ADM_000006', 0, 1, 0,  '/admin/rolemgn/deleteRoleWorkgroup' , '역할/업무그룹 삭제',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000016','ADM_000006', 1, 0, 0,  '/admin/rolemgn/searchRoleUserList' , '역할/사용자 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000017','ADM_000006', 0, 1, 0,  '/admin/rolemgn/saveRoleUser' , '역할/사용자 저장',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000018','ADM_000006', 0, 1, 0,  '/admin/rolemgn/deleteRoleUser' , '역할/사용자 삭제',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000019','ADM_000006', 1, 0, 0,  '/admin/rolemgn/searchUserList' , '사용자 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000020','ADM_000006', 1, 0, 0,  '/admin/rolemgn/checkExistedRoleId' , '권한 ID 존재 유무 검사',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000021','ADM_000006', 1, 0, 0,  '/admin/rolemgn/searchRole' , '권한 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000022','ADM_000006', 1, 0, 0,  '/admin/rolemgn/viewRoleAddPopup' , '권한 추가 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000023','ADM_000006', 1, 0, 0,  '/admin/rolemgn/viewRoleUserPopup' , '권한/사용자 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000024','ADM_000006', 1, 0, 0,  '/admin/rolemgn/viewRoleWorkgroupPopup' , '권한/업무그룹 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000025','ADM_000006', 1, 0, 0,  '/admin/rolemgn/viewAddWorkgroupPopup' , '업무그룹 추가 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000026','ADM_000006', 1, 0, 0,  '/admin/rolemgn/viewSelectUserPopup' , '사용자 추가 Popup',    'Y',  'superadmin', systimestamp );

--업무 그룹관리
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000027','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/checkExistedWorkgroupId' , 'workgroup 중복 확인',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000028','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/viewWorkgroupPopup' , 'workgroup Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000029','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/viewWorkgroupUserPopup' , '업무그룹/사용자 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000030','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/viewWorkgroupMenuPopup' , '업무그룹/메뉴 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000031','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/viewWorkgroupRolePopup' , '업무그룹/권한 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000032','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/viewSelectUserPopup' , '업무그룹 내 사용자 추가 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000033','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/viewAddWorkgroupRolePopup' , '업무그룹 내 권한 추가 Popup',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000034','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/searchWorkgroupList' , '업무그룹 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000035','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/searchWorkgroupMenuList' , '업무그룹 내 메뉴 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000036','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/searchWorkgroupUserList' , '업무그룹 내 사용자 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000037','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/searchWorkgroupRoleList' , '업무그룹 내 권한 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000038','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/searchUserList' , '업무그룹에 포함되지 않은 사용자 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000039','ADM_000007', 1, 0, 0,  '/admin/workgroupmgn/searchRoleList' , '업무그룹에 포함되지 않은 권한 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000040','ADM_000007', 0, 1, 0,  '/admin/workgroupmgn/insertWorkgroupMenuList' , '업무그룹 메뉴 리스트 추가',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000041','ADM_000007', 0, 1, 0,  '/admin/workgroupmgn/saveWorkgroup' , '업무그룹 저장',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000042','ADM_000007', 0, 1, 0,  '/admin/workgroupmgn/saveWorkgroupUserList' , '업무그룹 내 사용자 저장',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000043','ADM_000007', 0, 1, 0,  '/admin/workgroupmgn/saveWorkgroupRoleList' , '업무그룹 내 권한 저장',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000044','ADM_000007', 0, 1, 0,  '/admin/workgroupmgn/updateWorkgroupMenuList' , '업무그룹 내 메뉴 저장',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000045','ADM_000007', 0, 1, 0,  '/admin/workgroupmgn/deleteWorkgroup' , '업무그룹 삭제',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000046','ADM_000007', 0, 1, 0,  '/admin/workgroupmgn/deleteWorkgroupMenuList' , '업무그룹 내 메뉴 삭제',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000047','ADM_000007', 0, 1, 0,  '/admin/workgroupmgn/deleteWorkgroupUserList' , '업무그룹 내 사용자 삭제',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000048','ADM_000007', 0, 1, 0,  '/admin/workgroupmgn/deleteWorkgroupRoleList' , '업무그룹 내 권한 삭제',    'Y',  'superadmin', systimestamp );

-- 접속이력 관리
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000049','ADM_000009', 1, 0, 0,  '/admin/logmgn/searchloglist' , '접속이력 관리 리스트 검색',    'Y',  'superadmin', systimestamp );

--코드관리 페이지
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000050','ADM_000011', 1, 0, 0,  '/admin/codeMgn' , '코드 관리 page 호출',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000051','ADM_000011', 1, 0, 0,  '/admin/codeMgn/searchCodeTreeList' , '코드 트리 조회',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000052','ADM_000011', 1, 0, 0,  '/admin/codeMgn/searchCodeInfo' , '코드 상세 조회',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000053','ADM_000011', 0, 1, 0,  '/admin/codeMgn/changedCodeTreeList' , '코드 레벨 변경',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000054','ADM_000011', 0, 1, 0,  '/admin/codeMgn/saveCodeInfo' , '코드 추가/수정',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000055','ADM_000011', 0, 1, 0,  '/admin/codeMgn/deleteCodeInfo' , '코드  삭제',    'Y',  'superadmin', systimestamp );

--작업이력 관리
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000056','ADM_000012', 1, 0, 0,  '/admin/logmgn/searchWorkLogList' , '작업이력 리스트 검색',    'Y',  'superadmin', systimestamp );


--사용자 관리
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000057','ADM_000013', 1, 0, 0,  '/admin/usermgn/searchUserList' , '사용자정보 리스트 조회',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000059','ADM_000013', 0, 1, 0,  '/admin/usermgn/saveUserInfo' , '사용자 수정/입력',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000060','ADM_000013', 0, 1, 0,  '/admin/usermgn/registerUser' , '회원 가입',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000061','ADM_000013', 0, 1, 0,  '/admin/usermgn/deleteUser' , '사용자 삭제',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000062','ADM_000013', 1, 0, 0,  '/admin/usermgn/searchUserInfo' , '사용자정보 조회',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000063','ADM_000013', 1, 0, 0,  '/admin/usermgn/searchUserInfoByUserId' , 'ID에 의한 사용자정보 조회',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000065','ADM_000013', 1, 0, 0,  '/admin/usermgn/checkExistUser' , '사용자 아이디 체크',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000066','ADM_000013', 1, 0, 0,  '/admin/usermgn/viewUserEditPopup' , '사용자 추가 Popup 호출',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000067','ADM_000013', 1, 0, 0,  '/admin/usermgn/viewUserSigninPopup' , '회원가입 Popup 호출',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000069','ADM_000013', 1, 0, 0,  '/admin/usermgn/exportExcel' , '사용자 정보 excel export',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000070','ADM_000013', 1, 0, 0,  '/admin/usermgn/importExcel' , '사용자 정보 excel import',    'Y',  'superadmin', systimestamp );

--사용자 변경
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000071','ADM_000015', 1, 0, 0,  '/admin/impersonation/startImpersonate' , '사용자 변경 시작',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000072','ADM_000015', 1, 0, 0,  '/admin/impersonation/endImpersonate' , '사용자 변경 종료',    'Y',  'superadmin', systimestamp );

--메시지 관리
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000073','ADM_000016', 1, 0, 0,  '/admin/messagemgn/viewMessageAddPopup' , '메시지 추가 popup page',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000074','ADM_000016', 1, 0, 0,  '/admin/messagemgn/searchMessageList' , '메시지 리스트 검색',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000075','ADM_000016', 0, 1, 0,  '/admin/messagemgn/deleteMessage' , '메시지 삭제',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000076','ADM_000016', 1, 0, 0,  '/admin/messagemgn/searchMessageOne' , '메시지 검색',    'Y',  'superadmin', systimestamp );

--ESB 메일 발송
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000077','ADM_000018', 0, 1, 0,  '/common/esb/attachments' , 'ESB 메일 첨부파일',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000078','ADM_000018', 0, 1, 0,  '/common/esb/sendMail' , 'ESB 메일 발송',    'Y',  'superadmin', systimestamp );

-- 추후 추가분
INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000079','ADM_000016', 0, 1, 0,  '/admin/messagemgn/saveMessage' , '메시지 추가/수정 ',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000080','ADM_000013', 0, 1, 0,  '/admin/usermgn/saveMyInfo' , '본인 정보 수정',    'Y',  'superadmin', systimestamp );

INSERT INTO TB_FR_MENU_PAGE_INFO
( MENU_PAGE_SQ, MENU_SQ, READ_YN, UPDATE_YN, EXECUTE_YN, PAGE_URL, DESCRIPTION, USE_YN , CREATE_USR_ID, CREATE_DT)
VALUES ('ADM_000081','ADM_000013', 0, 1, 0,  '/admin/usermgn/saveUserPassword' , 'Password 변경',    'Y',  'superadmin', systimestamp );