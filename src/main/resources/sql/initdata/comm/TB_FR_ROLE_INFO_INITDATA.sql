
INSERT INTO TB_FR_ROLE_INFO
(
	ROLE_SQ,
	ROLE_ID,
	ROLE_NM,
	DESCRIPTION,
	USE_YN,
	CREATE_DT,
	CREATE_USR_ID,
	UPDATE_DT,
	UPDATE_USR_ID
)
VALUES (
	'ADM_000002',
	'SYSTEM_ADMIN',
	'시스템 관리자',
	'시스템 관리자용 역할로 업무그룹 상관없이 모든 권한 부여',
	'Y',
	NOW(),
	'superadmin',
	NOW(),
	'superadmin'
);

INSERT INTO TB_FR_ROLE_INFO
(
	ROLE_SQ,
	ROLE_ID,
	ROLE_NM,
	DESCRIPTION,
	USE_YN,
	CREATE_DT,
	CREATE_USR_ID,
	UPDATE_DT,
	UPDATE_USR_ID
)
VALUES (
	'ADM_000003',
	'NORMAL_USER',
	'일반사용자',
	'시스템을 사용하는 사용자',
	'Y',
	NOW(),
	'superadmin',
	NOW(),
	'superadmin'
);
