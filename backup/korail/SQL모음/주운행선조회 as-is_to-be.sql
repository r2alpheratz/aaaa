select ln_nm, ln_cd from tb_oz104
where ln_cd in ( select distinct mn_run_ln_cd from tb_sz001 where rout_dv_cd in ( '10', '30' ) )
  /*and apl_st_dt <= TO_CHAR( sysdate, 'yyyymmdd' ) */
  /*and apl_cls_dt >= TO_CHAR( sysdate, 'yyyymmdd' )*/
order by ln_cd


------------------------------------------------

<![CDATA[
		SELECT /*+ com.korail.yz.yb.co.YBCO003QMDAO.selectListMrmt */
		        LN_NM,    	/* 선명 */
		        LN_CD 		/* 선코드 */
		  FROM TB_YYDK103   /* 선코드이력TBL */
		 WHERE LN_CD IN ( SELECT DISTINCT MRNT_CD
		                    FROM TB_YYDK201    /* 노선코드TBL */
		               	   WHERE ROUT_DV_CD IN ('10','30') ) 
		ORDER BY LN_CD
]]>



