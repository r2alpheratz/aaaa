--수익관리 사용자 조회

SELECT USE_PS_ID, USE_PS_NM
FROM TB_ZZ100
	WHERE USE_PS_ID IN (SELECT DISTINCT USE_PS_ID 
                        FROM TB_YZ970)
AND VALID_USE_PS_FLG = 'Y'