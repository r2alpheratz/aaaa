SELECT ROUT_NM, ROUT_CD
FROM   TB_SZ001
WHERE  ROUT_DV_CD IN ( '10', '30' )
AND    MN_RUN_LN_CD = :AS_LN_CD
ORDER BY ROUT_CD


---------------------------------------------------------

<![CDATA[
		SELECT /*+ com.korail.yz.yb.co.YBCO003QMDAO.selectListRout */
				ROUT_NM, /* 노선명 */
				ROUT_CD /* 노선코드 */
		  FROM TB_YYDK201 /* 노선코드TBL */
		 WHERE ROUT_DV_CD IN ('10', '30')
		   AND MRNT_CD = #LN_CD# /* 주운행선코드 */
		ORDER BY ROUT_CD
]]>
