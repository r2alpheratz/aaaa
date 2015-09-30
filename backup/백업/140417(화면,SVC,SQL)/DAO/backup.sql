SET DEFINE OFF;
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.comm.COMMQMDAO.listMenuLst', '/*com.korail.yz.comm.COMMQMDAO.listMenuLst*/ 
<![CDATA[
	SELECT /*+ com.korail.yz.comm.COMMQMDAO.listMenuLst */
           TRVL_MENU_ID,
           MENU_NM,
           LVL_NUM,
           HRNK_TRVL_MENU_ID,
           TRVL_SCN_ID,
           SCN_NM,
           TRVL_SCN_URL_ADR,
           MENU_GP_CD,
           RN,
           ''0'' AS MYPG_REG_FLG
      FROM (           SELECT A.TRVL_MENU_ID,
                              A.MENU_NM,
                              A.LVL_NUM,
                              A.HRNK_TRVL_MENU_ID,
                              B.TRVL_SCN_ID,
                              B.SCN_NM,
                              B.TRVL_SCN_URL_ADR,
                              DECODE (CONNECT_BY_ISLEAF,  0, ''01'',  1, ''02'') AS MENU_GP_CD,
                              ROWNUM RN
                         FROM TB_YYBB011 A, TB_YYBB012 B
                        WHERE     A.TRVL_SCN_ID = B.TRVL_SCN_ID(+)
                              AND A.TRVL_MENU_ID LIKE ''MY%''
                              AND (   ''tu0001'' IS NULL
                                   OR EXISTS
                                         (SELECT ''1''
                                            FROM TB_YYBR008 S1, TB_YYBR010 S2
                                           WHERE     S1.TRVL_USR_ID = ''tu0001''
                                                 AND S1.ROLE_ID = S2.ROLE_ID
                                                 AND S2.TRVL_MENU_ID = A.TRVL_MENU_ID))
                   CONNECT BY PRIOR TRVL_MENU_ID = HRNK_TRVL_MENU_ID
                   START WITH LVL_NUM = ''0''
            ORDER SIBLINGS BY SORT_ORDR)
     WHERE RN > NVL (0, 0)
]]>
', TO_DATE('04/13/2014 21:48:27', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.comm.COMMQMDAO.selectListYmgtCgPs', '/*com.korail.yz.comm.COMMQMDAO.selectListYmgtCgPs*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.comm.COMMQMDAO.selectListYmgtCgPs */
			   TRVL_USR_ID AS TRVL_USR_ID 	/* 여객사용자ID 	*/
			  ,TRVL_USR_NM AS TRVL_USR_NM 	/* 여객사용자명 	*/
		  FROM TB_YYBB007 					/* 사용자기본TBL 	*/
		 WHERE TRVL_USR_ID IN ( SELECT DISTINCT USR_ID 	/* 사용자ID 				*/
								  FROM TB_YYFD007 		/* 담당그룹별사용자내역TBL 	*/
								)
		   AND VLID_USR_FLG = ''Y'' 			/* 유효사용자여부 */
		ORDER BY TRVL_USR_ID
]]>
', TO_DATE('04/13/2014 21:48:27', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.comm.COMMQMDAO.selectListYr', '/*com.korail.yz.comm.COMMQMDAO.selectListYr*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.comm.COMMQMDAO.selectListYr */
			   DISTINCT SUBSTR(RUN_DT,1,4) AS YR	/* 열차 운행 연도 	*/
 		  FROM TB_YYDK002							/* 카렌다 내역 	*/
 	  ORDER BY 1									/* 오름차순 		*/
]]>
', TO_DATE('04/13/2014 21:48:27', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.comm.COMMQMDAO.selectNonNmlTrnFlg', '/*com.korail.yz.comm.COMMQMDAO.selectNonNmlTrnFlg*/ 
<![CDATA[
		SELECT DECODE(A.NON_NML_TRN_FLG, ''Y'', ''Y'', ''N'') AS NON_NML_TRN_FLG
	      FROM TB_YYFD011 A
	     WHERE A.RUN_DT = #RUN_DT#
	       AND A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
	       AND A.REG_DTTM = ( SELECT MAX(REG_DTTM)
                                FROM TB_YYFD011
                               WHERE RUN_DT = A.RUN_DT
                                 AND TRN_NO = A.TRN_NO )
]]>
', TO_DATE('04/13/2014 21:48:27', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.comm.COMMQMDAO.selectStgpDegr', '/*com.korail.yz.comm.COMMQMDAO.selectStgpDegr*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.comm.COMMQMDAO.selectStgpDegr */
				STGP_DEGR /* 역그룹차수 */
		  FROM TB_YYFB001
		 WHERE APL_ST_DT  <= TO_CHAR( SYSDATE, ''YYYYMMDD'' )
		   AND APL_CLS_DT >= TO_CHAR( SYSDATE, ''YYYYMMDD'' )
]]>
', TO_DATE('04/13/2014 21:48:27', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.comm.COMMQMDAO.selectUserInfo', '/*com.korail.yz.comm.COMMQMDAO.selectUserInfo*/ 
<![CDATA[
		SELECT #TRVL_USR_ID# AS TRVL_USR_ID 
		     , #TRVL_USR_ID# AS TRVL_USR_NM 
		     , '''' AS WCT_NO 
		     , '''' AS TRN_OPR_BZ_DV_CD
		     , '''' AS STN_CD 
		     , '''' AS BLG_CD 
		  FROM dual
]]>
', TO_DATE('04/13/2014 21:48:27', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.aa.YBAA001QMDAO.selectListDtlCd', '/*com.korail.yz.yb.aa.YBAA001QMDAO.selectListDtlCd*/ 
<![CDATA[
  SELECT /*+ com.korail.yz.yb.aa.YBAA001QMDAO.selectListDtlCd */
           VLID_VAL                                                     /*유효값 */
         , VLID_VAL_NM                                                /* 유효값명*/
         , VLID_VAL_KOR_AVVR_NM                                  /*유효값 한글약어식명*/
         , VLID_VAL_ENGM_NM                                       /*유효값 영문명 */
         , VLID_VAL_ENGM_FOML_NM                                 /*유효값 영문정식명 */
         , (SELECT TRVL_USR_NM
             FROM TB_YYBB007
            WHERE TRVL_USR_ID = CHG_USR_ID AND VLID_USR_FLG = ''Y''
		   ) AS TRVL_USR_NM                                           /*변경자 */
         , SUBSTR (CHG_DTTM, 1, 8) AS CHG_DTTM                        /* 변경 일시*/
    FROM TB_YYDK007
   WHERE XROIS_OLD_SRT_CD = #XROIS_OLD_SRT_CD#
ORDER BY XROIS_OLD_SRT_CD
]]>
', TO_DATE('04/01/2014 10:42:08', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.aa.YBAA001QMDAO.selectListSrtCd', '/*com.korail.yz.yb.aa.YBAA001QMDAO.selectListSrtCd*/ 
<![CDATA[
SELECT /*+ com.korail.yz.yb.aa.YBAA001QMDAO.selectListSrtCd */
	     T1.XROIS_SRT_CD                           /* SR코드     */
	   , T1.XROIS_OLD_SRT_CD       			       /* 구SR    */
	   , T1.DOMN_NM 		        		       /* 코드명     */
	   , COUNT(T2.VLID_VAL) AS VLID_VAL_NUM        /* 유효값 수 */
FROM  TB_YYDK006 T1
	, TB_YYDK007 T2
WHERE  T1.XROIS_OLD_SRT_CD = T2.XROIS_OLD_SRT_CD
        AND T1.DOMN_NM LIKE ''%''|| #DOMN_NM# ||''%'' 
GROUP BY  T1.XROIS_SRT_CD
		, T1.XROIS_OLD_SRT_CD
		, T1.DOMN_NM
ORDER BY T1.DOMN_NM ASC

]]>
', TO_DATE('04/01/2014 10:42:08', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.ab.YBAB001QMDAO.deleteMsgCdDel', '/*com.korail.yz.yb.ab.YBAB001QMDAO.deleteMsgCdDel*/ 
<![CDATA[ 
DELETE FROM TB_YYFC014 /*+ com.korail.yz.yb.ab.YBAB001QMDAO.updateMsgCdMdfy */
WHERE INTG_MSG_CD = #INTG_MSG_CD# /*전달된 메시지코드가 동일하면 삭제*/
]]>
', TO_DATE('04/11/2014 13:43:22', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.ab.YBAB001QMDAO.insertMsgCdReg', '/*com.korail.yz.yb.ab.YBAB001QMDAO.insertMsgCdReg*/ 
<![CDATA[
INSERT /*+ com.korail.yz.yb.ab.YBAB001QMDAO.insertMsgCdReg */
		 INTO TB_YYFC014  (INTG_MSG_CD				/*메시지코드*/
                         , INTG_MSG_BODY_CONT		/*메시지본문*/
                         , MSR_MTD_CONT				/*조치방법*/
                         , BTN_TP_CD				/*버튼유형코드*/
                         , REG_USR_ID				/*등록자*/
                         , REG_DTTM					/*등록일시*/
                         , CHG_USR_ID				/*변경자*/
                         , CHG_DTTM)				/*변경일시*/       
        VALUES (
          #INTG_MSG_CD#
        , #INTG_MSG_BODY_CONT#
        , #MSR_MTD_CONT#
        , #BTN_TP_CD#
        , #USR_ID#
        , TO_CHAR(SYSDATE,''YYYYMMDDHH24MMSS'')
        , #USR_ID#
        , TO_CHAR(SYSDATE,''YYYYMMDDHH24MMSS'')
        )
]]>
', TO_DATE('04/11/2014 13:43:22', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.ab.YBAB001QMDAO.selectCdMaxVal', '/*com.korail.yz.yb.ab.YBAB001QMDAO.selectCdMaxVal*/ 
<![CDATA[
SELECT /*+ com.korail.yz.yb.ab.YBAB001QMDAO.selectCdMaxVal */
	   #msgSrt# || NVL((LPAD(TO_NUMBER(SUBSTR(MAX(INTG_MSG_CD),4,6))+1,6,0)),(LPAD(1,6,0))) /*입력된 코드의 앞 3자리를 바탕으로 6자리중 최대 값+1을 SELECT*/
	   AS INTG_MSG_CD
  FROM TB_YYFC014 
 WHERE INTG_MSG_CD LIKE #msgSrt# || ''%''
]]>
', TO_DATE('04/11/2014 13:43:22', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.ab.YBAB001QMDAO.selectMsgCdQry', '/*com.korail.yz.yb.ab.YBAB001QMDAO.selectMsgCdQry*/ 
<![CDATA[
SELECT /*+ com.korail.yz.yb.ab.YBAB001QMDAO.selectMsgCdQry */
	    INTG_MSG_CD								/*메시지코드*/
      , INTG_MSG_BODY_CONT						/*메세지 본문*/
      , MSR_MTD_CONT							/*조치방법*/
	  , BTN_TP_CD								/*버튼유형코드*/
      , NVL(VLID_VAL_NM,''없음'') AS VLID_VAL_NM	/*버튼유형이름*/
      , CHG_USR_ID								/*변경자*/
      , CHG_DTTM		/*변경일시*/
  FROM    TB_YYFC014 T1
        LEFT OUTER JOIN
           (SELECT  VLID_VAL				/*(버튼유형)코드*/
				  , VLID_VAL_NM				/*(버튼유형)이름*/
              FROM TB_YYDK007
             WHERE XROIS_OLD_SRT_CD = ''D018'') T2 				/*공통코드테이블에서 코드가 D018(버튼유형코드)인 테이블을 왼쪽외부조인*/
        ON T1.BTN_TP_CD = T2.VLID_VAL 							/*통합메시지 테이블에서 버튼유형코드와 동일한 코드값을 갖는 경우에 한함.*/
 WHERE  T1.INTG_MSG_CD LIKE #MSG_TP_CD# || #DUTY_DV_NM# || ''%''
]]>', TO_DATE('04/11/2014 13:43:22', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.ab.YBAB001QMDAO.updateMsgCdMdfy', '/*com.korail.yz.yb.ab.YBAB001QMDAO.updateMsgCdMdfy*/ 
<![CDATA[
UPDATE /*+ com.korail.yz.yb.ab.YBAB001QMDAO.updateMsgCdMdfy */
	    TB_YYFC014 
   SET  INTG_MSG_BODY_CONT = #INTG_MSG_BODY_CONT#			/*메시지본문*/
      , MSR_MTD_CONT = #MSR_MTD_CONT#						/*조치방법*/
      , BTN_TP_CD = #BTN_TP_CD#								/*버튼유형코드*/
      , CHG_USR_ID = #USR_ID#								/*변경자*/
      , CHG_DTTM = TO_CHAR (SYSDATE, ''YYYYMMDDHH24MMSS'')	/*변경일시*/
 WHERE  INTG_MSG_CD = #INTG_MSG_CD#							/*메시지코드*/
]]>
', TO_DATE('04/11/2014 13:43:22', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNo', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNo*/ 
<![CDATA[
/*일단 기본열차 조회.인데 수익관리 대상열차가 지금은 ktx로 한정되어있으니까 임시로 ktx 열차번호만 조회되도록 막는다. 허허*/
SELECT   TRN_NO
FROM     TB_YYDK301
WHERE    (#TRN_NO# IS NULL OR TRN_NO LIKE LPAD( #TRN_NO#, 5, ''0'') )
AND 	 STLB_TRN_CLSF_CD IN (''00'', ''07'')
GROUP BY TRN_NO
ORDER BY TRN_NO ASC
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoAutoSetCondData', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoAutoSetCondData*/ 
<![CDATA[
/*일단 기본열차 조회.인데 수익관리 대상열차가 지금은 ktx로 한정되어있으니까 임시로 ktx 열차번호만 조회되도록 막는다. 허허*/
SELECT   DISTINCT TRN_NO, UP_DN_DV_CD, YMS_APL_FLG
FROM     TB_YYDK301
WHERE    (#TRN_NO# IS NULL OR TRN_NO LIKE LPAD( #TRN_NO#, 5, ''0'') )
AND 	 STLB_TRN_CLSF_CD IN (''00'', ''07'')
ORDER BY TRN_NO ASC
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA003', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA003*/ 
<![CDATA[
/*일단 걸려있는 인덱스를 제거하고 진행*/
    SELECT DISTINCT B.TRN_NO
    FROM   TB_YYFD011 A
           , TB_YYDP503 B
    WHERE  B.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
    AND    (#TRN_NO# IS NULL OR B.TRN_NO  = LPAD(#TRN_NO#, 5, ''0'') )
	AND    B.UP_DN_DV_CD LIKE (CASE WHEN #UP_DN_DV_CD# = ''A'' THEN ''%'' ELSE #UP_DN_DV_CD# END)
    AND    A.YMGT_JOB_ID =
           ( SELECT SUBSTR ( MAX ( SUBSTR ( AA.REG_DTTM, 1, 8 )
                           ||AA.YMGT_JOB_ID ), 9, 20 )
           FROM     TB_YYFD011 AA
                   ,  TB_YYFD010 BB
           WHERE   AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
           AND     BB.YMGT_PROC_DV_ID IN ( ''YP620''
                                         , ''YP625'' )
           AND     AA.OTMZ_PRS_STT_CD = ''11''
           AND     AA.RUN_DT           = B.RUN_DT
           AND     AA.TRN_NO           = B.TRN_NO
           )
    AND    B.RUN_DT       = A.RUN_DT
    AND    B.TRN_NO       = A.TRN_NO
    AND    B.MRNT_CD = DECODE ( #MRNT_CD#, ''''
                                    , B.MRNT_CD
                                    , #MRNT_CD# )
    AND    B.ROUT_CD = DECODE ( #ROUT_CD#, ''''
                               , B.ROUT_CD
                               , #ROUT_CD# )
	ORDER BY B.TRN_NO ASC
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA003AutoSetCondData', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA003AutoSetCondData*/ 
<![CDATA[
	SELECT DISTINCT B.TRN_NO, B.ROUT_CD, B.MRNT_CD, B.UP_DN_DV_CD
    FROM   TB_YYFD011 A
           , TB_YYDP503 B
    WHERE  B.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
    AND    (#TRN_NO# IS NULL OR B.TRN_NO  = LPAD(#TRN_NO#, 5, ''0'') )
	AND    B.UP_DN_DV_CD LIKE (CASE WHEN #UP_DN_DV_CD# = ''A'' THEN ''%'' ELSE #UP_DN_DV_CD# END)
    AND    A.YMGT_JOB_ID =
           ( SELECT SUBSTR ( MAX ( SUBSTR ( AA.REG_DTTM, 1, 8 )
                           ||AA.YMGT_JOB_ID ), 9, 20 )
           FROM     TB_YYFD011 AA
                   ,  TB_YYFD010 BB
           WHERE   AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
           AND     BB.YMGT_PROC_DV_ID IN ( ''YP620''
                                         , ''YP625'' )
           AND     AA.OTMZ_PRS_STT_CD = ''11''
           AND     AA.RUN_DT           = B.RUN_DT
           AND     AA.TRN_NO           = B.TRN_NO
           )
    AND    B.RUN_DT       = A.RUN_DT
    AND    B.TRN_NO       = A.TRN_NO
    AND    B.MRNT_CD = DECODE ( #MRNT_CD#, ''''
                                    , B.MRNT_CD
                                    , #MRNT_CD# )
    AND    B.ROUT_CD = DECODE ( #ROUT_CD#, ''''
                               , B.ROUT_CD
                               , #ROUT_CD# )
	ORDER BY B.TRN_NO ASC
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA004', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA004*/ 
<![CDATA[
/*uo_trn_search*/
  SELECT DISTINCT TRN_NO
    FROM TB_YYDK301
   WHERE 1 = 1
         AND RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
         AND (#ROUT_CD# IS NULL OR ROUT_CD LIKE #ROUT_CD#)
         AND (#TRN_NO# IS NULL OR TRN_NO LIKE LPAD (#TRN_NO#, 5, ''0''))
         AND UP_DN_DV_CD LIKE (CASE WHEN #UP_DN_DV_CD# = ''A'' THEN ''%'' ELSE #UP_DN_DV_CD# END)
		 AND YMS_APL_FLG LIKE DECODE(#YMS_APL_FLG#, '''', ''%'', #YMS_APL_FLG#)
		 AND STLB_TRN_CLSF_CD IN (''00'', ''01'', ''07'')
		 AND (#STLB_TRN_CLSF_CD# IS NULL OR STLB_TRN_CLSF_CD = #STLB_TRN_CLSF_CD#)
ORDER BY TRN_NO

]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA004AutoSetCondData', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA004AutoSetCondData*/ 
<![CDATA[
/*uo_trn_search*/
 SELECT C.LN_NM MRNT_NM,
        C.LN_CD MRNT_CD,
        B.ROUT_NM ROUT_NM,
        A.ROUT_CD ROUT_CD,
        A.UP_DN_DV_CD,
        A.YMS_APL_FLG,
		A.TRN_NO
 FROM   TB_YYDK301 A,
        TB_YYDK201 B,
        TB_YYDK103 C
 WHERE  1         =1
 AND    (#TRN_NO# IS NULL OR A.TRN_NO  = LPAD( #TRN_NO#, 5, ''0''))
 AND    A.RUN_DT  BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
 AND    A.ROUT_CD = B.ROUT_CD
 AND    B.ROUT_DV_CD IN ( ''10'',
                         ''30'' )
 AND    B.MRNT_CD = C.LN_CD
 AND    ((B.EFC_ST_DT     <= #RUN_TRM_ST_DT#  AND    B.EFC_CLS_DT    >= #RUN_TRM_CLS_DT#) OR (B.EFC_ST_DT >= #RUN_TRM_ST_DT# AND B.EFC_CLS_DT <= #RUN_TRM_CLS_DT#))
 AND    ((C.APL_ST_DT     <= #RUN_TRM_ST_DT#  AND    C.APL_CLS_DT    >= #RUN_TRM_CLS_DT#) OR (C.APL_ST_DT >= #RUN_TRM_ST_DT# AND C.APL_CLS_DT <= #RUN_TRM_CLS_DT#))
 AND    A.STLB_TRN_CLSF_CD IN (''00'', ''01'', ''07'')
 AND (#STLB_TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD = #STLB_TRN_CLSF_CD#)
ORDER BY A.RUN_DT

]]>

', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsAll', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsAll*/ 
<![CDATA[
SELECT DISTINCT TRN_NO
FROM            TB_YYDK301
WHERE           1=1
AND 			RUN_DT         LIKE DECODE(#RUN_DT#, '''', ''%'', #RUN_DT#)
AND             (#STLB_TRN_CLSF_CD# IS NULL OR STLB_TRN_CLSF_CD LIKE #STLB_TRN_CLSF_CD#)
AND
                (
                                #ROUT_CD# IS NULL
                OR              ROUT_CD      LIKE #ROUT_CD#
                )
AND
                (
                                #TRN_NO# IS NULL
                OR              TRN_NO               LIKE LPAD( #TRN_NO#, 5, ''0'')
                )

AND 			UP_DN_DV_CD LIKE (CASE WHEN #UP_DN_DV_CD# = ''A'' THEN ''%'' ELSE #UP_DN_DV_CD# END)

ORDER BY        TRN_NO
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsAutoSetCondData', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsAutoSetCondData*/ 
<![CDATA[
 SELECT C.LN_NM MRNT_NM,
        C.LN_CD MRNT_CD,
        B.ROUT_NM,
        A.ROUT_CD,
        A.UP_DN_DV_CD,
        A.YMS_APL_FLG,
		A.TRN_NO
 FROM   TB_YYDK301 A,
        TB_YYDK201 B,
        TB_YYDK103 C
 WHERE  1         =1
 AND    (#TRN_NO# IS NULL OR A.TRN_NO  = LPAD( #TRN_NO#, 5, ''0''))
 AND    A.RUN_DT  = #RUN_DT#
 AND    A.ROUT_CD = B.ROUT_CD
 AND    B.ROUT_DV_CD IN ( ''10'',
                         ''30'' )
 AND    B.MRNT_CD = C.LN_CD
        /*AND    C.apl_st_dt <= TO_CHAR( sysdate, ''yyyymmdd'' ) */
        /*AND    C.apl_cls_dt >= TO_CHAR( sysdate, ''yyyymmdd'' )*/
 AND    B.EFC_ST_DT     <= #RUN_DT#
 AND    B.EFC_CLS_DT    >= #RUN_DT#
 AND    C.APL_ST_DT     <= #RUN_DT#
 AND    C.APL_CLS_DT    >= #RUN_DT#
 AND    (#STLB_TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD LIKE #STLB_TRN_CLSF_CD#)
        /*AND    A.yms_apl_flg = ''Y''*/
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsN', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsN*/ 
<![CDATA[
SELECT TRN_NO
FROM   ( SELECT DISTINCT TRN_NO
       FROM             TB_YYDK301
                        /*열차기본*/
       WHERE            RUN_DT LIKE DECODE(#RUN_DT#, '''', ''%'', #RUN_DT#)
                        /*운행일자*/
       AND
                        (
                                         #STLB_TRN_CLSF_CD# IS NULL
                        OR               STLB_TRN_CLSF_CD      LIKE #STLB_TRN_CLSF_CD#
                        )
                        /*열차종*/
       AND
                        (
                                         #ROUT_CD# IS NULL
                        OR               ROUT_CD      LIKE #ROUT_CD#
                        )
                        /*노선코드*/

	   AND 				UP_DN_DV_CD LIKE (CASE WHEN #UP_DN_DV_CD# = ''A'' THEN ''%'' ELSE #UP_DN_DV_CD# END)

       MINUS
       
       SELECT DISTINCT TRN_NO
       FROM            TB_YYDD513
                       /*YMS할당잔여석내역*/
       WHERE           1=1
AND 			RUN_DT         LIKE DECODE(#RUN_DT#, '''', ''%'', #RUN_DT#)
                       /*운행일자*/
       )
WHERE (
              #TRN_NO# IS NULL
       OR     TRN_NO               LIKE LPAD( #TRN_NO#, 5, ''0'')
       )
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsY', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsY*/ 
<![CDATA[
SELECT DISTINCT A.TRN_NO
FROM            TB_YYDK301 A,
                (SELECT DISTINCT TRN_NO
                FROM             TB_YYDK328
                WHERE            1=1
AND 			RUN_DT         LIKE DECODE(#RUN_DT#, '''', ''%'', #RUN_DT#)
                )
                B
WHERE           1=1
AND 			A.RUN_DT         LIKE DECODE(#RUN_DT#, '''', ''%'', #RUN_DT#)
                /*운행일자*/
AND
                (
                                #TRN_CLSF_CD# IS NULL
                OR              A.TRN_CLSF_CD    LIKE #TRN_CLSF_CD#
                )
                /*열차종코드*/
AND
                (
                                #ROUT_CD# IS NULL
                OR              A.ROUT_CD    LIKE #ROUT_CD#
                )
                /*주운행선/노선코드*/

AND 			A.UP_DN_DV_CD LIKE (CASE WHEN #UP_DN_DV_CD# = ''A'' THEN ''%'' ELSE #UP_DN_DV_CD# END)
                /*상하행구분코드*/
AND
                (
                                #TRN_NO# IS NULL
                OR              TRN_NO               LIKE LPAD( #TRN_NO#, 5, ''0'')
                )
AND             A.TRN_NO = B.TRN_NO
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.selectListGenTrnNo', '/*com.korail.yz.yb.co.YBCO001QMDAO.selectListGenTrnNo*/ 
<![CDATA[



]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYRAA005', '/*com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYRAA005*/ 
<![CDATA[
SELECT DISTINCT A.TRN_NO
FROM            TB_YYFD011 A,
                TB_YYDP503 B,
                TB_YYDK301 C
WHERE           A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
AND             A.RUN_DT         = B.RUN_DT
AND             A.TRN_NO         = B.TRN_NO
AND             A.RUN_DT         = C.RUN_DT
AND             A.TRN_NO         = C.TRN_NO
AND             C.STLB_TRN_CLSF_CD LIKE DECODE(#STLB_TRN_CLSF_CD#, '''', ''%'', #STLB_TRN_CLSF_CD#)
AND             B.MRNT_CD   = DECODE( #MRNT_CD# , '''', ''%'', #MRNT_CD# )
AND             B.ROUT_CD = DECODE( #ROUT_CD# , '''', ''%'', #ROUT_CD# )
AND             A.YMGT_JOB_ID =
                ( SELECT SUBSTR(MAX(SUBSTR(AA.REG_DTTM, 1, 8)
                                ||AA.YMGT_JOB_ID), 9, 20)
                FROM    TB_YYFD011 AA,
                        TB_YYFD010 BB
                WHERE   AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
                AND     BB.YMGT_PROC_DV_ID IN (''YP620'',
                                              ''YP625'')
                AND     AA.OTMZ_PRS_STT_CD = ''11''
                AND     AA.RUN_DT           = A.RUN_DT
                AND     AA.TRN_NO           = A.TRN_NO
                )
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYSAA001', '/*com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYSAA001*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYSAA001 */
			   DISTINCT TRN_NO 	/* 열차번호 */
		  FROM TB_YYDK301 		/* 열차기본TBL */
		 WHERE RUN_DT = #RUN_DT#
		   AND (LTRIM(#TRN_NO#, '' '') IS NULL OR TRN_NO = LPAD(LTRIM(#TRN_NO#, '' ''), 5, ''0''))
		   AND (#TRN_CLSF_CD# 	IS NULL OR STLB_TRN_CLSF_CD = #TRN_CLSF_CD# ) 	/* 열차종별코드		*/
		   AND (#ROUT_CD# 		IS NULL OR ROUT_CD 			= #ROUT_CD#		)	/* 노선코드 			*/
		   AND (#UP_DN_DV_CD# 	= ''A'' OR UP_DN_DV_CD 		= #UP_DN_DV_CD#	) 	/* 상행하행구분코드 	*/
]]>
<isNotEmpty property = "TRVL_USR_ID">

		   AND ( TRN_CLSF_CD 			/* 열차종별코드 */
			     , ROUT_CD 				/*노선코드*/
				 , UP_DN_DV_CD 			/*상하행구분코드*/
				 ,( SELECT SUBSTR(DPT_TM, 1, 2) /*출발시각*/
			     	  FROM TB_YYDK302 /*열차운행내역TBL*/
			   		 WHERE RUN_ORDR = 1 
			      	   AND RUN_DT = TB_YYDK301.RUN_DT
			      	   AND TRN_NO = TB_YYDK301.TRN_NO ))  IN ( SELECT TRN_CLSF_CD 	/*열차종별코드*/
																	 ,ROUT_CD 		/*노선구분코드*/
																	 ,UP_DN_DV_CD 	/*상하행구분코드*/
																	 ,TMWD_DV_CD 	/*시간대구분코드*/ 
																 FROM TB_YYFD008 	/*담당그룹별열차내역TBL*/
																WHERE USR_GP_ID IN ( SELECT USR_GP_ID 	/*사용자그룹ID*/
																					   FROM TB_YYFD007  /*담당그룹별사용자내역*/
																					  WHERE USR_ID = #TRVL_USR_ID# ) /*사용자ID*/)
</isNotEmpty>
<![CDATA[
		ORDER BY TRN_NO
]]>', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYSAA001AutoSetCondData', '/*com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYSAA001AutoSetCondData*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYSAA001AutoSetCondData */
			   A.TRN_NO         AS TRN_NO		/* 열차번호 */
			  ,C.LN_NM 			AS MRNT_NM  	/* 주운행선명 		*/
			  ,C.LN_CD 			AS MRNT_CD 		/* 주운행선코드 	*/
			  ,B.ROUT_NM 		AS ROUT_NM 		/* 노선명 		*/
			  ,B.ROUT_CD 		AS ROUT_CD 		/* 노선코드 		*/
			  ,A.UP_DN_DV_CD 	AS UP_DN_DV_CD 	/* 상하행구분코드 	*/
			  ,A.YMS_APL_FLG 	AS YMS_APL_FLG 	/* YMS적용여부 	*/
		  FROM TB_YYDK301 A 					/* 열차기본TBL 	*/
			  ,TB_YYDK201 B 					/* 노선코드TBL 	*/
			  ,TB_YYDK103 C 					/* 선코드이력TBL 	*/
		 WHERE (LTRIM(#TRN_NO#, '' '') IS NULL OR A.TRN_NO = LPAD(LTRIM(#TRN_NO#, '' ''), 5, ''0''))
		   AND A.RUN_DT = #RUN_DT#
		   AND A.ROUT_CD = B.ROUT_CD
		   AND B.ROUT_DV_CD IN (''10'', ''30'')
		   AND B.MRNT_CD = C.LN_CD
		   AND B.EFC_ST_DT <= #RUN_DT#
		   AND B.EFC_CLS_DT >= #RUN_DT#
		   AND C.APL_CLS_DT >= #RUN_DT#
		   AND (#TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD = #TRN_CLSF_CD#)
]]>
', TO_DATE('04/16/2014 20:13:35', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO002QMDAO.selectListHtnStopStn', '/*com.korail.yz.yb.co.YBCO002QMDAO.selectListHtnStopStn*/ 
<![CDATA[
  SELECT /*+ com.korail.yz.yb.co.YBCO002QMDAO.selectListHtnStopStn */
		 T1.RS_STN_CD AS RS_STN_CD							/**/
		,TRIM (T2.KOR_STN_NM) AS KOR_STN_NM					/**/
    FROM TB_YYDK001 T1										/**/
		,TB_YYDK102 T2										/**/
   WHERE     T1.STN_CD = T2.STN_CD
         AND T2.APL_ST_DT <= TO_CHAR (SYSDATE, ''YYYYMMDD'')	/**/
         AND T2.APL_CLS_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD'')	/**/
         AND T1.DEAL_TRN_CLSF_CD IN (''00'', ''01'')				/**/
ORDER BY T2.KOR_STN_NM
]]>
', TO_DATE('04/01/2014 18:40:51', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO002QMDAO.selectListRsvSaleStn', '/*com.korail.yz.yb.co.YBCO002QMDAO.selectListRsvSaleStn*/ 
<![CDATA[
  SELECT /*+ com.korail.yz.yb.co.YBCO002QMDAO.selectListRsvSaleStn */
		 T1.RS_STN_CD AS RS_STN_CD								/**/
	    ,TRIM (T2.KOR_STN_NM) AS KOR_STN_NM						/**/
    FROM TB_YYDK001 T1											/**/
		,TB_YYDK102 T2											/**/
   WHERE     T1.STN_CD = T2.STN_CD								/**/
         AND T2.APL_ST_DT <= TO_CHAR (SYSDATE, ''YYYYMMDD'')		/**/
         AND T2.APL_CLS_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD'')		/**/
         AND T1.DEAL_TRN_CLSF_CD IN (''00'', ''01'')				/**/
         AND T2.KOR_STN_NM BETWEEN #ST_STR# AND #END_STR#		/**/
ORDER BY T2.KOR_STN_NM
]]>', TO_DATE('04/01/2014 18:40:51', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO002QMDAO.test', '/*com.korail.yz.yb.co.YBCO002QMDAO.test*/ 
<![CDATA[
  SELECT /*+ com.korail.yz.yb.co.YBCO002QMDAO.selectListHtnStopStn */
		 T1.RS_STN_CD AS RS_STN_CD							/**/
		,TRIM (T2.KOR_STN_NM) AS KOR_STN_NM					/**/
		, #DPT_STN_CD# || #ARV_STN_CD# AS TEST
    FROM TB_YYDK001 T1										/**/
		,TB_YYDK102 T2										/**/
   WHERE     T1.STN_CD = T2.STN_CD
         AND T2.APL_ST_DT <= TO_CHAR (SYSDATE, ''YYYYMMDD'')	/**/
         AND T2.APL_CLS_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD'')	/**/
         AND T1.DEAL_TRN_CLSF_CD IN (''00'', ''01'')			/**/
		 
ORDER BY T2.KOR_STN_NM
]]>
', TO_DATE('04/01/2014 18:40:51', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO003QMDAO.selectListBkclCd', '/*com.korail.yz.yb.co.YBCO003QMDAO.selectListBkclCd*/ 
<![CDATA[

/*부킹클래스코드 가져오는 쿼리*/
SELECT 
BKCL_CD, 
BKCL_DSC_CONT BKCL_NM

FROM
(
    SELECT * FROM TB_YYBB003
    WHERE 1=1
    AND APL_ST_DT <= TO_CHAR(SYSDATE,''YYYYMMDD'')
    AND APL_CLS_DT BETWEEN TO_CHAR(SYSDATE,''YYYYMMDD'') AND ''99991231''
    AND BKCL_USE_FLG = ''Y''

    UNION ALL

    SELECT * FROM TB_YYBB003
    WHERE 1=1
    AND APL_ST_DT <= TO_CHAR(SYSDATE,''YYYYMMDD'')
    AND APL_CLS_DT BETWEEN TO_CHAR(SYSDATE,''YYYYMMDD'') AND ''99991231''
    AND BKCL_CD LIKE ''R%''
)
ORDER BY BKCL_APL_ORDR

]]>
', TO_DATE('04/17/2014 14:40:54', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO003QMDAO.selectListDptArvStgp', '/*com.korail.yz.yb.co.YBCO003QMDAO.selectListDptArvStgp*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yb.co.YBCO003QMDAO.selectListDptArvStgp */
			   DISTINCT 
			   A.DPT_STGP_CD || A.ARV_STGP_CD AS DPT_ARV_STGP_CD,
               ( SELECT VLID_VAL_NM
                   FROM TB_YYDK007
                  WHERE XROIS_OLD_SRT_CD = ''Y019'' /*역그룹코드*/
                    AND VLID_VAL = A.DPT_STGP_CD)
                || ''-'' || 
                ( SELECT VLID_VAL_NM
                   FROM TB_YYDK007
                  WHERE XROIS_OLD_SRT_CD = ''Y019'' /*역그룹코드*/
                    AND VLID_VAL = A.ARV_STGP_CD) AS DPT_ARV_STGP_CD_NM
          FROM TB_YYDD505 A,
               TB_YYFD002 B,
               TB_YYFD002 C
         WHERE A.RUN_DT = #RUN_DT#
           AND A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
            AND A.STGP_DEGR = #STGP_DEGR#
            AND A.TMWD_GP_CD = (
                                  SELECT TMWD_GP_CD
                                    FROM TB_YYFB003
                                   WHERE APL_ST_DT <= TO_CHAR(SYSDATE, ''YYYYMMDD'')
                                       AND APL_CLS_DT >= TO_CHAR(SYSDATE, ''YYYYMMDD'')
                                 )          
            AND B.STGP_CD   = A.DPT_STGP_CD
            AND B.STGP_DEGR = A.STGP_DEGR
            AND C.STGP_CD   = A.ARV_STGP_CD
            AND C.STGP_DEGR = A.STGP_DEGR
          ORDER BY 1
]]>
', TO_DATE('04/17/2014 14:40:54', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO003QMDAO.selectListMrnt', '/*com.korail.yz.yb.co.YBCO003QMDAO.selectListMrnt*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yb.co.YBCO003QMDAO.selectListMrnt */
		        DISTINCT
				LN_NM AS MRNT_NM,    /* 주운행선명 		*/
		        LN_CD AS MRNT_CD		/* 주운행선코드 	*/
		  FROM TB_YYDK103   			/* 선코드이력TBL 	*/
		 WHERE LN_CD IN ( SELECT DISTINCT MRNT_CD
		                    FROM TB_YYDK201    /* 노선코드TBL */
		               	   WHERE ROUT_DV_CD IN (''10'',''30'') ) 
		ORDER BY LN_CD
]]>
', TO_DATE('04/17/2014 14:40:54', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO003QMDAO.selectListRout', '/*com.korail.yz.yb.co.YBCO003QMDAO.selectListRout*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yb.co.YBCO003QMDAO.selectListRout */
				ROUT_NM, /* 노선명 */
				ROUT_CD /* 노선코드 */
		  FROM TB_YYDK201 /* 노선코드TBL */
		 WHERE ROUT_DV_CD IN (''10'', ''30'')
		   AND (#MRNT_CD# IS NULL OR MRNT_CD = #MRNT_CD#) /* 주운행선코드 */
		ORDER BY ROUT_CD
]]>
', TO_DATE('04/17/2014 14:40:54', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO003QMDAO.selectListRunSeg', '/*com.korail.yz.yb.co.YBCO003QMDAO.selectListRunSeg*/ 
<![CDATA[
	SELECT   B.kor_stn_nm STN_NM,
        	 A.RS_STN_CD  STN_CD,
			 A.STN_CONS_ORDR STN_ORDR
	FROM     TB_YYDK001 A,
    	     TB_YYDK102 B
	WHERE    A.STN_CD      = B.STN_CD
	AND      B.APL_ST_DT  <= TO_CHAR( SYSDATE, ''YYYYMMDD'' )
	AND      B.APL_CLS_DT >= TO_CHAR( SYSDATE, ''YYYYMMDD'' )
	AND      A.DEAL_TRN_CLSF_CD IN (''00'',
                                ''01'')
	ORDER BY A.RS_STN_CD
]]>
', TO_DATE('04/17/2014 14:40:54', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.co.YBCO003QMDAO.selectListRunSegWithPram', '/*com.korail.yz.yb.co.YBCO003QMDAO.selectListRunSegWithPram*/ 
<![CDATA[

SELECT DISTINCT C.kor_stn_nm STN_NM, A.STOP_RS_STN_CD STN_CD, A.STN_CONS_ORDR STN_ORDR
             FROM   TB_YYDK302 A, TB_YYDK001 B, TB_YYDK102 C
             WHERE  A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
             AND    A.TRN_NO = #TRN_NO# 
             AND    A.STOP_RS_STN_CD = B.RS_STN_CD   
             AND    B.STN_CD = C.STN_CD              
             AND    B.DEAL_TRN_CLSF_CD IN (''00'',''01'')
             AND    C.APL_ST_DT <= TO_CHAR( SYSDATE, ''YYYYMMDD'' )
             AND    C.APL_CLS_DT >= TO_CHAR( SYSDATE, ''YYYYMMDD'' ) 
]]>
		<isNotEmpty property="UP_DN_DV_CD">
			<isEqual property="UP_DN_DV_CD" compareValue="U">
				<isNotEmpty property="STN_CD">
				<![CDATA[
					AND     A.STN_CONS_ORDR < (SELECT DISTINCT STN_CONS_ORDR FROM TB_YYDK302 WHERE STOP_RS_STN_CD = #STN_CD# AND A.TRN_NO = #TRN_NO# AND RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#)
				]]>
				</isNotEmpty>
			ORDER BY STN_CONS_ORDR DESC
			</isEqual>

			<isEqual property="UP_DN_DV_CD" compareValue="D">
				<isNotEmpty property="STN_CD">
				<![CDATA[
					AND     A.STN_CONS_ORDR > (SELECT DISTINCT STN_CONS_ORDR FROM TB_YYDK302 WHERE STOP_RS_STN_CD = #STN_CD# AND A.TRN_NO = #TRN_NO# AND RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#)
				]]>
				</isNotEmpty>
			ORDER BY STN_CONS_ORDR ASC
			</isEqual>
		</isNotEmpty>
		<isEmpty property="UP_DN_DV_CD">
			ORDER BY STN_CONS_ORDR ASC
		</isEmpty>
', TO_DATE('04/17/2014 14:40:54', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.dc.YBDC001QMDAO.selectListRsvSaleInfo', '/*com.korail.yz.yb.dc.YBDC001QMDAO.selectListRsvSaleInfo*/ 
<![CDATA[
  SELECT /*+com.korail.yz.yb.dc.YBDC001QMDAO.selectListRsvSaleInfo */
		   T3.RS_STN_CD			/*예발역코드*/
         , T3.KOR_STN_NM		/*한글역명*/
         , T3.STN_ENGM_NM		/*영문역명*/
         , T3.STN_CD			/*역코드*/
         , T3.APL_ST_DT			/*적용시작일자*/
         , T3.APL_CLS_DT		/*적용종료일자*/
         , T3.STN_KND_DV_CD		/*역종류구분코드*/
         , T4.STN_KND_DV_NM		/*역종류구분명*/
         , T3.CHTN_STN_FLG		/*환승역여부*/
         , T3.DEAL_TRN_CLSF_CD	/*취급열차종별코드*/
         , T5.DEAL_TRN_CLSF_NM	/*취급열차종별*/
    FROM (SELECT   T2.RS_STN_CD			/*예발역코드*/
                 , T2.KOR_STN_NM		/*한글역명*/
                 , T2.STN_ENGM_NM		/*영문역명*/
                 , T1.STN_CD			/*역코드*/
                 , T1.APL_ST_DT			/*적용시작일자*/
                 , T1.APL_CLS_DT		/*적용종료일자*/
                 , T1.STN_KND_DV_CD		/*역종류구분코드*/
                 , NVL (T2.CHTN_STN_FLG, ''N'') AS CHTN_STN_FLG 		/*환승역여부(NULL일 경우 N으로 변환*/
                 , T2.DEAL_TRN_CLSF_CD				/*취급열차종별코드*/
            FROM  TB_YYDK102 T1		/*역이력 테이블*/
				, TB_YYDK001 T2		/*예발역코드 테이블*/
           WHERE        T1.STN_CD = T2.STN_CD		/**/
                    AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN T1.APL_ST_DT
                                                          AND T1.APL_CLS_DT
                    AND T2.DEAL_TRN_CLSF_CD IN (''00'', ''01'', ''02'', ''03'')		/*검색조건 : ''00'':KTX, ''01'':새마을, ''02'':무궁화, ''03'':통근열차*/
                    AND T2.KOR_STN_NM LIKE ''%'' || #KOR_STN_NM# || ''%''		/*검색조건 : 한글역명*/
                    AND T1.STN_KND_DV_CD LIKE #STN_KND_DV_CD# || ''%'')		/*검색조건 : 역종류구분코드*/
					T3
         LEFT OUTER JOIN (SELECT VLID_VAL AS STN_KND_DV_CD,			/*역종류구분코드*/
                                 VLID_VAL_NM AS STN_KND_DV_NM		/*역종류구분명*/
                            FROM TB_YYDK007
                           WHERE XROIS_OLD_SRT_CD = ''T503'') T4		/*T503 : 역종류구분코드 모음*/
            ON T3.STN_KND_DV_CD = T4.STN_KND_DV_CD
         LEFT OUTER JOIN (SELECT VLID_VAL AS DEAL_TRN_CLSF_CD,			/*취급열차종별코드*/
                                 VLID_VAL_NM AS DEAL_TRN_CLSF_NM		/*취급열차종별명*/
                            FROM TB_YYDK007
                           WHERE XROIS_OLD_SRT_CD = ''R027'') T5		/*R027 : 취급열차종별코드 모음 */
            ON T3.DEAL_TRN_CLSF_CD = T5.DEAL_TRN_CLSF_CD
		where T3.CHTN_STN_FLG LIKE #CHTN_STN_FLG# || ''%''
ORDER BY T3.RS_STN_CD
]]>
', TO_DATE('04/08/2014 17:32:26', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.dc.YBDC002QMDAO.selectListRunStnInfo', '/*com.korail.yz.yb.dc.YBDC002QMDAO.selectListRunStnInfo*/ 
<![CDATA[
  SELECT /*+com.korail.yz.yb.dc.YBDC002QMDAO.selectListRunStnInfo */
		 T1.STN_CD											/* 역코드*/
       , RTRIM (T1.KOR_STN_NM) AS KOR_STN_NM				/* 한글역명  */
       , T2.STN_ENGM_NM										/* 영어역명 */
       , RTRIM (T1.STNM_VAL) AS STNM_VAL					/* 역부호            */
       , T1.APL_ST_DT                                       /* 적용시작일자      */
       , T1.APL_CLS_DT                                      /* 적용종료일자      */
       , (SELECT T3.VLID_VAL_NM
            FROM TB_YYDK007 T3
           WHERE XROIS_OLD_SRT_CD = ''T503''  
		     AND T3.VLID_VAL = T1.STN_KND_DV_CD)
            AS STN_KND_DV_CD                                /* 역종류구분명 */
       , (SELECT T4.VLID_VAL_NM
            FROM TB_YYDK007 T4
          WHERE XROIS_OLD_SRT_CD = ''T501'' /*이 행은 KROIS본부구분 코드를 조회해옴(기존데이터들은 이 행의 코드를 지사구분코드로 가지고 있음).*/
/*			WHERE XROIS_OLD_SRT_CD = ''Z003''	 /* 화면 메타ID와 연결된 지역구분코드를 조회함*/
			 AND T4.VLID_VAL = T1.BLG_BRCF_CD)
            AS BRCF_DV_CD                          						/* 소속지역본부명(지사구분) */
       , T2.RS_STN_CD                                   			    /* 예발역코드        */
       , LTRIM(LTRIM (T1.FRG_DEAL_ST_DT, ''00000000''), '' '') AS FRG_DEAL_ST_DT 		/* 화물취급개시일    */
       , LTRIM(LTRIM (T1.FRG_DEAL_CLS_DT, ''00000000''), '' '') AS FRG_DEAL_CLS_DT 		/* 화물취급종료일    */
       , LTRIM(LTRIM (T1.TRVL_DEAL_ST_DT, ''00000000''), '' '') AS TRVL_DEAL_ST_DT 		/* 여객취급개시일    */
       , LTRIM(LTRIM (T1.TRVL_DEAL_CLS_DT, ''00000000''), '' '') AS TRVL_DEAL_CLS_DT 	/* 여객취급종료일    */
       , LTRIM(LTRIM (T1.PCL_DEAL_ST_DT, ''00000000''), '' '') AS PCL_DEAL_ST_DT 		/* 소화물취급개시일  */
       , LTRIM(LTRIM (T1.PCL_DEAL_CLS_DT, ''00000000''), '' '') AS PCL_DEAL_CLS_DT
    FROM TB_YYDK102 T1
	   , TB_YYDK001 T2
   WHERE TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT AND APL_CLS_DT
     AND STN_KND_DV_CD LIKE #STN_KND_DV_CD# || ''%''
     AND BLG_BRCF_CD LIKE #BLG_BRCF_CD#
     AND BLG_BRCF_CD NOT IN (''10'', ''20'', ''30'', ''40'', ''50'') /* KROIS본부구분코드*/
     AND T2.DEAL_TRN_CLSF_CD IN	(''00'', ''01'', ''02'', ''03'')
     AND T1.STN_CD = T2.STN_CD(+)
ORDER BY BLG_BRCF_CD, STN_CD
]]>
', TO_DATE('04/11/2014 18:14:15', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.dc.YBDC002QMDAO.selectRunStnDtl', '/*com.korail.yz.yb.dc.YBDC002QMDAO.selectRunStnDtl*/ 
<![CDATA[
SELECT /*+com.korail.yz.yb.dc.YBDC002QMDAO.selectRunStnDtl */
	   STN_CD
     , KOR_STN_NM                                         /* 역명              */
     , STN_AVVR_NM                                        /* 역약어            */
     , STN_ENGM_NM                                        /* 영문역명          */
     , STN_ENGM_AVVR_NM                                   /* 영문역약어        */
     , STNM_VAL                                           /* 역부호            */
     , (SELECT T1.VLID_VAL_NM
          FROM TB_YYDK007 T1
         WHERE XROIS_OLD_SRT_CD = ''T505'' AND T1.VLID_VAL = AR_MG_STN_CD)
          AS AR_MG_STN                                   /* 지역관리역        */
     , (SELECT T1.VLID_VAL_NM
          FROM TB_YYDK007 T1
         WHERE XROIS_OLD_SRT_CD = ''C004'' AND T1.VLID_VAL = BLG_BRCF_CD)
          AS BLG_BRCF_CD                                 /* 지역사무소        */
     , BLG_CD                                              /* 소속코드          */
     , LTRIM(LTRIM (NETB_DT, ''00000000''), '' '') AS NETB_DT                      /* 신설일자          */
     , LTRIM(LTRIM (ABOL_DT, ''00000000''), '' '') AS ABOL_DT                      /* 폐지일자          */
     , (SELECT T1.VLID_VAL_NM
          FROM TB_YYDK007 T1
         WHERE XROIS_OLD_SRT_CD = ''I309'' AND T1.VLID_VAL = CTRY_CD)
          AS CTRY_CD                             				     /* 국가              */
     , LTRIM(LTRIM (FRG_DEAL_ST_DT, ''00000000''), '' '') AS FRG_DEAL_ST_DT 		/* 화물취급개시일    */
     , LTRIM(LTRIM (FRG_DEAL_CLS_DT, ''00000000''), '' '') AS FRG_DEAL_CLS_DT 		/* 화물취급종료일    */
     , LTRIM(LTRIM (TRVL_DEAL_ST_DT, ''00000000''), '' '') AS TRVL_DEAL_ST_DT 		/* 여객취급개시일    */
     , LTRIM(LTRIM (TRVL_DEAL_CLS_DT, ''00000000''), '' '') AS TRVL_DEAL_CLS_DT 	/* 여객취급종료일    */
     , LTRIM(LTRIM (PCL_DEAL_ST_DT, ''00000000''), '' '') AS PCL_DEAL_ST_DT 		/* 소화물취급개시일  */
     , LTRIM(LTRIM (PCL_DEAL_CLS_DT, ''00000000''), '' '') AS PCL_DEAL_CLS_DT 		/* 소화물취급종료일  */
     , CHTN_STN_FLG                                                /* 환승역여부 */
     , QTST_FLG                                                    /* 분기역여부 */
     , INTG_STN_DV_CD                                              /* 통합역구분 */
     , (SELECT T2.BLG_KOR_NM
          FROM TB_YYDK101 T2, TB_YYDK102 T3
         WHERE     T2.BLG_CD = T3.LOCA_ISTT_CD
               AND T3.STN_CD = #STN_CD#
               AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT
                                                     AND APL_CLS_DT)
          AS LOCA_ISTT_CD1 
     , (SELECT T2.BLG_KOR_NM
          FROM TB_YYDK101 T2, TB_YYDK102 T3
         WHERE     T2.BLG_CD = T3.LOCA_ISTT_CD2
               AND T3.STN_CD = #STN_CD#
               AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT
                                                     AND APL_CLS_DT)
          AS LOCA_ISTT_CD2 
     , (SELECT T2.BLG_KOR_NM
          FROM TB_YYDK101 T2, TB_YYDK102 T3
         WHERE     T2.BLG_CD = T3.LOCA_ISTT_CD3
               AND T3.STN_CD = #STN_CD#
               AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT
                                                     AND APL_CLS_DT)
          AS LOCA_ISTT_CD3 
     , (SELECT T2.BLG_KOR_NM
          FROM TB_YYDK101 T2, TB_YYDK102 T3
         WHERE     T2.BLG_CD = T3.LOCA_ISTT_CD4
               AND T3.STN_CD = #STN_CD#
               AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT
                                                     AND APL_CLS_DT)
          AS CG_OFC_CD 
     , (SELECT T2.BLG_KOR_NM
          FROM TB_YYDK101 T2, TB_YYDK102 T3
         WHERE     T2.BLG_CD = T3.LOCA_ISTT_CD5
               AND T3.STN_CD = #STN_CD#
               AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT
                                                     AND APL_CLS_DT)
          AS LOCA_ISTT_CD5
  FROM TB_YYDK102 T3
 WHERE     STN_CD = #STN_CD#
       AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT AND APL_CLS_DT
]]>
', TO_DATE('04/11/2014 18:14:15', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.dc.YBDC003QMDAO.selectListCvrLnInfo', '/*com.korail.yz.yb.dc.YBDC003QMDAO.selectListCvrLnInfo*/ 
<![CDATA[
  SELECT /*+com.korail.yz.yb.dc.YBDC003QMDAO.selectListCvrLnInfo */
		 T1.CVR_LN_ORDR                                   /*     주행선 순서     */
       , T2.LN_NM                                        /*     주행선 명       */
       , (SELECT KOR_STN_NM
            FROM TB_YYDK102
           WHERE     STN_CD = T1.CVR_LN_ST_STN_CD
                 AND APL_CLS_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD'')
                 AND APL_ST_DT <= TO_CHAR (SYSDATE, ''YYYYMMDD''))
            CVR_LN_ST_STN_CD                             /*     선 시작역       */
       , (SELECT KOR_STN_NM
            FROM TB_YYDK102
           WHERE     STN_CD = T1.CVR_LN_CLS_STN_CD
                 AND APL_CLS_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD'')
                 AND APL_ST_DT <= TO_CHAR (SYSDATE, ''YYYYMMDD''))
            CVR_LN_CLS_STN_CD                            /*     선 종료역       */
       , (SELECT KOR_STN_NM
            FROM TB_YYDK102
           WHERE     STN_CD = T1.DIR_STDR_STN_CD
                 AND APL_CLS_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD'')
                 AND APL_ST_DT <= TO_CHAR (SYSDATE, ''YYYYMMDD''))
            DIR_STDR_STN_CD                              /*     방향기준역       */
       , ABS (
              (SELECT T3.ACM_DST
                 FROM TB_YYDK204 T3
                WHERE     T3.LN_CD = T1.CVR_LN_CD
                      AND T3.APL_ST_DT <= #ST_DT#
                      AND T3.APL_CLS_DT >= #ST_DT#
                      AND T3.STN_CD = T1.CVR_LN_CLS_STN_CD)
            - (SELECT T3.ACM_DST
                 FROM TB_YYDK204 T3
                WHERE     T3.LN_CD = T1.CVR_LN_CD
                      AND T3.APL_ST_DT <= #ST_DT#
                      AND T3.APL_CLS_DT >= #ST_DT#
                      AND T3.STN_CD = T1.CVR_LN_ST_STN_CD))
            SEG_DST                                      /*     구간거리        */
       , ABS (
              (SELECT DECODE (T3.STN_CONS_ORDR, 1, 0, T3.STN_CONS_ORDR)
                 FROM TB_YYDK204 T3
                WHERE     T3.LN_CD = T1.CVR_LN_CD
                      AND T3.APL_ST_DT <= #ST_DT#
                      AND T3.APL_CLS_DT >= #ST_DT#
                      AND T3.STN_CD = T1.CVR_LN_CLS_STN_CD)
            - (SELECT DECODE (T3.STN_CONS_ORDR, 1, 0, T3.STN_CONS_ORDR)
                 FROM TB_YYDK204 T3
                WHERE     T3.LN_CD = T1.CVR_LN_CD
                      AND T3.APL_ST_DT <= #ST_DT#
                      AND T3.APL_CLS_DT >= #ST_DT#
                      AND T3.STN_CD = T1.CVR_LN_ST_STN_CD))
            STN_NUM                                         /*   주행선구성역수    */
    FROM TB_YYDK202 T1,
         (SELECT VLID_VAL_NM AS LN_NM
			   , VLID_VAL AS LN_CD
            FROM TB_YYDK007
           WHERE XROIS_OLD_SRT_CD = ''C308'') T2
   WHERE T1.CVR_LN_CD = T2.LN_CD AND T1.ROUT_CD = #ROUT_DV_CD#
ORDER BY CVR_LN_ORDR
]]>
', TO_DATE('04/17/2014 10:15:28', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.dc.YBDC003QMDAO.selectListRoutInfo', '/*com.korail.yz.yb.dc.YBDC003QMDAO.selectListRoutInfo*/ 
<![CDATA[
  SELECT /*+com.korail.yz.yb.dc.YBDC003QMDAO.selectListRoutInfo*/
         T1.ROUT_CD                                 		         	/* 노선코드         */
       , T1.ROUT_NM 								  			       	/* 노선명           */
       , (SELECT KOR_STN_NM
            FROM TB_YYDK102
           WHERE     STN_CD = T1.ST_STN_CD
                 AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT
                                                       AND APL_CLS_DT)
            AS ST_STN_NM                                    			/* 시발역명         */
       , (SELECT KOR_STN_NM
            FROM TB_YYDK102
           WHERE     STN_CD = T1.CLS_STN_CD
                 AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT
                                                       AND APL_CLS_DT)
            AS CLS_STN_NM                                   			/* 종착역명         */
       , (SELECT VLID_VAL_NM
            FROM TB_YYDK007
           WHERE VLID_VAL = T1.MRNT_CD AND XROIS_OLD_SRT_CD = ''R160'')
            AS MRNT_CD_NM                                    /* 주운행선명       */
       , (SELECT KOR_STN_NM
            FROM TB_YYDK102
           WHERE     STN_CD = T1.REP_VIA_STN_CD
                 AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN APL_ST_DT
                                                       AND APL_CLS_DT)
            AS REP_VIA_STN_NM                                 /* 대표경유역명     */
       , (SELECT VLID_VAL_NM
            FROM TB_YYDK007
           WHERE VLID_VAL = T1.ROUT_DV_CD AND XROIS_OLD_SRT_CD = ''S030'')
            AS ROUT_DV_NM                                    /* 노선구분명       */
       , T1.EFC_ST_DT                                         /* 시행시작일자     */
       , T1.EFC_CLS_DT                                        /* 시행종료일자     */
       , NVL (T3.RSV_SALE_FLG, ''N'') AS RSV_SALE_FLG             /* 예약발매사용여부 */
    FROM TB_YYDK201 T1                                    /* 노선             */
       , TB_YYDK103 T2                                     /* 선이력           */
       , (SELECT T1.ROUT_CD, ''Y'' AS RSV_SALE_FLG
            FROM TB_YYDK201 T1                            /* 노선             */
           WHERE EXISTS
                    (SELECT ''Y''
                       FROM TB_YYDK301 T4                     /* 일일열차정보     */
                      WHERE     T4.RUN_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD'')
                            AND T4.ROUT_CD = T1.ROUT_CD
                            AND ROWNUM = 1)) T3
   WHERE     T1.MRNT_CD LIKE #MRNT_CD#
         AND T1.MRNT_CD IN (''01'', ''03'', ''04'')
         AND T1.MRNT_CD = T2.LN_CD
         AND T1.ROUT_CD = T3.ROUT_CD(+)
         AND (   (    NVL (LENGTH (#DPT_STN_CD#), 0) > 0
                  AND T1.ROUT_CD IN
                         (SELECT DISTINCT ROUT_CD
                            FROM TB_YYDK001 T5               /* 예약발매역       */
                               , TB_YYDK203 T6 				 /* 노선구성역       */
                           WHERE     T5.RS_STN_CD LIKE #DPT_STN_CD#
                                 AND T5.DEAL_TRN_CLSF_CD IN (''00'', ''01'')
                                 AND T5.STN_CD = T6.STN_CD))
              OR NVL (LENGTH (#DPT_STN_CD#), 0) = 0)
         AND (   (    NVL (LENGTH (#ARV_STN_CD#), 0) > 0
                  AND T1.ROUT_CD IN
                         (SELECT DISTINCT ROUT_CD
                            FROM TB_YYDK001 T5,                /* 예약발매역     */
                                               TB_YYDK203 T6   /* 노선구성역     */
                           WHERE     T5.RS_STN_CD LIKE #ARV_STN_CD#
                                 AND T5.DEAL_TRN_CLSF_CD IN (''00'', ''01'')
                                 AND T5.STN_CD = T6.STN_CD))
              OR NVL (LENGTH (#ARV_STN_CD#), 0) = 0)
         AND T1.ROUT_DV_CD IN (''10'', ''30'')
         AND T1.ROUT_DV_CD LIKE #ROUT_DV_CD# || ''%''
         AND T1.EFC_ST_DT <= #STDR_DT#
         AND T1.EFC_CLS_DT >= #STDR_DT#
         AND T2.APL_CLS_DT >= #STDR_DT#
         AND T2.APL_ST_DT <= #STDR_DT#
ORDER BY T1.ROUT_CD, T1.EFC_ST_DT
]]>', TO_DATE('04/17/2014 10:15:28', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yb.dc.YBDC003QMDAO.selectRoutConsStn', '/*com.korail.yz.yb.dc.YBDC003QMDAO.selectRoutConsStn*/ 
<![CDATA[
  SELECT /*+com.korail.yz.yb.dc.YBDC003QMDAO.selectRoutConsStn*/
	     T1.STN_CONS_ORDR                                     		/* 역구성순서     */
       , (SELECT KOR_STN_NM
            FROM TB_YYDK102
           WHERE     STN_CD = T1.STN_CD
                 AND APL_CLS_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD'')
                 AND APL_ST_DT <= TO_CHAR (SYSDATE, ''YYYYMMDD''))
            CONS_STN_NM                           		            /* 구성역         */
       , T2.LN_NM CVR_LN_NM                      		            /* 주행선명       */
       , T3.NEW_ROUT_ACM_DST                               	        /* 신선누적거리   */
       , T3.EXS_ROUT_ACM_DST                 	                    /* 기존선누적거리 */
       , T1.CPS_RDIR_FLG                                         	/* 편성순방향여부 */
       , T1.CATN_FLG                                           		/* 전차선여부     */
    FROM TB_YYDK203 T1                                         		/* 노선구성역     */
       , TB_YYDK103 T2                      			 			/* 선이력         */
       , TB_YYDK205 T3              							 	/* 노선구성역이력 */
   WHERE     T1.ROUT_CD LIKE #ROUT_DV_CD#
         AND T1.ROUT_CD = T3.ROUT_CD /*T3 노선구성역이력에 데이터가 없어어 임시조치*/
         AND T1.STN_CONS_ORDR = T3.STN_CONS_ORDR
         AND T3.APL_ST_DT = #ST_DT# 
         AND T1.CVR_LN_CD = T2.LN_CD(+)
         AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN T2.APL_ST_DT(+)
                                               AND T2.APL_CLS_DT(+)
         AND T1.STN_CD = T3.STN_CD
ORDER BY T1.STN_CONS_ORDR
]]>
', TO_DATE('04/17/2014 10:15:28', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA001QMDAO.selectListStgpInfo', '/*com.korail.yz.yf.aa.YFAA001QMDAO.selectListStgpInfo*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yf.aa.YFAA001QMDAO.selectListStgpInfo*/
      			A.KOR_STN_NM AS KOR_GRUP_STN_NM, 					/* 역그룹명(한글) 			*/
		      	B.KOR_STN_NM AS KOR_STN_NM,                         /* 소속역명(한글) 			*/
		        DECODE (B.REP_STN_FLG, ''Y'', ''Y'', '''') REP_STN_FLG,   /* 대표역여부 				*/
		        A.STGP_CD,  										/* 역그룹코드 				*/
		        CASE WHEN B.DEAL_TRN_CLSF_CD = ''00'' THEN ''KTX''
		        	 WHEN B.DEAL_TRN_CLSF_CD = ''07'' THEN ''KTX-산천''  
				ELSE ''새마을'' END DEAL_TRN_CLSF_CD, 					/* 취급열차종별코드 		*/
		        A.RS_STN_CD AS RS_STN_CD_1, 						/* 예발역코드(역그룹코드) 	*/
		        B.RS_STN_CD AS RS_STN_CD_2 							/* 예발역코드(소속역코드) 	*/
		  FROM (
				SELECT A.RS_STN_CD,     /* 예발역코드 			*/
       		   		   C.KOR_STN_NM,    /* 한글역명    			*/ 
		       		   A.STGP_CD        /* 역그룹코드 			*/
		  		  FROM TB_YYFD002 A, 	/* 역그룹핑내역 TBL 	*/
		       		   TB_YYDK001 B, 	/* 예발역코드 TBL		*/
					   TB_YYDK102 C     /* 역코드이력TBL 		*/
				 WHERE A.STGP_DEGR = ( SELECT STGP_DEGR
		                       			 FROM TB_YYFB001 /* 역그룹차수기본 */
		                      			WHERE APL_ST_DT <= TO_CHAR(SYSDATE, ''YYYYMMDD'')
		                        		  AND APL_CLS_DT >= TO_CHAR(SYSDATE, ''YYYYMMDD'')
		                     		  )
		    	   AND A.REP_STN_FLG 		= ''Y''
		    	   AND A.RS_STN_CD 			= B.RS_STN_CD
				   AND B.STN_CD 			= C.STN_CD
                   AND C.APL_ST_DT 			<= TO_CHAR(SYSDATE, ''YYYYMMDD'')
                   AND C.APL_CLS_DT 		>= TO_CHAR(SYSDATE, ''YYYYMMDD'')
		    	   AND B.DEAL_TRN_CLSF_CD 	IN(''00'',''01'')
		    	   AND A.STGP_CD IN ( SELECT DISTINCT A.STGP_CD     /* 역그룹코드 	*/
		                        		FROM TB_YYFD002 A 			/* 역그룹핑내역 TBL */
		                       		   WHERE EXISTS ( SELECT ''X''
		                                        		FROM TB_YYDK001     /* 예발역코드 TBL*/
		                                       		   WHERE RS_STN_CD 			= A.RS_STN_CD
		                                         		 AND  DEAL_TRN_CLSF_CD 	IN (''00'', ''01'')
		                                         		 AND  CHTN_STN_FLG 		IN (''Y'',''N'')
		                                    		 )
		                     		)                   
		   		   AND (#STGP_CD# IS NULL OR A.STGP_CD = #STGP_CD#)
					) A,
					( SELECT A.RS_STN_CD,		/* 예발역코드 			*/
		       		 		 C.KOR_STN_NM,		/* 한글역명    			*/
		       				 A.STGP_CD,			/* 역그룹코드 			*/
		       				 A.STGP_DEGR,		/* 역그룹차수			*/
		       				 A.REP_STN_FLG, 	/* 대표역여부			*/
		       				 B.DEAL_TRN_CLSF_CD /* 취급열차종별코드 	*/
		  				FROM TB_YYFD002 A, 		/* 역그룹핑내역 TBL 	*/
		       				 TB_YYDK001 B, 		/* 예발역코드 TBL		*/
							 TB_YYDK102 C       /* 역코드이력TBL 		*/
		 			   WHERE A.RS_STN_CD 	= B.RS_STN_CD
						 AND B.STN_CD	 	= C.STN_CD
						 AND C.APL_ST_DT	<= TO_CHAR(SYSDATE, ''YYYYMMDD'')
						 AND C.APL_CLS_DT	>= TO_CHAR(SYSDATE, ''YYYYMMDD'')
		   				 AND A.STGP_DEGR = ( SELECT STGP_DEGR
		                                       FROM TB_YYFB001 /* 역그룹차수기본 */
		                                      WHERE APL_ST_DT <= TO_CHAR(SYSDATE, ''YYYYMMDD'')
		                                        AND APL_CLS_DT >= TO_CHAR(SYSDATE, ''YYYYMMDD''))
					     AND B.DEAL_TRN_CLSF_CD IN (''00'', ''01'')
					     AND B.CHTN_STN_FLG 	IN (''Y'',''N'')
					     AND B.DEL_FLG 			= ''N''
					     AND (#STGP_CD# IS NULL OR A.STGP_CD = #STGP_CD#)
					) B
		  WHERE A.STGP_CD = B.STGP_CD
		    AND (#TRN_CLSF_CD# IS NULL OR B.DEAL_TRN_CLSF_CD LIKE #TRN_CLSF_CD#)
		 ORDER BY A.STGP_CD, A.RS_STN_CD, B.RS_STN_CD
]]>
', TO_DATE('04/16/2014 09:04:11', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA002QMDAO.selectListNonNmlPct', '/*com.korail.yz.yf.aa.YFAA002QMDAO.selectListNonNmlPct*/ 
<![CDATA[
SELECT /*+ com.korail.yz.yf.aa.YFAA002QMDAO.selectListNonNmlPct */
       DASP_DV_NO,       											/* DSP구분번호       	*/
       TO_CHAR(DASP_DV_STDR_PCT, ''FM0D00'') AS DASP_DV_STDR_PCT,		/* 기준비율	    	*/
       TO_CHAR(URG_ULMT_EXCS_PCT, ''FM0D00'') AS URG_ULMT_EXCS_PCT, 	/* 긴급상한초과비율	*/
       TO_CHAR(URG_LLMT_UNDR_PCT, ''FM0D00'') AS URG_LLMT_UNDR_PCT,	/* 긴급하한미만비율	*/
       TO_CHAR(CARE_ULMT_EXCS_PCT, ''FM0D00'') AS CARE_ULMT_EXCS_PCT,	/* 주의상한초과비율	*/
       TO_CHAR(CARE_LLMT_UNDR_PCT, ''FM0D00'') AS CARE_LLMT_UNDR_PCT,	/* 주의하한미만비율	*/
       TO_CHAR(CMNS_ULMT_EXCS_PCT, ''FM0D00'') AS CMNS_ULMT_EXCS_PCT,	/* 보통상한초과비율	*/
       TO_CHAR(CMNS_LLMT_UNDR_PCT, ''FM0D00'') AS CMNS_LLMT_UNDR_PCT,	/* 보통하한미만비율	*/
       REG_USR_ID,													/* 등록자ID	    	*/
       REG_DTTM,													/* 등록일시	    	*/
       CHG_USR_ID,													/* 변경자ID	    	*/
       CHG_DTTM     												/* 변경일시	    	*/
  FROM TB_YYFB005   												/* DSP구분 TBL		*/
]]>
', TO_DATE('04/02/2014 19:16:25', 'MM/DD/YYYY HH24:MI:SS'), 'ck2204');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA002QMDAO.updateNonNmlPct', '/*com.korail.yz.yf.aa.YFAA002QMDAO.updateNonNmlPct*/ 
<![CDATA[
		UPDATE /*+ com.korail.yz.yf.aa.YFAA002QMDAO.updateNonNmlPct */
			   TB_YYFB005											/* DSP구분 TBL		*/
		   SET URG_ULMT_EXCS_PCT 	= #URG_ULMT_EXCS_PCT#,  		/* 긴급상한초과비율 	*/
		       URG_LLMT_UNDR_PCT 	= #URG_LLMT_UNDR_PCT#,  		/* 긴급하한미만비율 	*/
		       CARE_ULMT_EXCS_PCT 	= #CARE_ULMT_EXCS_PCT#, 		/* 주의상한초과비율 	*/
		       CARE_LLMT_UNDR_PCT 	= #CARE_LLMT_UNDR_PCT#, 		/* 주의하한미만비율 	*/
		       CMNS_ULMT_EXCS_PCT 	= #CMNS_ULMT_EXCS_PCT#, 		/* 보통상한초과비율 	*/
		       CMNS_LLMT_UNDR_PCT 	= #CMNS_LLMT_UNDR_PCT#, 		/* 보통하한미만비율 	*/
		       CHG_USR_ID 			= #USER_ID#,   					/* 변경자ID			*/
		       CHG_DTTM 			= TO_CHAR(SYSDATE,''YYYYMMDD'')	/* 변경일시			*/
		WHERE DASP_DV_NO 			= #DASP_DV_NO#					/* DSP구분번호               */
		  AND DASP_DV_STDR_PCT 		= #DASP_DV_STDR_PCT#			/* 기준비율			*/

]]>
', TO_DATE('04/02/2014 19:16:25', 'MM/DD/YYYY HH24:MI:SS'), 'ck2204');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.deleteAbvCaus', '/*com.korail.yz.yf.aa.YFAA003QMDAO.deleteAbvCaus*/ 
<![CDATA[
		DELETE /*+ com.korail.yz.yf.aa.YFAA003QMDAO.deleteAbvCaus */
		  FROM TB_YYFC016	/* 이상분류코드TBL */
		 WHERE ABV_TRN_SRT_CD = #ABV_TRN_SRT_CD# /* 이상열차분류코드 */
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.deleteAbvTrn', '/*com.korail.yz.yf.aa.YFAA003QMDAO.deleteAbvTrn*/ 
<![CDATA[
		DELETE /*+ com.korail.yz.yf.aa.YFAA003QMDAO.deleteAbvTrn */
		  FROM TB_YYFD015									/* 이상열차내역TBL */
		 WHERE RUN_DT = #RUN_DT# 							/* 운행일자 */
		   AND TRN_NO = LPAD(LTRIM(#TRN_NO#, '' ''), 5, ''0'')	/* 열차번호 */
		   AND ABV_TRN_SRT_CD = #ABV_TRN_SRT_CD# 			/* 이상열차분류코드 */
]]>', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.insertAbvCaus', '/*com.korail.yz.yf.aa.YFAA003QMDAO.insertAbvCaus*/ 
<![CDATA[
		INSERT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.insertAbvCaus */
		  INTO TB_YYFC016 (
	       ABV_TRN_SRT_CD,          /* 이상열차분류코드 */
	       ABV_TRN_SRT_DSC_CONT,    /* 이상열차분류설명내용 */
		   REG_USR_ID,              /* 등록사용자ID */
		   REG_DTTM,                /* 등록일시 */
		   CHG_USR_ID,              /* 변경사용자ID */
		   CHG_DTTM                 /* 변경일시 */
			)
        VALUES
        (
           #ABV_TRN_SRT_CD#,
           #ABV_TRN_SRT_DSC_CONT#,
           #USER_ID#,
           TO_CHAR(SYSDATE, ''YYYYMMDDHH24MISS''),
           #USER_ID#,
           TO_CHAR(SYSDATE, ''YYYYMMDDHH24MISS'')
        )
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.insertAbvTrn', '/*com.korail.yz.yf.aa.YFAA003QMDAO.insertAbvTrn*/ 
<![CDATA[
		INSERT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.insertAbvTrn */
		  INTO TB_YYFD015 ( /*이상열차내역*/
		   RUN_DT, 					/* 운행일자(PK) 			*/
		   TRN_NO, 					/* 열차번호(PK) 			*/
		   ABV_TRN_SRT_CD,			/* 이상열차분류코드(PK/FK) */	
		   ABV_OCUR_CAUS_CONT,		/* 이상발생원인내용		*/       
		   REG_USR_ID,              /* 등록사용자ID 			*/
		   REG_DTTM,                /* 등록일시 				*/
		   CHG_USR_ID,              /* 변경사용자ID 			*/
		   CHG_DTTM                 /* 변경일시 				*/
			)
        VALUES
        (
           #RUN_DT#,
           LPAD(#TRN_NO#, 5, ''0''),
           #ABV_TRN_SRT_CD#,
           #ABV_OCUR_CAUS_CONT#,
           #USER_ID#,
           TO_CHAR(SYSDATE, ''YYYYMMDDHH24MISS''),
           #USER_ID#,
           TO_CHAR(SYSDATE, ''YYYYMMDDHH24MISS'')
        )
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvCausCnt', '/*com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvCausCnt*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvCausCnt*/
		       COUNT(*) 			AS QRY_CNT /*이상원인 건수*/
		  FROM TB_YYFC016	/* 이상분류코드TBL */
		 WHERE ABV_TRN_SRT_CD = #ABV_TRN_SRT_CD#	/* 이상열차분류코드 	*/
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvTrnAbrdPrnb', '/*com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvTrnAbrdPrnb*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvTrnAbrdPrnb */
				RUN_DT			AS RUN_DT,		/* 운행일자		*/
				TRN_NO			AS ABV_TRN_NO,	/* 이상열차번호	*/
				SUM(ABRD_PRNB) 	AS ABRD_PRNB 	/* 승차인원수		*/
		 FROM TB_YYDS507							/* 열차별승차인원집계TBL */
		WHERE RUN_DT = #RUN_DT#
		  AND TRN_NO = LPAD(LTRIM(#TRN_NO#, '' ''), 5, ''0'')
		GROUP BY RUN_DT, TRN_NO
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvTrnCnt', '/*com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvTrnCnt*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvCausCnt*/
		       COUNT(*) 			AS QRY_CNT /*이상원인 건수*/
		  FROM TB_YYFD015	/* 이상열차내역TBL	*/
		 WHERE ABV_TRN_SRT_CD 	= #ABV_TRN_SRT_CD#	/* 이상열차분류코드 	*/
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.selectCompTrnAbrdPrnb', '/*com.korail.yz.yf.aa.YFAA003QMDAO.selectCompTrnAbrdPrnb*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.selectCompTrnAbrdPrnb */
				TRN_NO 					AS COMP_TGT_TRN_NO,		/* 비교대상열차번호 */
				ROUND(AVG(ABRD_PRNB)) 	AS ABRD_PRNB			/* 승차인원수 */
		  FROM (
				SELECT  RUN_DT			AS RUN_DT, 				/* 운행일자 	*/
						TRN_NO			AS TRN_NO,				/* 열차번호 	*/ 
						SUM(ABRD_PRNB) 	AS ABRD_PRNB			/* 승차인원수 	*/
				  FROM TB_YYDS507								/* 열차별승차인원집계TBL */
				 WHERE RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT# 
				   AND TRN_NO = LPAD(LTRIM(#COMP_TGT_TRN_NO#, '' ''), 5, ''0'')
]]>
<isEqual property = "DAY_DV_CD" compareValue = "9">
				   AND TO_CHAR(TO_DATE(RUN_DT, ''YYYYMMDD''), ''D'') IN (''3'', ''4'', ''5'', ''6'')	/* 평요일(화~금) */
</isEqual>
<isNotEqual property = "DAY_DV_CD" compareValue = "0">
	<isNotEqual property = "DAY_DV_CD" compareValue = "8">
		<isNotEqual property = "DAY_DV_CD" compareValue = "9">
				   AND TO_CHAR(TO_DATE(RUN_DT, ''YYYYMMDD''), ''D'') = #DAY_DV_CD#
		</isNotEqual>
	</isNotEqual>
</isNotEqual>
<![CDATA[
				 GROUP BY RUN_DT, TRN_NO )
		GROUP BY TRN_NO
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.selectCompTrnAbrdPrnbPrDt', '/*com.korail.yz.yf.aa.YFAA003QMDAO.selectCompTrnAbrdPrnbPrDt*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.selectCompTrnAbrdPrnbPrDt */
				RUN_DT			AS RUN_DT, 				/* 운행일자 				*/
				TRN_NO			AS COMP_TGT_TRN_NO,		/* 비교대상열차번호 		*/ 
				SUM(ABRD_PRNB) 	AS ABRD_PRNB			/* 승차인원수 				*/
		  FROM TB_YYDS507								/* 열차별승차인원집계TBL 	*/
		 WHERE RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT# 
		   AND TRN_NO = LPAD(LTRIM(#COMP_TGT_TRN_NO#, '' ''), 5, ''0'')
]]>
<isEqual property = "DAY_DV_CD" compareValue = "9">
		   AND TO_CHAR(TO_DATE(RUN_DT, ''YYYYMMDD''), ''D'') IN (''3'', ''4'', ''5'', ''6'')	/* 평요일(화~금) */
</isEqual>
<isNotEqual property = "DAY_DV_CD" compareValue = "0">
	<isNotEqual property = "DAY_DV_CD" compareValue = "8">
		<isNotEqual property = "DAY_DV_CD" compareValue = "9">
		   AND TO_CHAR(TO_DATE(RUN_DT, ''YYYYMMDD''), ''D'') = #DAY_DV_CD#
		</isNotEqual>
	</isNotEqual>
</isNotEqual>
<![CDATA[
		 GROUP BY RUN_DT, TRN_NO
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.selectDlyTrnInfoCnt', '/*com.korail.yz.yf.aa.YFAA003QMDAO.selectDlyTrnInfoCnt*/ 
<![CDATA[
		SELECT /*+com.korail.yz.yf.aa.YFAA003QMDAO.selectDlyTrnInfoCnt */
			   COUNT(*)	AS QRY_CNT	/* 일일열차 건수 */
		  FROM TB_YYDK301 			/* 열차기본TBL */
		 WHERE RUN_DT = #RUN_DT#
		   AND TRN_NO = LPAD(LTRIM(#TRN_NO#, '' ''), 5, ''0'')
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.selectListAbvCaus', '/*com.korail.yz.yf.aa.YFAA003QMDAO.selectListAbvCaus*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.selectListAbvCaus*/
		        ABV_TRN_SRT_CD 			AS ABV_TRN_SRT_CD,		/* 이상열차분류코드 	*/
		        ABV_TRN_SRT_DSC_CONT 	AS ABV_TRN_SRT_DSC_CONT /* 이상열차분류설명내용 	*/
		  FROM TB_YYFC016	/* 이상분류코드TBL */
		ORDER BY ABV_TRN_SRT_CD
]]>', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.selectListAbvTrn', '/*com.korail.yz.yf.aa.YFAA003QMDAO.selectListAbvTrn*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.selectListAbvTrn*/
		   		RUN_DT AS RUN_DT,                             /* 운행 일자       		*/
		   		LPAD(LTRIM(TRN_NO,''0''), 5, '' '')	AS TRN_NO,    /* 열차번호        		*/
		   		TRN_NO AS O_TRN_NO,                           /* 원본 열차번호   	*/
		   		ABV_TRN_SRT_CD ,                              /* 이상열차분류코드  	*/
		   		ABV_OCUR_CAUS_CONT,		                      /* 이상발생원인내용  	*/
		   		REG_USR_ID,                                   /* 등록사용자ID    	*/
		   		REG_DTTM,                                     /* 등록일시               	*/
		   		CHG_USR_ID,                                   /* 변경사용자ID    	*/
		   		CHG_DTTM                                      /* 변경일시        		*/
		   FROM TB_YYFD015        							  /* 이상열차내역TBL	*/
		  WHERE ABV_TRN_SRT_CD 	= #ABV_TRN_SRT_CD#
]]>
<isNotEmpty property = "RUN_TRM_ST_DT">
		    AND RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
</isNotEmpty>
<![CDATA[
		    AND (#TRN_NO# IS NULL OR TRN_NO	= LPAD(LTRIM(#TRN_NO#, '' ''), 5, ''0''))
		ORDER BY  RUN_DT, TRN_NO, ABV_TRN_SRT_CD
]]>', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.selectListNmlTrn', '/*com.korail.yz.yf.aa.YFAA003QMDAO.selectListNmlTrn*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.yf.aa.YFAA003QMDAO.selectListNmlTrn */
			   DISTINCT LPAD(LTRIM(TRN_NO, 0), 5, '' '') AS TRN_NO
		  FROM TB_YYDK301 /* 열차기본TBL */
		 WHERE RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
		   AND TRN_NO NOT IN ( SELECT TRN_NO FROM TB_YYFD015 /* 이상열차내역TBL */
								WHERE RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT# 
								  AND ABV_TRN_SRT_CD = #ABV_TRN_SRT_CD# )
		   AND (#TRN_NO# IS NULL OR TRN_NO = LPAD( #TRN_NO#, 5, ''0'') )
	     ORDER BY TRN_NO
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.updateAbvCaus', '/*com.korail.yz.yf.aa.YFAA003QMDAO.updateAbvCaus*/ 
<![CDATA[
		UPDATE /*+ com.korail.yz.yf.aa.YFAA003QMDAO.updateAbvCaus */
		       TB_YYFC016     /* 이상분류코드TBL */
		   SET 
		       ABV_TRN_SRT_DSC_CONT = #ABV_TRN_SRT_DSC_CONT#,   			/* 이상열차분류설명내용 */
		       CHG_USR_ID           = #USER_ID#,		        			/* 변경사용자ID */
		       CHG_DTTM             = TO_CHAR(SYSDATE, ''YYYYMMDDHH24MISS'')	/* 변경일시 */
		 WHERE ABV_TRN_SRT_CD       = #ABV_TRN_SRT_CD#          			/* 이상열차분류코드 */
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.aa.YFAA003QMDAO.updateAbvTrn', '/*com.korail.yz.yf.aa.YFAA003QMDAO.updateAbvTrn*/ 
<![CDATA[
		UPDATE /*+ com.korail.yz.yf.aa.YFAA003QMDAO.updateAbvTrn */
		       TB_YYFD015     /* 이상열차내역TBL */
		   SET 
		       ABV_OCUR_CAUS_CONT	= #ABV_OCUR_CAUS_CONT#,					/* 이상발생원인내용 	*/
		       CHG_USR_ID           = #USER_ID#,		    				/* 변경사용자ID 		*/
		       CHG_DTTM             = TO_CHAR(SYSDATE, ''YYYYMMDDHH24MISS'')	/* 변경일시 			*/
		 WHERE RUN_DT       	= #RUN_DT# 								/* 운행일자 			*/
		   AND TRN_NO			= LPAD(LTRIM(#TRN_NO#, '' ''), 5, ''0'')	/* 열차번호 			*/
		   AND ABV_TRN_SRT_CD 	= #ABV_TRN_SRT_CD#						/* 이상열차분류코드 	*/
]]>
', TO_DATE('04/06/2014 19:27:04', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.ba.YFBA001QMDAO.selectExpChart', '/*com.korail.yz.yf.ba.YFBA001QMDAO.selectExpChart*/ 
<![CDATA[
SELECT SUBSTR(A.FCST_YM, 1,4) || SUBSTR(A.FCST_YM, 5, 2) FCST_YM,    /* 예측년월 */
      
           (
      SELECT VLID_VAL_NM  
        FROM TB_YYDK007 
       WHERE XROIS_OLD_SRT_CD =''Y002''
            AND VLID_VAL =    A.FCST_MDL_DV_CD
      )  MDL_KOR_NM,
       A.WEIT_AVG_FCST_ABRD_PRNB
FROM TB_YYFS202 A,    /* 요일별예측승차인원집계TBL */
     TB_YYFD203 C
WHERE A.TRN_CLSF_CD = #TRN_CLSF_CD#    /* 열차종별코드 */
AND A.DPT_STGP_CD = #DPT_STGP_CD#
AND A.ARV_STGP_CD = #ARV_STGP_CD#
AND A.DAY_DV_CD = #DAY_DV_CD# 
AND A.STGP_DEGR = ( SELECT STGP_DEGR
                          FROM TB_YYFB001    /*    역그룹차수기본    */
                   WHERE  APL_ST_DT <= TO_CHAR( SYSDATE, ''yyyymmdd'' )
                   AND    APL_CLS_DT >= TO_CHAR( SYSDATE, ''yyyymmdd'' ))
AND C.FCST_ACHV_DT = (SELECT MAX(FCST_ACHV_DT)    /* 예측수행일자 */
                              FROM TB_YYFD203
                     WHERE TRN_CLSF_CD = #TRN_CLSF_CD#)     /* 열차종별코드 */
AND C.STGP_DEGR = A.STGP_DEGR
AND C.DAY_DV_CD = A.DAY_DV_CD
AND C.DPT_STGP_CD = A.DPT_STGP_CD
AND C.ARV_STGP_CD = A.ARV_STGP_CD
AND C.FCST_MDL_DV_CD = A.FCST_MDL_DV_CD    /* 예측모형구분코드 */
AND A.FCST_ACHV_DT = C.FCST_ACHV_DT    /* 예측수행일자 */

UNION ALL

SELECT SUBSTR(RUN_YM, 1,4) || SUBSTR(RUN_YM, 5, 2),    /* 운행년월 */
       ''실적'' KOR_CD_VAL,
       WEIT_AVG_ABRD_PRNB    /* 가중평균승차인원수 */
FROM TB_YYFS201    /* 요일별실적승차인원집계TBL */
WHERE TRN_CLSF_CD = #TRN_CLSF_CD#     /* 열차종별코드 */
AND DPT_STGP_CD = #DPT_STGP_CD#
AND ARV_STGP_CD = #ARV_STGP_CD#
AND DAY_DV_CD = #DAY_DV_CD#
AND STGP_DEGR = ( SELECT STGP_DEGR
                        FROM TB_YYFB001
                  WHERE  APL_ST_DT <= TO_CHAR( SYSDATE, ''yyyymmdd'' )
                  AND    APL_CLS_DT >= TO_CHAR( SYSDATE, ''yyyymmdd'' ))
ORDER BY MDL_KOR_NM, FCST_YM
]]>

', TO_DATE('04/16/2014 20:52:41', 'MM/DD/YYYY HH24:MI:SS'), 'ck2204');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.ba.YFBA001QMDAO.selectExpModel', '/*com.korail.yz.yf.ba.YFBA001QMDAO.selectExpModel*/ 
<![CDATA[
	SELECT /*+	com.korail.yz.yf.ba.YFBA001QMDAO.selectExpModel	*/
       A.FCST_ACHV_DT,        /* 예측수행일자     */
       A.FCST_MDL_DV_CD,    /* 예측모형구분코드 */
       B.VLID_VAL_KOR_AVVR_NM,  /* 유효 한글어 값     */
       A.DAY_DV_CD,         /* 요일구분코드 */
       A.DPT_STGP_CD,     /* 출발역그룹코드 */
       A.ARV_STGP_CD,      /* 도착역그룹코드 */
       A.STGP_DEGR,     /* 역그룹차수 */
       A.FCST_ERRO_RT,     /* 예측오차율 */
       A.FCST_MDL_SEL_FLG,     /* 예측모형선택여부 */
       A.REG_USR_ID,     /* 등록사용자ID */
       A.REG_DTTM,         /* 등록일시 */
       A.CHG_USR_ID,     /* 변경사용자ID */
       A.CHG_DTTM        /* 변경일시 */
	FROM TB_YYFD203 A,    /* 예측오차율내역TBL */
     	(
      	SELECT * 
       	FROM TB_YYDK007 
      	WHERE XROIS_OLD_SRT_CD =''Y002''
     	) B
	WHERE A.TRN_CLSF_CD = #TRN_CLSF_CD#    /* 열차종별코드 */
	AND A.DPT_STGP_CD = #DPT_STGP_CD#    /* 출발역그룹코드 */
	AND A.ARV_STGP_CD = #ARV_STGP_CD#   /* 도착역그룹코드 */
	AND A.STGP_DEGR = ( SELECT STGP_DEGR
                       	FROM   TB_YYFB001
                  		WHERE  APL_ST_DT <= TO_CHAR( SYSDATE, ''YYYYMMDD'' )
    AND    APL_CLS_DT >= TO_CHAR( SYSDATE, ''YYYYMMDD'' ))
	AND A.DAY_DV_CD = #DAY_DV_CD# 
	AND A.FCST_MDL_DV_CD = B.VLID_VAL
	AND A.FCST_ACHV_DT = ( SELECT MAX(FCST_ACHV_DT) FROM TB_YYFD203    /* 예측오차율내역TBL */
                      		WHERE  TRN_CLSF_CD = #TRN_CLSF_CD# )
	ORDER BY FCST_MDL_DV_CD DESC
]]>
', TO_DATE('04/16/2014 20:52:41', 'MM/DD/YYYY HH24:MI:SS'), 'ck2204');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.ba.YFBA001QMDAO.selectListMthSTGP', '/*com.korail.yz.yf.ba.YFBA001QMDAO.selectListMthSTGP*/ 
<![CDATA[
  SELECT 
		 a.TRN_CLSF_CD,
		 b.DPT_STGP_CD DPT_STGP_CD,
         b.ARV_STGP_CD ARV_STGP_CD,
         SUBSTR (a.FCST_YM, 1, 4) || ''년'' || SUBSTR (a.FCST_YM, 5, 2) || ''월''
            FCST_YM,
         ''02'' DIV,
         SUM (DECODE (b.DAY_DV_CD, ''1'', 1, 0) * WEIT_AVG_FCST_ABRD_PRNB)
            SUN_ABRD_PSNO,                                   /* 가중평균예측승차인원수 */
         SUM (DECODE (b.DAY_DV_CD, ''2'', 1, 0) * WEIT_AVG_FCST_ABRD_PRNB)
            MON_ABRD_PSNO,                                   /* 가중평균예측승차인원수 */
         SUM (DECODE (b.DAY_DV_CD, ''3'', 1, 0) * WEIT_AVG_FCST_ABRD_PRNB)
            TUE_ABRD_PSNO,                                   /* 가중평균예측승차인원수 */
         SUM (DECODE (b.DAY_DV_CD, ''4'', 1, 0) * WEIT_AVG_FCST_ABRD_PRNB)
            WED_ABRD_PSNO,                                   /* 가중평균예측승차인원수 */
         SUM (DECODE (b.DAY_DV_CD, ''5'', 1, 0) * WEIT_AVG_FCST_ABRD_PRNB)
            THR_ABRD_PSNO,                                   /* 가중평균예측승차인원수 */
         SUM (DECODE (b.DAY_DV_CD, ''6'', 1, 0) * WEIT_AVG_FCST_ABRD_PRNB)
            FRI_ABRD_PSNO,                                   /* 가중평균예측승차인원수 */
         SUM (DECODE (b.DAY_DV_CD, ''7'', 1, 0) * WEIT_AVG_FCST_ABRD_PRNB)
            SAT_ABRD_PSNO,                                   /* 가중평균예측승차인원수 */
         b.DPT_STGP_CD DPT_CD,                                   /* 출발역그룹코드 */
         b.ARV_STGP_CD ARV_CD                                    /* 도착역그룹코드 */
    FROM TB_YYFS202 a,                               /*    요일별예측승차인원 TBL    */
                      TB_YYFD203 b               /*    예측오차율 TBL            */
   WHERE     b.TRN_CLSF_CD = #TRN_CLSF_CD#                        /* 열차종별코드 */
         AND (b.DPT_STGP_CD || ''_'' || b.ARV_STGP_CD) IN (#DPTARV_STGP_CD#)
         AND b.DPT_STGP_CD IN (#DPT_STGP_CD#)                    /* 출발역그룹코드 */
         AND b.ARV_STGP_CD IN (#ARV_STGP_CD#)                    /* 도착역그룹코드 */
         AND b.STGP_DEGR =
                (SELECT STGP_DEGR                                  /* 역그룹차수 */
                   FROM TB_YYFB001                            /* 역그룹차수기본TBL */
                  WHERE     APL_ST_DT <= TO_CHAR (SYSDATE, ''YYYYMMDD'')
                        AND APL_CLS_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD''))
         AND b.FCST_ACHV_DT = (SELECT MAX (FCST_ACHV_DT)
                                 FROM TB_YYFD203
                                WHERE TRN_CLSF_CD = #TRN_CLSF_CD#) /* 예측수행일자 */
         AND b.FCST_MDL_SEL_FLG = ''Y''                           /* 예측모형선택여부 */
         AND a.TRN_CLSF_CD = #TRN_CLSF_CD#                        /* 열차종별코드 */
         AND a.FCST_YM BETWEEN #RUN_YMFrom# AND #RUN_YMTo#          /* 예측년월 */
         AND a.DPT_STGP_CD = b.DPT_STGP_CD                       /* 출발역그룹코드 */
         AND a.ARV_STGP_CD = b.ARV_STGP_CD                       /* 도착역그룹코드 */
         AND a.FCST_MDL_DV_CD = b.FCST_MDL_DV_CD                /* 예측모형구분코드 */
         AND a.FCST_ACHV_DT = b.FCST_ACHV_DT                      /* 예측수행일자 */
         AND a.DAY_DV_CD = b.DAY_DV_CD                          /* 요일구분코드 */
         AND a.STGP_DEGR = b.STGP_DEGR                             /* 역그룹차수 */
GROUP BY a.TRN_CLSF_CD, b.DPT_STGP_CD, b.ARV_STGP_CD, a.FCST_YM
UNION ALL
  SELECT 
		 c.TRN_CLSF_CD,
		 c.DPT_STGP_CD DPT_STGP_CD,
         c.ARV_STGP_CD ARV_STGP_CD,
         SUBSTR (c.RUN_YM, 1, 4) || ''년'' || SUBSTR (c.RUN_YM, 5, 2) || ''월''
            RUN_YM,                                                 /* 운행년월 */
         ''01'' DIV,
         SUM (DECODE (c.DAY_DV_CD, ''1'', 1, 0) * NVL (WEIT_AVG_ABRD_PRNB, 0))
            SUN_ABRD_PSNO,                                     /* 가중평균승차인원수 */
         SUM (DECODE (c.DAY_DV_CD, ''2'', 1, 0) * NVL (WEIT_AVG_ABRD_PRNB, 0))
            MON_ABRD_PSNO,                                     /* 가중평균승차인원수 */
         SUM (DECODE (c.DAY_DV_CD, ''3'', 1, 0) * NVL (WEIT_AVG_ABRD_PRNB, 0))
            TUE_ABRD_PSNO,                                     /* 가중평균승차인원수 */
         SUM (DECODE (c.DAY_DV_CD, ''4'', 1, 0) * NVL (WEIT_AVG_ABRD_PRNB, 0))
            WED_ABRD_PSNO,                                     /* 가중평균승차인원수 */
         SUM (DECODE (c.DAY_DV_CD, ''5'', 1, 0) * NVL (WEIT_AVG_ABRD_PRNB, 0))
            THR_ABRD_PSNO,                                     /* 가중평균승차인원수 */
         SUM (DECODE (c.DAY_DV_CD, ''6'', 1, 0) * NVL (WEIT_AVG_ABRD_PRNB, 0))
            FRI_ABRD_PSNO,                                     /* 가중평균승차인원수 */
         SUM (DECODE (c.DAY_DV_CD, ''7'', 1, 0) * NVL (WEIT_AVG_ABRD_PRNB, 0))
            SAT_ABRD_PSNO,                                     /* 가중평균승차인원수 */
         c.DPT_STGP_CD DPT_CD,
         c.ARV_STGP_CD ARV_CD
    FROM TB_YYFS201 c                                        /*요일별실적승차인원 TBL*/
   WHERE     c.TRN_CLSF_CD = #TRN_CLSF_CD#                        /* 열차종별코드 */
         AND (c.DPT_STGP_CD || ''_'' || c.ARV_STGP_CD) IN (#DPTARV_STGP_CD#)
         AND c.DPT_STGP_CD IN (#DPT_STGP_CD#)
         AND c.ARV_STGP_CD IN (#ARV_STGP_CD#)
         AND c.RUN_YM BETWEEN #RUN_YMFrom# AND #RUN_YMTo#
         AND c.STGP_DEGR =
                (SELECT STGP_DEGR
                   FROM TB_YYFB001                               /*역그룹차수 TBL*/
                  WHERE     APL_ST_DT <= TO_CHAR (SYSDATE, ''YYYYMMDD'')
                        AND APL_CLS_DT >= TO_CHAR (SYSDATE, ''YYYYMMDD''))
GROUP BY c.TRN_CLSF_CD, c.DPT_STGP_CD, c.ARV_STGP_CD, c.RUN_YM
ORDER BY DPT_CD,
         ARV_CD,
         FCST_YM,
         DIV
]]>
', TO_DATE('04/16/2014 20:52:41', 'MM/DD/YYYY HH24:MI:SS'), 'ck2204');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yf.ba.YFBA001QMDAO.updateMdDv', '/*com.korail.yz.yf.ba.YFBA001QMDAO.updateMdDv*/ 
<![CDATA[
UPDATE TB_YYFD203
SET FCST_MDL_SEL_FLG = #FCST_MDL_SEL_FLG#,
	CHG_USR_ID = #CHG_USR_ID#,
	CHG_DTTM = TO_CHAR(SYSDATE, ''YYYYMMDDHH24MISS'')
 WHERE TRN_CLSF_CD = #TRN_CLSF_CD#
 AND   FCST_ACHV_DT =   #FCST_ACHV_DT#
 AND   STGP_DEGR = ( SELECT STGP_DEGR 
                       FROM   TB_YYFB001
                      WHERE  APL_ST_DT <= TO_CHAR( SYSDATE, ''YYYYMMDD'' ))
 AND   DPT_STGP_CD = #DPT_STGP_CD#
 AND   ARV_STGP_CD = #ARV_STGP_CD#
 AND   DAY_DV_CD   = #DAY_DV_CD#
 AND   FCST_MDL_DV_CD = #FCST_MDL_DV_CD#
]]>
', TO_DATE('04/16/2014 20:52:41', 'MM/DD/YYYY HH24:MI:SS'), 'ck2204');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA001QMDAO.selectListTrnPrDatePrRunAcvmQry', '/*com.korail.yz.yr.aa.YRAA001QMDAO.selectListTrnPrDatePrRunAcvmQry*/ 
<![CDATA[
/*
초과예약적용여부 다국어처리 필요
일단 그냥 진행
YYDK305.SEAT_ATT_CD 2BYTE -> 3BYTE로 변경 . 앞에 0 더 붙임.
UP_DN_DV_CD AS-IS와 TO-BE 코드값이 상이함.
TO-BE (A(상하행), D(하행), U(상행))
AS-IS (''%''(상하행), D(하행), U(상행))

*/
SELECT Z.*
FROM   (SELECT  A.STLB_TRN_CLSF_CD,
                A.RUN_DT,
                /* 운행일자         */
                A.TRN_NO,
                /* 열차번호         */
                A.ROUT_CD,
                /* 노선코드         */
                C.ROUT_NM,
                /* 노선명           */
                A.SHTM_EXCS_RSV_ALLW_FLG,
                /* 초과예약적용여부 */
                ( SELECT VLID_VAL_KOR_AVVR_NM
                FROM    TB_YYDK007
                WHERE   XROIS_OLD_SRT_CD = ''T305''
                AND     DOMN_NM          = ''RUN_DV_CD''
                AND     VLID_VAL         = A.RUN_DV_CD
                ) RUN_DV_CD,
                /* 운행구분코드     */
                A.YMS_APL_FLG,
                /* 할당량 잔여석에 운열일자와 열차번호가 있으면
                수익관리가 되고있다고 간주하고
                NULL이면 YMS_APL_FLG NULL이 아니면 ''Y''이*/
                DECODE(
                         (SELECT ''Y''
                         FROM    TB_YYDK328
                         WHERE   RUN_DT = A.RUN_DT
                         AND     TRN_NO = A.TRN_NO
                         AND     ROWNUM = 1
                         )
                       , NULL,
                       A.YMS_APL_FLG,
                       ''Y'') YMS_REAL_FLG,
                /* YMS상태        */
                A.ORG_RS_STN_CD,
                /* 시발예발역코드 */
                A.TMN_RS_STN_CD,
                /* 종착예발역코드 */
                ( SELECT B.KOR_STN_NM
                FROM    TB_YYDK001 A,
                        TB_YYDK102 B
                WHERE   1           =1
                AND     A.RS_STN_CD = SUBSTR(A.ORG_RS_STN_CD,2,5)
                AND     A.STN_CD    = B.STN_CD
                AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
                )
                         || ''-''
                         ||
                ( SELECT B.KOR_STN_NM
                FROM    TB_YYDK001 A,
                        TB_YYDK102 B
                WHERE   1           =1
                AND     A.RS_STN_CD = SUBSTR(A.TMN_RS_STN_CD,2,5)
                AND     A.STN_CD    = B.STN_CD
                AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
                )
                         || ''(''
                         ||
                (SELECT TO_CHAR(TO_DATE(DPT_TM, ''hh24miss''), ''hh24:mi'')
                FROM    TB_YYDK302
                        /** 일일열차운행시각 **/
                WHERE   RUN_DT   = A.RUN_DT
                AND     TRN_NO   = A.TRN_NO
                AND     RUN_ORDR = 1
                )
                         || ''-''
                         ||
                (SELECT TO_CHAR(TO_DATE(ARV_TM, ''hh24miss''), ''hh24:mi'')
                FROM    TB_YYDK302
                        /** 일일열차운행시각 **/
                WHERE   RUN_DT   = A.RUN_DT
                AND     TRN_NO   = A.TRN_NO
                AND     RUN_ORDR =
                        (SELECT MAX(RUN_ORDR)
                        FROM    TB_YYDK302
                        WHERE   RUN_DT = A.RUN_DT
                        AND     TRN_NO = A.TRN_NO
                        )
                )
                         || '')'' RUN_INFO,
                /* 운행구간정보 */
                SUM(B.SEAT_NUM) SEAT_NUM,
                /* 좌석수          */
                SUM(D.REAL_SEAT_NUM) REAL_SEAT_NUM,
                /* 실제 발매좌석수 */
                ROUND ( SUM(B.SEAT_CRKM), 0) SEAT_CRKM,
                /* 좌석키로        */
                ROUND ( SUM(B.ABRD_PKLO), 0) ABRD_PKLO,
                /* 인키로          */
                SUM(B.ABRD_PRNB) + DECODE(#SMG_ABRD_FLG#,''Y'',
                                          SUM(B.SMG_ABRD_PRNB),
                                          0) + DECODE(#CMTR_ABRD_FLG#,''Y'',
                                                      SUM(CMTR_ABRD_PRNB),
                                                      0) ABRD_PRNB,
                /* 승차인원        */
                
    ROUND ( SUM(B.ABRD_PKLO) / SUM(B.SEAT_CRKM) * 100, 1) ABRD_RT,
                /* 승차율          */

                ROUND( (SUM(B.ABRD_PRNB) + DECODE(#SMG_ABRD_FLG#,''Y'',
                                           SUM(B.SMG_ABRD_PRNB),
                                           0) + DECODE(#CMTR_ABRD_FLG#,''Y'',
                                                       SUM(CMTR_ABRD_PRNB),
                                                       0)) / SUM(B.SEAT_NUM) * 100, 1) UTL_RT,
                /* 이용율          */

                (SUM(B.ABRD_PRNB) + DECODE(#SMG_ABRD_FLG#,''Y'', SUM(B.SMG_ABRD_PRNB),0) + DECODE(#CMTR_ABRD_FLG#,''Y'', SUM(CMTR_ABRD_PRNB), 0)) / SUM(D.REAL_SEAT_NUM)  * 100 REAL_SEAT_RT,
                /* 좌석당 자투리의 비율  = 실제발매 이용율*/

                (SELECT SUM(BIZ_RVN_AMT - SMG_BIZ_RVN_AMT) + DECODE(#SMG_ABRD_FLG#,''Y'',
                                                                    SUM(SMG_BIZ_RVN_AMT),
                                                                    0) + DECODE(#CMTR_ABRD_FLG#,''Y'',
                                                                                SUM(CMTR_BIZ_RVN_AMT),
                                                                                0)
                FROM    TB_YYDS512
                        /** 수입금 **/
                WHERE   RUN_DT = A.RUN_DT
                AND     TRN_NO = A.TRN_NO
                )
                BIZ_RVN_AMT,

    ROUND(
                (SELECT SUM(BIZ_RVN_AMT - SMG_BIZ_RVN_AMT) + DECODE(#SMG_ABRD_FLG#,''Y'',
                                                       SUM(SMG_BIZ_RVN_AMT),
                                                        0) + DECODE(#CMTR_ABRD_FLG#,''Y'',
                                                                    SUM(CMTR_BIZ_RVN_AMT),
                                                                    0)
                FROM    TB_YYDS512
                        /** 수입금 **/
                WHERE   RUN_DT = A.RUN_DT
                AND     TRN_NO = A.TRN_NO
                )
                 / SUM(B.ABRD_PRNB), 0) EACH_PR_AMT,
                /* 1인당 수입 */
                
    ROUND(
                (SELECT SUM(BIZ_RVN_AMT - SMG_BIZ_RVN_AMT) + DECODE(#SMG_ABRD_FLG#,''Y'',
                                                       SUM(SMG_BIZ_RVN_AMT),
                                                        0) + DECODE(#CMTR_ABRD_FLG#,''Y'',
                                                                    SUM(CMTR_BIZ_RVN_AMT),
                                                                    0)
                FROM    TB_YYDS512
                        /** 수입금 **/
                WHERE   RUN_DT = A.RUN_DT
                AND     TRN_NO = A.TRN_NO
                )
                 / SUM(B.SEAT_NUM), 0) SEAT_PR_AMT,
                 /* 좌석당 수입 */

    ROUND(
                (SELECT SUM(BIZ_RVN_AMT - SMG_BIZ_RVN_AMT) + DECODE(#SMG_ABRD_FLG#,''Y'',
                                                       SUM(SMG_BIZ_RVN_AMT),
                                                        0) + DECODE(#CMTR_ABRD_FLG#,''Y'',
                                                                    SUM(CMTR_BIZ_RVN_AMT),
                                                                    0)
                FROM    TB_YYDS512
                        /** 수입금 **/
                WHERE   RUN_DT = A.RUN_DT
                AND     TRN_NO = A.TRN_NO
                )
                 / SUM(B.SEAT_CRKM), 2) CRKM_PR_AMT
                 /* 좌석KM당 수입 */



       FROM     TB_YYDK301 A,
                /* 일일열차정보  */
                TB_YYDS511 B,
                /* 열차별 승차율 */
                TB_YYDK201 C,
                /* 노선          */
                (SELECT  RUN_DT,
                         TRN_NO,
                         PSRM_CL_CD,
                         SUM(BS_SEAT_NUM - NOTY_SALE_SEAT_NUM) REAL_SEAT_NUM
                FROM     TB_YYDK305
                WHERE    RUN_DT           = #RUN_DT#
                AND      (#TRN_NO# IS NULL OR TRN_NO        LIKE #TRN_NO#)
                AND      (#PSRM_CL_CD# IS NULL OR PSRM_CL_CD    LIKE #PSRM_CL_CD#)

                /*AND      GEN_SEAT_DUP_FLG = ''N''*/

                AND      SEAT_ATT_CD IN(''003'',
                                        ''015'',
                                        ''016'',
                                        ''017'',
                                        ''018'',
                                        ''019'',
                                        ''020'',
                                        ''021'',
                                        ''022'',
                                        ''023'',
                                        ''024'',
                                        ''027'',
                                        ''028'')
                GROUP BY RUN_DT,
                         TRN_NO,
                         PSRM_CL_CD
                )
                D
       WHERE    
        A.RUN_DT        = #RUN_DT#
       AND      (#MRNT_CD# IS NULL OR C.MRNT_CD LIKE #MRNT_CD#)
       AND      C.MRNT_CD IN (''01'',
                                   ''03'',
                                   ''04'')
       AND      (#PSRM_CL_CD# IS NULL OR B.PSRM_CL_CD  LIKE #PSRM_CL_CD#)
       AND      C.EFC_ST_DT     <= #RUN_DT#
       AND      C.EFC_ST_DT     <= #RUN_DT#
       AND      (#ROUT_CD# IS NULL OR A.ROUT_CD     LIKE #ROUT_CD#)
       AND      (#STLB_TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD LIKE #STLB_TRN_CLSF_CD#)

       AND      A.UP_DN_DV_CD LIKE (CASE WHEN #UP_DN_DV_CD# = ''A'' THEN ''%'' ELSE #UP_DN_DV_CD# END)

       AND      (#TRN_NO# IS NULL OR A.TRN_NO      LIKE #TRN_NO#)
       AND      A.TRN_OPN_FLG    = ''Y''
       AND      A.TRN_SPS_FLG    = ''N''
       AND      A.RUN_DT         = B.RUN_DT(+)
       AND      A.TRN_NO         = B.TRN_NO(+)
       AND      A.ROUT_CD        = C.ROUT_CD
       AND      A.RUN_DT         = B.RUN_DT
       AND      A.TRN_NO         = B.TRN_NO
       AND      B.RUN_DT         = D.RUN_DT
       AND      B.TRN_NO         = D.TRN_NO
       AND      B.PSRM_CL_CD     = D.PSRM_CL_CD
       GROUP BY A.STLB_TRN_CLSF_CD,
                A.RUN_DT,
                A.TRN_NO,
                A.ROUT_CD,
                C.ROUT_NM,
                A.SHTM_EXCS_RSV_ALLW_FLG,
                A.YMS_APL_FLG,
                A.RUN_DV_CD,
                A.ORG_RS_STN_CD,
                A.TMN_RS_STN_CD
       ORDER BY A.RUN_DT,
                A.TRN_NO
       )
       Z
WHERE  (#YMS_APL_FLG# IS NULL OR Z.YMS_REAL_FLG LIKE #YMS_APL_FLG#)

]]>
', TO_DATE('03/26/2014 15:43:14', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA002QMDAO.selectListDtlAcvmQry', '/*com.korail.yz.yr.aa.YRAA002QMDAO.selectListDtlAcvmQry*/ 
<![CDATA[

/** SEAT_ATT_CD 3BYTE인데 샘플데이터가 아직 2BYTE인 관계로
SUBSTR해서 사용함 
그리고 NUMBER에서 CHAR로 변경됨
**/
SELECT TRN_NO,
               SEG_GP_NO,
               ORDR,
               ORDR2,
               DPT_STN_CONS_ORDR,
               ARV_STN_CONS_ORDR,
			   TO_CHAR(SEG_GP_NO)||DPT_INFO||ARV_INFO SEG_DPT_ARV_CHT,
               DPT_INFO,
               ARV_INFO,
               PSRM_CL_NM,
               BKCL_CD,
               BKCL_NM,
			   PSRM_CL_NM||''/''||BKCL_NM PSRM_BKCL_NM_CHT,
               ABRD_PRNB,
               BIZ_RVN_AMT,
               NVL(RATIO_TO_REPORT(ABRD_PRNB) OVER (), 0)   * 100 AS ABRD_RT,
               NVL(RATIO_TO_REPORT(BIZ_RVN_AMT) OVER (), 0) * 100 AS BIZ_RVN_AMT_RT,
               BKCLS_ORDR
       FROM    ( SELECT  A.TRN_NO,
                        /* 열차번호         */
                        F.SEG_GP_NO,
                        /* 구역구간그룹번호 */
                        LPAD(TO_CHAR(C.RUN_ORDR), 2, '' '') ORDR,
                        /* 출발역 운행순서  */
                        LPAD(TO_CHAR(D.RUN_ORDR), 2, '' '') ORDR2,
                        /* 도착역 운행순서  */
                        A.DPT_STN_CONS_ORDR,
                        /* 출발역 구성순서  */
                        A.ARV_STN_CONS_ORDR,
                        /* 도착역 구성순서  */
                        (SELECT B.KOR_STN_NM
                        FROM    TB_YYDK001 A,
                                TB_YYDK102 B
                        WHERE   1           =1
                        AND     A.RS_STN_CD = C.STOP_RS_STN_CD
                        AND     A.STN_CD    = B.STN_CD
                        AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
                        )
                                 || ''(''
                                 || SUBSTR(C.DPT_TM, 1, 2)
                                 || '':''
                                 || SUBSTR(C.DPT_TM, 3, 2)
                                 || '')'' DPT_INFO,
                        /* 출발역/시각  */
                        (SELECT B.KOR_STN_NM
                        FROM    TB_YYDK001 A,
                                TB_YYDK102 B
                        WHERE   1           =1
                        AND     A.RS_STN_CD = D.STOP_RS_STN_CD
                        AND     A.STN_CD    = B.STN_CD
                        AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
                        )
                                 || ''(''
                                 || SUBSTR(D.ARV_TM, 1, 2)
                                 || '':''
                                 || SUBSTR(D.ARV_TM, 3, 2)
                                 || '')'' ARV_INFO,
                        /* 도착역/시각  */
                        A.PSRM_CL_CD,
                        /* 객실등급코드 */
                        (SELECT VLID_VAL_KOR_AVVR_NM
                        FROM    TB_YYDK007
                        WHERE   XROIS_OLD_SRT_CD = ''R408''
                        AND     DOMN_NM          = ''PSRM_CL_CD''
                        AND     VLID_VAL         = A.PSRM_CL_CD
                        )
                        PSRM_CL_NM,
                        /* 객실등급명 */
                        A.BKCL_CD,
                        /* 할인등급코드 */
                        (SELECT VLID_VAL_KOR_AVVR_NM
                        FROM    TB_YYDK007
                        WHERE   XROIS_OLD_SRT_CD = ''R507''
                        AND     DOMN_NM          = ''MRK_CL_CD''
                        AND     VLID_VAL         = A.BKCL_CD
                        )
                        BKCL_NM,
                        /* MRK_CL_CD 확실치 않음. */
                        /* 할인등급명   */
                        /* 왜 있는지 몰라서 주석처리
                        A.BKCL_CD BKCL_ORDR,*/
                        /* 할인등급순서   */
                        NVL(AVG(B.ABRD_PRNB), 0) ABRD_PRNB,
                        /* 승차인원     */
                        NVL(AVG(BB.BIZ_RVN_AMT), 0) BIZ_RVN_AMT,
                        /* 영업수입     */
                        /*TO_CHAR(G.ENG_CD_VAL_AVVR, ''00'') BKCLS_ORDR*/
                        /*TO_CHAR(G.VLID_VAL_ENGM_FOML_NM, ''00'') BKCL_ORDR*/
                        G.VLID_VAL_ENGM_FOML_NM BKCLS_ORDR,
                        SUM(B.ABRD_PRNB) SUM_ABRD_PRNB,
                        /* 승차점유율 */
                        SUM(BB.BIZ_RVN_AMT) SUM_BIZ_RVN_AMT
                        /* 수입점유율 */
                        /**/
               FROM     (SELECT  A.RUN_DT,
                                 /* 운행일자         */
                                 A.TRN_NO,
                                 /* 열차번호         */
                                 A.PSRM_CL_CD,
                                 /* 객실등급코드     */
                                 A.BKCL_CD,
                                 /* 할인등급코드     */
                                 B.DPT_STN_CONS_ORDR,
                                 /* 출발역 구성순서  */
                                 B.ARV_STN_CONS_ORDR
                                 /* 도착역 구성순서  */
                        FROM     TB_YYDD504 A,
                                 /** 열차/객실/BOOKINGCLASS정보 **/
                                 TB_YYDD505 B
                                 /** 열차/구간정보              **/
                        WHERE    A.RUN_DT = B.RUN_DT
                        AND      A.TRN_NO = B.TRN_NO
                        AND      A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
                        AND      A.TRN_NO LIKE #TRN_NO#
                        AND
                                 (
                                          #PSRM_CL_CD# IS NULL
                                 OR       A.PSRM_CL_CD    LIKE #PSRM_CL_CD#
                                 )
                        AND
                                 (
                                          #BKCL_CD# IS NULL
                                 OR       A.BKCL_CD    LIKE #BKCL_CD#
                                 )
                        GROUP BY A.RUN_DT,
                                 A.TRN_NO,
                                 A.PSRM_CL_CD,
                                 A.BKCL_CD,
                                 B.DPT_STN_CONS_ORDR,
                                 B.ARV_STN_CONS_ORDR
                        )
                        A,
                        (SELECT  A.RUN_DT,
                                 /* 운행일자         */
                                 A.TRN_NO,
                                 /* 열차번호         */
                                 A.PSRM_CL_CD,
                                 /* 객실등급코드     */
                                 DECODE(A.BKCL_CD, ''F2'',
                                        ''F1'',
                                        A.BKCL_CD) BKCL_CD,
                                 /* 할인등급코드     */
                                 A.DPT_STN_CONS_ORDR,
                                 /* 출발역 구성순서  */
                                 A.ARV_STN_CONS_ORDR,
                                 /* 도착역 구성순서  */
                                 SUM(A.ABRD_PRNB) ABRD_PRNB,
                                 /* 승차인원         */
                                 SUM(A.ABRD_POSN_RT) ABRD_POSN_RT,
                                 /* 승차점유율       */
                                 SUM(B.BIZ_RVN_AMT - B.SMG_BIZ_RVN_AMT) BIZ_RVN_AMT
                                 /* 영업수입         */
                        FROM     TB_YYDS510 A,
                                 /** 구간별 승차수입실적 **/
                                 TB_YYDS512 B
                                 /** 열차별 초과예약한도 **/
                        WHERE    A.RUN_DT            = B.RUN_DT(+)
                        AND      A.TRN_NO            = B.TRN_NO(+)
                        AND      A.PSRM_CL_CD        = B.PSRM_CL_CD(+)
                        AND      A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR(+)
                        AND      A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR(+)
                        AND      A.BKCL_CD           = B.BKCL_CD(+)
                        AND      A.SEAT_ATT_CD       = B.SEAT_ATT_CD(+)
                        AND      A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
                        AND      A.TRN_NO LIKE #TRN_NO#
                        AND
                                 (
                                          #PSRM_CL_CD# IS NULL
                                 OR       A.PSRM_CL_CD    LIKE #PSRM_CL_CD#
                                 )
                        AND
                                 (
                                          #BKCL_CD# IS NULL
                                 OR       A.BKCL_CD    LIKE DECODE(#BKCL_CD#, ''F1'',
                                                                   ''F%'',
                                                                   #BKCL_CD#)
                                 )
                        AND
                                 (
                                          TO_NUMBER(SUBSTR(#SEAT_ATT_CD#, 2, 3) ) IS NULL
                                 OR       A.SEAT_ATT_CD = TO_NUMBER(SUBSTR(#SEAT_ATT_CD#, 2, 3))
                                 )
                        GROUP BY A.RUN_DT,
                                 A.TRN_NO,
                                 A.PSRM_CL_CD,
                                 DECODE(A.BKCL_CD, ''F2'',
                                        ''F1'',
                                        A.BKCL_CD),
                                 A.DPT_STN_CONS_ORDR,
                                 A.ARV_STN_CONS_ORDR
                        )
                        B,
                        (SELECT  A.RUN_DT,
                                 /* 운행일자         */
                                 A.TRN_NO,
                                 /* 열차번호         */
                                 A.PSRM_CL_CD,
                                 /* 객실등급코드     */
                                 A.BKCL_CD,
                                 /* 할인등급코드     */
                                 A.DPT_STN_CONS_ORDR,
                                 /* 출발역 구성순서  */
                                 A.ARV_STN_CONS_ORDR,
                                 /* 도착역 구성순서  */
                                 SUM(A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT) BIZ_RVN_AMT
                                 /* 영업수입         */
                        FROM     TB_YYDS512 A,
                                 /** 구간별 승차수입실적 **/
                                 TB_YYDS510 B
                                 /** 열차별 초과예약한도 **/
                        WHERE    A.RUN_DT            = B.RUN_DT(+)
                        AND      A.TRN_NO            = B.TRN_NO(+)
                        AND      A.PSRM_CL_CD        = B.PSRM_CL_CD(+)
                        AND      A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR(+)
                        AND      A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR(+)
                        AND      A.BKCL_CD           = B.BKCL_CD(+)
                        AND      A.SEAT_ATT_CD       = B.SEAT_ATT_CD(+)
                        AND      A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
                        AND      A.TRN_NO LIKE #TRN_NO#
                        AND
                                 (
                                          #PSRM_CL_CD# IS NULL
                                 OR       A.PSRM_CL_CD    LIKE #PSRM_CL_CD#
                                 )
                        AND
                                 (
                                          #BKCL_CD# IS NULL
                                 OR       A.BKCL_CD    LIKE #BKCL_CD#
                                 )
                        AND
                                 (
                                          TO_NUMBER(SUBSTR(#SEAT_ATT_CD#, 2, 3)) IS NULL
                                 OR       A.SEAT_ATT_CD = TO_NUMBER(SUBSTR(#SEAT_ATT_CD#, 2, 3))
                                 )
                        GROUP BY A.RUN_DT,
                                 A.TRN_NO,
                                 A.PSRM_CL_CD,
                                 A.BKCL_CD,
                                 A.DPT_STN_CONS_ORDR,
                                 A.ARV_STN_CONS_ORDR
                        )
                        BB,
                        TB_YYDK302 C,
                        /** 일일열차운행시각 **/
                        TB_YYDK302 D,
                        /** 일일열차운행시각 **/
                        TB_YYDK301 E,
                        /** 일일열차정보     **/
                        TB_YYDK308 F,
                        /** 구역별구간그룹   **/
                        TB_YYDK007 G,
                        TB_YYDK201 H
               WHERE    A.RUN_DT                = B.RUN_DT(+)
               AND      A.TRN_NO                = B.TRN_NO(+)
               AND      A.PSRM_CL_CD            = B.PSRM_CL_CD(+)
               AND      A.BKCL_CD               = B.BKCL_CD(+)
               AND      A.DPT_STN_CONS_ORDR     = B.DPT_STN_CONS_ORDR(+)
               AND      A.ARV_STN_CONS_ORDR     = B.ARV_STN_CONS_ORDR(+)
               AND      BB.RUN_DT(+)            = A.RUN_DT
               AND      BB.TRN_NO(+)            = A.TRN_NO
               AND      BB.PSRM_CL_CD(+)        = A.PSRM_CL_CD
               AND      BB.BKCL_CD(+)           = A.BKCL_CD
               AND      BB.DPT_STN_CONS_ORDR(+) = A.DPT_STN_CONS_ORDR
               AND      BB.ARV_STN_CONS_ORDR(+) = A.ARV_STN_CONS_ORDR
               AND      A.RUN_DT                = C.RUN_DT
               AND      A.TRN_NO                = C.TRN_NO
               AND      A.DPT_STN_CONS_ORDR     = C.STN_CONS_ORDR
               AND      A.RUN_DT                = D.RUN_DT
               AND      A.TRN_NO                = D.TRN_NO
               AND      A.ARV_STN_CONS_ORDR     = D.STN_CONS_ORDR
               AND      A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
               AND      A.TRN_NO LIKE #TRN_NO#
               AND
                        (
                                 #PSRM_CL_CD# IS NULL
                        OR       A.PSRM_CL_CD    LIKE #PSRM_CL_CD#
                        )
               AND
                        (
                                 #BKCL_CD# IS NULL
                        OR       A.BKCL_CD    LIKE #BKCL_CD#
                        )
               AND      A.RUN_DT       = E.RUN_DT
               AND      A.TRN_NO       = E.TRN_NO
               AND      A.RUN_DT       = F.RUN_DT
               AND      A.TRN_NO       = F.TRN_NO
               AND      C.TRVL_ZONE_NO = DECODE(E.UP_DN_DV_CD, ''D'',
                                                F.DPT_ZONE_NO,
                                                F.ARV_ZONE_NO)
               AND      D.TRVL_ZONE_NO = DECODE(E.UP_DN_DV_CD, ''D'',
                                                F.ARV_ZONE_NO,
                                                F.DPT_ZONE_NO)
               AND      F.SEG_GP_NO BETWEEN TO_NUMBER(#ZONE_SEG_GP_NO_FROM#) AND      TO_NUMBER(#ZONE_SEG_GP_NO_TO#)
               AND      A.BKCL_CD          = G.VLID_VAL
               AND      G.XROIS_OLD_SRT_CD = ''R507''
               AND      E.ROUT_CD          = H.ROUT_CD
               AND
                        (
                                 #RUN_LN_CD# IS NULL
                        OR       H.MRNT_CD      LIKE #MRNT_CD#
                        )
               AND      H.MRNT_CD IN (''01'',
                                      ''03'',
                                      ''04'')
               GROUP BY A.TRN_NO,
                        F.SEG_GP_NO,
                        C.RUN_ORDR,
                        D.RUN_ORDR,
                        A.DPT_STN_CONS_ORDR,
                        A.ARV_STN_CONS_ORDR,
                        C.STOP_RS_STN_CD,
                        C.DPT_TM,
                        D.STOP_RS_STN_CD,
                        D.ARV_TM,
                        A.PSRM_CL_CD,
                        A.BKCL_CD,
                        G.VLID_VAL_ENGM_FOML_NM
               )

ORDER BY SEG_GP_NO ASC
]]>
', TO_DATE('04/01/2014 16:21:33', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA002QMDAO.selectTrnBaseInfoQry', '/*com.korail.yz.yr.aa.YRAA002QMDAO.selectTrnBaseInfoQry*/ 
<![CDATA[
SELECT TO_CHAR(TO_DATE(A.RUN_DT),''YYYY-MM-DD'')||'' ''||
       (SELECT VLID_VAL_KOR_AVVR_NM
       FROM    TB_YYDK007
       WHERE   XROIS_OLD_SRT_CD = ''I909''
       AND     DOMN_NM          = ''DAY_DV_CD''
       AND     VLID_VAL         = B.DAY_DV_CD
       )
       RUN_DT,
       /*요일*/
       LPAD( TO_NUMBER( A.TRN_NO ), 5, ''0'' ) TRN_NO,
       (SELECT VLID_VAL_KOR_AVVR_NM
       FROM    TB_YYDK007
       WHERE   XROIS_OLD_SRT_CD = ''T305''
       AND     DOMN_NM          = ''RUN_DV_CD''
       AND     VLID_VAL         = A.RUN_DV_CD
       )
       RUN_DV_NM,
       /*RUN_DV_NM*/
       (SELECT VLID_VAL_KOR_AVVR_NM
       FROM    TB_YYDK007
       WHERE   XROIS_OLD_SRT_CD = ''R027''
       AND     DOMN_NM          = ''STLB_TRN_CLSF_CD''
       AND     VLID_VAL         = A.STLB_TRN_CLSF_CD
       )
       TRN_CLSF_NM,
       /*RUN_DV_NM*/
       C.ROUT_NM,
                        (SELECT B.KOR_STN_NM
                        FROM    TB_YYDK001 A,
                                TB_YYDK102 B
                        WHERE   1           =1
                        AND     A.RS_STN_CD = SUBSTR(A.ORG_RS_STN_CD, 2, 5)
                        AND     A.STN_CD    = B.STN_CD
                        AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
                        )
              || ''-''
              || 
                        (SELECT B.KOR_STN_NM
                        FROM    TB_YYDK001 A,
                                TB_YYDK102 B
                        WHERE   1           =1
                        AND     A.RS_STN_CD = SUBSTR(A.TMN_RS_STN_CD, 2, 5)
                        AND     A.STN_CD    = B.STN_CD
                        AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
                        )
              || ''(''
              ||
       ( SELECT TO_CHAR( TO_DATE( DPT_TM, ''hh24miss'' ), ''hh24:mi'' )
       FROM    TB_YYDK302
       WHERE   RUN_DT   = A.RUN_DT
       AND     TRN_NO   = A.TRN_NO
       AND     RUN_ORDR = 1
       )
              || ''-''
              ||
       ( SELECT TO_CHAR( TO_DATE( ARV_TM, ''hh24miss'' ), ''hh24:mi'' )
       FROM    TB_YYDK302
       WHERE   RUN_DT   = A.RUN_DT
       AND     TRN_NO   = A.TRN_NO
       AND     RUN_ORDR =
               ( SELECT MAX( RUN_ORDR )
               FROM    TB_YYDK302
               WHERE   RUN_DT = A.RUN_DT
               AND     TRN_NO = A.TRN_NO
               )
       )
              || '')'' RUN_INFO,
       DECODE( A.YMS_APL_FLG, ''Y'',
              ''적용'',
              ''해제'' ) YMS_FLG,
       A.SHTM_EXCS_RSV_ALLW_FLG,
       A.STOP_STN_NUM,
       A.PSC_NUM,
       ( SELECT SUM( SEAT_NUM )
       FROM    TB_YYDK303
       WHERE   RUN_DT = A.RUN_DT
       AND     TRN_NO = A.TRN_NO
       )
       SEAT_CNT
FROM   TB_YYDK301 A,
       TB_YYDK002 B,
       TB_YYDK201 C
WHERE  A.RUN_DT      = B.RUN_DT
AND    A.ROUT_CD     = C.ROUT_CD
AND    A.RUN_DT      = #RUN_TRM_CLS_DT#
AND    A.TRN_NO      = #TRN_NO#
AND    C.EFC_ST_DT  <= #RUN_TRM_CLS_DT#
AND    C.EFC_CLS_DT >= #RUN_TRM_CLS_DT#

]]>
', TO_DATE('04/01/2014 16:21:33', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA002QMDAO.selectTrnRunInfoQry', '/*com.korail.yz.yr.aa.YRAA002QMDAO.selectTrnRunInfoQry*/ 
<![CDATA[
SELECT ROUND(SEAT_NUM, 0) SEAT_NUM,
       ROUND(SEAT_CRKM, 0) SEAT_CRKM,
       ROUND(ABRD_PKLO, 0) ABRD_PKLO,
       ROUND(ABRD_PRNB, 0) ABRD_PRNB,
       ROUND(ABRD_RT, 3) * 100 ABRD_RT,
	   ROUND(UTL_RT, 3) * 100 UTL_RT,
       ROUND(BIZ_RVN_AMT, 0) BIZ_RVN_AMT,
	   ROUND( BIZ_RVN_AMT / SEAT_NUM, 0)  SEAT_PR_AMT,
       ROUND( BIZ_RVN_AMT / SEAT_CRKM, 0) SEAT_CRKM_PR_AMT,
       ROUND( BIZ_RVN_AMT / ABRD_PRNB, 0) EACH_PR_AMT
FROM   ( SELECT  SUM(B.SEAT_NUM) SEAT_NUM,
                /** 좌석수(화면엔 없음) **/
                SUM(B.SEAT_CRKM) SEAT_CRKM,
                /** 좌석공급 KM **/
                SUM(B.ABRD_PKLO) ABRD_PKLO,
                /** 이용인원 인KM **/
                SUM(B.ABRD_PRNB) ABRD_PRNB,
                /** 승차인원 **/
                SUM(B.ABRD_PKLO) / SUM(B.SEAT_CRKM) ABRD_RT,
                /** 승차율 **/
                SUM(B.ABRD_PRNB) / SUM(B.SEAT_NUM) UTL_RT,
                /** 이용율* */
                (SELECT SUM(C.BIZ_RVN_AMT) BIZ_RVN_AM
                        /** 영업수입 **/
                FROM    TB_YYDS510 A,
                        /** 구간별 승차수입실적 **/
                        TB_YYDS512 C
                        /** 열차별 초과예약한도 **/
                WHERE   C.RUN_DT             = A.RUN_DT(+)
                AND     C.TRN_NO             = A.TRN_NO(+)
                AND     C.PSRM_CL_CD         = A.PSRM_CL_CD(+)
                AND     C.DPT_STN_CONS_ORDR  = A.DPT_STN_CONS_ORDR(+)
                AND     C.ARV_STN_CONS_ORDR  = A.ARV_STN_CONS_ORDR(+)
                AND     C.BKCL_CD            = A.BKCL_CD(+)
                AND     C.SEAT_ATT_CD        = A.SEAT_ATT_CD(+)
                AND     C.ARV_STN_CONS_ORDR <> C.DPT_STN_CONS_ORDR
                AND     C.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND     #RUN_TRM_CLS_DT#
                AND     C.TRN_NO = #TRN_NO#
                AND
                        (
                                #PSRM_CL_CD# IS NULL
                        OR      C.PSRM_CL_CD    LIKE #PSRM_CL_CD#
                        )
                )
                BIZ_RVN_AMT
       FROM     TB_YYDS511 B
       WHERE    B.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
       AND      B.TRN_NO = #TRN_NO#
       AND
                (
                         #PSRM_CL_CD# IS NULL
                OR       B.PSRM_CL_CD    LIKE #PSRM_CL_CD#
                )
       GROUP BY B.TRN_NO,
                B.RUN_DT
       )
]]>
', TO_DATE('04/01/2014 16:21:33', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA003QMDAO.selectListAcvmPsrnGrdQry', '/*com.korail.yz.yr.aa.YRAA003QMDAO.selectListAcvmPsrnGrdQry*/ 
<![CDATA[

SELECT 
RUN_DT_TXT
,RUN_DT
,TRN_NO
,ROUT_CD
,ROUT_NM
,RUN_DV_CD
,PSRM_CL_CD
,PSRM_CL_NM
,SHTM_EXCS_RSV_ALLW_FLG
,YMS_REAL_FLG
,ORG_RS_STN_CD
,TMN_RS_STN_CD
,RUN_INFO
,SEAT_NUM
,REAL_SEAT_NUM 
,ROUND(SEAT_CRKM, 0) SEAT_CRKM
,ROUND(ABRD_PKLO, 0) ABRD_PKLO
,ABRD_PRNB
,ROUND(ABRD_RT * 100, 2) ABRD_RT
,ROUND(UTL_RT * 100, 2) UTL_RT
,ROUND(REAL_SEAT_RT * 100, 2) REAL_SEAT_RT
,BIZ_RVN_AMT
,ROUND(BIZ_RVN_AMT / SEAT_NUM , 0) SEAT_PR_AMT
,ROUND(BIZ_RVN_AMT / ABRD_PRNB, 0)  EACH_PR_AMT
,ROUND(BIZ_RVN_AMT / SEAT_CRKM , 2) SEAT_CRKM_PR_AMT
FROM
(
SELECT   TO_CHAR(TO_DATE(A.RUN_DT), ''YYYY-mm-DD'')
                  || '' (''
                  ||
         ( SELECT VLID_VAL_KOR_AVVR_NM
         FROM    TB_YYDK007
         WHERE   XROIS_OLD_SRT_CD = ''I909''
         AND     DOMN_NM          = ''DAY_DV_CD''
         AND     VLID_VAL         = D.DAY_DV_CD
         )
                  || '')'' RUN_DT_TXT,
         A.RUN_DT RUN_DT,
		 A.TRN_NO ,
         A.ROUT_CD ,
         C.ROUT_NM ,
         A.SHTM_EXCS_RSV_ALLW_FLG ,
		 B.PSRM_CL_CD,
         ( SELECT VLID_VAL_KOR_AVVR_NM
         FROM    TB_YYDK007
         WHERE   XROIS_OLD_SRT_CD = ''R408''
         AND     DOMN_NM          = ''PSRM_CL_CD''
         AND     VLID_VAL         = B.PSRM_CL_CD
         )
         PSRM_CL_NM ,

         ( SELECT VLID_VAL_KOR_AVVR_NM
         FROM    TB_YYDK007
         WHERE   XROIS_OLD_SRT_CD = ''T305''
         AND     DOMN_NM          = ''RUN_DV_CD''
         AND     VLID_VAL         = A.RUN_DV_CD
         )
         RUN_DV_CD ,
         DECODE (
                   ( SELECT ''Y''
                   FROM    TB_YYDK328
                   WHERE   RUN_DT = A.RUN_DT
                   AND     TRN_NO = A.TRN_NO
                   AND     ROWNUM = 1
                   )
                 , NULL ,
                 A.YMS_APL_FLG ,
                 ''Y'' ) YMS_REAL_FLG ,
         A.ORG_RS_STN_CD ,
         A.TMN_RS_STN_CD ,
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A ,
                 TB_YYDK102 B
         WHERE   1           = 1
         AND     A.RS_STN_CD = SUBSTR(A.ORG_RS_STN_CD, 2, 5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR ( SYSDATE, ''YYYYMMDD'' ) BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
                  || ''-''
                  ||
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A ,
                 TB_YYDK102 B
         WHERE   1           = 1
         AND     A.RS_STN_CD = SUBSTR(A.TMN_RS_STN_CD, 2, 5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR ( SYSDATE, ''YYYYMMDD'' ) BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
                  || ''(''
                  ||
         ( SELECT TO_CHAR ( TO_DATE ( DPT_TM, ''hh24miss'' ), ''hh24:mi'' )
         FROM    TB_YYDK302
         WHERE   RUN_DT   = A.RUN_DT
         AND     TRN_NO   = A.TRN_NO
         AND     RUN_ORDR = 1
         )
                  || ''-''
                  ||
         ( SELECT TO_CHAR ( TO_DATE ( ARV_TM, ''hh24miss'' ), ''hh24:mi'' )
         FROM    TB_YYDK302
         WHERE   RUN_DT   = A.RUN_DT
         AND     TRN_NO   = A.TRN_NO
         AND     RUN_ORDR =
                 ( SELECT MAX ( RUN_ORDR )
                 FROM    TB_YYDK302
                 WHERE   RUN_DT = A.RUN_DT
                 AND     TRN_NO = A.TRN_NO
                 )
         )
                  || '')'' RUN_INFO ,
         SUM ( B.SEAT_NUM ) SEAT_NUM,
         SUM ( E.REAL_SEAT_NUM ) REAL_SEAT_NUM ,
         SUM ( B.SEAT_CRKM ) SEAT_CRKM ,
         SUM ( B.ABRD_PKLO ) ABRD_PKLO ,
         SUM ( B.ABRD_PRNB ) ABRD_PRNB ,
         SUM ( B.ABRD_PKLO )        / SUM ( B.SEAT_CRKM ) ABRD_RT ,
         SUM ( B.ABRD_PRNB )        / SUM ( B.SEAT_NUM ) UTL_RT ,
         SUM ( B.ABRD_PRNB )        / SUM ( E.REAL_SEAT_NUM ) REAL_SEAT_RT ,
         ( SELECT SUM ( BIZ_RVN_AMT - SMG_BIZ_RVN_AMT )
         FROM    TB_YYDS512
         WHERE   RUN_DT = A.RUN_DT
         AND     TRN_NO = A.TRN_NO
		 AND     PSRM_CL_CD = B.PSRM_CL_CD
         )
         BIZ_RVN_AMT
FROM     TB_YYDK301 A ,
         TB_YYDP503 Z ,
         TB_YYDS511 B ,
         TB_YYDK201 C ,
         TB_YYDK002 D ,
         ( SELECT  RUN_DT ,
                  TRN_NO ,
                  PSRM_CL_CD ,
                  SUM ( BS_SEAT_NUM - NOTY_SALE_SEAT_NUM ) REAL_SEAT_NUM
         FROM     TB_YYDK305
         WHERE    1=1
         AND RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
         AND      (#TRN_NO# IS NULL OR TRN_NO LIKE #TRN_NO#)
         AND
                  (
                           #SEAT_ATT_CD# IS NULL
                  OR       SEAT_ATT_CD        = #SEAT_ATT_CD#
                  )
         GROUP BY RUN_DT ,
                  TRN_NO ,
                  PSRM_CL_CD
         )
         E
WHERE    1=1
AND      A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
AND      (#TRN_NO# IS NULL OR A.TRN_NO      LIKE #TRN_NO#)
AND      A.TRN_OPN_FLG    = ''Y''
AND      A.TRN_SPS_FLG        = ''N''
AND      (#ROUT_CD# IS NULL OR A.ROUT_CD     LIKE #ROUT_CD#)
AND      (#STLB_TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD LIKE #STLB_TRN_CLSF_CD#)
AND      A.UP_DN_DV_CD LIKE (CASE WHEN #UP_DN_DV_CD# = ''A'' THEN ''%'' ELSE #UP_DN_DV_CD# END)
AND      A.RUN_DT         = Z.RUN_DT
AND      A.TRN_NO         = Z.TRN_NO
AND
         (
                  #MRNT_CD# IS NULL
         OR       Z.MRNT_CD    LIKE #MRNT_CD#
         )
AND      Z.MRNT_CD IN ( ''01'',
                            ''03'',
                            ''04'' )
AND      A.RUN_DT  = B.RUN_DT(+)
AND      A.TRN_NO  = B.TRN_NO(+)
AND      A.ROUT_CD = C.ROUT_CD
AND
         (
                  (
                           C.EFC_ST_DT  <= #RUN_TRM_ST_DT#
                  AND      C.EFC_CLS_DT >= #RUN_TRM_CLS_DT#
                  )
         OR
                  (
                           C.EFC_ST_DT  >= #RUN_TRM_ST_DT#
                  AND      C.EFC_CLS_DT <= #RUN_TRM_CLS_DT#
                  )
         )
AND      A.RUN_DT       = D.RUN_DT(+)
AND      D.DAY_DV_CD LIKE DECODE(#DAY_DV_CD#, ''0'', ''%'', #DAY_DV_CD#)
AND      B.RUN_DT       = E.RUN_DT
AND      B.TRN_NO       = E.TRN_NO
AND      B.PSRM_CL_CD   = E.PSRM_CL_CD
AND      (#PSRM_CL_CD# IS NULL OR B.PSRM_CL_CD LIKE #PSRM_CL_CD#)

GROUP BY D.DAY_DV_CD ,
         A.RUN_DT ,
         A.TRN_NO ,
         A.ROUT_CD ,
         C.ROUT_NM ,
         A.SHTM_EXCS_RSV_ALLW_FLG ,
         A.YMS_APL_FLG ,
         A.RUN_DV_CD ,
         A.ORG_RS_STN_CD ,
         A.TMN_RS_STN_CD ,
		 B.PSRM_CL_CD
)
ORDER BY RUN_DT ,
         TRN_NO

]]>
', TO_DATE('04/06/2014 19:24:55', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA003QMDAO.selectListAcvmQry', '/*com.korail.yz.yr.aa.YRAA003QMDAO.selectListAcvmQry*/ 
<![CDATA[
SELECT 
	RUN_DT_TXT
,RUN_DT
,TRN_NO
,ROUT_CD
,ROUT_NM
,RUN_DV_CD
,SHTM_EXCS_RSV_ALLW_FLG
,YMS_REAL_FLG
,ORG_RS_STN_CD
,TMN_RS_STN_CD
,RUN_INFO
,SEAT_NUM
,REAL_SEAT_NUM 
,ROUND(SEAT_CRKM, 0) SEAT_CRKM
,ROUND(ABRD_PKLO, 0) ABRD_PKLO
,ABRD_PRNB
,ROUND(ABRD_RT * 100, 2) ABRD_RT
,ROUND(UTL_RT * 100, 2) UTL_RT
,ROUND(REAL_SEAT_RT * 100, 2) REAL_SEAT_RT
,BIZ_RVN_AMT
,ROUND(BIZ_RVN_AMT / SEAT_NUM , 0) SEAT_PR_AMT
,ROUND(BIZ_RVN_AMT / ABRD_PRNB, 0)  EACH_PR_AMT
,ROUND(BIZ_RVN_AMT / SEAT_CRKM , 2) SEAT_CRKM_PR_AMT

FROM
(
SELECT   TO_CHAR(TO_DATE(A.RUN_DT), ''YYYY-mm-DD'')
                  || '' (''
                  ||
         ( SELECT VLID_VAL_KOR_AVVR_NM
         FROM    TB_YYDK007
         WHERE   XROIS_OLD_SRT_CD = ''I909''
         AND     DOMN_NM          = ''DAY_DV_CD''
         AND     VLID_VAL         = D.DAY_DV_CD
         )
                  || '')'' RUN_DT_TXT,
         A.RUN_DT RUN_DT,
		 A.TRN_NO ,
         A.ROUT_CD ,
         C.ROUT_NM ,
         A.SHTM_EXCS_RSV_ALLW_FLG ,
         ( SELECT VLID_VAL_KOR_AVVR_NM
         FROM    TB_YYDK007
         WHERE   XROIS_OLD_SRT_CD = ''T305''
         AND     DOMN_NM          = ''RUN_DV_CD''
         AND     VLID_VAL         = A.RUN_DV_CD
         )
         RUN_DV_CD ,
         DECODE (
                   ( SELECT ''Y''
                   FROM    TB_YYDK328
                   WHERE   RUN_DT = A.RUN_DT
                   AND     TRN_NO = A.TRN_NO
                   AND     ROWNUM = 1
                   )
                 , NULL ,
                 A.YMS_APL_FLG ,
                 ''Y'' ) YMS_REAL_FLG ,
         A.ORG_RS_STN_CD ,
         A.TMN_RS_STN_CD ,
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A ,
                 TB_YYDK102 B
         WHERE   1           = 1
         AND     A.RS_STN_CD = SUBSTR(A.ORG_RS_STN_CD, 2, 5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR ( SYSDATE, ''YYYYMMDD'' ) BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
                  || ''-''
                  ||
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A ,
                 TB_YYDK102 B
         WHERE   1           = 1
         AND     A.RS_STN_CD = SUBSTR(A.TMN_RS_STN_CD, 2, 5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR ( SYSDATE, ''YYYYMMDD'' ) BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
                  || ''(''
                  ||
         ( SELECT TO_CHAR ( TO_DATE ( DPT_TM, ''hh24miss'' ), ''hh24:mi'' )
         FROM    TB_YYDK302
         WHERE   RUN_DT   = A.RUN_DT
         AND     TRN_NO   = A.TRN_NO
         AND     RUN_ORDR = 1
         )
                  || ''-''
                  ||
         ( SELECT TO_CHAR ( TO_DATE ( ARV_TM, ''hh24miss'' ), ''hh24:mi'' )
         FROM    TB_YYDK302
         WHERE   RUN_DT   = A.RUN_DT
         AND     TRN_NO   = A.TRN_NO
         AND     RUN_ORDR =
                 ( SELECT MAX ( RUN_ORDR )
                 FROM    TB_YYDK302
                 WHERE   RUN_DT = A.RUN_DT
                 AND     TRN_NO = A.TRN_NO
                 )
         )
                  || '')'' RUN_INFO ,
         SUM ( B.SEAT_NUM ) SEAT_NUM,
         SUM ( E.REAL_SEAT_NUM ) REAL_SEAT_NUM ,
         SUM ( B.SEAT_CRKM ) SEAT_CRKM ,
         SUM ( B.ABRD_PKLO ) ABRD_PKLO ,
         SUM ( B.ABRD_PRNB ) ABRD_PRNB ,
         SUM ( B.ABRD_PKLO )        / SUM ( B.SEAT_CRKM ) ABRD_RT ,
         SUM ( B.ABRD_PRNB )        / SUM ( B.SEAT_NUM ) UTL_RT ,
         SUM ( B.ABRD_PRNB )        / SUM ( E.REAL_SEAT_NUM ) REAL_SEAT_RT ,
         ( SELECT SUM ( BIZ_RVN_AMT - SMG_BIZ_RVN_AMT )
         FROM    TB_YYDS512
         WHERE   RUN_DT = A.RUN_DT
         AND     TRN_NO = A.TRN_NO
         ) BIZ_RVN_AMT
FROM     TB_YYDK301 A ,
         TB_YYDP503 Z ,
         TB_YYDS511 B ,
         TB_YYDK201 C ,
         TB_YYDK002 D ,
         ( SELECT  RUN_DT ,
                  TRN_NO ,
                  PSRM_CL_CD ,
                  SUM ( BS_SEAT_NUM - NOTY_SALE_SEAT_NUM ) REAL_SEAT_NUM
         FROM     TB_YYDK305
         WHERE    1=1
         AND RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
         AND      (#TRN_NO# IS NULL OR TRN_NO LIKE #TRN_NO#)
         AND
                  (
                           #SEAT_ATT_CD# IS NULL
                  OR       SEAT_ATT_CD        = #SEAT_ATT_CD#
                  )
         GROUP BY RUN_DT ,
                  TRN_NO ,
                  PSRM_CL_CD
         )
         E
WHERE    1=1
AND      A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
AND      (#TRN_NO# IS NULL OR A.TRN_NO      LIKE #TRN_NO#)
AND      A.TRN_OPN_FLG    = ''Y''
AND      A.TRN_SPS_FLG        = ''N''
AND      (#ROUT_CD# IS NULL OR A.ROUT_CD     LIKE #ROUT_CD#)
AND      (#STLB_TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD LIKE #STLB_TRN_CLSF_CD#)
AND      A.UP_DN_DV_CD LIKE (CASE WHEN #UP_DN_DV_CD# = ''A'' THEN ''%'' ELSE #UP_DN_DV_CD# END)
AND      A.RUN_DT         = Z.RUN_DT
AND      A.TRN_NO         = Z.TRN_NO
AND
         (
                  #MRNT_CD# IS NULL
         OR       Z.MRNT_CD    LIKE #MRNT_CD#
         )
AND      Z.MRNT_CD IN ( ''01'',
                            ''03'',
                            ''04'' )
AND      A.RUN_DT  = B.RUN_DT(+)
AND      A.TRN_NO  = B.TRN_NO(+)
AND      A.ROUT_CD = C.ROUT_CD
AND
         (
                  (
                           C.EFC_ST_DT  <= #RUN_TRM_ST_DT#
                  AND      C.EFC_CLS_DT >= #RUN_TRM_CLS_DT#
                  )
         OR
                  (
                           C.EFC_ST_DT  >= #RUN_TRM_ST_DT#
                  AND      C.EFC_CLS_DT <= #RUN_TRM_CLS_DT#
                  )
         )
AND      A.RUN_DT       = D.RUN_DT(+)
AND      D.DAY_DV_CD LIKE DECODE(#DAY_DV_CD#, ''0'', ''%'', #DAY_DV_CD#)
AND      B.RUN_DT       = E.RUN_DT
AND      B.TRN_NO       = E.TRN_NO
AND      B.PSRM_CL_CD   = E.PSRM_CL_CD

GROUP BY D.DAY_DV_CD ,
         A.RUN_DT ,
         A.TRN_NO ,
         A.ROUT_CD ,
         C.ROUT_NM ,
         A.SHTM_EXCS_RSV_ALLW_FLG ,
         A.YMS_APL_FLG ,
         A.RUN_DV_CD ,
         A.ORG_RS_STN_CD ,
         A.TMN_RS_STN_CD
)
ORDER BY RUN_DT ,
         TRN_NO
]]>
', TO_DATE('04/06/2014 19:24:55', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA004QMDAO.selectListAcvmDtlQry', '/*com.korail.yz.yr.aa.YRAA004QMDAO.selectListAcvmDtlQry*/ 
<![CDATA[
SELECT A.*,
	   A.ORDR||''-''||A.ORDR2||'' ''||DPT_STR||''-''||ARV_STR RUN_INFO_CHT,
       B.ABRD_PRNB,
       B.BIZ_RVN_AMT,
       B.RUN_INFO,
       C.SEG_GP_NO
FROM   (SELECT A.RUN_DT RUN_DT,
               A.TRN_NO,
               LPAD(TO_CHAR(D.RUN_ORDR), 2, '' '') ORDR,
               LPAD(TO_CHAR(E.RUN_ORDR), 2, '' '') ORDR2,
               A.DPT_STN_CONS_ORDR,
               A.ARV_STN_CONS_ORDR,
  			   O1.KOR_STN_NM DPT_STR,
               O1.KOR_STN_NM
                       || ''(''
                       || SUBSTR(D.DPT_TM, 1, 2)
                       || '':''
                       || SUBSTR(D.DPT_TM, 3, 2)
                       || '')'' DPT_INFO,
			   O2.KOR_STN_NM ARV_STR,
               O2.KOR_STN_NM
                       || ''(''
                       || SUBSTR(E.ARV_TM, 1, 2)
                       || '':''
                       || SUBSTR(E.ARV_TM, 3, 2)
                       || '')'' ARV_INFO,
               NVL(B.RESERVATION, 0) RESERVATION,
               NVL(B.CANCELLATION, 0) CANCELLATION,
               NVL(C.NO_SHOW, 0) NO_SHOW,
               D.TRVL_ZONE_NO START_ZONE,
               E.TRVL_ZONE_NO END_ZONE,
               F.UP_DN_DV_CD
       FROM    TB_YYDD505 A,
               (SELECT  B.RUN_DT,
                        B.TRN_NO,
                        B.DPT_STN_CONS_ORDR,
                        B.ARV_STN_CONS_ORDR,
                        SUM(B.RSV_SEAT_NUM + B.SALE_SEAT_NUM + B.SMG_SALE_SEAT_NUM) RESERVATION,
                        SUM(B.RET_SEAT_NUM + CNC_SEAT_NUM + SMG_RET_SEAT_NUM) CANCELLATION
               FROM     TB_YYDS501 B,
                        TB_YYDK301 X
               WHERE    1=1
               AND X.RUN_DT    = #RUN_DT#
               AND      X.TRN_NO LIKE #TRN_NO#
               AND      X.STLB_TRN_CLSF_CD IN(''00'',
                                         ''01'')
               AND      X.RUN_DT      = B.RUN_DT
               AND      X.TRN_NO      = B.TRN_NO
               AND      (#PSRM_CL_CD# IS NULL OR PSRM_CL_CD LIKE #PSRM_CL_CD#)
               AND      (#BKCL_CD# IS NULL OR BKCL_CD   LIKE #BKCL_CD#)
               GROUP BY B.RUN_DT,
                        B.TRN_NO,
                        B.DPT_STN_CONS_ORDR,
                        B.ARV_STN_CONS_ORDR
               )
               B,
               (SELECT  RUN_DT,
                        TRN_NO,
                        DPT_STN_CONS_ORDR,
                        ARV_STN_CONS_ORDR,
                        SUM(CNC_RET_SEAT_NUM) NO_SHOW
               FROM     TB_YYDS502
               WHERE    1=1
               AND RUN_DT        = #RUN_DT#
               AND      TRN_NO     LIKE #TRN_NO#
               AND      (#PSRM_CL_CD# IS NULL OR PSRM_CL_CD LIKE #PSRM_CL_CD#)
               GROUP BY RUN_DT,
                        TRN_NO,
                        DPT_STN_CONS_ORDR,
                        ARV_STN_CONS_ORDR
               )
               C,
               TB_YYDK302 D,
               TB_YYDK302 E,
               TB_YYDK301 F,
               TB_YYDK201 G,
               TB_YYDK001 R1,
               TB_YYDK102 O1,
               TB_YYDK001 R2,
               TB_YYDK102 O2
       WHERE   A.RUN_DT            = B.RUN_DT(+)
       AND     A.TRN_NO            = B.TRN_NO(+)
       AND     A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR(+)
       AND     A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR(+)
       AND     A.RUN_DT            = C.RUN_DT(+)
       AND     A.TRN_NO            = C.TRN_NO(+)
       AND     A.DPT_STN_CONS_ORDR = C.DPT_STN_CONS_ORDR(+)
       AND     A.ARV_STN_CONS_ORDR = C.ARV_STN_CONS_ORDR(+)
       AND     A.RUN_DT            = D.RUN_DT
       AND     A.TRN_NO            = D.TRN_NO
       AND     A.DPT_STN_CONS_ORDR = D.STN_CONS_ORDR
       AND     A.RUN_DT            = E.RUN_DT
       AND     A.TRN_NO            = E.TRN_NO
       AND     A.ARV_STN_CONS_ORDR = E.STN_CONS_ORDR
       AND     A.RUN_DT            = F.RUN_DT
       AND     A.TRN_NO            = F.TRN_NO
       AND     F.ROUT_CD           = G.ROUT_CD
       AND     A.RUN_DT         LIKE #RUN_DT#
       AND     A.TRN_NO         LIKE #TRN_NO#
       AND     R1.DEAL_TRN_CLSF_CD IN (''00'',
                                       ''01'')
       AND     R1.RS_STN_CD   = D.STOP_RS_STN_CD
       AND     R1.STN_CD      = O1.STN_CD
       AND     O1.APL_ST_DT  <= TO_CHAR(SYSDATE, ''YYYYMMDD'')
       AND     O1.APL_CLS_DT >= TO_CHAR(SYSDATE, ''YYYYMMDD'')
       AND     R2.DEAL_TRN_CLSF_CD IN (''00'',
                                       ''01'')
       AND     R2.RS_STN_CD   = E.STOP_RS_STN_CD
       AND     R2.STN_CD      = O2.STN_CD
       AND     O2.APL_ST_DT  <= TO_CHAR(SYSDATE, ''YYYYMMDD'')
       AND     O2.APL_CLS_DT >= TO_CHAR(SYSDATE, ''YYYYMMDD'')
       )
       A,
       (SELECT  A.RUN_DT,
                A.TRN_NO,
                LPAD(TO_CHAR(C.RUN_ORDR), 2, '' '') ORDR,
                LPAD(TO_CHAR(D.RUN_ORDR), 2, '' '') ORDR2,
                A.DPT_STN_CONS_ORDR,
                A.ARV_STN_CONS_ORDR,
                
                         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A ,
                 TB_YYDK102 B
         WHERE   1           = 1
         AND     A.RS_STN_CD = SUBSTR(C.STOP_RS_STN_CD, 2, 5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR ( SYSDATE, ''YYYYMMDD'' ) BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
                         || ''(''
                         || SUBSTR(C.DPT_TM, 1, 2)
                         || '':''
                         || SUBSTR(C.DPT_TM, 3, 2)
                         || '')'' DPT_INFO,
                         
                         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A ,
                 TB_YYDK102 B
         WHERE   1           = 1
         AND     A.RS_STN_CD = SUBSTR(D.STOP_RS_STN_CD, 2, 5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR ( SYSDATE, ''YYYYMMDD'' ) BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )         
                         || ''(''
                         || SUBSTR(D.ARV_TM, 1, 2)
                         || '':''
                         || SUBSTR(D.ARV_TM, 3, 2)
                         || '')'' ARV_INFO,
                (SELECT 
                                         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A ,
                 TB_YYDK102 B
         WHERE   1           = 1
         AND     A.RS_STN_CD = SUBSTR(A.ORG_RS_STN_CD, 2, 5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR ( SYSDATE, ''YYYYMMDD'' ) BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         ) 
                                || ''-''
                                || 
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A ,
                 TB_YYDK102 B
         WHERE   1           = 1
         AND     A.RS_STN_CD = SUBSTR(A.TMN_RS_STN_CD, 2, 5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR ( SYSDATE, ''YYYYMMDD'' ) BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         ) 
                                || ''(''
                                ||
                        (SELECT TO_CHAR(TO_DATE(DPT_TM, ''HH24MISS''), ''HH24:MI'')
                        FROM    TB_YYDK302
                        WHERE   RUN_DT   = A.RUN_DT
                        AND     TRN_NO   = A.TRN_NO
                        AND     RUN_ORDR = 1
                        )
                                || ''-''
                                ||
                        (SELECT TO_CHAR(TO_DATE(ARV_TM, ''HH24MISS''), ''HH24:MI'')
                        FROM    TB_YYDK302
                        WHERE   RUN_DT   = A.RUN_DT
                        AND     TRN_NO   = A.TRN_NO
                        AND     RUN_ORDR =
                                (SELECT MAX(RUN_ORDR)
                                FROM    TB_YYDK302
                                WHERE   RUN_DT = A.RUN_DT
                                AND     TRN_NO = A.TRN_NO
                                )
                        )
                                || '')'' RUN_INFO
                FROM    TB_YYDK301 A,
                        TB_YYDK002 B,
                        TB_YYDK201 C
                WHERE   A.RUN_DT  = B.RUN_DT
                AND     A.ROUT_CD = C.ROUT_CD
                AND     A.RUN_DT  = #RUN_DT#
                AND     A.TRN_NO  = #TRN_NO#
                )
                RUN_INFO,
                NVL(SUM(B.ABRD_PRNB), 0) ABRD_PRNB,
                NVL(SUM(B.BIZ_RVN_AMT), 0) BIZ_RVN_AMT
       FROM     (SELECT DISTINCT A.RUN_DT,
                                 A.TRN_NO,
                                 A.PSRM_CL_CD,
                                 A.BKCL_CD,
                                 B.DPT_STN_CONS_ORDR,
                                 B.ARV_STN_CONS_ORDR
                FROM             TB_YYDD504 A,
                                 TB_YYDD505 B
                WHERE            A.RUN_DT        = B.RUN_DT
                AND              A.TRN_NO        = B.TRN_NO
                AND              A.RUN_DT        = #RUN_DT#
                AND              A.TRN_NO     LIKE #TRN_NO#
                AND              (#PSRM_CL_CD# IS NULL OR A.PSRM_CL_CD LIKE #PSRM_CL_CD#)
                AND              (#BKCL_CD# IS NULL OR A.BKCL_CD   LIKE #BKCL_CD#)
                AND              A.SEAT_ATT_CD   = ''15''
                )
                A,
                (SELECT  RUN_DT,
                         TRN_NO,
                         PSRM_CL_CD,
                         BKCL_CD,
                         DPT_STN_CONS_ORDR,
                         ARV_STN_CONS_ORDR,
                         SUM(ABRD_PRNB) ABRD_PRNB,
                         SUM(BIZ_RVN_AMT) BIZ_RVN_AMT
                FROM     (SELECT  A.RUN_DT,
                                  A.TRN_NO,
                                  A.PSRM_CL_CD,
                                  DECODE(A.BKCL_CD,''F2'',
                                         ''F1'',
                                         A.BKCL_CD) BKCL_CD,
                                  A.DPT_STN_CONS_ORDR,
                                  A.ARV_STN_CONS_ORDR,
                                  SUM(A.ABRD_PRNB) AS ABRD_PRNB,
                                  0 BIZ_RVN_AMT
                         FROM     TB_YYDS510 A
                         WHERE    1=1
                         AND A.RUN_DT        = #RUN_DT#
                         AND      A.TRN_NO     LIKE #TRN_NO#
                         AND      (#PSRM_CL_CD# IS NULL OR A.PSRM_CL_CD LIKE #PSRM_CL_CD#)
			 			 AND    A.BKCL_CD LIKE DECODE ( #BKCL_CD# ,''F1'', ''F%'', DECODE(#BKCL_CD#,'''',''%'',#BKCL_CD#) )
                         GROUP BY A.RUN_DT,
                                  A.TRN_NO,
                                  A.PSRM_CL_CD,
                                  DECODE(A.BKCL_CD,''F2'',
                                         ''F1'',
                                         A.BKCL_CD) ,
                                  A.DPT_STN_CONS_ORDR,
                                  A.ARV_STN_CONS_ORDR
                         
                         UNION ALL
                         
                         SELECT   A.RUN_DT,
                                  A.TRN_NO,
                                  A.PSRM_CL_CD,
                                  DECODE(A.BKCL_CD,''F2'',
                                         ''F1'',
                                         A.BKCL_CD) BKCL_CD,
                                  A.DPT_STN_CONS_ORDR,
                                  A.ARV_STN_CONS_ORDR,
                                  0,
                                  SUM(A.BIZ_RVN_AMT - A.smg_biz_rvn_amt) AS BIZ_RVN_AMT
                         FROM     TB_YYDS512 A
                         WHERE    1=1
                         AND A.RUN_DT        = #RUN_DT#
                         AND      A.TRN_NO     LIKE #TRN_NO#
                         AND      (#PSRM_CL_CD# IS NULL OR A.PSRM_CL_CD LIKE #PSRM_CL_CD#)
	     			     AND    A.BKCL_CD LIKE DECODE ( #BKCL_CD# ,''F1'', ''F%'', DECODE(#BKCL_CD#,'''',''%'',#BKCL_CD#) )
						
                         GROUP BY A.RUN_DT,
                                  A.TRN_NO,
                                  A.PSRM_CL_CD,
                                  DECODE(A.BKCL_CD,''F2'',
                                         ''F1'',
                                         A.BKCL_CD),
                                  A.DPT_STN_CONS_ORDR,
                                  A.ARV_STN_CONS_ORDR
                         )
                GROUP BY RUN_DT,
                         TRN_NO,
                         PSRM_CL_CD,
                         BKCL_CD,
                         DPT_STN_CONS_ORDR,
                         ARV_STN_CONS_ORDR
                )
                B,
                TB_YYDK302 C,
                TB_YYDK302 D
       WHERE    A.RUN_DT            = B.RUN_DT(+)
       AND      A.TRN_NO            = B.TRN_NO(+)
       AND      A.PSRM_CL_CD        = B.PSRM_CL_CD(+)
       AND      A.BKCL_CD          = B.BKCL_CD(+)
       AND      A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR(+)
       AND      A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR(+)
       AND      A.RUN_DT            = C.RUN_DT
       AND      A.TRN_NO            = C.TRN_NO
       AND      A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
       AND      A.RUN_DT            = D.RUN_DT
       AND      A.TRN_NO            = D.TRN_NO
       AND      A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
       AND      A.RUN_DT            = #RUN_DT#
       AND      A.TRN_NO         LIKE #TRN_NO#
       AND      (#PSRM_CL_CD# IS NULL OR A.PSRM_CL_CD LIKE #PSRM_CL_CD#)
       AND      (#BKCL_CD# IS NULL OR A.BKCL_CD       LIKE #BKCL_CD#)
       GROUP BY A.RUN_DT,
                A.TRN_NO,
                C.RUN_ORDR,
                D.RUN_ORDR,
                A.DPT_STN_CONS_ORDR,
                A.ARV_STN_CONS_ORDR,
                C.STOP_RS_STN_CD,
                C.DPT_TM,
                C.DPT_TM,
                D.STOP_RS_STN_CD,
                D.ARV_TM,
                D.ARV_TM
       )
       B,
       TB_YYDK308 C
WHERE  A.RUN_DT            = B.RUN_DT
AND    A.TRN_NO            = B.TRN_NO
AND    A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR
AND    A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR
AND    A.RUN_DT            = C.RUN_DT
AND    A.TRN_NO            = C.TRN_NO
AND    A.START_ZONE        = DECODE(A.UP_DN_DV_CD, ''D'',
                                    C.DPT_ZONE_NO,
                                    C.ARV_ZONE_NO)
AND    A.END_ZONE = DECODE(A.UP_DN_DV_CD, ''D'',
                           C.ARV_ZONE_NO,
                           C.DPT_ZONE_NO)
AND    C.SEG_GP_NO BETWEEN #ZONE_SEG_GP_FROM# AND #ZONE_SEG_GP_TO#
ORDER BY C.SEG_GP_NO, A.ORDR, A.ORDR2

]]>
', TO_DATE('04/09/2014 10:48:54', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA005QMDAO.selectListDayBrdRtPrAcvmQry', '/*com.korail.yz.yr.aa.YRAA005QMDAO.selectListDayBrdRtPrAcvmQry*/ 
<![CDATA[
SELECT RUN_DT_TXT
,RUN_DT
,TRN_NO
,ROUT_CD
,ROUT_NM
,RUN_DV_CD
,SHTM_EXCS_RSV_ALLW_FLG
,YMS_APL_FLG
,YMS_REAL_FLG
,RUN_INFO
,SEAT_NUM
,ROUND(SEAT_CRKM, 0) SEAT_CRKM
,ROUND(ABRD_PKLO, 0) ABRD_PKLO
,ABRD_PRNB
,ROUND(ABRD_RT * 100, 2) ABRD_RT
,ROUND(UTL_RT * 100, 2) UTL_RT
,BIZ_RVN_AMT
,ROUND(BIZ_RVN_AMT / SEAT_NUM , 0) SEAT_PR_AMT
,ROUND(BIZ_RVN_AMT / ABRD_PRNB, 0)  EACH_PR_AMT
,ROUND(BIZ_RVN_AMT / SEAT_CRKM , 2) SEAT_CRKM_PR_AMT
FROM
(
  SELECT A.RUN_DT_TXT,
         A.RUN_DT,
         LPAD (TO_NUMBER (A.TRN_NO), 5, ''0'') TRN_NO,
         A.ROUT_CD,
         A.ROUT_NM,
         A.SHTM_EXCS_RSV_ALLW_FLG,
         A.RUN_DV_CD,
         A.YMS_APL_FLG,
         A.YMS_REAL_FLG,
         A.ORG_RS_STN_CD,
         A.TMN_RS_STN_CD,
         A.RUN_INFO,
         SUM (A.SEAT_NUM) SEAT_NUM,
         SUM (A.SEAT_CRKM) SEAT_CRKM,
         SUM (A.ABRD_PKLO) ABRD_PKLO,
         SUM (A.ABRD_PRNB) ABRD_PRNB,
         SUM (A.ABRD_PKLO) / SUM (A.SEAT_CRKM) ABRD_RT,
         SUM (A.ABRD_PRNB) / SUM (A.SEAT_NUM) UTL_RT,
         (SELECT SUM (BIZ_RVN_AMT - smg_biz_rvn_amt)
            FROM TB_YYDS512
           WHERE     RUN_DT = A.RUN_DT
                 AND TRN_NO = A.TRN_NO
                 AND (#PSRM_CL_CD# IS NULL OR PSRM_CL_CD LIKE #PSRM_CL_CD#))
            BIZ_RVN_AMT
    FROM (  SELECT    SUBSTR(A.RUN_DT, 1, 4)||''.''||SUBSTR(A.RUN_DT, 5, 2)||''.''||SUBSTR(A.RUN_DT, 7, 2)
                   || '' (''
                   || (SELECT VLID_VAL_KOR_AVVR_NM
                         FROM TB_YYDK007
                        WHERE     XROIS_OLD_SRT_CD = ''I909''
                              AND DOMN_NM = ''DAY_DV_CD''
                              AND VLID_VAL = D.DAY_DV_CD)
                   || '')'' RUN_DT_TXT,
                   A.RUN_DT RUN_DT,
                   A.TRN_NO,
                   A.ROUT_CD,
                   C.ROUT_NM,
                   ''N'' SHTM_EXCS_RSV_ALLW_FLG,
                   (SELECT VLID_VAL_KOR_AVVR_NM
                      FROM TB_YYDK007
                     WHERE     XROIS_OLD_SRT_CD = ''T305''
                           AND DOMN_NM = ''RUN_DV_CD''
                           AND VLID_VAL = A.RUN_DV_CD)
                      RUN_DV_CD,
                   A.YMS_APL_FLG,
                   DECODE (
                      (SELECT ''Y''
                         FROM TB_YYDK328
                        WHERE     RUN_DT = A.RUN_DT
                              AND TRN_NO = A.TRN_NO
                              AND ROWNUM = 1),
                      NULL, A.YMS_APL_FLG,
                      ''Y'')
                      YMS_REAL_FLG,
                   A.ORG_RS_STN_CD,
                   A.TMN_RS_STN_CD,
                      (SELECT B.KOR_STN_NM
                         FROM TB_YYDK001 A, TB_YYDK102 B
                        WHERE     1 = 1
                              AND A.RS_STN_CD = SUBSTR (A.ORG_RS_STN_CD, 2, 5)
                              AND A.STN_CD = B.STN_CD
                              AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT
                                                                    AND B.APL_CLS_DT)
                   || ''-''
                   || (SELECT B.KOR_STN_NM
                         FROM TB_YYDK001 A, TB_YYDK102 B
                        WHERE     1 = 1
                              AND A.RS_STN_CD = SUBSTR (A.TMN_RS_STN_CD, 2, 5)
                              AND A.STN_CD = B.STN_CD
                              AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT
                                                                    AND B.APL_CLS_DT)
                   || ''(''
                   || (SELECT TO_CHAR (TO_DATE (DPT_TM, ''HH24MISS''), ''HH24:MI'')
                         FROM TB_YYDK302
                        WHERE     RUN_DT = A.RUN_DT
                              AND TRN_NO = A.TRN_NO
                              AND RUN_ORDR = 1)
                   || ''-''
                   || (SELECT TO_CHAR (TO_DATE (ARV_TM, ''HH24MISS''), ''HH24:MI'')
                         FROM TB_YYDK302
                        WHERE     RUN_DT = A.RUN_DT
                              AND TRN_NO = A.TRN_NO
                              AND RUN_ORDR =
                                     (SELECT MAX (RUN_ORDR)
                                        FROM TB_YYDK302
                                       WHERE     RUN_DT = A.RUN_DT
                                             AND TRN_NO = A.TRN_NO))
                   || '')''
                      RUN_INFO,
                   SUM (B.SEAT_NUM) SEAT_NUM,
                   SUM (B.SEAT_CRKM) SEAT_CRKM,
                   SUM (B.ABRD_PKLO) ABRD_PKLO,
                   SUM (B.ABRD_PRNB) ABRD_PRNB,
                   SUM (B.ABRD_PKLO) / SUM (B.SEAT_CRKM) ABRD_RT,
                   SUM (B.ABRD_PRNB) / SUM (B.SEAT_NUM) UTL_RT
              FROM TB_YYDK301 A,
                   TB_YYDS511 B,
                   TB_YYDK201 C,
                   TB_YYDK002 D
             WHERE     1=1
             AND A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
                   AND (#MRNT_CD# IS NULL OR C.MRNT_CD LIKE #MRNT_CD#)
                   AND  C.MRNT_CD IN (''01'', ''03'', ''04'')
                   AND (#ROUT_CD# IS NULL OR A.ROUT_CD LIKE #ROUT_CD#)
                   AND (#STLB_TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD LIKE #STLB_TRN_CLSF_CD#)
                   AND A.UP_DN_DV_CD LIKE DECODE(#UP_DN_DV_CD#, ''A'', ''%'', #UP_DN_DV_CD#)
                   AND (#TRN_NO# IS NULL OR A.TRN_NO LIKE #TRN_NO#)
                   AND A.RUN_DT = B.RUN_DT(+)
                   AND A.TRN_NO = B.TRN_NO(+)
                   AND A.ROUT_CD = C.ROUT_CD
                   AND (   (    C.EFC_ST_DT <= #RUN_TRM_ST_DT#
                            AND C.EFC_CLS_DT >= #RUN_TRM_CLS_DT#)
                        OR (    C.EFC_ST_DT >= #RUN_TRM_ST_DT#
                            AND C.EFC_CLS_DT <= #RUN_TRM_CLS_DT#))
                   AND A.RUN_DT = D.RUN_DT(+)
                   AND D.DAY_DV_CD LIKE DECODE(#DAY_DV_CD#, ''0'', ''%'', #DAY_DV_CD#)
                   AND (#PSRM_CL_CD# IS NULL OR B.PSRM_CL_CD LIKE #PSRM_CL_CD#)
                   AND A.TRN_OPN_FLG = ''Y''
                   AND A.TRN_SPS_FLG = ''N''
          GROUP BY D.DAY_DV_CD,
                   A.RUN_DT,
                   A.TRN_NO,
                   A.ROUT_CD,
                   C.ROUT_NM,
                   --A.SHTM_EXCS_RSV_ALLW_FLG,
                   A.YMS_APL_FLG,
                   A.RUN_DV_CD,
                   A.ORG_RS_STN_CD,
                   A.TMN_RS_STN_CD
          ORDER BY A.RUN_DT, A.TRN_NO) A
   WHERE     (A.ABRD_PKLO / A.SEAT_CRKM) * 100 BETWEEN TO_NUMBER(#ABRD_RT_FROM#) AND TO_NUMBER(#ABRD_RT_TO#)
         AND (#YMS_APL_FLG# IS NULL OR A.YMS_REAL_FLG LIKE #YMS_APL_FLG#)
GROUP BY A.SEAT_NUM,
         A.TRN_NO,
         A.RUN_DT_TXT,
         A.ABRD_PKLO,
         A.SEAT_CRKM,
         A.ABRD_PRNB,
         A.RUN_DT,
         A.ROUT_CD,
         A.ROUT_NM,
         A.SHTM_EXCS_RSV_ALLW_FLG,
         A.RUN_DV_CD,
         A.YMS_APL_FLG,
         A.YMS_REAL_FLG,
         A.ORG_RS_STN_CD,
         A.TMN_RS_STN_CD,
         A.RUN_INFO
)
ORDER BY TRN_NO, RUN_DT_TXT
]]>
', TO_DATE('04/16/2014 16:24:52', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA006QMDAO.selectListDatePrRunAcvmQry', '/*com.korail.yz.yr.aa.YRAA006QMDAO.selectListDatePrRunAcvmQry*/ 
<![CDATA[
  SELECT (SELECT VLID_VAL_NM
            FROM TB_YYDK007
           WHERE XROIS_OLD_SRT_CD = ''R027'' AND VLID_VAL = STLB_TRN_CLSF_CD)
            STLB_TRN_CLSF_CD,
            SUBSTR(RUN_DT,1,4)||''.''||SUBSTR(RUN_DT,5,2)||''.''||SUBSTR(RUN_DT,7,2)
         || '' (''
         || (SELECT SUBSTR(VLID_VAL_NM,1,1)
               FROM TB_YYDK007
              WHERE XROIS_OLD_SRT_CD = ''I909'' AND VLID_VAL = DAY_DV_CD)
         || '')''
            RUN_DT,
         RUN_DT RUN_DT_1,
         ROUND( SUM (SEAT_NUM), 0) SEAT_NUM,                           /* 좌석수          */
         ROUND( SUM (SEAT_CRKM), 0) SEAT_CRKM,                            /* 좌석키로        */
         ROUND( SUM (ABRD_PKLO), 0) ABRD_PKLO,                             /* 인키로          */
         ROUND( SUM (ABRD_PRNB), 0) ABRD_PRNB,                          /* 승차인원        */
		 ROUND( SUM (ABRD_PKLO) / SUM (SEAT_CRKM) * 100, 2)  ABRD_RT,               /* 승차율          */
         ROUND( SUM (ABRD_PRNB) / SUM (SEAT_NUM) * 100, 2)  UTL_RT,
         SUM (BIZ_AMT) AMT
    FROM (  SELECT A.STLB_TRN_CLSF_CD,
                   A.RUN_DT,                                 /* 운행일자        */
                   SUM (B.SEAT_NUM) SEAT_NUM,               /* 좌석수          */
                   SUM (B.SEAT_CRKM) SEAT_CRKM,              /* 좌석키로        */
                   SUM (B.ABRD_PKLO) ABRD_PKLO,             /* 인키로          */
                   SUM (B.ABRD_PRNB) ABRD_PRNB,              /* 승차인원        */
                   SUM (B.ABRD_PKLO) / SUM (B.SEAT_CRKM) ABRD_RT, /* 승차율          */
                   SUM (B.ABRD_PRNB) / SUM (B.SEAT_NUM) UTL_RT,
                   (SELECT SUM (C.BIZ_RVN_AMT - C.SMG_BIZ_RVN_AMT) BIZ_RVN_AMT /* 영업수입        */
                      FROM TB_YYDS510 A,                    /** 구간별 승차수입실적 **/
                                        TB_YYDS512 C        /** 열차별 초과예약한도 **/
                     WHERE     C.RUN_DT = A.RUN_DT
                           AND C.TRN_NO = A.TRN_NO
                           AND C.PSRM_CL_CD = A.PSRM_CL_CD
                           AND C.PSRM_CL_CD LIKE DECODE(#PSRM_CL_CD#,'''',''%'',#PSRM_CL_CD#)
                           AND C.DPT_STN_CONS_ORDR = A.DPT_STN_CONS_ORDR
                           AND C.ARV_STN_CONS_ORDR = A.ARV_STN_CONS_ORDR
                           AND C.BKCL_CD = A.BKCL_CD
                           AND C.SEAT_ATT_CD = A.SEAT_ATT_CD
                           AND C.RUN_DT = B.RUN_DT
                           AND C.TRN_NO = B.TRN_NO)
                      BIZ_AMT,
                   D.DAY_DV_CD
              FROM TB_YYDK301 A,                                 /* 일일열차정보  */
                   TB_YYDS511 B,                                 /* 열차별 승차율 */
                   TB_YYDK201 C,
                   TB_YYDK002 D                              /* 노선          */
             WHERE     1=1
				   AND A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
                   AND A.STLB_TRN_CLSF_CD LIKE DECODE(#STLB_TRN_CLSF_CD#, '''', ''%'', #STLB_TRN_CLSF_CD#)
                   AND C.MRNT_CD LIKE DECODE(#MRNT_CD#, '''', ''%'', #MRNT_CD#)
                   AND C.MRNT_CD IN (''01'', ''03'', ''04'')
                   AND A.ROUT_CD LIKE DECODE(#ROUT_CD#, '''', ''%'', #ROUT_CD#)
                   AND A.UP_DN_DV_CD LIKE DECODE(#UP_DN_DV_CD#, ''A'',''%'', #UP_DN_DV_CD#)
                   AND B.PSRM_CL_CD LIKE DECODE(#PSRM_CL_CD#, '''', ''%'', #PSRM_CL_CD#)
                   AND A.RUN_DT = B.RUN_DT(+)
                   AND A.TRN_NO = B.TRN_NO(+)
                   AND A.ROUT_CD = C.ROUT_CD
                   AND A.RUN_DT = D.RUN_DT
          GROUP BY A.STLB_TRN_CLSF_CD,
                   A.RUN_DT,
                   D.DAY_DV_CD,
                   B.RUN_DT,
                   B.TRN_NO)
GROUP BY STLB_TRN_CLSF_CD, RUN_DT, DAY_DV_CD
ORDER BY STLB_TRN_CLSF_CD, RUN_DT_1
]]>
', TO_DATE('04/16/2014 11:25:23', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA006QMDAO.selectListDatePrRunSegPrAcvmQry', '/*com.korail.yz.yr.aa.YRAA006QMDAO.selectListDatePrRunSegPrAcvmQry*/ 
<![CDATA[
SELECT   (SELECT VLID_VAL_NM FROM TB_YYDK007 WHERE XROIS_OLD_SRT_CD = ''R027'' AND VLID_VAL = STLB_TRN_CLSF_CD) STLB_TRN_CLSF_CD,
         SUBSTR(RUN_DT,1,4)||''.''||SUBSTR(RUN_DT,5,2)||''.''||SUBSTR(RUN_DT,7,2)
                  || '' (''
                  || SUBSTR(DAY_DV,1,1)
                  || '')'' RUN_DT,
         RUN_DT RUN_DT_1,
         DPT_RUN_ORDR,
         ARV_RUN_ORDR,
         DPT_STN_NM,
         ARV_STN_NM,
         SUM(SEAT_NUM) SEAT_NUM,
         SUM(ABRD_PRNB) ABRD_PRNB,
         ROUND( SUM(ABRD_PRNB) / SUM(SEAT_NUM), 3) * 100 UTL_RT,
         ROUND( SUM(SEAT_CRKM), 0) SEAT_CRKM,
         ROUND( SUM(USE_CRKM), 0) ABRD_PKLO,
    	 ROUND( SUM(USE_CRKM) / SUM(SEAT_CRKM), 3) * 100 ABRD_RT,
         SUM(BIZ_RVN_AMT) AMT
FROM     (SELECT  STLB_TRN_CLSF_CD,
                  RUN_DT,
                  TRN_NO,
                  DAY_DV,
                  SEAT_NUM,
                  DPT_RUN_ORDR,
                  ARV_RUN_ORDR,
                  DPT_STN_CD AS DPT_STN_NM,
                  ARV_STN_CD AS ARV_STN_NM,
                  SUM(ABRD_PRNB) ABRD_PRNB,
                  SUM(ABRD_PRNB) / SEAT_NUM RATE1,
                  MAX(SEAT_CRKM) SEAT_CRKM,
                  SUM(USE_CRKM) USE_CRKM,
                  '''' RATE2,
                  SUM(BIZ_RVN_AMT) BIZ_RVN_AMT
         FROM     (SELECT  STLB_TRN_CLSF_CD,
                           RUN_DT,
                           TRN_NO,
                           (SELECT VLID_VAL_NM FROM TB_YYDK007 WHERE XROIS_OLD_SRT_CD = ''I909'' AND VLID_VAL = Z.DAY_DV_CD) DAY_DV,
						(SELECT B.KOR_STN_NM
                         FROM TB_YYDK001 A, TB_YYDK102 B
                        WHERE     1 = 1
                              AND A.RS_STN_CD = DPT_STN_CD
                              AND A.STN_CD = B.STN_CD
                              AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT
                                                                    AND B.APL_CLS_DT) DPT_STN_CD,
						(SELECT B.KOR_STN_NM
                         FROM TB_YYDK001 A, TB_YYDK102 B
                        WHERE     1 = 1
                              AND A.RS_STN_CD = ARV_STN_CD
                              AND A.STN_CD = B.STN_CD
                              AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT
                                                                    AND B.APL_CLS_DT) ARV_STN_CD,
                           TO_CHAR(DPT_RUN_ORDR) DPT_RUN_ORDR,
                           TO_CHAR(ARV_RUN_ORDR) ARV_RUN_ORDR,
                           SEAT_NUM,
                           SUM(ABRD_PRNB) ABRD_PRNB,
                           SUM(ABRD_PRNB) / SEAT_NUM RATE1,
                           MAX_OD_DST     * SEAT_NUM SEAT_CRKM,
                           SUM(ABRD_PRNB) * OD_DST USE_CRKM,
                           OD_DST,
                           MAX_OD_DST,
                           '''' RATE2,
                           NVL(BIZ_RVN_AMT, 0) BIZ_RVN_AMT
                  FROM     (SELECT  S.STLB_TRN_CLSF_CD,
                                    A.RUN_DT,
                                    A.TRN_NO,
                                    (SELECT DAY_DV_CD
                                    FROM    TB_YYDK002
                                    WHERE   RUN_DT = A.RUN_DT
                                    )
                                    DAY_DV_CD,
                                    C.STOP_RS_STN_CD DPT_STN_CD,
                                    D.STOP_RS_STN_CD ARV_STN_CD,
                                    C.RUN_ORDR DPT_RUN_ORDR,
                                    D.RUN_ORDR ARV_RUN_ORDR,
                                    SUM(A.ABRD_PRNB) ABRD_PRNB,
                                    (SELECT SUM(SEAT_NUM)
                                    FROM    TB_YYDS511
                                    WHERE   RUN_DT = A.RUN_DT
                                    AND     TRN_NO LIKE DECODE(#TRN_NO#, '''',
                                                            ''%'',
                                                            #TRN_NO#)
                                    AND     PSRM_CL_CD LIKE DECODE(#PSRM_CL_CD#, '''',''%'',''%'')
                                    )
                                    SEAT_NUM,
                                    YZDBA.FN_YZYB_GetRoutDstCal(G.ROUT_CD, H.STN_CONS_ORDR, I.STN_CONS_ORDR, A.RUN_DT, 1) OD_DST,
                                    
									(SELECT CASE WHEN TO_NUMBER(MOD( DECODE(#TRN_NO#, '''', 0, #TRN_NO#) , 2)) = 1 THEN YZDBA.FN_YZYB_GetRoutDstCal(CC.ROUT_CD, MIN(AA.STN_CONS_ORDR), MAX(BB.STN_CONS_ORDR), AA.RUN_DT, 1)
                                                                                                    ELSE YZDBA.FN_YZYB_GetRoutDstCal(CC.ROUT_CD, MAX(AA.STN_CONS_ORDR), MIN(BB.STN_CONS_ORDR), AA.RUN_DT, 1)
									END MAX_OD_DST
                                    FROM     TB_YYDK302 AA,
                                             TB_YYDK302 BB,
                                             TB_YYDK301 CC
                                    WHERE    AA.RUN_DT         = CC.RUN_DT
                                    AND      AA.TRN_NO         = CC.TRN_NO
                                    AND      CC.STLB_TRN_CLSF_CD LIKE DECODE(#STLB_TRN_CLSF_CD#,'''',''%'',#STLB_TRN_CLSF_CD#)
                                    AND      AA.RUN_DT         = A.RUN_DT
                                    AND      AA.TRN_NO         = A.TRN_NO
                                    AND      AA.RUN_DT         = C.RUN_DT
                                    AND      AA.TRN_NO         = C.TRN_NO
                                    AND      AA.STOP_RS_STN_CD LIKE DECODE(#DPT_STN_CD#, '''',
                                                                        ''%'',
                                                                        #DPT_STN_CD#)
                                    AND      BB.RUN_DT         = D.RUN_DT
                                    AND      BB.TRN_NO         = D.TRN_NO
                                    AND      BB.STOP_RS_STN_CD LIKE DECODE(#ARV_STN_CD#, '''',
                                                                        ''%'',
                                                                        #ARV_STN_CD#)
                                    GROUP BY CC.ROUT_CD,
                                             AA.RUN_DT,
                                             C.STN_CONS_ORDR,
                                             D.STN_CONS_ORDR
                                    )
                                    MAX_OD_DST,
                                    J.BIZ_RVN_AMT
                           FROM     TB_YYDK301 S,
                                    (SELECT  RUN_DT,
                                             TRN_NO,
                                             PSRM_CL_CD,
                                             DECODE(BKCL_CD,''F2'',
                                                    ''F1'',
                                                    BKCL_CD) BKCL_CD,
                                             DPT_STN_CONS_ORDR,
                                             ARV_STN_CONS_ORDR,
                                             SUM(ABRD_POSN_RT)   AS ABRD_POSN_RT,
                                             SUM(ABRD_PRNB)      AS ABRD_PRNB,
                                             SUM(SMG_ABRD_PRNB)  AS SMG_ABRD_PRNB,
                                             SUM(CMTR_ABRD_PRNB) AS CMTR_ABRD_PRNB
                                    FROM     TB_YYDS510
                                    WHERE    RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
                                    AND      TRN_NO LIKE DECODE(#TRN_NO#, '''',
                                                             ''%'',
                                                             #TRN_NO#)
                                    GROUP BY RUN_DT,
                                             TRN_NO,
                                             PSRM_CL_CD,
                                             DECODE(BKCL_CD,''F2'',
                                                    ''F1'',
                                                    BKCL_CD),
                                             DPT_STN_CONS_ORDR,
                                             ARV_STN_CONS_ORDR
                                    )
                                    A,
                                    (SELECT RUN_DT,
                                            TRN_NO,
                                            STN_CONS_ORDR,
                                            RUN_ORDR,
                                            STOP_RS_STN_CD
                                    FROM    TB_YYDK302
                                    WHERE   RUN_DT BETWEEN #RUN_TRM_ST_DT# AND     #RUN_TRM_CLS_DT#
                                    AND     TRN_NO LIKE DECODE(#TRN_NO#, '''',
                                                            ''%'',
                                                            #TRN_NO#)
                                    AND     STOP_RS_STN_CD LIKE DECODE(#DPT_STN_CD#, '''',
                                                                    ''%'',
                                                                    #DPT_STN_CD#)
                                    )
                                    C,
                                    (SELECT RUN_DT,
                                            TRN_NO,
                                            STN_CONS_ORDR,
                                            RUN_ORDR,
                                            STOP_RS_STN_CD
                                    FROM    TB_YYDK302
                                    WHERE   RUN_DT BETWEEN #RUN_TRM_ST_DT# AND     #RUN_TRM_CLS_DT#
                                    AND     TRN_NO LIKE DECODE(#TRN_NO#, '''',
                                                            ''%'',
                                                            #TRN_NO#)
                                    AND     STOP_RS_STN_CD LIKE DECODE(#ARV_STN_CD#, '''',
                                                                    ''%'',
                                                                    #ARV_STN_CD#)
                                    )
                                    D,
                                    (SELECT RUN_DT,
                                            TRN_NO,
                                            ROUT_CD
                                    FROM    TB_YYDK301
                                    WHERE   RUN_DT BETWEEN #RUN_TRM_ST_DT# AND     #RUN_TRM_CLS_DT#
                                    AND     TRN_NO LIKE DECODE(#TRN_NO#, '''',
                                                            ''%'',
                                                            #TRN_NO#)
                                    )
                                    G,
                                    TB_YYDK302 H,
                                    TB_YYDK302 I,
                                    (SELECT  A.RUN_DT,
                                             /* 운행일자         */
                                             A.TRN_NO,
                                             /* 열차번호         */
                                             A.DPT_STN_CONS_ORDR,
                                             /* 출발역 구성순서  */
                                             A.ARV_STN_CONS_ORDR,
                                             /* 도착역 구성순서  */
                                             SUM(A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT) BIZ_RVN_AMT
                                             /* 영업수입*/
                                    FROM     TB_YYDS512 A,
                                             /** 구간별 승차수입실적 **/
                                             TB_YYDS510 B
                                             /** 열차별 초과예약한도 **/
                                    WHERE    A.RUN_DT     = B.RUN_DT
                                    AND      A.TRN_NO     = B.TRN_NO
                                    AND      A.PSRM_CL_CD = B.PSRM_CL_CD
                                    AND      B.PSRM_CL_CD LIKE DECODE(#PSRM_CL_CD#, '''',''%'',''%'')
                                    AND      A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR
                                    AND      A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR
                                    AND      A.BKCL_CD          = B.BKCL_CD
                                    AND      A.SEAT_ATT_CD       = B.SEAT_ATT_CD
                                    AND      A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
                                    AND      A.TRN_NO LIKE DECODE(#TRN_NO#, '''',
                                                               ''%'',
                                                               #TRN_NO#)
                                    GROUP BY A.RUN_DT,
                                             A.TRN_NO,
                                             A.DPT_STN_CONS_ORDR,
                                             A.ARV_STN_CONS_ORDR
                                    )
                                    J
                           WHERE    S.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
                           AND      S.TRN_NO LIKE DECODE(#TRN_NO#, '''',
                                                      ''%'',
                                                      #TRN_NO#)
                           AND      S.STLB_TRN_CLSF_CD LIKE DECODE(#STLB_TRN_CLSF_CD#,'''',''%'',#STLB_TRN_CLSF_CD#)
                           AND      S.RUN_DT         = A.RUN_DT
                           AND      S.TRN_NO         = A.TRN_NO
                           AND      A.PSRM_CL_CD     LIKE DECODE(#PSRM_CL_CD#, '''',''%'',''%'')
                           AND      S.RUN_DT               = J.RUN_DT
                           AND      S.TRN_NO               = J.TRN_NO
                           AND      J.RUN_DT(+)            = A.RUN_DT
                           AND      J.TRN_NO(+)            = A.TRN_NO
                           AND      J.DPT_STN_CONS_ORDR(+) = A.DPT_STN_CONS_ORDR
                           AND      J.ARV_STN_CONS_ORDR(+) = A.ARV_STN_CONS_ORDR
                           AND      S.TRN_NO               = C.TRN_NO
                           AND      S.TRN_NO               = D.TRN_NO
                           AND      S.RUN_DT               = C.RUN_DT
                           AND      S.RUN_DT               = D.RUN_DT
                           AND      S.RUN_DT               = G.RUN_DT
                           AND      S.TRN_NO               = G.TRN_NO
                           AND      S.RUN_DT               = H.RUN_DT
                           AND      S.TRN_NO               = H.TRN_NO
                           AND      C.RUN_DT               = H.RUN_DT
                           AND      C.TRN_NO               = H.TRN_NO
                           AND      C.RUN_ORDR             = H.RUN_ORDR
                           AND      C.STN_CONS_ORDR        = H.STN_CONS_ORDR
                           AND      C.STOP_RS_STN_CD       = H.STOP_RS_STN_CD
                           AND      D.RUN_DT               = I.RUN_DT
                           AND      D.TRN_NO               = I.TRN_NO
                           AND      D.RUN_ORDR             = I.RUN_ORDR
                           AND      D.STN_CONS_ORDR        = I.STN_CONS_ORDR
                           AND      D.STOP_RS_STN_CD       = I.STOP_RS_STN_CD
                           AND      A.DPT_STN_CONS_ORDR    = H.STN_CONS_ORDR
                           AND      S.RUN_DT               = I.RUN_DT
                           AND      S.TRN_NO               = I.TRN_NO
                           AND      A.ARV_STN_CONS_ORDR    = I.STN_CONS_ORDR
				AND      NOT
			    (
				     I.RUN_ORDR <= C.RUN_ORDR
			    OR       H.RUN_ORDR >= D.RUN_ORDR
			    )
                           GROUP BY S.STLB_TRN_CLSF_CD,
                                    A.RUN_DT,
                                    A.TRN_NO,
                                    C.STOP_RS_STN_CD,
                                    D.STOP_RS_STN_CD,
                                    G.ROUT_CD,
                                    H.STN_CONS_ORDR,
                                    I.STN_CONS_ORDR,
                                    C.RUN_ORDR,
                                    D.RUN_ORDR,
                                    J.BIZ_RVN_AMT,
                                    A.PSRM_CL_CD,
                                    C.STN_CONS_ORDR,
                                    D.STN_CONS_ORDR,
                                    C.TRN_NO,
                                    C.RUN_DT,
                                    D.TRN_NO,
                                    D.RUN_DT
                           ORDER BY S.STLB_TRN_CLSF_CD,
                                    A.RUN_DT,
                                    A.TRN_NO,
                                    C.RUN_ORDR,
                                    D.RUN_ORDR,
                                    C.STOP_RS_STN_CD,
                                    D.STOP_RS_STN_CD,
                                    BIZ_RVN_AMT
                           )
                           Z
                  GROUP BY STLB_TRN_CLSF_CD,
                           RUN_DT,
                           TRN_NO,
                           DPT_STN_CD,
                           ARV_STN_CD,
                           DPT_RUN_ORDR,
                           ARV_RUN_ORDR,
                           SEAT_NUM,
                           OD_DST,
                           BIZ_RVN_AMT,
                           Z.DAY_DV_CD,
                           MAX_OD_DST
                  )
         GROUP BY STLB_TRN_CLSF_CD,
                  RUN_DT,
                  TRN_NO,
                  SEAT_NUM,
                  DAY_DV,
                  DPT_RUN_ORDR,
                  ARV_RUN_ORDR,
                  DPT_STN_CD,
                  ARV_STN_CD
         )
GROUP BY STLB_TRN_CLSF_CD,
         RUN_DT,
         DAY_DV,
         DPT_RUN_ORDR,
         ARV_RUN_ORDR,
         DPT_STN_NM,
         ARV_STN_NM
ORDER BY STLB_TRN_CLSF_CD, RUN_DT, DPT_RUN_ORDR, ARV_RUN_ORDR
]]>
', TO_DATE('04/16/2014 11:25:23', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA007QMDAO.selectListAcvmByDateQry', '/*com.korail.yz.yr.aa.YRAA007QMDAO.selectListAcvmByDateQry*/ 
<![CDATA[

/*추후 테스트 데이터 정상 이관 후 수정 예정
1. SEAT_ATT_CD YYDS512 2BYTE에서 3BYTE로 변경됨
2. RS_STN_CD   YYDK001 4BYTE에서 5BYTE로 변경됨

일단 테스트를 위해 
일시적으로 3BYTE, 5BYTE데이터를 2BYTE, 4BYTE로 잘라서 사용한다.
*/
SELECT   A.RUN_DT AS RUN_DT,
         A.TRN_NO AS TRN_NO,
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A,
                 TB_YYDK102 B
         WHERE   1=1
         AND     A.RS_STN_CD = SUBSTR(A.ORG_RS_STN_CD,2,5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
                  || ''-''
                  ||
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A,
                 TB_YYDK102 B
         WHERE   1           =1
         AND     A.RS_STN_CD = SUBSTR(A.TMN_RS_STN_CD,2,5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
                  || ''(''
                  ||
         (SELECT TO_CHAR(TO_DATE(DPT_TM, ''hh24miss''), ''hh24:mi'')
         FROM    TB_YYDK302
         WHERE   RUN_DT   = A.RUN_DT
         AND     TRN_NO   = A.TRN_NO
         AND     RUN_ORDR = 1
         )
                  || ''-''
                  ||
         (SELECT TO_CHAR(TO_DATE(ARV_TM, ''hh24miss''), ''hh24:mi'')
         FROM    TB_YYDK302
         WHERE   RUN_DT   = A.RUN_DT
         AND     TRN_NO   = A.TRN_NO
         AND     RUN_ORDR =
                 (SELECT MAX(RUN_ORDR)
                 FROM    TB_YYDK302
                 WHERE   RUN_DT = A.RUN_DT
                 AND     TRN_NO = A.TRN_NO
                 )
         )
                  || '')'' RUN_INFO,
         A.SEAT_ATT_CD SEAT_ATT_CD,
         A.BS_SEAT_NUM,
         NVL(B.ABRD_PRNB,0) ABRD_PRNB,
         NVL(C.BIZ_RVN_AMT,0) BIZ_RVN_AMT
FROM     (SELECT  Y.RUN_DT,
                  Y.TRN_NO,
                  SEAT_ATT_CD,
                  X.STLB_TRN_CLSF_CD,
                  X.ORG_RS_STN_CD,
                  X.TMN_RS_STN_CD,
                  SUM(Y.BS_SEAT_NUM) AS BS_SEAT_NUM
         FROM     TB_YYDK305 Y,
                  TB_YYDK301 X
         WHERE    Y.SEAT_ATT_CD IN (''003'',
                                    ''033'')
         AND      Y.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
         AND
                  (
                           #TRN_NO_CONT# IS NULL
                  OR       Y.TRN_NO         LIKE #TRN_NO_CONT#
                  )
         AND      Y.RUN_DT         = X.RUN_DT
         AND      Y.TRN_NO         = X.TRN_NO
         AND      (#STLB_TRN_CLSF_CD# IS NULL OR X.STLB_TRN_CLSF_CD LIKE #STLB_TRN_CLSF_CD#)
         GROUP BY Y.RUN_DT,
                  Y.TRN_NO,
                  SEAT_ATT_CD,
                  X.STLB_TRN_CLSF_CD,
                  X.ORG_RS_STN_CD,
                  X.TMN_RS_STN_CD
         )
         A,
         (SELECT  RUN_DT,
                  TRN_NO,
                  SEAT_ATT_CD,
                  SUM(ABRD_PRNB) AS ABRD_PRNB
         FROM     TB_YYDS510
         WHERE    SEAT_ATT_CD IN (''03'',
                                  ''33'')
         AND      RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
         AND
                  (
                           #TRN_NO_CONT# IS NULL
                  OR       TRN_NO           LIKE #TRN_NO_CONT#
                  )
         GROUP BY RUN_DT,
                  TRN_NO,
                  SEAT_ATT_CD
         )
         B,
         (SELECT  RUN_DT,
                  TRN_NO,
                  SEAT_ATT_CD,
                  SUM(BIZ_RVN_AMT - SMG_BIZ_RVN_AMT) AS BIZ_RVN_AMT
         FROM     TB_YYDS512
         WHERE    SEAT_ATT_CD IN (''03'',
                                  ''33'')
         AND      RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
         AND
                  (
                           #TRN_NO_CONT# IS NULL
                  OR       TRN_NO           LIKE #TRN_NO_CONT#
                  )
         GROUP BY RUN_DT,
                  TRN_NO,
                  SEAT_ATT_CD
         )
         C
WHERE    A.RUN_DT      = B.RUN_DT(+)
AND      A.TRN_NO      = B.TRN_NO(+)
AND      A.SEAT_ATT_CD = ''0''||B.SEAT_ATT_CD(+)
AND      A.RUN_DT      = C.RUN_DT(+)
AND      A.TRN_NO      = C.TRN_NO(+)
AND      A.SEAT_ATT_CD = ''0''||C.SEAT_ATT_CD(+)
ORDER BY A.RUN_DT,
         A.TRN_NO,
         A.ORG_RS_STN_CD,
         A.TMN_RS_STN_CD,
         A.SEAT_ATT_CD
]]>', TO_DATE('03/26/2014 17:53:07', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA007QMDAO.selectListAcvmByTrnQry', '/*com.korail.yz.yr.aa.YRAA007QMDAO.selectListAcvmByTrnQry*/ 
<![CDATA[
SELECT   A.TRN_NO TRN_NO,
         A.SEAT_ATT_CD SEAT_ATT_CD,
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A,
                 TB_YYDK102 B
         WHERE   1           =1
         AND     A.RS_STN_CD = SUBSTR(A.ORG_RS_STN_CD,2,5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
                  || ''-''
                  ||
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A,
                 TB_YYDK102 B
         WHERE   1=1
         AND     A.RS_STN_CD = SUBSTR(A.TMN_RS_STN_CD,2,5)
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
                  || ''(''
                  ||
         (SELECT TO_CHAR(TO_DATE(DPT_TM, ''hh24miss''), ''hh24:mi'')
         FROM    TB_YYDK302
         WHERE   RUN_DT   = #RUN_TRM_CLS_DT#
         AND     TRN_NO   = A.TRN_NO
         AND     RUN_ORDR = 1
         )
                  || ''-''
                  ||
         (SELECT TO_CHAR(TO_DATE(ARV_TM, ''hh24miss''), ''hh24:mi'')
         FROM    TB_YYDK302
         WHERE   RUN_DT   = #RUN_TRM_CLS_DT#
         AND     TRN_NO   = A.TRN_NO
         AND     RUN_ORDR =
                 (SELECT MAX(RUN_ORDR)
                 FROM    TB_YYDK302
                 WHERE   RUN_DT = #RUN_TRM_CLS_DT#
                 AND     TRN_NO = A.TRN_NO
                 )
         )
                  || '')'' RUN_INFO,
         A.BS_SEAT_NUM,
         NVL(B.ABRD_PRNB,0) ABRD_PRNB,
         NVL(C.BIZ_RVN_AMT,0) BIZ_RVN_AMT
FROM     (SELECT  Y.TRN_NO,
                  SEAT_ATT_CD,
                  X.STLB_TRN_CLSF_CD,
                  X.ORG_RS_STN_CD,
                  X.TMN_RS_STN_CD,
                  SUM(Y.BS_SEAT_NUM) AS BS_SEAT_NUM
         FROM     TB_YYDK305 Y,
                  TB_YYDK301 X
         WHERE    Y.SEAT_ATT_CD IN (''003'',
                                    ''033'')
         AND      Y.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
         AND
                  (
                           #TRN_NO_CONT# IS NULL
                  OR       Y.TRN_NO         LIKE #TRN_NO_CONT#
                  )
         AND      Y.RUN_DT         = X.RUN_DT
         AND      Y.TRN_NO         = X.TRN_NO
         AND      (#STLB_TRN_CLSF_CD# IS NULL OR X.STLB_TRN_CLSF_CD LIKE #STLB_TRN_CLSF_CD#)
         GROUP BY Y.TRN_NO,
                  SEAT_ATT_CD,
                  X.STLB_TRN_CLSF_CD,
                  X.ORG_RS_STN_CD,
                  X.TMN_RS_STN_CD
         )
         A,
         (SELECT  TRN_NO,
                  SEAT_ATT_CD,
                  SUM(ABRD_PRNB) AS ABRD_PRNB
         FROM     TB_YYDS510
         WHERE    SEAT_ATT_CD IN (''03'',
                                  ''33'')
         AND      RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
         AND
                  (
                           #TRN_NO_CONT# IS NULL
                  OR       TRN_NO           LIKE #TRN_NO_CONT#
                  )
         GROUP BY TRN_NO,
                  SEAT_ATT_CD
         )
         B,
         (SELECT  TRN_NO,
                  SEAT_ATT_CD,
                  SUM(BIZ_RVN_AMT - SMG_BIZ_RVN_AMT) AS BIZ_RVN_AMT
         FROM     TB_YYDS512
         WHERE    SEAT_ATT_CD IN (''03'',
                                  ''33'')
         AND      RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
         AND
                  (
                           #TRN_NO_CONT# IS NULL
                  OR       TRN_NO           LIKE #TRN_NO_CONT#
                  )
         GROUP BY TRN_NO,
                  SEAT_ATT_CD
         )
         C
WHERE    A.TRN_NO      = B.TRN_NO(+)
AND      A.SEAT_ATT_CD = ''0''||B.SEAT_ATT_CD(+)
AND      A.TRN_NO      = C.TRN_NO(+)
AND      A.SEAT_ATT_CD = ''0''||C.SEAT_ATT_CD(+)
ORDER BY A.TRN_NO,
         A.SEAT_ATT_CD
]]>

', TO_DATE('03/26/2014 17:53:07', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA008QMDAO.selectListRestSeatAcvmByDateQry', '/*com.korail.yz.yr.aa.YRAA008QMDAO.selectListRestSeatAcvmByDateQry*/ 
<![CDATA[
   SELECT    SUBSTR (A.RUN_DT, 1, 4) 
          || ''.'' 
          || SUBSTR (A.RUN_DT, 5, 2) 
          || ''.'' 
          || SUBSTR (A.RUN_DT, 7, 2) 
          || ''('' 
          || (SELECT SUBSTR(VLID_VAL_NM, 1, 1) FROM TB_YYDK007 WHERE XROIS_OLD_SRT_CD = ''I909'' AND VLID_VAL = A.DAY_DV_CD) 
          || '')'' 
             AS RUN_DT, 
          TO_CHAR (TO_NUMBER (A.TRN_NO)) AS TRN_NO, 
  
        (SELECT B.KOR_STN_NM 
   FROM TB_YYDK001 A, TB_YYDK102 B 
  WHERE     1 = 1 
        AND A.RS_STN_CD = SUBSTR (A.ORG_RS_STN_CD, 2, 5) 
        AND A.STN_CD = B.STN_CD 
        AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT 
           AND B.APL_CLS_DT) 
          || ''-'' 
   || 
  (SELECT B.KOR_STN_NM 
    FROM TB_YYDK001 A, TB_YYDK102 B 
    WHERE     1 = 1 
        AND A.RS_STN_CD = SUBSTR (A.TMN_RS_STN_CD, 2, 5) 
        AND A.STN_CD = B.STN_CD 
        AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT 
           AND B.APL_CLS_DT) 
          || ''('' 
          || (SELECT TO_CHAR (TO_DATE (DPT_TM, ''HH24MISS''), ''HH24:MI'') 
                FROM TB_YYDK302                                  /** 일일열차운행시각 **/ 
               WHERE RUN_DT = A.RUN_DT AND TRN_NO = A.TRN_NO AND RUN_ORDR = 1) 
          || ''-'' 
          || (SELECT TO_CHAR (TO_DATE (ARV_TM, ''HH24MISS''), ''HH24:MI'') 
                FROM TB_YYDK302                                  /** 일일열차운행시각 **/ 
               WHERE     RUN_DT = A.RUN_DT 
                     AND TRN_NO = A.TRN_NO 
                     AND RUN_ORDR = 
                            (SELECT MAX (RUN_ORDR) 
                               FROM TB_YYDK302 
                              WHERE RUN_DT = A.RUN_DT AND TRN_NO = A.TRN_NO)) 
          || '')'' 
             RUN_INFO,                                             /* 운행구간정보 */ 
          (SELECT VLID_VAL_NM FROM TB_YYDK007 WHERE XROIS_OLD_SRT_CD = ''R701'' AND VLID_VAL = LPAD(A.SEAT_ATT_CD,2,''0'')) SEAT_ATT_CD, 
          A.DPT_STN_RUN_ORDR, 
  
   (SELECT B.KOR_STN_NM 
   FROM TB_YYDK001 A, TB_YYDK102 B 
  WHERE     1 = 1 
        AND A.RS_STN_CD = A.STOP_RS_STN_CD
        AND A.STN_CD = B.STN_CD 
        AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT 
           AND B.APL_CLS_DT) 
          || ''('' 
          || SUBSTR (A.DPT_TM, 1, 2) 
          || '':'' 
          || SUBSTR (A.DPT_TM, 3, 2) 
          || '')-'' 
          ||          (SELECT B.KOR_STN_NM 
   FROM TB_YYDK001 A, TB_YYDK102 B 
  WHERE     1 = 1 
        AND A.RS_STN_CD = A.ARV_STOP_RS_STN_CD
        AND A.STN_CD = B.STN_CD 
        AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT 
           AND B.APL_CLS_DT) 
          || ''('' 
          || SUBSTR (A.ARV_TM, 1, 2) 
          || '':'' 
          || SUBSTR (A.ARV_TM, 3, 2) 
          || '')'' 
             STOP_RS_STN_CD, 
          A.WHL_SEAT_NUM - A.REST_SEAT_NUM SALE_NUM, 
          A.REST_SEAT_NUM, 
          A.WHL_SEAT_NUM
     FROM (  SELECT Y.RUN_DT, 
                    Y.TRN_NO, 
                    Q.SEAT_ATT_CD, 
                    Y.DPT_STN_RUN_ORDR, 
                    X.STLB_TRN_CLSF_CD, 
                    X.ORG_RS_STN_CD, 
                    X.TMN_RS_STN_CD, 
                    S.STOP_RS_STN_CD, 
                    S.DPT_TM, 
                    T.DAY_DV_CD, 
                    Z.STOP_RS_STN_CD ARV_STOP_RS_STN_CD, 
                    Z.DPT_TM ARV_TM, 
                    SUM (Y.REST_SEAT_NUM) AS REST_SEAT_NUM,
                    SUM (Y.WHL_SEAT_NUM) AS WHL_SEAT_NUM
                    --SUM (Y.FST_SEAT_NUM) AS FST_SEAT_NUM,
                    
               FROM TB_YYDK307 Y, 
                    TB_YYDK301 X, 
                    TB_YYDK302 S, 
                    TB_YYDP503 T, 
                    TB_YYDK302 Z,
                    TB_YYDK305 Q
              WHERE 1=1
                    AND Y.RUN_DT = Q.RUN_DT
                    AND Y.TRN_NO = Q.TRN_NO
                    AND Y.REST_SEAT_MG_ID = Q.REST_SEAT_MG_ID 
                    AND Q.SEAT_ATT_CD IN (''03'', ''33'') 
                   AND Y.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
                   AND Y.TRN_NO LIKE DECODE(#TRN_NO#, '''', ''%'', #TRN_NO#)
                   AND Y.RUN_DT = X.RUN_DT
                   AND Y.TRN_NO = X.TRN_NO
                   AND X.STLB_TRN_CLSF_CD LIKE DECODE(#STLB_TRN_CLSF_CD#, '''', ''%'', #STLB_TRN_CLSF_CD#)
                   AND X.UP_DN_DV_CD LIKE DECODE(#UP_DN_DV_CD#, ''A'', ''%'', #UP_DN_DV_CD#)
                   AND Y.RUN_DT = S.RUN_DT
                   AND Y.TRN_NO = S.TRN_NO
                   AND Y.DPT_STN_RUN_ORDR = S.RUN_ORDR
                   AND S.DPT_TM ^= ''999999''
                   AND Y.RUN_DT = T.RUN_DT
                   AND Y.TRN_NO = T.TRN_NO
                   AND T.MRNT_CD LIKE DECODE(#MRNT_CD#, '''', ''%'', #MRNT_CD#)
                   AND T.MRNT_CD IN (''01'', ''03'', ''04'')
                   AND T.DAY_DV_CD LIKE DECODE(#DAY_DV_CD#, ''0'', ''%'', #DAY_DV_CD#)
                   AND Y.RUN_DT = Z.RUN_DT
                   AND Y.TRN_NO = Z.TRN_NO
                    AND Y.DPT_STN_RUN_ORDR = (Z.RUN_ORDR - 1) 
           GROUP BY Y.RUN_DT, 
                    Y.TRN_NO, 
                    Q.SEAT_ATT_CD, 
                    Y.DPT_STN_RUN_ORDR, 
                    X.STLB_TRN_CLSF_CD, 
                    X.ORG_RS_STN_CD, 
                    X.TMN_RS_STN_CD, 
                    S.STOP_RS_STN_CD, 
                    S.DPT_TM, 
                    T.DAY_DV_CD, 
                    Z.STOP_RS_STN_CD, 
                    Z.DPT_TM) A 
 ORDER BY A.RUN_DT, 
          A.TRN_NO, 
          A.SEAT_ATT_CD, 
          A.DPT_STN_RUN_ORDR 
  
  
]]>
', TO_DATE('04/14/2014 10:49:17', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA008QMDAO.selectListRestSeatAcvmByTrnQry', '/*com.korail.yz.yr.aa.YRAA008QMDAO.selectListRestSeatAcvmByTrnQry*/ 
<![CDATA[

  SELECT TO_CHAR (TO_NUMBER (A.TRN_NO)) AS TRN_NO,
         (SELECT VLID_VAL_NM
            FROM TB_YYDK007
           WHERE XROIS_OLD_SRT_CD = ''I909'' AND VLID_VAL = A.DAY_DV_CD)
            DAY_DV_CD,
         (SELECT VLID_VAL_NM
            FROM TB_YYDK007
           WHERE XROIS_OLD_SRT_CD = ''R701'' AND VLID_VAL = LPAD(A.SEAT_ATT_CD, 2, ''0''))
            SEAT_ATT_CD,
         A.DPT_STN_RUN_ORDR,
        (SELECT B.KOR_STN_NM 
   FROM TB_YYDK001 A, TB_YYDK102 B 
  WHERE     1 = 1 
        AND A.RS_STN_CD = A.STOP_RS_STN_CD
        AND A.STN_CD = B.STN_CD 
        AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT 
           AND B.APL_CLS_DT)
         || ''(''
         || SUBSTR (A.DPT_TM, 1, 2)
         || '':''
         || SUBSTR (A.DPT_TM, 3, 2)
         || '')-''
		 ||         (SELECT B.KOR_STN_NM 
   FROM TB_YYDK001 A, TB_YYDK102 B 
  WHERE     1 = 1 
        AND A.RS_STN_CD = A.ARV_STOP_RS_STN_CD
        AND A.STN_CD = B.STN_CD 
        AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT 
        AND B.APL_CLS_DT)
         || ''(''
         || SUBSTR (A.ARV_TM, 1, 2)
         || '':''
         || SUBSTR (A.ARV_TM, 3, 2)
         || '')''
            STOP_RS_STN_CD,
         A.WHL_SEAT_NUM,
         A.WHL_SEAT_NUM - A.REST_SEAT_NUM AS SALE_NUM,
         A.REST_SEAT_NUM
    FROM (  SELECT Y.TRN_NO,
                   Q.SEAT_ATT_CD,
                   Y.DPT_STN_RUN_ORDR,
                   X.STLB_TRN_CLSF_CD,
                   S.STOP_RS_STN_CD,
                   S.DPT_TM,
                   T.DAY_DV_CD,
                   Z.STOP_RS_STN_CD ARV_STOP_RS_STN_CD,
                   Z.DPT_TM ARV_TM,
                   AVG (Y.WHL_SEAT_NUM) AS WHL_SEAT_NUM,
                   AVG (Y.REST_SEAT_NUM) AS REST_SEAT_NUM
              FROM TB_YYDK307 Y,
                   TB_YYDK301 X,
                   TB_YYDK302 S,
                   TB_YYDP503 T,
                   TB_YYDK302 Z,
                   TB_YYDK305 Q
             WHERE  Y.RUN_DT = Q.RUN_DT
                    AND Y.TRN_NO = Q.TRN_NO
                    AND Y.REST_SEAT_MG_ID = Q.REST_SEAT_MG_ID 
					AND Q.SEAT_ATT_CD IN (''03'', ''33'')
                   AND Y.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
                   AND Y.TRN_NO LIKE DECODE (#TRN_NO#, '''', ''%'', #TRN_NO#)
                   AND Y.RUN_DT = X.RUN_DT
                   AND Y.TRN_NO = X.TRN_NO
                   AND X.STLB_TRN_CLSF_CD LIKE
                          DECODE (#STLB_TRN_CLSF_CD#,
                                  '''', ''%'',
                                  #STLB_TRN_CLSF_CD#)
                   AND X.UP_DN_DV_CD LIKE
                          DECODE (#UP_DN_DV_CD#, ''A'', ''%'', #UP_DN_DV_CD#)
                   AND Y.RUN_DT = S.RUN_DT
                   AND Y.TRN_NO = S.TRN_NO
                   AND Y.DPT_STN_RUN_ORDR = S.RUN_ORDR
                   AND S.DPT_TM ^= ''999999''
                   AND Y.RUN_DT = T.RUN_DT
                   AND Y.TRN_NO = T.TRN_NO
                   AND T.MRNT_CD LIKE DECODE (#MRNT_CD#, '''', ''%'', #MRNT_CD#)
                   AND T.MRNT_CD IN (''01'', ''03'', ''04'')
                   AND T.DAY_DV_CD LIKE
                          DECODE (#DAY_DV_CD#, ''0'', ''%'', #DAY_DV_CD#)
                   AND Y.RUN_DT = Z.RUN_DT
                   AND Y.TRN_NO = Z.TRN_NO
                   AND Y.DPT_STN_RUN_ORDR = (Z.RUN_ORDR - 1)
          GROUP BY Y.TRN_NO,
                   Q.SEAT_ATT_CD,
                   Y.DPT_STN_RUN_ORDR,
                   X.STLB_TRN_CLSF_CD,
                   S.STOP_RS_STN_CD,
                   S.DPT_TM,
                   T.DAY_DV_CD,
                   Z.STOP_RS_STN_CD,
                   Z.DPT_TM) A
ORDER BY A.TRN_NO,
         A.DAY_DV_CD,
         A.SEAT_ATT_CD,
         A.DPT_STN_RUN_ORDR

]]>
', TO_DATE('04/14/2014 10:49:17', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA009QMDAO.selectListSegPassRtTrnPrChtQry', '/*com.korail.yz.yr.aa.YRAA009QMDAO.selectListSegPassRtTrnPrChtQry*/ 
<![CDATA[
   
 SELECT 
 ORDR||''-''||ORDR2||DPT_STN_NM||''-''||ARV_STN_NM SEG_INFO 
 , DPT_INFO 
 , ARV_INFO
 , '''' PSRM_CL_NM
 , SUM(EACH_SEAT_NUM) EACH_SEAT_NUM
 , SUM(NSTP_PRNB) NSTP_PRNB 
 , SUM(ABRD_PRNB) ABRD_PRNB
 , SUM(GOFF_PRNB) GOFF_PRNB
 , ROUND( SUM(NSTP_PRNB)/SUM(EACH_SEAT_NUM),3) *100 SEG_PASS_RT
 
 FROM( 
 SELECT LPAD(TO_CHAR(C.RUN_ORDR), 2, '' '') ORDR,                                                      /* 출발역운행순서 */ 
        LPAD(TO_CHAR(D.RUN_ORDR), 2, '' '') ORDR2,    
        A.PSRM_CL_CD,                                      /* 도착역운행순서 */ 
        A.DPT_STN_CONS_ORDR,                                                                         /* 출발역구성순서 */ 
        A.ARV_STN_CONS_ORDR,                                                                         /* 도착역구성순서 */ 
        (SELECT VLID_VAL_NM FROM TB_YYDK007 WHERE XROIS_OLD_SRT_CD = ''R408'' AND VLID_VAL = A.PSRM_CL_CD) PSRM_CL_NM,/* 객실등급명 */ 
          ( SELECT B.KOR_STN_NM 
          FROM    TB_YYDK001 A, 
                  TB_YYDK102 B 
          WHERE   1           =1 
          AND     A.RS_STN_CD = C.STOP_RS_STN_CD 
          AND     A.STN_CD    = B.STN_CD 
          AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT 
          )DPT_STN_NM, 
          ( SELECT B.KOR_STN_NM 
          FROM    TB_YYDK001 A, 
                  TB_YYDK102 B 
          WHERE   1           =1 
          AND     A.RS_STN_CD = D.STOP_RS_STN_CD 
          AND     A.STN_CD    = B.STN_CD 
          AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT 
          )ARV_STN_NM, 
          ( SELECT B.KOR_STN_NM 
          FROM    TB_YYDK001 A, 
                  TB_YYDK102 B 
          WHERE   1           =1 
          AND     A.RS_STN_CD = C.STOP_RS_STN_CD 
          AND     A.STN_CD    = B.STN_CD 
          AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT 
          ) 
          || ''('' || SUBSTR(C.DPT_TM, 1, 2) || '':'' || SUBSTR(C.DPT_TM, 3, 2) 
          || '')'' DPT_INFO, 
          ( SELECT B.KOR_STN_NM 
          FROM    TB_YYDK001 A, 
                  TB_YYDK102 B 
          WHERE   1           =1 
          AND     A.RS_STN_CD = D.STOP_RS_STN_CD 
          AND     A.STN_CD    = B.STN_CD 
          AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT 
          ) 
          || ''('' || SUBSTR(D.ARV_TM, 1, 2) || '':'' || SUBSTR(D.ARV_TM, 3, 2) 
          || '')'' ARV_INFO,     /* 도착역/시각 */                                                                               
        A.NSTP_PRNB,                                                                                    /* 통과인원    */ 
        A.ABRD_PRNB,                                                                                    /* 승차인원    */ 
        A.GOFF_PRNB,                                                                                    /* 하차인원    */ 
        NVL((SELECT SUM(SEAT_NUM) 
         FROM   TB_YYDK303 
         WHERE  RUN_DT = A.RUN_DT 
         AND    TRN_NO = A.TRN_NO 
         AND    PSRM_CL_CD = ''1''),0) SEAT_NUM,                                                           /* 일반실 좌석수 */ 
        NVL((SELECT SUM(SEAT_NUM) 
         FROM   TB_YYDK303 
         WHERE  RUN_DT = A.RUN_DT 
         AND    TRN_NO = A.TRN_NO 
         AND    PSRM_CL_CD = ''2''),0) SPL_SEAT_NUM,                                                         /* 특실 좌석수 */ 
        DECODE(A.PSRM_CL_CD, 
               ''1'', NVL((SELECT SUM(SEAT_NUM) 
                     FROM   TB_YYDK303 
                     WHERE  RUN_DT = A.RUN_DT 
                     AND    TRN_NO = A.TRN_NO 
                     AND    PSRM_CL_CD = ''1''),0), 
               NVL((SELECT SUM(SEAT_NUM) 
                FROM   TB_YYDK303 
                WHERE  RUN_DT = A.RUN_DT 
                AND    TRN_NO = A.TRN_NO 
                AND    PSRM_CL_CD = ''2''),0) ) EACH_SEAT_NUM                                          /* 객실등급별 좌석수 */ 
 FROM   TB_YYRD005 A,                                                                          /** 열차별단구간통과인원 **/ 
        TB_YYDK302 C,                                                                          /** 일일열차운행시각     **/ 
        TB_YYDK302 D         
WHERE  A.RUN_DT = #RUN_DT#
AND    A.TRN_NO = #TRN_NO#
AND    A.PSRM_CL_CD LIKE DECODE(#PSRM_CL_CD#,'''',''%'',#PSRM_CL_CD#)
AND    A.RUN_DT = C.RUN_DT
AND    A.TRN_NO = C.TRN_NO
AND    A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
AND    A.RUN_DT = D.RUN_DT
AND    A.TRN_NO = D.TRN_NO
AND    A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
)
 GROUP BY 
 ORDR||''-''||ORDR2||DPT_STN_NM||''-''||ARV_STN_NM 
 ,DPT_INFO 
 ,ARV_INFO
 ORDER BY ORDR||''-''||ORDR2||DPT_STN_NM||''-''||ARV_STN_NM 
 ,DPT_INFO 
 ,ARV_INFO 


]]>
', TO_DATE('04/17/2014 10:09:10', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA009QMDAO.selectListSegPassRtTrnPrQry', '/*com.korail.yz.yr.aa.YRAA009QMDAO.selectListSegPassRtTrnPrQry*/ 
<![CDATA[
SELECT
ORDR
,ORDR2
,DPT_STN_CONS_ORDR
,ARV_STN_CONS_ORDR
,ORDR||''-''||ORDR2||DPT_STN_NM||''-''||ARV_STN_NM AS SEG_INFO
,PSRM_CL_CD
,PSRM_CL_NM
,DPT_INFO
,ARV_INFO
,NSTP_PRNB 
,ABRD_PRNB
,GOFF_PRNB
,SEAT_NUM
,SPL_SEAT_NUM
,EACH_SEAT_NUM
, DECODE(PSRM_CL_CD, ''1'', ROUND(NSTP_PRNB/SEAT_NUM, 3) * 100, ROUND(NSTP_PRNB/SPL_SEAT_NUM, 3) * 100) SEG_PASS_RT
FROM(
SELECT LPAD(TO_CHAR(C.RUN_ORDR), 2, '' '') ORDR,                                                      /* 출발역운행순서 */
       LPAD(TO_CHAR(D.RUN_ORDR), 2, '' '') ORDR2,                                                     /* 도착역운행순서 */
       A.DPT_STN_CONS_ORDR,                                                                         /* 출발역구성순서 */
       A.ARV_STN_CONS_ORDR,                                                                         /* 도착역구성순서 */
       A.PSRM_CL_CD,                                                                                /* 객실등급코드   */
       (SELECT VLID_VAL_NM FROM TB_YYDK007 WHERE XROIS_OLD_SRT_CD = ''R408'' AND VLID_VAL = A.PSRM_CL_CD) PSRM_CL_NM,/* 객실등급명 */
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A,
                 TB_YYDK102 B
         WHERE   1           =1
         AND     A.RS_STN_CD = C.STOP_RS_STN_CD
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )DPT_STN_NM,
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A,
                 TB_YYDK102 B
         WHERE   1           =1
         AND     A.RS_STN_CD = D.STOP_RS_STN_CD
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )ARV_STN_NM,
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A,
                 TB_YYDK102 B
         WHERE   1           =1
         AND     A.RS_STN_CD = C.STOP_RS_STN_CD
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
         || ''('' || SUBSTR(C.DPT_TM, 1, 2) || '':'' || SUBSTR(C.DPT_TM, 3, 2)
         || '')'' DPT_INFO,
         ( SELECT B.KOR_STN_NM
         FROM    TB_YYDK001 A,
                 TB_YYDK102 B
         WHERE   1           =1
         AND     A.RS_STN_CD = D.STOP_RS_STN_CD
         AND     A.STN_CD    = B.STN_CD
         AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
         )
         || ''('' || SUBSTR(D.ARV_TM, 1, 2) || '':'' || SUBSTR(D.ARV_TM, 3, 2)
         || '')'' ARV_INFO,					/* 도착역/시각 */                                                                              
       A.NSTP_PRNB,                                                                                    /* 통과인원    */
       A.ABRD_PRNB,                                                                                    /* 승차인원    */
       A.GOFF_PRNB,                                                                                    /* 하차인원    */
       NVL((SELECT SUM(SEAT_NUM)
        FROM   TB_YYDK303
        WHERE  RUN_DT = A.RUN_DT
        AND    TRN_NO = A.TRN_NO
        AND    PSRM_CL_CD = ''1''),0) SEAT_NUM,                                                           /* 일반실 좌석수 */
       NVL((SELECT SUM(SEAT_NUM)
        FROM   TB_YYDK303
        WHERE  RUN_DT = A.RUN_DT
        AND    TRN_NO = A.TRN_NO
        AND    PSRM_CL_CD = ''2''),0) SPL_SEAT_NUM,                                                         /* 특실 좌석수 */
       DECODE(A.PSRM_CL_CD,
              ''1'', NVL((SELECT SUM(SEAT_NUM)
                    FROM   TB_YYDK303
                    WHERE  RUN_DT = A.RUN_DT
                    AND    TRN_NO = A.TRN_NO
                    AND    PSRM_CL_CD = ''1''),0),
              NVL((SELECT SUM(SEAT_NUM)
               FROM   TB_YYDK303
               WHERE  RUN_DT = A.RUN_DT
               AND    TRN_NO = A.TRN_NO
               AND    PSRM_CL_CD = ''2''),0) ) EACH_SEAT_NUM                                          /* 객실등급별 좌석수 */
FROM   TB_YYRD005 A,                                                                          /** 열차별단구간통과인원 **/
       TB_YYDK302 C,                                                                          /** 일일열차운행시각     **/
       TB_YYDK302 D                                                                           /** 일일열차운행시각     **/
WHERE  A.RUN_DT = #RUN_DT#
AND    A.TRN_NO = #TRN_NO#
AND    A.PSRM_CL_CD LIKE DECODE(#PSRM_CL_CD#,'''',''%'',#PSRM_CL_CD#)
AND    A.RUN_DT = C.RUN_DT
AND    A.TRN_NO = C.TRN_NO
AND    A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
AND    A.RUN_DT = D.RUN_DT
AND    A.TRN_NO = D.TRN_NO
AND    A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
)
ORDER BY ORDR, ORDR2, PSRM_CL_CD


]]>
', TO_DATE('04/17/2014 10:09:10', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.aa.YRAA010QMDAO.selectListSegPassRtRunTrmPrQry', '/*com.korail.yz.yr.aa.YRAA010QMDAO.selectListSegPassRtRunTrmPrQry*/ 
<![CDATA[
SELECT A2.RUN_DT
              || '' (''
              || (SELECT VLID_VAL_NM FROM TB_YYDK007 WHERE XROIS_OLD_SRT_CD = ''I909'' AND VLID_VAL = A2.DAY_DV_CD)
              || '')'' RUN_DT,
       /* 운행일자       */
       LPAD(TO_CHAR(C2.RUN_ORDR), 2, '' '') ORDR,
       /* 출발역운행순서 */
       LPAD(TO_CHAR(D2.RUN_ORDR), 2, '' '') ORDR2,
       /* 도착역운행순서 */
       A2.DPT_STN_CONS_ORDR,
       /* 출발역구성순서 */
       A2.ARV_STN_CONS_ORDR,
       /* 도착역구성순서 */
       (SELECT VLID_VAL_NM FROM TB_YYDK007 WHERE XROIS_OLD_SRT_CD = ''R408'' AND VLID_VAL = A2.PSRM_CL_CD) PSRM_CL_CD,
       /* 객실등급명 */
        (SELECT B.KOR_STN_NM 
   FROM TB_YYDK001 A, TB_YYDK102 B 
  WHERE     1 = 1 
        AND A.RS_STN_CD = C2.STOP_RS_STN_CD
        AND A.STN_CD = B.STN_CD 
        AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT 
           AND B.APL_CLS_DT)

              || ''(''
              || SUBSTR(C2.DPT_TM, 1, 2)
              || '':''
              || SUBSTR(C2.DPT_TM, 3, 2)
              || '')'' DPT_INFO,
       /* 출발역/시각 */
        (SELECT B.KOR_STN_NM 
   FROM TB_YYDK001 A, TB_YYDK102 B 
  WHERE     1 = 1 
        AND A.RS_STN_CD = D2.STOP_RS_STN_CD
        AND A.STN_CD = B.STN_CD 
        AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN B.APL_ST_DT 
           AND B.APL_CLS_DT)

              || ''(''
              || SUBSTR(D2.ARV_TM, 1, 2)
              || '':''
              || SUBSTR(D2.ARV_TM, 3, 2)
              || '')'' ARV_INFO,
       /* 도착역/시각 */
       A2.NSTP_PRNB,
       /* 통과인원    */
       A2.ABRD_PRNB,
       /* 승차인원    */
       A2.GOFF_PRNB,
       /* 하차인원    */
       B2.SEAT_NUM,
       B2.SPL_SEAT_NUM,
       /* 특실 좌석수 */
       NVL(DECODE(A2.PSRM_CL_CD, ''1'',
                  B2.SEAT_NUM,
                  B2.SPL_SEAT_NUM),0) EACH_SEAT_NUM,
       /* 객실등급별 좌석수 */
       E2.ABRD_RT,
       E2.UTL_RT
FROM   (SELECT  A1.RUN_DT,
                A1.TRN_NO,
                A1.PSRM_CL_CD PSRM_CL_CD,
                DECODE(B1.UP_DN_DV_CD, ''D'',
                       MIN(A1.DPT_STN_CONS_ORDR),
                       MAX(A1.DPT_STN_CONS_ORDR)) DPT_STN_CONS_ORDR,
                DECODE(B1.UP_DN_DV_CD, ''D'',
                       MAX(A1.ARV_STN_CONS_ORDR),
                       MIN(A1.ARV_STN_CONS_ORDR)) ARV_STN_CONS_ORDR,
                MAX(A1.NSTP_PRNB) NSTP_PRNB,
                SUM(A1.ABRD_PRNB) ABRD_PRNB,
                SUM(A1.GOFF_PRNB) GOFF_PRNB,
                MIN(A1.DAY_DV_CD) DAY_DV_CD
       FROM     (SELECT A.RUN_DT,
                        A.TRN_NO,
                        A.DPT_STN_CONS_ORDR,
                        A.ARV_STN_CONS_ORDR,
                        A.PSRM_CL_CD,
                        A.NSTP_PRNB,
                        A.ABRD_PRNB,
                        A.GOFF_PRNB,
                        B.DAY_DV_CD
                FROM    TB_YYRD005 A,
                        /** 열차별단구간통과인원 **/
                        TB_YYDK002 B,
                        /** 캘린더               **/
                        TB_YYDK301 C
                WHERE   A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND     #RUN_TRM_CLS_DT#
                AND     A.TRN_NO        = #TRN_NO#
                AND     A.RUN_DT        = B.RUN_DT
                AND     A.PSRM_CL_CD LIKE #PSRM_CL_CD#
                AND     B.DAY_DV_CD  LIKE #DAY_DV_CD#
                AND     A.RUN_DT        = C.RUN_DT
                AND     A.TRN_NO        = C.TRN_NO
                AND     DECODE(C.UP_DN_DV_CD, ''D'',
                               A.DPT_STN_CONS_ORDR,
                               A.ARV_STN_CONS_ORDR) >=
                        (SELECT STN_CONS_ORDR
                        FROM    TB_YYDK302
                        WHERE   RUN_DT         = A.RUN_DT
                        AND     TRN_NO         = A.TRN_NO
                        AND     STOP_RS_STN_CD = DECODE(C.UP_DN_DV_CD, ''D'',
                                                        #RUN_SEG_DPT_STN_CD#,
                                                        #RUN_SEG_ARV_STN_CD#)
                        )
                
                INTERSECT
                
                SELECT A.RUN_DT,
                       A.TRN_NO,
                       A.DPT_STN_CONS_ORDR,
                       A.ARV_STN_CONS_ORDR,
                       A.PSRM_CL_CD,
                       A.NSTP_PRNB,
                       A.ABRD_PRNB,
                       A.GOFF_PRNB,
                       B.DAY_DV_CD
                FROM   TB_YYRD005 A,
                       /** 열차별단구간통과인원 **/
                       TB_YYDK002 B,
                       /** 캘린더               **/
                       TB_YYDK301 C
                WHERE  A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND    #RUN_TRM_CLS_DT#
                AND    A.TRN_NO        = #TRN_NO#
                AND    A.RUN_DT        = B.RUN_DT
                AND    A.PSRM_CL_CD LIKE #PSRM_CL_CD#
                AND    B.DAY_DV_CD  LIKE #DAY_DV_CD#
                AND    A.RUN_DT        = C.RUN_DT
                AND    A.TRN_NO        = C.TRN_NO
                AND    DECODE(C.UP_DN_DV_CD, ''D'',
                              A.ARV_STN_CONS_ORDR,
                              A.DPT_STN_CONS_ORDR) <=
                       (SELECT STN_CONS_ORDR
                       FROM    TB_YYDK302
                       WHERE   RUN_DT         = A.RUN_DT
                       AND     TRN_NO         = A.TRN_NO
                       AND     STOP_RS_STN_CD = DECODE(C.UP_DN_DV_CD, ''D'',
                                                       #RUN_SEG_ARV_STN_CD#,
                                                       #RUN_SEG_DPT_STN_CD#)
                       )
                )
                A1,
                TB_YYDK301 B1
       WHERE    A1.RUN_DT = B1.RUN_DT
       AND      A1.TRN_NO = B1.TRN_NO
       GROUP BY A1.RUN_DT,
                A1.TRN_NO,
                A1.PSRM_CL_CD,
                B1.UP_DN_DV_CD
       )
       A2,
       (SELECT  RUN_DT,
                TRN_NO,
                NVL(SUM(DECODE(PSRM_CL_CD, ''1'',
                               SEAT_NUM) ),0) SEAT_NUM,
                NVL(SUM(DECODE(PSRM_CL_CD, ''2'',
                               SEAT_NUM) ),0) SPL_SEAT_NUM
       FROM     TB_YYDK303
       WHERE    RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
       AND      TRN_NO = #TRN_NO#
       GROUP BY RUN_DT,
                TRN_NO
       )
       B2,
       TB_YYDK302 C2,
       TB_YYDK302 D2,
       (SELECT  A.RUN_DT,
                A.TRN_NO,
                A.PSRM_CL_CD,
                A.DPT_STN_CONS_ORDR,
                A.ARV_STN_CONS_ORDR,
                SUM(NVL(A.ABRD_PRNB, 0)) ABRD_PRNB,
                AVG(DECODE(B.SEAT_NUM, 0,
                           0,
                           NVL(A.ABRD_PRNB, 0) / B.SEAT_NUM)) UTL_RT,
                AVG(DECODE((B.SEAT_NUM         * YZDBA.FN_YZYB_GetRoutDstCal(C.ROUT_CD, A.DPT_STN_CONS_ORDR, A.ARV_STN_CONS_ORDR, B.RUN_DT, 1)), 0,
                           0,
                           NVL(A.PKILO, 0) / (B.SEAT_NUM * YZDBA.FN_YZYB_GetRoutDstCal(C.ROUT_CD, A.DPT_STN_CONS_ORDR, A.ARV_STN_CONS_ORDR, B.RUN_DT, 1)))) ABRD_RT
       FROM     (SELECT  A.RUN_DT,
                         A.TRN_NO,
                         A.PSRM_CL_CD,
                         A.DPT_STN_CONS_ORDR,
                         A.ARV_STN_CONS_ORDR,
                         SUM(A.ABRD_PRNB) ABRD_PRNB,
                         SUM(A.ABRD_PRNB * YZDBA.FN_YZYB_GetRoutDstCal(B.ROUT_CD, A.DPT_STN_CONS_ORDR, A.ARV_STN_CONS_ORDR, A.RUN_DT, 1)) PKILO
                FROM     TB_YYDS510 A,
                         TB_YYDK301 B,
                         TB_YYDK002 C
                WHERE    A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
                AND      A.TRN_NO        = #TRN_NO#
                AND      A.RUN_DT        = C.RUN_DT
                AND      A.PSRM_CL_CD LIKE #PSRM_CL_CD#
                AND      C.DAY_DV_CD  LIKE #DAY_DV_CD#
                AND      B.RUN_DT        = A.RUN_DT
                AND      B.TRN_NO        = A.TRN_NO
                AND      B.TRN_ATT_CD IN (''1'',
                                          ''6'')
                GROUP BY A.RUN_DT,
                         A.TRN_NO,
                         A.PSRM_CL_CD,
                         A.DPT_STN_CONS_ORDR,
                         A.ARV_STN_CONS_ORDR
                )
                A,
                (SELECT  A.RUN_DT,
                         A.TRN_NO,
                         A.PSRM_CL_CD,
                         SUM(A.BS_SEAT_NUM) SEAT_NUM
                FROM     TB_YYDK305 A,
                         TB_YYDK301 B
                WHERE    B.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
                AND      B.TRN_NO = #TRN_NO#
                AND      B.TRN_ATT_CD IN (''1'',
                                          ''6'')
                AND      A.RUN_DT           = B.RUN_DT
                AND      A.TRN_NO           = B.TRN_NO
                AND      A.SEAT_ATT_CD IN (''03'',
                                           ''15'',
                                           ''16'',
                                           ''17'',
                                           ''18'',
                                           ''19'',
                                           ''19'',
                                           ''20'',
                                           ''21'',
                                           ''22'',
                                           ''23'',
                                           ''24'',
                                           ''27'',
                                           ''28'')
                GROUP BY A.RUN_DT,
                         A.TRN_NO,
                         A.PSRM_CL_CD
                )
                B,
                TB_YYDK301 C
       WHERE    B.RUN_DT     = A.RUN_DT(+)
       AND      B.TRN_NO     = A.TRN_NO(+)
       AND      B.PSRM_CL_CD = A.PSRM_CL_CD(+)
       AND      C.RUN_DT     = B.RUN_DT
       AND      C.TRN_NO     = B.TRN_NO
       AND      C.STLB_TRN_CLSF_CD IN (''00'',
                                  ''01'')
       GROUP BY A.RUN_DT,
                A.TRN_NO,
                A.PSRM_CL_CD,
                A.DPT_STN_CONS_ORDR,
                A.ARV_STN_CONS_ORDR
       ORDER BY A.RUN_DT,
                A.TRN_NO,
                A.DPT_STN_CONS_ORDR,
                A.ARV_STN_CONS_ORDR
       )
       E2
WHERE  A2.RUN_DT            = B2.RUN_DT
AND    A2.TRN_NO            = B2.TRN_NO
AND    A2.RUN_DT            = C2.RUN_DT
AND    A2.TRN_NO            = C2.TRN_NO
AND    A2.DPT_STN_CONS_ORDR = C2.STN_CONS_ORDR
AND    A2.RUN_DT            = D2.RUN_DT
AND    A2.TRN_NO            = D2.TRN_NO
AND    A2.ARV_STN_CONS_ORDR = D2.STN_CONS_ORDR
AND    A2.RUN_DT            = E2.RUN_DT
AND    A2.TRN_NO            = E2.TRN_NO
AND    A2.PSRM_CL_CD        = E2.PSRM_CL_CD
AND    A2.DPT_STN_CONS_ORDR = E2.DPT_STN_CONS_ORDR
AND    A2.ARV_STN_CONS_ORDR = E2.ARV_STN_CONS_ORDR
]]>
', TO_DATE('04/17/2014 15:52:26', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.co.YRCO001QMDAO.selectTrnBaseInfoQry', '/*com.korail.yz.yr.co.YRCO001QMDAO.selectTrnBaseInfoQry*/ 
<![CDATA[

SELECT TO_CHAR(TO_DATE(A.RUN_DT),''YYYY.MM.DD'')||'' ''||
       (SELECT VLID_VAL_KOR_AVVR_NM
       FROM    TB_YYDK007
       WHERE   XROIS_OLD_SRT_CD = ''I909''
       AND     DOMN_NM          = ''DAY_DV_CD''
       AND     VLID_VAL         = B.DAY_DV_CD
       )
       RUN_DT,
       /*요일*/
       LPAD( TO_NUMBER( A.TRN_NO ), 5, ''0'' ) TRN_NO,
       (SELECT VLID_VAL_KOR_AVVR_NM
       FROM    TB_YYDK007
       WHERE   XROIS_OLD_SRT_CD = ''T305''
       AND     DOMN_NM          = ''RUN_DV_CD''
       AND     VLID_VAL         = A.RUN_DV_CD
       )
       RUN_DV_NM,
       /*RUN_DV_NM*/
       (SELECT VLID_VAL_KOR_AVVR_NM
       FROM    TB_YYDK007
       WHERE   XROIS_OLD_SRT_CD = ''R027''
       AND     DOMN_NM          = ''STLB_TRN_CLSF_CD''
       AND     VLID_VAL         = A.STLB_TRN_CLSF_CD
       )
       TRN_CLSF_NM,
       /*RUN_DV_NM*/
       C.ROUT_NM,
                        (SELECT B.KOR_STN_NM
                        FROM    TB_YYDK001 A,
                                TB_YYDK102 B
                        WHERE   1           =1
                        AND     A.RS_STN_CD = SUBSTR(A.ORG_RS_STN_CD, 2, 5)
                        AND     A.STN_CD    = B.STN_CD
                        AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
                        )
              || ''-''
              || 
                        (SELECT B.KOR_STN_NM
                        FROM    TB_YYDK001 A,
                                TB_YYDK102 B
                        WHERE   1           =1
                        AND     A.RS_STN_CD = SUBSTR(A.TMN_RS_STN_CD, 2, 5)
                        AND     A.STN_CD    = B.STN_CD
                        AND     TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN B.APL_ST_DT AND     B.APL_CLS_DT
                        )
              || ''(''
              ||
       ( SELECT TO_CHAR( TO_DATE( DPT_TM, ''hh24miss'' ), ''hh24:mi'' )
       FROM    TB_YYDK302
       WHERE   RUN_DT   = A.RUN_DT
       AND     TRN_NO   = A.TRN_NO
       AND     RUN_ORDR = 1
       )
              || ''-''
              ||
       ( SELECT TO_CHAR( TO_DATE( ARV_TM, ''hh24miss'' ), ''hh24:mi'' )
       FROM    TB_YYDK302
       WHERE   RUN_DT   = A.RUN_DT
       AND     TRN_NO   = A.TRN_NO
       AND     RUN_ORDR =
               ( SELECT MAX( RUN_ORDR )
               FROM    TB_YYDK302
               WHERE   RUN_DT = A.RUN_DT
               AND     TRN_NO = A.TRN_NO
               )
       )
              || '')'' RUN_INFO,
       DECODE( A.YMS_APL_FLG, ''Y'',
              ''적용'',
              ''해제'' ) YMS_FLG,
       --A.SHTM_EXCS_RSV_ALLW_FLG, --초과예약프로세스는 예발삭제, 하지만 수익관리는 남겨둠
	   ''N'' SHTM_EXCS_RSV_ALLW_FLG,
       A.STOP_STN_NUM,
       A.PSC_NUM,
       ( SELECT SUM( SEAT_NUM )
       FROM    TB_YYDK303
       WHERE   RUN_DT = A.RUN_DT
       AND     TRN_NO = A.TRN_NO
       )
       SEAT_CNT
FROM   TB_YYDK301 A,
       TB_YYDK002 B,
       TB_YYDK201 C
WHERE  A.RUN_DT      = B.RUN_DT
AND    A.ROUT_CD     = C.ROUT_CD
AND    A.TRN_NO      = #TRN_NO#
]]>

<isNotEmpty property = "RUN_DT">
<![CDATA[
	AND    A.RUN_DT      = #RUN_DT#
	AND    C.EFC_ST_DT  <= #RUN_DT#
	AND    C.EFC_CLS_DT >= #RUN_DT#
]]>
</isNotEmpty>
<isEmpty property = "RUN_DT">
<![CDATA[
	AND    A.RUN_DT      = #RUN_TRM_CLS_DT#
	AND    C.EFC_ST_DT  <= #RUN_TRM_CLS_DT#
	AND    C.EFC_CLS_DT >= #RUN_TRM_CLS_DT#
]]>
</isEmpty>
', TO_DATE('04/16/2014 11:41:18', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.yr.co.YRCO001QMDAO.selectTrnRunInfoQry', '/*com.korail.yz.yr.co.YRCO001QMDAO.selectTrnRunInfoQry*/ 
<![CDATA[
SELECT ROUND(SEAT_NUM, 0) SEAT_NUM,
       ROUND(SEAT_CRKM, 0) SEAT_CRKM,
       ROUND(ABRD_PKLO, 0) ABRD_PKLO,
       ROUND(ABRD_PRNB, 0) ABRD_PRNB,
       ROUND(ABRD_RT, 3) * 100 ABRD_RT,
	   ROUND(UTL_RT, 3) * 100 UTL_RT,
       ROUND(BIZ_RVN_AMT, 0) BIZ_RVN_AMT,
	   ROUND( BIZ_RVN_AMT / SEAT_NUM, 0)  SEAT_PR_AMT,
       ROUND( BIZ_RVN_AMT / SEAT_CRKM, 0) SEAT_CRKM_PR_AMT,
       ROUND( BIZ_RVN_AMT / ABRD_PRNB, 0) EACH_PR_AMT
FROM   ( SELECT  SUM(B.SEAT_NUM) SEAT_NUM,
                /** 좌석수(화면엔 없음) **/
                SUM(B.SEAT_CRKM) SEAT_CRKM,
                /** 좌석공급 KM **/
                SUM(B.ABRD_PKLO) ABRD_PKLO,
                /** 이용인원 인KM **/
                SUM(B.ABRD_PRNB) ABRD_PRNB,
                /** 승차인원 **/
                SUM(B.ABRD_PKLO) / SUM(B.SEAT_CRKM) ABRD_RT,
                /** 승차율 **/
                SUM(B.ABRD_PRNB) / SUM(B.SEAT_NUM) UTL_RT,
                /** 이용율* */
                (SELECT SUM(C.BIZ_RVN_AMT) BIZ_RVN_AM
                        /** 영업수입 **/
                FROM    TB_YYDS510 A,
                        /** 구간별 승차수입실적 **/
                        TB_YYDS512 C
                        /** 열차별 초과예약한도 **/
                WHERE   C.RUN_DT             = A.RUN_DT(+)
                AND     C.TRN_NO             = A.TRN_NO(+)
                AND     C.PSRM_CL_CD         = A.PSRM_CL_CD(+)
                AND     C.DPT_STN_CONS_ORDR  = A.DPT_STN_CONS_ORDR(+)
                AND     C.ARV_STN_CONS_ORDR  = A.ARV_STN_CONS_ORDR(+)
                AND     C.BKCL_CD            = A.BKCL_CD(+)
                AND     C.SEAT_ATT_CD        = A.SEAT_ATT_CD(+)
                AND     C.ARV_STN_CONS_ORDR <> C.DPT_STN_CONS_ORDR
]]>
<isNotEmpty property = "RUN_DT">
   			    AND     C.RUN_DT = #RUN_DT#
</isNotEmpty>
<isEmpty property = "RUN_DT">
   			    AND     C.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND     #RUN_TRM_CLS_DT#
</isEmpty>
<![CDATA[		    
                AND     C.TRN_NO = #TRN_NO#
                AND
                        (
                                #PSRM_CL_CD# IS NULL
                        OR      C.PSRM_CL_CD    LIKE #PSRM_CL_CD#
                        )
                )
                BIZ_RVN_AMT
       FROM     TB_YYDS511 B
]]>
<isNotEmpty property = "RUN_DT">
   	   WHERE    B.RUN_DT = #RUN_DT#
</isNotEmpty>
<isEmpty property = "RUN_DT">
   	   WHERE    B.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND      #RUN_TRM_CLS_DT#
</isEmpty>
<![CDATA[
       AND      B.TRN_NO = #TRN_NO#
       AND
                (
                         #PSRM_CL_CD# IS NULL
                OR       B.PSRM_CL_CD    LIKE #PSRM_CL_CD#
                )
       GROUP BY B.TRN_NO,
                B.RUN_DT
       )
]]>
', TO_DATE('04/16/2014 11:41:18', 'MM/DD/YYYY HH24:MI:SS'), 'changki');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA001QMDAO.selectListDtlPrsCnqe', '/*com.korail.yz.ys.aa.YSAA001QMDAO.selectListDtlPrsCnqe*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.ys.aa.YSAA001QMDAO.selectListDtlPrsCnqe */
			   A.YMGT_JOB_ID AS YMGT_JOB_ID /* 수익관리작업 ID */
			  ,LPAD(TO_NUMBER(SUBSTR(A.YMGT_JOB_ID,18,3)),3,'' '') AS SEQ /* 순번 */
			  ,A.RUN_DT AS RUN_DT /* 운행일자 */
			  ,LPAD(TO_NUMBER(A.TRN_NO), 5, '' '') AS TRN_NO /* 열차번호 */
			  ,A.FCST_PRS_STT_CD AS FCST_PRS_STT_CD /* 예측진행상태코드   NULL: ''미실행'' */
			  ,A.OTMZ_PRS_STT_CD AS OTMZ_PRS_STT_CD /* 최적화진행상태코드   NULL: ''미실행'' */
			  ,A.RSV_SALE_TNSM_STT_CD AS RSV_SALE_TNSM_STT_CD /* 예발전송상태코드   NULL: ''미전송'' */
			  ,NVL(A.ALC_PRS_STT_CD, ''1'') AS ALC_PRS_STT_CD /* 수익관리할당처리상태코드   NULL: 1 */
			  ,A.RSV_SALE_REFL_STT_CD AS RSV_SALE_REFL_STT_CD /* 예발반영상태코드   NULL: ''미반영'' */
			  ,A.JOB_DTTM AS JOB_DTTM /* 작업일시 */
			  ,A.JOB_CLS_DTTM AS JOB_CLS_DTTM /* 작업종료일시 */
		  FROM ( SELECT A.YMGT_JOB_ID /* 수익관리작업ID       */
					   ,A.RUN_DT /* 운행일자             */
					   ,A.TRN_NO /* 열차번호             */
					   ,A.FCST_PRS_STT_CD /* 예측진행상태코드     */
					   ,A.OTMZ_PRS_STT_CD /* 최적화진행상태코드   */
					   ,A.ITDC_SUPT_STT_CD /* 의사결정지원상태코드 */
					   ,A.NON_NML_TRN_FLG /* 비정상열차여부       */
					   ,A.RSV_SALE_TNSM_STT_CD /* 예발전송상태코드     */
					   ,A.RSV_SALE_TNSM_DTTM /* 예약발매전송일시     */
					   ,A.RSV_SALE_REFL_STT_CD /* 예발반영상태코드     */
					   ,C.ALC_PRS_STT_CD /* 수익관리할당처리상태코드 */
					   ,B.JOB_DTTM /* 작업시작일자         */
					   ,B.JOB_CLS_DTTM /* 작업종료일자         */
				   FROM TB_YYFD011 A /** 수익관리대상열차TBL **/
					   ,TB_YYFB009 B /** 수익관리작업결과TBL **/
					   ,TB_YYBB004 C  /** 열차별할당처리TBL **/
				  WHERE B.JOB_DTTM LIKE #JOB_DT# || ''%''
				    AND A.RUN_DT = #RUN_DT#
				    AND A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
					AND A.RUN_DT = C.RUN_DT(+)
					AND A.TRN_NO = C.TRN_NO(+)
					AND ((DECODE(PSRM_CL_CD||BKCL_CD,''1F1'',1,''1C1'',2,''1R1'',3,''1R2'',4,''1R3'',5,''2F1'',6,''2C1'',7,''2R1'',8,''2R2'',9,''2R3'',10,0) 
					  = ( SELECT min(DECODE(PSRM_CL_CD||BKCL_CD,''1F1'',1,''1C1'',2,''1R1'',3,''1R2'',4,''1R3'',5,''2F1'',6,''2C1'',7,''2R1'',8,''2R2'',9,''2R3'',10,0))
							FROM TB_YYBB004 D
						   WHERE D.RUN_DT = C.RUN_DT
							 AND D.TRN_NO = C.TRN_NO )
							AND PSRM_CL_CD IS NOT NULL) 
						OR PSRM_CL_CD IS NULL)
					AND A.YMGT_JOB_ID = B.YMGT_JOB_ID) A
		ORDER BY SEQ 

]]>
', TO_DATE('04/08/2014 19:37:19', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnJobDt', '/*com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnJobDt*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnJobDt */
			   D.YMGT_JOB_ID  											AS YMGT_JOB_ID 				/* 수익관리작업ID 						*/
			  ,A.RUN_DT													AS RUN_DT					/* 운행일자							*/
			  ,LPAD(TO_NUMBER(A.TRN_NO), 5, '' '') 						AS TRN_NO 					/* 열차번호(앞0뺀거)					*/
		      ,A.SHTM_EXCS_RSV_ALLW_FLG 								AS SHTM_EXCS_RSV_ALLW_FLG 	/* 단기초과예약허용여부 					*/
		      ,A.RUN_DV_CD 												AS RUN_DV_CD 				/* 운행구분코드						*/
		      ,DECODE(( SELECT ''Y''
						  FROM  TB_YYPD006 /* YMS할당결과내역TBL */
		                 WHERE  RUN_DT = A.RUN_DT
		                   AND  TRN_NO = A.TRN_NO
		                   AND  ROWNUM = 1), NULL, A.YMS_APL_FLG, ''Y'')	AS YMS_APL_FLG 				/* YMS적용여부						*/
		      ,A.RUN_INFO   											AS RUN_INFO 				/* 운행구간							*/
		      ,D.FCST_PRS_STT_CD 										AS FCST_PRS_STT_CD 			/* 예측처리상태코드(NULL이면 ''미실행'') 	*/
		      ,D.OTMZ_PRS_STT_CD 										AS OTMZ_PRS_STT_CD 			/* 최적화처리상태코드(NULL이면 ''미실행'')	*/
		      ,D.RSV_SALE_TNSM_STT_CD 									AS RSV_SALE_TNSM_STT_CD 	/* 예발전송상태코드(NULL이면 ''미전송'')	*/
			  ,A.ALC_PRS_STT_CD 										AS ALC_PRS_STT_CD 			/* 수익관리할당처리상태코드 				*/
			  ,NVL(D.RSV_SALE_REFL_STT_CD, ''N1'') 						AS RSV_SALE_REFL_STT_CD		/* 예발반영상태코드 					*/
			  ,A.STLB_TRN_CLSF_CD 										AS TRN_CLSF_CD 				/* 열차종별코드 						*/
			  ,A.ROUT_CD 												AS ROUT_CD 					/* 노선코드 							*/
			  ,A.UP_DN_DV_CD 											AS UP_DN_DV_CD 				/* 상하행구분코드 						*/
			  ,A.DPT_TM 												AS DPT_TM 					/* 출발시각 							*/
			  ,SUBSTR(D.JOB_DTTM, 3, 12) 								AS JOB_DTTM 				/* 작업일시							*/
			  ,SUBSTR(D.JOB_CLS_DTTM, 3, 12) 							AS JOB_CLS_DTTM 			/* 작업종료일시 						*/
			  ,A.TRN_NO													AS TRN_NO_VAL 				/* 열차번호 원데이터 					*/
			  ,DPT_TM_VAL 												AS DPT_TM_VAL 				/* 출발시각 원데이터 					*/
		  FROM ( SELECT A.RUN_DT 						AS RUN_DT 					/* 운행일자 			*/
					   ,A.TRN_NO 						AS TRN_NO 					/* 열차번호 			*/
		               ,A.ROUT_CD 						AS ROUT_CD 					/* 노선코드 			*/
		               ,A.UP_DN_DV_CD 					AS UP_DN_DV_CD 				/* 상하행구분코드 		*/
		               ,A.STLB_TRN_CLSF_CD 				AS STLB_TRN_CLSF_CD 		/* 열차종별코드     		*/
		               ,A.SHTM_EXCS_RSV_ALLW_FLG 		AS SHTM_EXCS_RSV_ALLW_FLG 	/* 단기초과예약허용여부 	*/
		               ,A.RUN_DV_CD 					AS RUN_DV_CD 				/* 운행구분코드 		*/
		               ,A.YMS_APL_FLG 					AS YMS_APL_FLG 				/* YMS적용여부 		*/
		               ,A.ORG_RS_STN_CD 				AS ORG_RS_STN_CD 			/* 시발예발역코드 		*/
		               ,A.TMN_RS_STN_CD 				AS TMN_RS_STN_CD 			/* 종착예발역코드 		*/
		               ,SUBSTR(B.DPT_TM, 1, 2) 			AS DPT_TM 					/* 출발시각 			*/
		               ,B.DPT_TM 						AS DPT_TM_VAL				/* 출발시각값 			*/
		               ,( SELECT Y.KOR_STN_NM /* 한글역명 	 */
		                    FROM TB_YYDK001 X /* 예발역코드TBL */
	                            ,TB_YYDK102 Y /* 역코드이력TBL */
		                   WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
		                     AND X.STN_CD = Y.STN_CD
		                     AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
					  || ''-'' 
					  || ( SELECT Y.KOR_STN_NM /* 한글역명 */
							 FROM TB_YYDK001 X /* 예발역코드TBL */
								 ,TB_YYDK102 Y /* 역코드이력TBL */
							WHERE X.RS_STN_CD = A.TMN_RS_STN_CD
							  AND X.STN_CD = Y.STN_CD
							  AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
					  || ''(''
					  || TO_CHAR(TO_DATE(B.DPT_TM, ''HH24MISS''), ''HH24:MI'')
					  || ''-''
					  || TO_CHAR(TO_DATE(C.ARV_TM, ''HH24MISS''), ''HH24:MI'')
					  || '')''  								AS RUN_INFO 				/* 출발도착역시각 			*/
		               ,NVL(E.ALC_PRS_STT_CD, 1) 			AS ALC_PRS_STT_CD 			/* 할당처리상태코드 		*/
		               ,NVL(E.EXCS_RSV_ALC_PRS_STT_CD, 1) 	AS EXCS_RSV_ALC_PRS_STT_CD 	/* 초과예약할당처리상태코드 	*/
		          FROM TB_YYDK301 A /* 열차기본TBL */
		              ,TB_YYDK302 B /* 열차운행내역TBL */
		              ,TB_YYDK302 C /* 열차운행내역TBL */
		              ,TB_YYDK201 D /* 노선코드TBL */
		              ,( SELECT RUN_DT 					/* 운행일자 				*/
		                       ,TRN_NO 					/* 열차번호 				*/
		                       ,ALC_PRS_STT_CD 			/* 할당처리상태코드 		*/
		                       ,EXCS_RSV_ALC_PRS_STT_CD /* 초과예약할당처리상태코드 	*/
		                   FROM TB_YYBB004 BB 			/* 열차별할당기본TBL 		*/
		                  WHERE ((DECODE(PSRM_CL_CD || BKCL_CD,''1F1'', 1,''1C1'', 2,''1R1'', 3,''1R2'', 4,''1R3'', 5,''2F1'', 6,''2C1'', 7,''2R1'', 8,''2R2'', 9,''2R3'', 10,0) 
		                           = ( SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCL_CD,''1F1'', 1,''1C1'', 2,''1R1'', 3,''1R2'', 4,''1R3'', 5,''2F1'', 6,''2C1'', 7,''2R1'', 8,''2R2'', 9,''2R3'', 10,0) )
		                                 FROM TB_YYBB004 X /* 열차별할당기본TBL 		*/
		                                     ,TB_YYDK309 Y /* 부킹클래스적용내역TBL 	*/
		                                WHERE X.RUN_DT 			= BB.RUN_DT
		                              	  AND X.TRN_NO 			= BB.TRN_NO
		                              	  AND X.RUN_DT 			= Y.RUN_DT
		                              	  AND X.TRN_NO 			= Y.TRN_NO
		                              	  AND X.PSRM_CL_CD 		= Y.PSRM_CL_CD
		                              	  AND X.BKCL_CD 		= Y.BKCL_CD
		                              	  AND Y.BKCL_USE_FLG 	=''Y'')
									AND PSRM_CL_CD 		IS NOT NULL) /* END DECODE */
		                     OR PSRM_CL_CD IS NULL)
		                  UNION ALL
		                 SELECT DISTINCT A.RUN_DT 					/* 열차번호 					*/
		                                ,A.TRN_NO 					/* 운행일자 					*/
		                                ,B.YMGT_ALC_PRS_STT_CD 		/* 할당처리상태코드 			*/
		                                ,B.EXCS_RSV_ALC_PRS_STT_CD 	/* 초과예약할당처리상태코드 		*/
		                  FROM TB_YYDK301 A 						/* 열차기본TBL 				*/
	                          ,TB_YYBB005 B 						/* 노선별할당기본TBL 			*/
                              ,TB_YYDK003 C 						/* 열차운영사업자카렌다내역 TBL 	*/
						 WHERE A.ROUT_CD = B.ROUT_CD 				/* 노선코드 					*/
						   AND A.UP_DN_DV_CD = B.UP_DN_DV_CD 		/* 상행하행구분코드 			*/
						   AND (#TRN_CLSF_CD# IS NULL OR B.TRN_CLSF_CD = #TRN_CLSF_CD#)
						   AND B.BIZ_DD_STG_CD = C.BIZ_DD_STG_CD 	/* 영업일단계코드 				*/
						   AND A.RUN_DT = C.RUN_DT
						   AND A.RUN_DT BETWEEN B.APL_ST_DT AND B.APL_CLS_DT
						   AND NOT EXISTS( SELECT ''1''
                                             FROM TB_YYBB004 BB /* 열차별할당기본TBL */
                                            WHERE RUN_DT = A.RUN_DT
                                              AND TRN_NO = A.TRN_NO
                                              AND ( (DECODE(PSRM_CL_CD || BKCL_CD,''1F1'', 1,''1C1'', 2,''1R1'', 3,''1R2'', 4,''1R3'', 5,''2F1'', 6,''2C1'', 7,''2R1'', 8,''2R2'', 9,''2R3'', 10,0) 
                                                   = ( SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCL_CD,''1F1'', 1,''1C1'', 2,''1R1'', 3,''1R2'', 4,''1R3'', 5,''2F1'', 6,''2C1'', 7,''2R1'', 8,''2R2'', 9,''2R3'', 10,0) )
                                                         FROM TB_YYBB004 X /* 열차별할당기본TBL */
                                                             ,TB_YYDK309 Y /* 부킹클래스적용내역TBL */
                                                        WHERE X.RUN_DT 			= BB.RUN_DT
                                                          AND X.TRN_NO 			= BB.TRN_NO
                                                          AND X.RUN_DT 			= Y.RUN_DT
                                                          AND X.TRN_NO 			= Y.TRN_NO
                                                          AND X.PSRM_CL_CD 		= Y.PSRM_CL_CD
                                                          AND X.BKCL_CD 		= Y.BKCL_CD
                                                          AND Y.BKCL_USE_FLG 	= ''Y'')
                                                     AND PSRM_CL_CD IS NOT NULL)
                                               OR PSRM_CL_CD IS NULL) ) ) E
         WHERE A.RUN_DT 			= B.RUN_DT
           AND A.TRN_NO 			= B.TRN_NO
           AND (#TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD = #TRN_CLSF_CD#)
           AND A.ORG_RS_STN_CD 		= B.STOP_RS_STN_CD 	/* 시발예발역코드 */
           AND A.RUN_DT 			= C.RUN_DT
           AND A.TRN_NO 			= C.TRN_NO
           AND A.TMN_RS_STN_CD 		= C.STOP_RS_STN_CD
           AND A.ROUT_CD 			= D.ROUT_CD
           AND A.RUN_DT 			= E.RUN_DT(+)
           AND A.TRN_NO 			= E.TRN_NO(+)
           AND A.RUN_DT 			BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT# /* 운행기간 */
           AND (#MRNT_CD# IS NULL 	OR D.MRNT_CD = #MRNT_CD#)  /* 주운행선코드 */
           AND D.MRNT_CD 			IN (''01'',''03'',''04'')
           AND ( (D.EFC_ST_DT <= #RUN_TRM_ST_DT#
                  AND D.EFC_CLS_DT >= #RUN_TRM_CLS_DT#)
               OR(D.EFC_ST_DT >= #RUN_TRM_ST_DT#
                  AND D.EFC_CLS_DT <= #RUN_TRM_CLS_DT#) ) /* 시행시작일자/종료일자 */
           AND (#ROUT_CD# IS NULL 	OR A.ROUT_CD = #ROUT_CD#)  /* 노선코드 */
           AND (#UP_DN_DV_CD# = ''A'' OR A.UP_DN_DV_CD = #UP_DN_DV_CD#)   /*상하행구분코드*/
           ) A, 
         ( SELECT A.YMGT_JOB_ID 			/* 수익관리작업ID 			*/
                 ,A.RUN_DT 					/* 운행일자 				*/
                 ,A.TRN_NO 					/* 열차번호 				*/
                 ,A.FCST_PRS_STT_CD 		/* 예측처리상태코드 		*/
                 ,A.OTMZ_PRS_STT_CD 		/* 최적화처리상태코드 		*/
                 ,A.ITDC_SUPT_STT_CD 		/* 의사결정지원상태코드 		*/
                 ,A.NON_NML_TRN_FLG 		/* 비정상열차여부 			*/
                 ,A.RSV_SALE_TNSM_STT_CD 	/* 예약발매전송상태코드 		*/
                 ,A.RSV_SALE_TNSM_DTTM 		/* 예약발매전송일시 		*/
                 ,A.RSV_SALE_REFL_STT_CD 	/* 예약발매반영상태코드 		*/
                 ,D.JOB_DTTM 				/* 작업일시 				*/
                 ,D.JOB_CLS_DTTM 			/* 작업종료일시 			*/
            FROM  TB_YYFD011 A          	/* 수익관리대상열차내역TBL 	*/
                 ,TB_YYFB009 D              /* 수익관리작업결과기본TBL 	*/
          WHERE  (D.JOB_DTTM, A.RUN_DT, A.TRN_NO) IN(
                    SELECT MAX(B.JOB_DTTM)
                          ,A.RUN_DT
                          ,A.TRN_NO
                      FROM ( SELECT A.YMGT_JOB_ID 	/* 수익관리작업ID */
                                   ,A.RUN_DT 		/* 운행일자 		*/
                                   ,A.TRN_NO 		/* 열차번호 		*/
                               FROM TB_YYFD011 A 	/* 수익관리대상열차내역TBL */
                              WHERE A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
                                AND (A.NON_NML_TRN_FLG = ''Y'' OR A.NON_NML_TRN_FLG = ''N'')
                                AND (A.ITDC_SUPT_STT_CD IS NULL
                                      OR A.ITDC_SUPT_STT_CD = ''A''
                                      OR A.ITDC_SUPT_STT_CD = ''Y'')                               /* 초과예약만 돌린열차 제외 */
                                                           ) A,
                           ( SELECT B.YMGT_JOB_ID /* 수익관리작업ID */
                                   ,B.JOB_DTTM /* 작업일시 */
                               FROM TB_YYFB009 B    /* 수익관리작업결과기본TBL */
                              WHERE B.REG_DTTM LIKE #JOB_DT# || ''%''
                                AND (#ONLN_ARNG_DV_CD# IS NULL OR B.ONLN_ARNG_DV_CD = #ONLN_ARNG_DV_CD#) /* 온라인배치구분코드 */ 
                              ) B
                     WHERE B.YMGT_JOB_ID = A.YMGT_JOB_ID
                     GROUP BY A.RUN_DT,
                             A.TRN_NO)
            AND A.YMGT_JOB_ID = D.YMGT_JOB_ID
            AND A.REG_DTTM LIKE #JOB_DT# || ''%''
          		) D
		WHERE A.RUN_DT = D.RUN_DT
		  AND A.TRN_NO = D.TRN_NO
		  AND (A.STLB_TRN_CLSF_CD, A.ROUT_CD, A.UP_DN_DV_CD, A.DPT_TM) IN(
            	SELECT TRN_CLSF_CD	/* 열차종별코드   	*/
                	  ,ROUT_CD		/* 노선코드       	*/
                   	  ,UP_DN_DV_CD	/* 상하행구분코드 	*/
                      ,TMWD_DV_CD	/* 시간대구분코드 	*/
            	  FROM TB_YYFD008 	/* 담당그룹별열차내역TBL */
            WHERE USR_GP_ID IN( SELECT DISTINCT USR_GP_ID /* 사용자그룹ID */
                                  FROM TB_YYFD007 /* 담당그룹별사용자내역TBL */
                                 WHERE (#USR_ID# IS NULL OR USR_ID = #USR_ID#)
                               )
              AND (#TRN_CLSF_CD# IS NULL OR STLB_TRN_CLSF_CD = #TRN_CLSF_CD#)
              AND (#ROUT_CD# IS NULL OR ROUT_CD = #ROUT_CD#)
              AND (#UP_DN_DV_CD# = ''A'' OR UP_DN_DV_CD = #UP_DN_DV_CD#)
            )
		ORDER BY RUN_DT,
		         TRN_NO,
		         YMS_APL_FLG DESC

]]>
', TO_DATE('04/08/2014 19:37:19', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnRunDt', '/*com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnRunDt*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnRunDt */  
D.YMGT_JOB_ID AS YMGT_JOB_ID /* 수익관리작업ID */
  ,SUBSTR(D.YMGT_JOB_ID, 10, 8) AS JOB_DT /* 작업일자 */
         ,A.RUN_DT AS RUN_DT /* 운행일자 */
         ,LPAD(TO_NUMBER(A.TRN_NO), 5, '' '')                        AS TRN_NO                   /* 열차번호(앞0뺀거)                   */
              ,A.SHTM_EXCS_RSV_ALLW_FLG                                 AS SHTM_EXCS_RSV_ALLW_FLG   /* 단기초과예약허용여부                   */
              ,A.RUN_DV_CD                                              AS RUN_DV_CD                /* 운행구분코드                       */
              ,DECODE(( SELECT ''Y''
                          FROM  TB_YYPD006 /* YMS할당결과내역TBL */
                         WHERE  RUN_DT = A.RUN_DT
                           AND  TRN_NO = A.TRN_NO
                           AND  ROWNUM = 1), NULL, A.YMS_APL_FLG, ''Y'')  AS YMS_APL_FLG              /* YMS적용여부                      */
              ,A.RUN_INFO                                               AS RUN_INFO                 /* 운행구간                         */
              ,D.FCST_PRS_STT_CD                                        AS FCST_PRS_STT_CD          /* 예측처리상태코드(NULL이면 ''미실행'')   */
              ,D.OTMZ_PRS_STT_CD                                        AS OTMZ_PRS_STT_CD          /* 최적화처리상태코드(NULL이면 ''미실행'')  */
              ,D.RSV_SALE_TNSM_STT_CD                                   AS RSV_SALE_TNSM_STT_CD     /* 예발전송상태코드(NULL이면 ''미전송'')   */
              ,A.ALC_PRS_STT_CD                                         AS ALC_PRS_STT_CD           /* 수익관리할당처리상태코드                 */
              ,NVL(D.RSV_SALE_REFL_STT_CD, ''N1'')                        AS RSV_SALE_REFL_STT_CD     /* 예발반영상태코드                     */
              ,SUBSTR(D.JOB_DTTM, 3, 12)                                AS JOB_DTTM                 /* 작업일시                         */
              ,SUBSTR(D.JOB_CLS_DTTM, 3, 12)                            AS JOB_CLS_DTTM             /* 작업종료일시                       */
              ,A.TRN_NO                                                 AS TRN_NO_VAL               /* 열차번호 원데이터                    */
              ,A.DPT_TM_VAL  AS DPT_TM_VAL               /* 출발시각 원데이터                    */
         /*아래 4개 변수는 열차재작업에 필요한 것임 d_ys11110_1 참조*/
         ,A.STLB_TRN_CLSF_CD AS TRN_CLSF_CD              /* 열차종별코드                       */
         ,A.ROUT_CD                                                AS ROUT_CD                  /* 노선코드                             */
              ,A.UP_DN_DV_CD                                            AS UP_DN_DV_CD              /* 상하행구분코드                      */
              ,A.DPT_TM                                                 AS DPT_TM                   /* 출발시각                             */
FROM     (SELECT   A.RUN_DT                        AS RUN_DT                   /* 운행일자             */
                       ,A.TRN_NO                        AS TRN_NO                   /* 열차번호             */
                       ,A.ROUT_CD                       AS ROUT_CD                  /* 노선코드             */
                       ,A.UP_DN_DV_CD                   AS UP_DN_DV_CD              /* 상하행구분코드      */
                       ,A.STLB_TRN_CLSF_CD              AS STLB_TRN_CLSF_CD         /* 열차종별코드           */
                       ,A.SHTM_EXCS_RSV_ALLW_FLG        AS SHTM_EXCS_RSV_ALLW_FLG   /* 단기초과예약허용여부   */
                       ,A.RUN_DV_CD                     AS RUN_DV_CD                /* 운행구분코드       */
                       ,A.YMS_APL_FLG                   AS YMS_APL_FLG              /* YMS적용여부      */
                       ,A.ORG_RS_STN_CD                 AS ORG_RS_STN_CD            /* 시발예발역코드      */
                       ,A.TMN_RS_STN_CD                 AS TMN_RS_STN_CD            /* 종착예발역코드      */
                       ,SUBSTR(B.DPT_TM, 1, 2)          AS DPT_TM                   /* 출발시각             */
                       ,B.DPT_TM                        AS DPT_TM_VAL               /* 출발시각값            */
                       ,( SELECT Y.KOR_STN_NM /* 한글역명    */
                            FROM TB_YYDK001 X /* 예발역코드TBL */
                                ,TB_YYDK102 Y /* 역코드이력TBL */
                           WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
                             AND X.STN_CD = Y.STN_CD
                             AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                      || ''-'' 
                      || ( SELECT Y.KOR_STN_NM /* 한글역명 */
                             FROM TB_YYDK001 X /* 예발역코드TBL */
                                 ,TB_YYDK102 Y /* 역코드이력TBL */
                            WHERE X.RS_STN_CD = A.TMN_RS_STN_CD
                              AND X.STN_CD = Y.STN_CD
                              AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                      || ''(''
                      || TO_CHAR(TO_DATE(B.DPT_TM, ''HH24MISS''), ''HH24:MI'')
                      || ''-''
                      || TO_CHAR(TO_DATE(C.ARV_TM, ''HH24MISS''), ''HH24:MI'')
                      || '')''                                AS RUN_INFO                 /* 출발도착역시각          */
                       
                  ,NVL(E.ALC_PRS_STT_CD, 1)            AS ALC_PRS_STT_CD           /* 할당처리상태코드         */
                       
          FROM     TB_YYDK301 A /* 열차기본TBL */
                      ,TB_YYDK302 B /* 열차운행내역TBL */
                      ,TB_YYDK302 C /* 열차운행내역TBL */
                      ,TB_YYDK201 D /* 노선코드TBL */
                   ,( SELECT RUN_DT                  /* 운행일자                 */
                               ,TRN_NO                  /* 열차번호                 */
                               ,ALC_PRS_STT_CD          /* 할당처리상태코드         */
                               ,EXCS_RSV_ALC_PRS_STT_CD /* 초과예약할당처리상태코드     */
                           FROM TB_YYBB004 BB           /* 열차별할당기본TBL       */
                          WHERE ((DECODE(PSRM_CL_CD || BKCL_CD,''1F1'', 1,''1C1'', 2,''1R1'', 3,''1R2'', 4,''1R3'', 5,''2F1'', 6,''2C1'', 7,''2R1'', 8,''2R2'', 9,''2R3'', 10,0) 
                                   = ( SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCL_CD,''1F1'', 1,''1C1'', 2,''1R1'', 3,''1R2'', 4,''1R3'', 5,''2F1'', 6,''2C1'', 7,''2R1'', 8,''2R2'', 9,''2R3'', 10,0) )
                                         FROM TB_YYBB004 X /* 열차별할당기본TBL        */
                                             ,TB_YYDK309 Y /* 부킹클래스적용내역TBL  */
                                        WHERE X.RUN_DT          = BB.RUN_DT
                                          AND X.TRN_NO          = BB.TRN_NO
                                          AND X.RUN_DT          = Y.RUN_DT
                                          AND X.TRN_NO          = Y.TRN_NO
                                          AND X.PSRM_CL_CD      = Y.PSRM_CL_CD
                                          AND X.BKCL_CD         = Y.BKCL_CD
                                          AND Y.BKCL_USE_FLG    =''Y'')
                                    AND PSRM_CL_CD      IS NOT NULL) /* END DECODE */
                             OR PSRM_CL_CD IS NULL)
                    UNION ALL
                     SELECT DISTINCT A.RUN_DT                   /* 열차번호                     */
                                        ,A.TRN_NO                   /* 운행일자                     */
                                        ,B.YMGT_ALC_PRS_STT_CD      /* 할당처리상태코드             */
                                        ,B.EXCS_RSV_ALC_PRS_STT_CD  /* 초과예약할당처리상태코드         */
                          FROM TB_YYDK301 A                         /* 열차기본TBL              */
                              ,TB_YYBB005 B                         /* 노선별할당기본TBL           */
                              ,TB_YYDK003 C                         /* 열차운영사업자카렌다내역 TBL     */
                         WHERE A.ROUT_CD = B.ROUT_CD                /* 노선코드                     */
                           AND A.UP_DN_DV_CD = B.UP_DN_DV_CD        /* 상행하행구분코드             */
                           AND B.TRN_CLSF_CD LIKE #TRN_CLSF_CD#     /* 열차종별코드               */
                           AND B.BIZ_DD_STG_CD = C.BIZ_DD_STG_CD    /* 영업일단계코드              */
                           AND A.RUN_DT = C.RUN_DT
                           AND A.RUN_DT BETWEEN B.APL_ST_DT AND B.APL_CLS_DT
                           AND NOT EXISTS( SELECT ''1''
                                             FROM TB_YYBB004 BB /* 열차별할당기본TBL */
                                            WHERE RUN_DT = A.RUN_DT
                                              AND TRN_NO = A.TRN_NO
                                              AND ( (DECODE(PSRM_CL_CD || BKCL_CD,''1F1'', 1,''1C1'', 2,''1R1'', 3,''1R2'', 4,''1R3'', 5,''2F1'', 6,''2C1'', 7,''2R1'', 8,''2R2'', 9,''2R3'', 10,0) 
                                                   = ( SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCL_CD,''1F1'', 1,''1C1'', 2,''1R1'', 3,''1R2'', 4,''1R3'', 5,''2F1'', 6,''2C1'', 7,''2R1'', 8,''2R2'', 9,''2R3'', 10,0) )
                                                         FROM TB_YYBB004 X /* 열차별할당기본TBL */
                                                             ,TB_YYDK309 Y /* 부킹클래스적용내역TBL */
                                                        WHERE X.RUN_DT          = BB.RUN_DT
                                                          AND X.TRN_NO          = BB.TRN_NO
                                                          AND X.RUN_DT          = Y.RUN_DT
                                                          AND X.TRN_NO          = Y.TRN_NO
                                                          AND X.PSRM_CL_CD      = Y.PSRM_CL_CD
                                                          AND X.BKCL_CD         = Y.BKCL_CD
                                                          AND Y.BKCL_USE_FLG    = ''Y'')
                                                     AND PSRM_CL_CD IS NOT NULL)
                                               OR PSRM_CL_CD IS NULL) ) ) E
          WHERE     A.RUN_DT = B.RUN_DT
                 AND A.TRN_NO = B.TRN_NO
                 AND (#TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD = #TRN_CLSF_CD#)         /* 열차종별코드 */
                 AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD          /* 시발예발역코드 */
                 AND A.RUN_DT = C.RUN_DT
                 AND A.TRN_NO = C.TRN_NO
                 AND A.TMN_RS_STN_CD = C.STOP_RS_STN_CD
                 AND A.ROUT_CD = D.ROUT_CD
          AND      D.EFC_ST_DT <= #RUN_DT#
          AND      A.RUN_DT = E.RUN_DT(+)
          AND      A.TRN_NO = E.TRN_NO(+)
          AND      A.RUN_DT = #RUN_DT#
          AND (#MRNT_CD# IS NULL OR D.MRNT_CD = #MRNT_CD#)   /* 주운행선코드 */
          AND D.MRNT_CD IN (''01'', ''03'', ''04'')
          AND (#ROUT_CD# IS NULL OR A.ROUT_CD = #ROUT_CD#)     /* 노선코드 */
          AND (#UP_DN_DV_CD# = ''A'' OR A.UP_DN_DV_CD = #UP_DN_DV_CD#) /*상하행구분코드*/
          AND  (#TRN_NO# IS NULL OR A.TRN_NO = LPAD(LTRIM(#TRN_NO#,'' ''), 5, ''0'') )
          ORDER BY A.RUN_DT,
                   A.TRN_NO) A,
         ( SELECT A.YMGT_JOB_ID             /* 수익관리작업ID             */
                 ,A.RUN_DT                  /* 운행일자                 */
                 ,A.TRN_NO                  /* 열차번호                 */
                 ,A.FCST_PRS_STT_CD         /* 예측처리상태코드         */
                 ,A.OTMZ_PRS_STT_CD         /* 최적화처리상태코드        */
                 ,A.ITDC_SUPT_STT_CD        /* 의사결정지원상태코드       */
                 ,A.NON_NML_TRN_FLG         /* 비정상열차여부          */
                 ,A.RSV_SALE_TNSM_STT_CD    /* 예약발매전송상태코드       */
                 ,A.RSV_SALE_TNSM_DTTM      /* 예약발매전송일시         */
                 ,A.RSV_SALE_REFL_STT_CD    /* 예약발매반영상태코드       */
                 ,D.JOB_DTTM                /* 작업일시                 */
                 ,D.JOB_CLS_DTTM            /* 작업종료일시           */
            FROM  TB_YYFD011 A              /* 수익관리대상열차내역TBL    */
                 ,TB_YYFB009 D              /* 수익관리작업결과기본TBL    */
          WHERE    (D.JOB_DTTM, A.RUN_DT, A.TRN_NO) IN(
                    SELECT MAX(B.JOB_DTTM)
                          ,A.RUN_DT
                          ,A.TRN_NO
                      FROM ( SELECT A.YMGT_JOB_ID   /* 수익관리작업ID */
                                   ,A.RUN_DT        /* 운행일자         */
                                   ,A.TRN_NO        /* 열차번호         */
                               FROM TB_YYFD011 A    /* 수익관리대상열차내역TBL */
                                                                 WHERE  A.RUN_DT = #RUN_DT#
                                                                    AND (A.NON_NML_TRN_FLG = ''Y'' OR A.NON_NML_TRN_FLG = ''N'')
                                AND (A.ITDC_SUPT_STT_CD IS NULL
                                      OR A.ITDC_SUPT_STT_CD = ''A''
                                      OR A.ITDC_SUPT_STT_CD = ''Y'')                               /* 초과예약만 돌린열차 제외 */
                                                                 AND   (#TRN_NO# IS NULL OR A.TRN_NO = LPAD(LTRIM(#TRN_NO#,'' ''), 5, ''0'')) ) A,


                                                                ( SELECT B.YMGT_JOB_ID /* 수익관리작업ID */
                                                                       ,B.JOB_DTTM /* 작업일시 */
                                                                   FROM TB_YYFB009 B    /* 수익관리작업결과기본TBL */
                                                                                  ) B
                                                      WHERE B.YMGT_JOB_ID = A.YMGT_JOB_ID
                                                       GROUP BY A.RUN_DT,
                                                                A.TRN_NO)
          AND A.YMGT_JOB_ID = D.YMGT_JOB_ID
          ORDER BY A.RUN_DT,
                   A.TRN_NO) D
WHERE    A.RUN_DT = D.RUN_DT
AND      A.TRN_NO = D.TRN_NO
AND (A.STLB_TRN_CLSF_CD, A.ROUT_CD, A.UP_DN_DV_CD, A.DPT_TM) IN(
            SELECT TRN_CLSF_CD  /* 열차종별코드       */
                      ,ROUT_CD      /* 노선코드         */
                      ,UP_DN_DV_CD  /* 상하행구분코드  */
                      ,TMWD_DV_CD   /* 시간대구분코드  */
                  FROM TB_YYFD008   /* 담당그룹별열차내역TBL */
            WHERE USR_GP_ID IN( SELECT DISTINCT USR_GP_ID /* 사용자그룹ID */
                                  FROM TB_YYFD007 /* 담당그룹별사용자내역TBL */
                                 WHERE (#USR_ID# IS NULL OR USR_ID = #USR_ID#)
                               )
              AND (#TRN_CLSF_CD# IS NULL OR STLB_TRN_CLSF_CD = #TRN_CLSF_CD#)
              AND (#ROUT_CD# IS NULL OR ROUT_CD = #ROUT_CD#)
              AND (#UP_DN_DV_CD# = ''A'' OR UP_DN_DV_CD = #UP_DN_DV_CD#)
            )
ORDER BY A.RUN_DT,
         A.TRN_NO
]]>
', TO_DATE('04/08/2014 19:37:19', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA001QMDAO.seletListBsTrnNoYSAA001', '/*com.korail.yz.ys.aa.YSAA001QMDAO.seletListBsTrnNoYSAA001*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.ys.aa.YSAA001QMDAO.seletListBsTrnNoYSAA001 */
			   DISTINCT TRN_NO 	/* 열차번호 */
		  FROM TB_YYDK301 		/* 열차기본TBL */
		 WHERE RUN_DT = #RUN_DT#
		   AND (#STLB_TRN_CLSF_CD# 	IS NULL OR STLB_TRN_CLSF_CD = #TRN_CLSF_CD# ) 	/* 열차종별코드		*/
		   AND (#ROUT_CD# 		IS NULL OR ROUT_CD 			= #ROUT_CD#		)	/* 노선코드 			*/
		   AND (#UP_DN_DV_CD# 	IS NULL OR UP_DN_DV_CD 		= #UP_DN_DV_CD#	) 	/* 상행하행구분코드 	*/
]]>
<isNotEmpty property = "TRVL_USR_ID">

		   AND ( TRN_CLSF_CD 			/* 열차종별코드 */
			     , ROUT_CD 				/*노선코드*/
				 , UP_DN_DV_CD 			/*상하행구분코드*/
				 ,( SELECT SUBSTR(DPT_TM, 1, 2) /*출발시각*/
			     	  FROM TB_YYDK302 /*열차운행내역TBL*/
			   		 WHERE RUN_ORDR = 1 
			      	   AND RUN_DT = TB_YYDK301.RUN_DT
			      	   AND TRN_NO = TB_YYDK301.TRN_NO ))  IN ( SELECT TRN_CLSF_CD 	/*열차종별코드*/
																	 ,ROUT_CD 		/*노선구분코드*/
																	 ,UP_DN_DV_CD 	/*상하행구분코드*/
																	 ,TMWD_DV_CD 	/*시간대구분코드*/ 
																 FROM TB_YYFD008 	/*담당그룹별열차내역TBL*/
																WHERE USR_GP_ID IN ( SELECT USR_GP_ID 	/*사용자그룹ID*/
																					   FROM TB_YYFD007  /*담당그룹별사용자내역*/
																					  WHERE USR_ID = #TRVL_USR_ID# ) /*사용자ID*/)
</isNotEmpty>
<![CDATA[
		ORDER BY TRN_NO
]]>', TO_DATE('04/08/2014 19:37:19', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA002QMDAO.selectListJobDdprYmgtTgtTrn', '/*com.korail.yz.ys.aa.YSAA002QMDAO.selectListJobDdprYmgtTgtTrn*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.ys.aa.YSAA002QMDAO.selectListJobDdprYmgtTgtTrn */
			   A.RUN_DT 							AS RUN_DT /* 운행일자         */
			  ,LTRIM(A.TRN_NO, ''0'') 				AS TRN_NO /* 열차번호         */
			  ,A.ROUT_CD 							AS ROUT_CD /* 노선코드         */
			  ,A.UP_DN_DV_CD 						AS UP_DN_DV_CD /* 상하행구분코드   */
			  ,A.STLB_TRN_CLSF_CD 					AS STLB_TRN_CLSF_CD /* 열차종별코드     */
			  ,A.RUN_DV_CD 							AS RUN_DV_CD /* 운행구분코드 */
			  ,A.YMS_APL_FLG 						AS YMS_APL_FLG /* YMS적용여부      */
			  ,A.SHTM_EXCS_RSV_ALLW_FLG 			AS SHTM_EXCS_RSV_ALLW_FLG /* 단기초과예약허용여부 */
			  ,( SELECT TRIM(Y.KOR_STN_NM) AS KOR_STN_NM /* 한글역명 */
				   FROM TB_YYDK001 X /*예발역코드*/
					   ,TB_YYDK102 Y /*역코드이력*/
				  WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
					AND X.STN_CD 	= Y.STN_CD
					AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN Y.APL_ST_DT
					AND Y.APL_CLS_DT)
			 || ''-''
			 || ( SELECT TRIM(Y.KOR_STN_NM) AS KOR_STN_NM
					FROM TB_YYDK001 X, TB_YYDK102 Y
				   WHERE X.RS_STN_CD 	= A.TMN_RS_STN_CD
					 AND X.STN_CD 		= Y.STN_CD
					 AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN Y.APL_ST_DT
					 AND Y.APL_CLS_DT)
			 || ''(''
			 || TO_CHAR(TO_DATE(B.DPT_TM, ''hh24miss''), ''hh24:mi'')
			 || ''-''
			 || TO_CHAR(TO_DATE(C.ARV_TM, ''hh24miss''), ''hh24:mi'')
			 || '')'' 								AS RUN_INFO /* 운행구간 */
			  ,NVL(E.ALC_PRS_STT_CD, 1) 			AS ALC_PRS_STT_CD /* 할당처리상태코드  */
			  ,NVL(E.EXCS_RSV_ALC_PRS_STT_CD, 1) 	AS EXCS_RSV_ALC_PRS_STT_CD /* 초과예약할당처리상태코드  */
			  ,F.DPT_BF_DT_NUM 						AS DPT_BF_DT_NUM /* 출발전일수 */
			  ,F.YDCP_SQNO 							AS YDCP_SQNO /* DCP구분번호 */
			  ,G.DAY_DV_CD 							AS DAY_DV_CD /* 요일구분코드 */
			  ,F.ORDY_LRG_CRG_DV_CD 				AS ORDY_LRG_CRG_DV_CD /* 평시대수송구분코드 */
			  ,D.MRNT_CD 							AS MRNT_CD /* 주운행선코드 */
		  FROM ( SELECT A.*
					   ,B.DAY_DV_CD /* 요일구분코드 */
				   FROM TB_YYDK301 A /* 열차기본TBL */
					   ,TB_YYDK002 B /* 카렌다내역TBL */
				  WHERE (#UP_DN_DV_CD# = ''A'' OR A.UP_DN_DV_CD = #UP_DN_DV_CD#) /* 상행하행구분코드 */
					AND (#ROUT_CD# IS NULL OR A.ROUT_CD = #ROUT_CD#) /* 노선코드 */
					AND A.STLB_TRN_CLSF_CD = ''00'' /* 열차종별 - KTX */
					AND A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
					AND (A.YMS_APL_FLG = ''Y'' OR A.SHTM_EXCS_RSV_ALLW_FLG = ''Y'')
					AND TO_DATE(A.RUN_DT, ''YYYYMMDD'') > TO_DATE (#JOB_DT#, ''YYYYMMDD'')
					AND A.RUN_DT = B.RUN_DT) A
			   ,TB_YYDK302 B /* 열차운행내역TBL */
			   ,TB_YYDK302 C /* 열차운행내역TBL */
			   ,TB_YYDK201 D /* 노선코드TBL */
			   ,TB_YYBB004 E /* 열차별할당기본TBL */
			   ,( SELECT *
					FROM TB_YYBB001 /* DCP적용기본TBL    */
				   WHERE (#MRNT_CD# IS NULL OR MRNT_CD = #MRNT_CD#) /* 주운행선코드 */
					 AND MRNT_CD IN (''01'', ''03'', ''04'') /* 주운행선코드 */
					 AND (#UP_DN_DV_CD# = ''A'' OR UP_DN_DV_CD = #UP_DN_DV_CD#) /* 상행하행구분코드 */
					 AND TRN_CLSF_CD = ''00'' /* 열차종별 - KTX */
					 AND ORDY_LRG_CRG_DV_CD = ( SELECT CASE ''ORDY_LRG_CRG_DV_CD''        /* 평시대수송구분코드 */
													   WHEN ( SELECT ''ORDY_LRG_CRG_DV_CD'' /* 평시대수송구분코드 */
																FROM TB_YYDK002 /* 카렌다내역TBL */
															   WHERE ROWNUM = 1
																 AND RUN_DT = #JOB_DT#  /* 운행일자 */
																 AND HLDY_BF_AFT_DV_CD IS NOT NULL) /* 휴일이전이후구분코드 */
													   THEN ''05''
													   WHEN ( SELECT ''ORDY_LRG_CRG_DV_CD'' /* 평시대수송구분코드 */
																FROM TB_YYDK003        /* 카렌다내역TBL */
															   WHERE ROWNUM = 1
																 AND RUN_DT = #JOB_DT#  /* 운행일자 */
																 AND BIZ_DD_STG_CD = ''6'' /* 영업일단계코드 */
																 AND LRG_CRG_DV_CD = ''03'') /* 대수송구분코드 */
													   THEN ''03''
													   WHEN ( SELECT ''ORDY_LRG_CRG_DV_CD'' /* 평시대수송구분코드 */
																FROM TB_YYDK003        /* 카렌다내역TBL */
															   WHERE ROWNUM = 1
																 AND RUN_DT = #JOB_DT#  /* 운행일자 */
																 AND BIZ_DD_STG_CD = ''6'' /* 영업일단계코드 */
																 AND LRG_CRG_DV_CD = ''04'') /* 대수송구분코드 */
													   THEN ''04''
													   ELSE ''00'' END
												  FROM DUAL
												 WHERE ROWNUM = 1)) F
			    ,( SELECT DAY_DV_CD /* 요일구분코드 */
					 FROM TB_YYDK002 /* 카렌다내역TBL */
					WHERE RUN_DT = #JOB_DT#) G                  /** 캘린더                **/
		   WHERE A.RUN_DT = B.RUN_DT /* 운행일자 */
			 AND A.TRN_NO = B.TRN_NO /* 열차번호 */
			 AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD /* 시발예발역코드 */
			 AND A.RUN_DT = C.RUN_DT /* 운행일자 */
			 AND A.TRN_NO = C.TRN_NO /* 열차번호 */
			 AND A.TMN_RS_STN_CD = C.STOP_RS_STN_CD /* 시발예발역코드 */
			 AND A.ROUT_CD = D.ROUT_CD /* 노선코드 */
			 AND ((D.EFC_ST_DT <= #RUN_TRM_ST_DT# AND D.EFC_CLS_DT >= #RUN_TRM_CLS_DT#)
					OR (D.EFC_ST_DT >= #RUN_TRM_ST_DT# AND D.EFC_CLS_DT <= #RUN_TRM_CLS_DT#))
			 AND A.RUN_DT = E.RUN_DT(+)
			 AND A.TRN_NO = E.TRN_NO(+)
			 AND ((DECODE(PSRM_CL_CD || BKCL_CD,''1F1'',1,''1C1'',2,''1R1'',3,''1R2'',4,''1R3'',5,''2F1'',6,''2C1'',7,''2R1'',8,''2R2'',9,''2R3'',10,0)
				  = ( SELECT MIN(DECODE (PSRM_CL_CD || BKCL_CD,''1F1'',1,''1C1'',2,''1R1'',3,''1R2'',4,''1R3'',5,''2F1'',6,''2C1'',7,''2R1'',8,''2R2'',9,''2R3'',10,0))
						FROM TB_YYBB004 /* 열차별할당기본TBL */
					   WHERE RUN_DT = E.RUN_DT
						 AND TRN_NO = E.TRN_NO)
						 AND PSRM_CL_CD IS NOT NULL)
					OR PSRM_CL_CD IS NULL)
			 AND A.DAY_DV_CD = F.DAY_DV_CD(+) /* 요일구분코드 */
			 AND D.MRNT_CD = F.MRNT_CD /* 주운행선코드 */
			 AND A.UP_DN_DV_CD = F.UP_DN_DV_CD /* 상행하행구분코드 */
			 AND A.RUN_DT BETWEEN F.APL_ST_DT AND F.APL_CLS_DT
			 AND F.DPT_BF_DT_NUM = TO_NUMBER(TO_DATE(A.RUN_DT, ''YYYYMMDD'') - TO_DATE (#JOB_DT#, ''YYYYMMDD'')) /* 출발이전일자수 */
			 AND A.TRN_NO NOT IN ( SELECT TRN_NO
									 FROM TB_YYBB002 /* DCP예외열차기본TBL */
									WHERE A.RUN_DT BETWEEN APL_ST_DT AND APL_CLS_DT
									  AND DPT_BF_DT_NUM = TO_NUMBER (TO_DATE (A.RUN_DT, ''YYYYMMDD'')- TO_DATE (#JOB_DT#, ''YYYYMMDD'')))
		ORDER BY RUN_DT, TRN_NO
]]>
', TO_DATE('04/07/2014 20:41:01', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectLgtmFcstDv', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectLgtmFcstDv*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectLgtmFcstDv */
               RUN_DV_CD     /* 운행구분코드 */
              ,YMS_APL_FLG    /* YMS적용여부 */
              ,HLDY_BF_AFT_DV_CD  /*공휴일전후구분코드*/
              ,LRG_CRG_DV_CD    /* 대수송구분코드 */
          FROM TB_YYDP503
         WHERE RUN_DT = #RUN_DT#
           AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListLastFcstPrnb', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListLastFcstPrnb*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListLastFcstPrnb */ 
               SUM(A.USR_CTL_EXPN_DMD_NUM) AS LAST_FCST_PRNB
          FROM TB_YYFD410 A /* 최종탑승예측수요내역 */
              ,TB_YYDD505 B /* 열차구간내역 */
         WHERE A.RUN_DT = B.RUN_DT
           AND A.TRN_NO = B.TRN_NO
           AND A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR
           AND A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR   
           AND A.RUN_DT = #RUN_DT#
           AND A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND (#DPT_STGP_CD# IS NULL OR B.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR B.ARV_STGP_CD = #ARV_STGP_CD#)   
           AND A.YMGT_JOB_ID = ( 
                                SELECT MAX(AA.YMGT_JOB_ID)
                                  FROM TB_YYFD410 AA /* 최종탑승예측수요내역 */
                                      ,TB_YYDD505 BB /* 열차구간내역 */
                                WHERE AA.RUN_DT = BB.RUN_DT
                                  AND AA.TRN_NO = BB.TRN_NO
                                  AND AA.DPT_STN_CONS_ORDR = BB.DPT_STN_CONS_ORDR
                                  AND AA.ARV_STN_CONS_ORDR = BB.ARV_STN_CONS_ORDR
                                  AND AA.RUN_DT = #RUN_DT#
                                  AND AA.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                  AND (#DPT_STGP_CD# IS NULL OR BB.DPT_STGP_CD = #DPT_STGP_CD#)
                                  AND (#ARV_STGP_CD# IS NULL OR BB.ARV_STGP_CD = #ARV_STGP_CD#)
                                )
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbLghd', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbLghd*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbLghd */
               A.DPT_STGP_CD
              ,A.ARV_STGP_CD
              ,A.DASP_DV_NO
              ,CASE WHEN D.RSV_DPT_BF_DNO > 60 THEN 60 
                    ELSE D.RSV_DPT_BF_DNO
                    END  AS RSV_DPT_BF_DNO
              ,CASE WHEN D.CNC_DPT_BF_DNO > 60 THEN 60
                    ELSE D.CNC_DPT_BF_DNO
                    END  AS CNC_DPT_BF_DNO
              ,A.RSV_SALE_FCST_PRNB
              ,A.CNC_RET_FCST_PRNB
          FROM TB_YYFD308 A
              ,TB_YYDP503 B
              ,TB_YYDD505 C
              ,TB_YYFD307 D
         WHERE A.FCST_ACHV_DT = ( SELECT MAX(A.FCST_ACHV_DT)
                                    FROM TB_YYFD308 A
                                        ,TB_YYDP503 B
                                   WHERE A.STGP_DEGR = #STGP_DEGR#
                                     AND A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                     AND B.RUN_DT = #RUN_DT#
                                     AND B.TRN_NO = A.TRN_NO
                                     AND B.HLDY_BF_AFT_DV_CD = A.HLDY_BF_AFT_DV_CD
                                     AND B.DAY_DV_CD = A.DAY_DV_CD ) 
           AND A.STGP_DEGR = #STGP_DEGR#
           AND A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND B.RUN_DT = #RUN_DT#
           AND B.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND B.HLDY_BF_AFT_DV_CD = A.HLDY_BF_AFT_DV_CD
           AND B.DAY_DV_CD = A.DAY_DV_CD
           AND C.RUN_DT = B.RUN_DT
           AND C.TRN_NO = B.TRN_NO
           AND C.STGP_DEGR = A.STGP_DEGR
           AND C.DPT_STGP_CD = A.DPT_STGP_CD
           AND C.ARV_STGP_CD = A.ARV_STGP_CD
           AND C.REP_DPT_STN_TMWD_DV_CD = D.TMWD_DV_CD
           AND D.HLDY_BF_AFT_DV_CD = A.HLDY_BF_AFT_DV_CD
           AND D.DPT_STGP_CD = A.DPT_STGP_CD
           AND D.ARV_STGP_CD = A.ARV_STGP_CD
           AND D.STGP_DEGR = A.STGP_DEGR
           AND D.DASP_DV_NO = A.DASP_DV_NO
           AND (#DPT_STGP_CD# IS NULL OR A.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR A.ARV_STGP_CD = #ARV_STGP_CD#)
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbNml', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbNml*/ 
<![CDATA[
        SELECT /*com.korail.yz.ys.aa.YSAA003QMDAO.selectLgtmFcstPrnbNml*/
               S.DPT_STGP_CD
              ,S.ARV_STGP_CD
              ,S.DASP_DV_NO
              ,F.RSV_DPT_BF_DNO
              ,F.CNC_DPT_BF_DNO
              ,S.RSV_SALE_FCST_PRNB
              ,S.CNC_RET_FCST_PRNB
          FROM TB_YYFD211 S
              ,TB_YYDP503 B
              ,TB_YYFD203 D
              ,(
                SELECT DPT_STN_CONS_ORDR
                      ,ARV_STN_CONS_ORDR
                      ,RUN_DT
                      ,TRN_NO
                      ,DPT_STGP_CD
                      ,ARV_STGP_CD
                      ,TMWD_GP_CD
                      ,TMWD_GP_DEGR
                  FROM TB_YYDD505
                 WHERE RUN_DT = #RUN_DT#
                   AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                   AND STGP_DEGR = #STGP_DEGR#
                   AND TMWD_GP_DEGR = (
                                        SELECT MAX(TMWD_GP_DEGR) TMWD_GP_DEGR
                                          FROM TB_YYFB003
                                         WHERE APL_ST_DT <= #RUN_DT#
                                           AND APL_CLS_DT >= #RUN_DT#
                                      )
               )E
              ,TB_YYFD210 F
         WHERE B.RUN_DT = #RUN_DT#
           AND B.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND S.FCST_ACHV_DT = ( SELECT MAX(FCST_ACHV_DT) AS FCST_ACHV_DT 
                                    FROM TB_YYFS202
                                   WHERE FCST_YM = SUBSTR(#RUN_DT#,1,6)
                                     AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
                                     AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#) 
                                     AND STGP_DEGR = #STGP_DEGR# )
           AND S.FCST_YM = SUBSTR(#RUN_DT#, 1, 6)
           AND S.DAY_DV_CD = B.DAY_DV_CD
           AND S.TRN_NO = B.TRN_NO
           AND (#DPT_STGP_CD# IS NULL OR S.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR S.ARV_STGP_CD = #ARV_STGP_CD#)
           AND S.STGP_DEGR = #STGP_DEGR#
           AND (S.CRG_PLN_NO, S.CRG_PLN_CHG_DEGR) IN ( SELECT CRG_PLN_NO
                                                             ,MAX(CRG_PLN_CHG_DEGR)
                                                         FROM TB_YYFD211
                                                        WHERE FCST_ACHV_DT = ( SELECT MAX(FCST_ACHV_DT)
                                                                                 FROM TB_YYFS202
                                                                                WHERE FCST_YM = SUBSTR(#RUN_DT#,1,6)
                                                                                  AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
                                                                                  AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#) 
                                                                                  AND STGP_DEGR = #STGP_DEGR# )
                                                          AND CRG_PLN_NO = ( SELECT MAX(CRG_PLN_NO)
                                                                               FROM TB_YYFD211
                                                                              WHERE FCST_ACHV_DT = ( SELECT MAX(FCST_ACHV_DT)
                                                                                                       FROM TB_YYFS202
                                                                                                      WHERE FCST_YM = SUBSTR(#RUN_DT#,1,6)
                                                                                                        AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
                                                                                                        AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#)  
                                                                                                        AND STGP_DEGR = #STGP_DEGR# )
                                                                                AND FCST_YM = SUBSTR(#RUN_DT#, 1, 6)            
                                                                                AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                                                                AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
                                                                                AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#) )
                                                          AND FCST_YM = SUBSTR(#RUN_DT#, 1, 6)            
                                                          AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                                          AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
                                                          AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#) 
                                                        GROUP BY CRG_PLN_NO )
           AND D.FCST_ACHV_DT     = S.FCST_ACHV_DT
           AND D.DAY_DV_CD        = S.DAY_DV_CD
           AND D.STGP_DEGR        = S.STGP_DEGR
           AND D.DPT_STGP_CD      = S.DPT_STGP_CD
           AND D.ARV_STGP_CD      = S.ARV_STGP_CD
           AND D.FCST_MDL_DV_CD   = S.FCST_MDL_DV_CD
           AND D.FCST_MDL_SEL_FLG = ''Y''
           AND E.RUN_DT           = B.RUN_DT
           AND E.TRN_NO           = B.TRN_NO
           AND E.DPT_STGP_CD      = S.DPT_STGP_CD
           AND E.ARV_STGP_CD      = S.ARV_STGP_CD
           AND F.TMWD_GP_CD       = E.TMWD_GP_CD
           AND F.TMWD_GP_DEGR     = E.TMWD_GP_DEGR
           AND S.DASP_DV_NO       = F.DASP_DV_NO      
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbSmer', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbSmer*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbSmer */
               A.DPT_STGP_CD
              ,A.ARV_STGP_CD
              ,A.DASP_DV_NO
              ,C.RSV_DPT_BF_DNO
              ,C.CNC_DPT_BF_DNO
              ,A.RSV_SALE_FCST_PRNB
              ,A.CNC_RET_FCST_PRNB
          FROM TB_YYFD108 A
              ,( SELECT RUN_DT
                       ,TRN_NO
                       ,DAY_DV_CD
                       ,WK_DEGR
                   FROM TB_YYDP503
                  WHERE RUN_DT = #RUN_DT#
                    AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
               ) B
              ,( SELECT AA.RUN_DT
                       ,AA.TRN_NO
                       ,AA.DPT_STGP_CD
                       ,AA.ARV_STGP_CD
                       ,AA.STGP_DEGR
                       ,AA.TMWD_GP_CD
                       ,AA.TMWD_GP_DEGR
                       ,BB.DASP_DV_NO
                       ,BB.RSV_DPT_BF_DNO
                       ,BB.CNC_DPT_BF_DNO
                   FROM TB_YYDD505 AA
                       ,TB_YYFD107 BB
                  WHERE AA.RUN_DT = #RUN_DT#
                    AND AA.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                    AND AA.STGP_DEGR = #STGP_DEGR#
                    AND AA.TMWD_GP_DEGR = ( SELECT MAX(TMWD_GP_DEGR) TMWD_GP_DEGR
                                              FROM TB_YYFB003
                                             WHERE APL_ST_DT  <= #RUN_DT#
                                               AND APL_CLS_DT >= #RUN_DT# )
                    AND AA.TMWD_GP_CD   = BB.TMWD_GP_CD
                    AND AA.TMWD_GP_DEGR = BB.TMWD_GP_DEGR
                    AND BB.LRG_CRG_DV_CD  = ''03''
               ) C
         WHERE A.FCST_ACHV_DT = ( SELECT MAX(FCST_ACHV_DT)
                                    FROM TB_YYFD108
                                   WHERE LRG_CRG_DV_CD = ''03''
                                     AND WK_DEGR       = B.WK_DEGR
                                     AND TRN_NO        = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                     AND STGP_DEGR     = #STGP_DEGR#
                                     AND DAY_DV_CD     = B.DAY_DV_CD )
           AND A.LRG_CRG_DV_CD = ''03''
           AND A.TRN_NO        = B.TRN_NO
           AND A.STGP_DEGR     = #STGP_DEGR#
           AND (#DPT_STGP_CD# IS NULL OR A.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR A.ARV_STGP_CD = #ARV_STGP_CD#)
           AND A.DAY_DV_CD     = B.DAY_DV_CD
           AND A.WK_DEGR       = B.WK_DEGR
           AND B.RUN_DT        = C.RUN_DT
           AND B.TRN_NO        = C.TRN_NO
           AND A.STGP_DEGR     = C.STGP_DEGR
           AND A.DPT_STGP_CD   = C.DPT_STGP_CD
           AND A.ARV_STGP_CD   = C.ARV_STGP_CD
           AND A.DASP_DV_NO    = C.DASP_DV_NO
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpLghd', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpLghd*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpLghd */ 
               A.DPT_STGP_CD
              ,A.ARV_STGP_CD
              ,A.DASP_DV_NO
              ,D.RSV_DPT_BF_DNO
              ,D.CNC_DPT_BF_DNO
              ,A.RSV_SALE_FCST_PRNB
              ,A.CNC_RET_FCST_PRNB
          FROM TB_YYFD213 A
              ,TB_YYDP503 B
              ,TB_YYDD505 C
              ,TB_YYFD307 D
         WHERE A.RUN_DT = #RUN_DT#
           AND A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND A.FCST_ACHV_DT = ( SELECT MAX(FCST_ACHV_DT)
                                    FROM TB_YYFD213
                                   WHERE RUN_DT = #RUN_DT#
                                     AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                     AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
                                     AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#)
                                     AND STGP_DEGR = #STGP_DEGR#)
           AND (#DPT_STGP_CD# IS NULL OR A.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR A.ARV_STGP_CD = #ARV_STGP_CD#)
           AND A.STGP_DEGR = #STGP_DEGR#
           AND B.RUN_DT = A.RUN_DT
           AND B.TRN_NO = A.TRN_NO
           AND C.RUN_DT = A.RUN_DT
           AND C.TRN_NO = A.TRN_NO
           AND C.STGP_DEGR = A.STGP_DEGR
           AND C.DPT_STGP_CD = A.DPT_STGP_CD
           AND C.ARV_STGP_CD = A.ARV_STGP_CD
           AND D.HLDY_BF_AFT_DV_CD = B.HLDY_BF_AFT_DV_CD
           AND D.TMWD_DV_CD = C.REP_DPT_STN_TMWD_DV_CD
           AND D.DPT_STGP_CD = A.DPT_STGP_CD
           AND D.ARV_STGP_CD = A.ARV_STGP_CD
           AND D.STGP_DEGR = A.STGP_DEGR
           AND D.DASP_DV_NO = A.DASP_DV_NO
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpNml', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpNml*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpNml */ 
               A.DPT_STGP_CD
              ,A.ARV_STGP_CD
              ,A.DASP_DV_NO
              ,C.RSV_DPT_BF_DNO
              ,C.CNC_DPT_BF_DNO
              ,A.RSV_SALE_FCST_PRNB
              ,A.CNC_RET_FCST_PRNB
          FROM TB_YYFD213 A
              ,TB_YYDD505 B
              ,TB_YYFD210 C
         WHERE A.RUN_DT = #RUN_DT#
           AND A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND A.FCST_ACHV_DT = ( SELECT MAX(FCST_ACHV_DT)
                                    FROM TB_YYFD213
                                   WHERE RUN_DT = #RUN_DT#
                                     AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                     AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
                                     AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#)
                                     AND STGP_DEGR = #STGP_DEGR#)
           AND (#DPT_STGP_CD# IS NULL OR A.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR A.ARV_STGP_CD = #ARV_STGP_CD#)
           AND A.STGP_DEGR = #STGP_DEGR#
           AND B.RUN_DT = #RUN_DT#
           AND B.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND (#DPT_STGP_CD# IS NULL OR B.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR B.ARV_STGP_CD = #ARV_STGP_CD#)
           AND B.TMWD_GP_CD = C.TMWD_GP_CD 
           AND B.TMWD_GP_DEGR = C.TMWD_GP_DEGR
           AND A.DASP_DV_NO = C.DASP_DV_NO
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpSmer', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpSmer*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpSmer */ 
               A.DPT_STGP_CD
              ,A.ARV_STGP_CD
              ,A.DASP_DV_NO
              ,D.RSV_DPT_BF_DNO
              ,D.CNC_DPT_BF_DNO
              ,A.RSV_SALE_FCST_PRNB
              ,A.CNC_RET_FCST_PRNB
          FROM TB_YYFD213 A
              ,TB_YYDP503 B
              ,TB_YYDD505 C
              ,TB_YYFD107 D
         WHERE A.RUN_DT        = #RUN_DT#
           AND A.TRN_NO        = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND A.FCST_ACHV_DT  = ( SELECT MAX(FCST_ACHV_DT)
                                     FROM TB_YYFD213
                                    WHERE RUN_DT = #RUN_DT#
                                      AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                      AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
                                      AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#)
                                      AND STGP_DEGR = #STGP_DEGR#)
           AND (#DPT_STGP_CD# IS NULL OR A.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR A.ARV_STGP_CD = #ARV_STGP_CD#)
           AND A.STGP_DEGR     = #STGP_DEGR#
           AND B.RUN_DT        = A.RUN_DT
           AND B.TRN_NO        = A.TRN_NO
           AND B.LRG_CRG_DV_CD = ''03''
           AND C.RUN_DT        = A.RUN_DT
           AND C.TRN_NO        = A.TRN_NO
           AND C.DPT_STGP_CD   = A.DPT_STGP_CD
           AND C.ARV_STGP_CD   = A.ARV_STGP_CD
           AND C.STGP_DEGR     = #STGP_DEGR#
           AND D.TMWD_GP_CD    = C.TMWD_GP_CD 
           AND D.TMWD_GP_DEGR  = C.TMWD_GP_DEGR
           AND D.LRG_CRG_DV_CD = B.LRG_CRG_DV_CD
           AND D.DASP_DV_NO    = A.DASP_DV_NO
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpWntr', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpWntr*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpSmer */ 
               A.DPT_STGP_CD
              ,A.ARV_STGP_CD
              ,A.DASP_DV_NO
              ,D.RSV_DPT_BF_DNO
              ,D.CNC_DPT_BF_DNO
              ,A.RSV_SALE_FCST_PRNB
              ,A.CNC_RET_FCST_PRNB
          FROM TB_YYFD213 A
              ,TB_YYDP503 B
              ,TB_YYDD505 C
              ,TB_YYFD107 D
         WHERE A.RUN_DT        = #RUN_DT#
           AND A.TRN_NO        = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND A.FCST_ACHV_DT  = ( SELECT MAX(FCST_ACHV_DT)
                                     FROM TB_YYFD213
                                    WHERE RUN_DT = #RUN_DT#
                                      AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                      AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
                                      AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#)
                                      AND STGP_DEGR = #STGP_DEGR#)
           AND (#DPT_STGP_CD# IS NULL OR A.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR A.ARV_STGP_CD = #ARV_STGP_CD#)
           AND A.STGP_DEGR     = #STGP_DEGR#
           AND B.RUN_DT        = A.RUN_DT
           AND B.TRN_NO        = A.TRN_NO
           AND B.LRG_CRG_DV_CD = ''04''
           AND C.RUN_DT        = A.RUN_DT
           AND C.TRN_NO        = A.TRN_NO
           AND C.DPT_STGP_CD   = A.DPT_STGP_CD
           AND C.ARV_STGP_CD   = A.ARV_STGP_CD
           AND C.STGP_DEGR     = #STGP_DEGR#
           AND D.TMWD_GP_CD    = C.TMWD_GP_CD 
           AND D.TMWD_GP_DEGR  = C.TMWD_GP_DEGR
           AND D.LRG_CRG_DV_CD = B.LRG_CRG_DV_CD
           AND D.DASP_DV_NO    = A.DASP_DV_NO
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbWntr', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbWntr*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbWntr */
               A.DPT_STGP_CD
              ,A.ARV_STGP_CD
              ,A.DASP_DV_NO
              ,C.RSV_DPT_BF_DNO
              ,C.CNC_DPT_BF_DNO
              ,A.RSV_SALE_FCST_PRNB
              ,A.CNC_RET_FCST_PRNB
          FROM TB_YYFD108 A
              ,( SELECT RUN_DT
                       ,TRN_NO
                       ,DAY_DV_CD
                       ,WK_DEGR
                   FROM TB_YYDP503
                  WHERE RUN_DT = #RUN_DT#
                    AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
               ) B
              ,( SELECT AA.RUN_DT
                       ,AA.TRN_NO
                       ,AA.DPT_STGP_CD
                       ,AA.ARV_STGP_CD
                       ,AA.STGP_DEGR
                       ,AA.TMWD_GP_CD
                       ,AA.TMWD_GP_DEGR
                       ,BB.DASP_DV_NO
                       ,BB.RSV_DPT_BF_DNO
                       ,BB.CNC_DPT_BF_DNO
                   FROM TB_YYDD505 AA
                       ,TB_YYFD107 BB
                  WHERE AA.RUN_DT = #RUN_DT#
                    AND AA.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                    AND AA.STGP_DEGR = #STGP_DEGR#
                    AND AA.TMWD_GP_DEGR = ( SELECT MAX(TMWD_GP_DEGR) TMWD_GP_DEGR
                                              FROM TB_YYFB003
                                             WHERE APL_ST_DT  <= #RUN_DT#
                                               AND APL_CLS_DT >= #RUN_DT# )
                    AND AA.TMWD_GP_CD   = BB.TMWD_GP_CD
                    AND AA.TMWD_GP_DEGR = BB.TMWD_GP_DEGR
                    AND BB.LRG_CRG_DV_CD  = ''04''
               ) C
         WHERE A.FCST_ACHV_DT = ( SELECT MAX(FCST_ACHV_DT)
                                    FROM TB_YYFD108
                                   WHERE LRG_CRG_DV_CD = ''04''
                                     AND WK_DEGR       = B.WK_DEGR
                                     AND TRN_NO        = LPAD(TRIM(#TRN_NO#), 5, ''0'')
                                     AND STGP_DEGR     = #STGP_DEGR#
                                     AND DAY_DV_CD     = B.DAY_DV_CD )
           AND A.LRG_CRG_DV_CD = ''04''
           AND A.TRN_NO        = B.TRN_NO
           AND A.STGP_DEGR     = #STGP_DEGR#
           AND (#DPT_STGP_CD# IS NULL OR A.DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR A.ARV_STGP_CD = #ARV_STGP_CD#)
           AND A.DAY_DV_CD     = B.DAY_DV_CD
           AND A.WK_DEGR       = B.WK_DEGR
           AND B.RUN_DT        = C.RUN_DT
           AND B.TRN_NO        = C.TRN_NO
           AND A.STGP_DEGR     = C.STGP_DEGR
           AND A.DPT_STGP_CD   = C.DPT_STGP_CD
           AND A.ARV_STGP_CD   = C.ARV_STGP_CD
           AND A.DASP_DV_NO    = C.DASP_DV_NO
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSelectedSgmp', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSelectedSgmp*/ 
<![CDATA[
SELECT /*+com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSelectedSgmp */
      T2.DPT_STGP_CD,
       T2.ARV_STGP_CD,
       (   (SELECT T7.KOR_STN_NM
              FROM TB_YYDK001 T6, TB_YYDK102 T7
             WHERE     T6.RS_STN_CD = T4.STOP_RS_STN_CD
                   AND T6.STN_CD = T7.STN_CD
                   AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN T7.APL_ST_DT
                                                         AND T7.APL_CLS_DT)
        || ''-''
        || (SELECT T7.KOR_STN_NM
              FROM TB_YYDK001 T6, TB_YYDK102 T7
             WHERE     T6.RS_STN_CD = T5.STOP_RS_STN_CD
                   AND T6.STN_CD = T7.STN_CD
                   AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN T7.APL_ST_DT
                                                         AND T7.APL_CLS_DT))
          AS DPT_ARV_STGP_NM,
          TO_CHAR (T3.SEG_GP_NO) AS ZONE_SEG_GP_NO
  FROM TB_YYDK301 T1,
       TB_YYDD505 T2,
       TB_YYDK308 T3,
       TB_YYDK302 T4,
       TB_YYDK302 T5
 WHERE     T1.RUN_DT = #RUN_DT#
       AND T1.TRN_NO = #TRN_NO#
       AND T1.RUN_DT = T2.RUN_DT
       AND T1.TRN_NO = T2.TRN_NO
       AND T2.RUN_DT = T4.RUN_DT
       AND T2.TRN_NO = T4.TRN_NO
       AND T2.DPT_STN_CONS_ORDR = T4.STN_CONS_ORDR
       AND T2.RUN_DT = T5.RUN_DT
       AND T2.TRN_NO = T5.TRN_NO
       AND T2.ARV_STN_CONS_ORDR = T5.STN_CONS_ORDR
       AND T2.RUN_DT = T3.RUN_DT
       AND T2.TRN_NO = T3.TRN_NO
       AND T4.TRVL_ZONE_NO =
              DECODE (T1.UP_DN_DV_CD, ''D'', T3.DPT_ZONE_NO, T3.ARV_ZONE_NO)
       AND T5.TRVL_ZONE_NO =
              DECODE (T1.UP_DN_DV_CD, ''D'', T3.ARV_ZONE_NO, T3.DPT_ZONE_NO)
       AND TO_CHAR (T3.SEG_GP_NO) LIKE #ZONE_CD#
       AND T2.STGP_DEGR LIKE #STGP_DEGR#
ORDER BY ZONE_SEG_GP_NO, DPT_STGP_CD, ARV_STGP_CD  DESC
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSgmpAlcCnqe', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSgmpAlcCnqe*/ 
<![CDATA[
SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSgmpAlcCnqe */
       RUN_DT,
       TRN_NO,                                                        /*열차번호*/
       ZONE_SEG_GP_NO,                                              /*그룹구간코드*/
       DPT_ARV,                                                     /*출발-도착역*/
       GP_BKCL_FST_ALC_NUM,                                         /*최초할당수 */
       ALL_CNT,                                                      /*판매허용수*/
       ALC_CNT,                                                      /*그룹할당수*/
       MRK_CNT,                                                        /*판매량*/
       DECODE (#BKCL_CD#, ''F1'', REMAIN, '''') REMAIN,                    /*미할당*/
       YMGT_JOB_ID,                                                     /*수익관리작업ID*/
       DPT_TM,                                                        /*출발시간*/
       RUN_INFO,                                                      /*운행정보*/
       RUN_DT_VAL,                                                   /*운행일자값*/
       TRN_NO_VAL,                                                   /*열차번호값*/
       BS_SEAT_NUM,                                                  /*기본좌석수*/
       NOTY_SALE_SEAT_NUM,                                          /*미발매좌석수*/
       EXPCT_DMD,                                           /*예측승차인원(사용자조정))*/
       LAST_ABRD_EXPN_DMD_NUM                                     /*최종승차예상인원*/
  FROM (SELECT A.RUN_DT,
               LPAD (LTRIM (A.TRN_NO, ''0''), 5, '' '') TRN_NO,
               A.ZONE_SEG_GP_NO,                                    /*그룹구간코드*/
               A.DPT_ARV,                                           /*출발-도착역*/
               A.RUN_DT RUN_DT_VAL,
               A.TRN_NO TRN_NO_VAL,
               (SELECT SUM (Y.BS_SEAT_NUM)
                  FROM TB_YYDK305 Y
                 WHERE     Y.RUN_DT = A.RUN_DT
                       AND Y.TRN_NO = A.TRN_NO
                       AND Y.SEAT_ATT_CD           /* (ASIS : SEAT_ATT_CD ) */
                                        LIKE #SEAT_DV_CD#
                       AND Y.PSRM_CL_CD             /* (ASIS : PSRM_CL_CD ) */
                                       LIKE #PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                        )
                  BS_SEAT_NUM,
               (SELECT SUM (Y.NOTY_SALE_SEAT_NUM)
                  FROM TB_YYDK305 Y
                 WHERE     Y.RUN_DT = A.RUN_DT
                       AND Y.TRN_NO = A.TRN_NO
                       AND Y.SEAT_ATT_CD           /* (ASIS : SEAT_ATT_CD ) */
                                        LIKE #SEAT_DV_CD#
                       AND Y.PSRM_CL_CD             /* (ASIS : PSRM_CL_CD ) */
                                       LIKE #PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                        )
                  NOTY_SALE_SEAT_NUM,
               (SELECT Z.DPT_TM
                  FROM TB_YYDK301 Y, TB_YYDK302 Z
                 WHERE     Y.RUN_DT = A.RUN_DT
                       AND Y.TRN_NO = A.TRN_NO
                       AND Y.RUN_DT = Z.RUN_DT
                       AND Y.TRN_NO = Z.TRN_NO
                       AND Y.ORG_RS_STN_CD = Z.STOP_RS_STN_CD)
                  DPT_TM,
               (SELECT    (SELECT T2.KOR_STN_NM
                             FROM TB_YYDK001 T1, TB_YYDK102 T2
                            WHERE     T1.RS_STN_CD = X.ORG_RS_STN_CD
                                  AND T1.STN_CD = T2.STN_CD
                                  AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                        AND T2.APL_CLS_DT)
                       || ''-''
                       || (SELECT T2.KOR_STN_NM
                             FROM TB_YYDK001 T1, TB_YYDK102 T2
                            WHERE     T1.RS_STN_CD = X.TMN_RS_STN_CD
                                  AND T1.STN_CD = T2.STN_CD
                                  AND TO_CHAR (SYSDATE, ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                        AND T2.APL_CLS_DT)
                       || ''(''
                       || TO_CHAR (TO_DATE (Y.DPT_TM, ''HH24MISS''), ''HH24:MI'')
                       || ''-''
                       || TO_CHAR (TO_DATE (Z.ARV_TM, ''HH24MISS''), ''HH24:MI'')
                       || '')''
                  FROM TB_YYDK301 X, TB_YYDK302 Y, TB_YYDK302 Z
                 WHERE     X.RUN_DT = A.RUN_DT
                       AND X.TRN_NO = A.TRN_NO
                       AND X.RUN_DT = Y.RUN_DT
                       AND X.TRN_NO = Y.TRN_NO
                       AND X.ORG_RS_STN_CD = Y.STOP_RS_STN_CD
                       AND X.RUN_DT = Z.RUN_DT
                       AND X.TRN_NO = Z.TRN_NO
                       AND X.TMN_RS_STN_CD = Z.STOP_RS_STN_CD)
                  RUN_INFO,
               A.YMGT_JOB_ID,
               A.GP_BKCL_FST_ALC_NUM,
               A.ALL_CNT,
               A.ALC_CNT,
               A.MRK_CNT,
                  TO_NUMBER (
                     TO_CHAR (
                        DECODE (A.ALC_CNT,
                                NULL, ''-'',
                                0, 0,
                                ROUND (A.MRK_CNT / A.ALC_CNT * 100, 2)),
                        999990.99))
               || ''%''
                  PER,
                 (SELECT SUM (
                            DECODE (#BKCL_CD#,
                                    ''F1'', AA.GP_MRK_ALLW_NUM,
                                    AA.BKCL_MRK_ALLW_NUM))
                            ALL_CNT
                    FROM TB_YYPD006 AA, TB_YYDK301 BB
                   WHERE     AA.RUN_DT = BB.RUN_DT
                         AND AA.TRN_NO = BB.TRN_NO
                         AND AA.YMGT_JOB_ID = #YMGT_JOB_ID#
                         AND AA.SEAT_ATT_CD        /* (ASIS : SEAT_ATT_CD ) */
                                           LIKE #SEAT_DV_CD#
                         AND AA.RUN_DT = #RUN_DT#
                         AND AA.TRN_NO = A.TRN_NO
                         AND AA.PSRM_CL_CD          /* (ASIS : PSRM_CL_CD ) */
                                          =
                                DECODE (#PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                    ,
                                        ''%'', AA.PSRM_CL_CD /* (ASIS : PSRM_CL_CD ) */
                                                          ,
                                        #PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                    )
                         AND AA.BKCL_CD = #BKCL_CD#
                         AND BB.UP_DN_DV_CD =
                                DECODE (#UP_DN_DV_CD#,
                                        ''%'', BB.UP_DN_DV_CD,
                                        #UP_DN_DV_CD#)
                         AND AA.ZONE_SEG_GP_NO  /* (ASIS : ZONE_SEG_GP_NO ) */
                                              =
                                (SELECT MIN (I.ZONE_SEG_GP_NO /* (ASIS : ZONE_SEG_GP_NO ) */
                                                             )
                                   FROM TB_YYPD006 I, TB_YYDK301 K
                                  WHERE     I.RUN_DT = K.RUN_DT
                                        AND I.TRN_NO = K.TRN_NO
                                        AND I.RUN_DT = #RUN_DT#
                                        AND I.TRN_NO = AA.TRN_NO
                                        AND I.BKCL_CD = #BKCL_CD#
                                        AND I.PSRM_CL_CD /* (ASIS : PSRM_CL_CD ) */
                                                        =
                                               DECODE (#PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                                   ,
                                                       ''%'', I.PSRM_CL_CD /* (ASIS : PSRM_CL_CD ) */
                                                                        ,
                                                       #PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                                   )
                                        AND K.UP_DN_DV_CD =
                                               DECODE (#UP_DN_DV_CD#,
                                                       ''%'', K.UP_DN_DV_CD,
                                                       #UP_DN_DV_CD#)))
               - (SELECT SUM (
                            DECODE (#BKCL_CD#,
                                    ''F1'', K.GP_ALC_NUM,
                                    K.BKCL_ALC_NUM))
                            ALC_CNT
                    FROM TB_YYPD006 K, TB_YYDK301 I
                   WHERE     K.RUN_DT = I.RUN_DT
                         AND K.TRN_NO = I.TRN_NO
                         AND K.YMGT_JOB_ID = #YMGT_JOB_ID#
                         AND K.SEAT_ATT_CD         /* (ASIS : SEAT_ATT_CD ) */
                                          LIKE #SEAT_DV_CD#
                         AND K.PSRM_CL_CD           /* (ASIS : PSRM_CL_CD ) */
                                         =
                                DECODE (#PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                    ,
                                        ''%'', K.PSRM_CL_CD /* (ASIS : PSRM_CL_CD ) */
                                                         ,
                                        #PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                    )
                         AND K.BKCL_CD = #BKCL_CD#
                         AND K.RUN_DT = #RUN_DT#
                         AND I.UP_DN_DV_CD =
                                DECODE (#UP_DN_DV_CD#,
                                        ''%'', I.UP_DN_DV_CD,
                                        #UP_DN_DV_CD#)
                         AND K.TRN_NO = A.TRN_NO)
                  REMAIN,
               (SELECT SUM (AZ.USR_CTL_EXPN_DMD_NUM)
                  FROM TB_YYFD410 AZ,
                       TB_YYDK302 B,
                       TB_YYDK302 C,
                       TB_YYDK308 D,
                       TB_YYDP503 E
                 WHERE     AZ.YMGT_JOB_ID = #YMGT_JOB_ID#
                       AND AZ.RUN_DT = B.RUN_DT
                       AND AZ.TRN_NO = B.TRN_NO
                       AND AZ.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                       AND AZ.RUN_DT = C.RUN_DT
                       AND AZ.TRN_NO = C.TRN_NO
                       AND AZ.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                       AND AZ.RUN_DT = D.RUN_DT
                       AND AZ.TRN_NO = D.TRN_NO
                       AND B.TRVL_ZONE_NO =
                              DECODE (E.UP_DN_DV_CD,
                                      ''D'', D.DPT_ZONE_NO,
                                      D.ARV_ZONE_NO)
                       AND C.TRVL_ZONE_NO =
                              DECODE (E.UP_DN_DV_CD,
                                      ''D'', D.ARV_ZONE_NO,
                                      D.DPT_ZONE_NO)
                       AND AZ.RUN_DT = E.RUN_DT
                       AND AZ.TRN_NO = E.TRN_NO
                       AND AZ.RUN_DT = A.RUN_DT
                       AND AZ.TRN_NO = A.TRN_NO
                       AND D.SEG_GP_NO = A.ZONE_SEG_GP_NO /* (ASIS : ZONE_SEG_GP_NO ) */
                       AND AZ.RUN_DT = #RUN_DT#
                       AND (TRIM(#TRN_NO#) IS NULL OR AZ.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0''))
                       AND AZ.PSRM_CL_CD            /* (ASIS : PSRM_CL_CD ) */
                                        =
                              DECODE (#PSRM_CL_CD#  /* (ASIS : PSRM_CL_CD ) */
                                                  ,
                                      ''%'', AZ.PSRM_CL_CD /* (ASIS : PSRM_CL_CD ) */
                                                        ,
                                      #PSRM_CL_CD#  /* (ASIS : PSRM_CL_CD ) */
                                                  )
                       AND E.UP_DN_DV_CD =
                              DECODE (#UP_DN_DV_CD#,
                                      ''%'', E.UP_DN_DV_CD,
                                      #UP_DN_DV_CD#))
                  EXPCT_DMD,
               (SELECT SUM (AZ.LAST_ABRD_EXPN_DMD_NUM)
                  FROM TB_YYFD410 AZ,
                       TB_YYDK302 B,
                       TB_YYDK302 C,
                       TB_YYDK308 D,
                       TB_YYDP503 E
                 WHERE     AZ.YMGT_JOB_ID = #YMGT_JOB_ID#
                       AND AZ.RUN_DT = B.RUN_DT
                       AND AZ.TRN_NO = B.TRN_NO
                       AND AZ.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                       AND AZ.RUN_DT = C.RUN_DT
                       AND AZ.TRN_NO = C.TRN_NO
                       AND AZ.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                       AND AZ.RUN_DT = D.RUN_DT
                       AND AZ.TRN_NO = D.TRN_NO
                       AND B.TRVL_ZONE_NO =
                              DECODE (E.UP_DN_DV_CD,
                                      ''D'', D.DPT_ZONE_NO,
                                      D.ARV_ZONE_NO)
                       AND C.TRVL_ZONE_NO =
                              DECODE (E.UP_DN_DV_CD,
                                      ''D'', D.ARV_ZONE_NO,
                                      D.DPT_ZONE_NO)
                       AND AZ.RUN_DT = E.RUN_DT
                       AND AZ.TRN_NO = E.TRN_NO
                       AND AZ.RUN_DT = A.RUN_DT
                       AND AZ.TRN_NO = A.TRN_NO
                       AND D.SEG_GP_NO = A.ZONE_SEG_GP_NO /* (ASIS : ZONE_SEG_GP_NO ) */
                       AND AZ.RUN_DT = #RUN_DT#
                       AND (TRIM(#TRN_NO#) IS NULL OR AZ.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0''))
                       AND AZ.PSRM_CL_CD            /* (ASIS : PSRM_CL_CD ) */
                                        =
                              DECODE (#PSRM_CL_CD#  /* (ASIS : PSRM_CL_CD ) */
                                                  ,
                                      ''%'', AZ.PSRM_CL_CD /* (ASIS : PSRM_CL_CD ) */
                                                        ,
                                      #PSRM_CL_CD#  /* (ASIS : PSRM_CL_CD ) */
                                                  )
                       AND E.UP_DN_DV_CD =
                              DECODE (#UP_DN_DV_CD#,
                                      ''%'', E.UP_DN_DV_CD,
                                      #UP_DN_DV_CD#))
                  LAST_ABRD_EXPN_DMD_NUM
          FROM (  /*T ALIAS*/
                  SELECT T.RUN_DT,
                         T.TRN_NO,
                         T.ZONE_SEG_GP_NO       /* (ASIS : ZONE_SEG_GP_NO ) */
                                         ,
                         T.DPT_ARV,
                         T.YMGT_JOB_ID,
                         DECODE (
                            T.GP_BKCL_FST_ALC_NUM,
                            999, 0,
                            DECODE (
                               #PSRM_CL_CD#         /* (ASIS : PSRM_CL_CD ) */
                                           ,
                               ''%'',   T.GP_BKCL_FST_ALC_NUM
                                    + R.GP_BKCL_FST_ALC_NUM,
                               ''1'', T.GP_BKCL_FST_ALC_NUM,
                               ''2'', R.GP_BKCL_FST_ALC_NUM))
                            GP_BKCL_FST_ALC_NUM,
                         DECODE (#PSRM_CL_CD#       /* (ASIS : PSRM_CL_CD ) */
                                             ,
                                 ''%'', T.ALL_CNT + R.ALL_CNT,
                                 ''1'', T.ALL_CNT,
                                 ''2'', R.ALL_CNT)
                            ALL_CNT,
                         DECODE (#PSRM_CL_CD#       /* (ASIS : PSRM_CL_CD ) */
                                             ,
                                 ''%'', T.ALC_CNT + R.ALC_CNT,
                                 ''1'', T.ALC_CNT,
                                 ''2'', R.ALC_CNT)
                            ALC_CNT,
                         DECODE (#PSRM_CL_CD#       /* (ASIS : PSRM_CL_CD ) */
                                             ,
                                 ''%'', T.MRK_CNT + R.MRK_CNT,
                                 ''1'', T.MRK_CNT,
                                 ''2'', R.MRK_CNT)
                            MRK_CNT,
                         T.UP_DN_DV_CD,
                         T.RUN_ORDR,
                         R.RUN_ORDR
                    FROM (  SELECT A.RUN_DT,
                                   A.TRN_NO,
                                   A.ZONE_SEG_GP_NO,
                                   C.RUN_ORDR,
                                   E.UP_DN_DV_CD,
                                   DECODE (
                                      E.UP_DN_DV_CD,
                                      ''D'',    (SELECT T2.KOR_STN_NM
                                                 FROM TB_YYDK001 T1,
                                                      TB_YYDK102 T2
                                                WHERE     T1.RS_STN_CD =
                                                             C.STOP_RS_STN_CD
                                                      AND T1.STN_CD = T2.STN_CD
                                                      AND TO_CHAR (SYSDATE,
                                                                   ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                                   AND T2.APL_CLS_DT)
                                           || ''-''
                                           || (SELECT T2.KOR_STN_NM
                                                 FROM TB_YYDK001 T1,
                                                      TB_YYDK102 T2
                                                WHERE     T1.RS_STN_CD =
                                                             D.STOP_RS_STN_CD
                                                      AND T1.STN_CD = T2.STN_CD
                                                      AND TO_CHAR (SYSDATE,
                                                                   ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                                   AND T2.APL_CLS_DT),
                                         (SELECT T2.KOR_STN_NM
                                            FROM TB_YYDK001 T1, TB_YYDK102 T2
                                           WHERE     T1.RS_STN_CD =
                                                        D.STOP_RS_STN_CD
                                                 AND T1.STN_CD = T2.STN_CD
                                                 AND TO_CHAR (SYSDATE,
                                                              ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                              AND T2.APL_CLS_DT)
                                      || ''-''
                                      || (SELECT T2.KOR_STN_NM
                                            FROM TB_YYDK001 T1, TB_YYDK102 T2
                                           WHERE     T1.RS_STN_CD =
                                                        C.STOP_RS_STN_CD
                                                 AND T1.STN_CD = T2.STN_CD
                                                 AND TO_CHAR (SYSDATE,
                                                              ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                              AND T2.APL_CLS_DT))
                                      DPT_ARV,
                                   A.YMGT_JOB_ID,
                                   NVL (A.GP_BKCL_FST_ALC_NUM, 0)
                                      GP_BKCL_FST_ALC_NUM,
                                   SUM (
                                      DECODE (#BKCL_CD#,
                                              ''F1'', NVL (A.GP_MRK_ALLW_NUM, 0),
                                              NVL (A.BKCL_MRK_ALLW_NUM, 0)))
                                      ALL_CNT,
                                   SUM (
                                      DECODE (#BKCL_CD#,
                                              ''F1'', NVL (A.GP_ALC_NUM, 0),
                                              NVL (A.BKCL_ALC_NUM, 0)))
                                      ALC_CNT,
                                   SUM (A.GP_BKCL_BORD_SNO) MRK_CNT
                              FROM TB_YYPD006 A,
                                   TB_YYDK308 B,
                                   TB_YYDK302 C,
                                   TB_YYDK302 D,
                                   TB_YYDK301 E,
                                   TB_YYDD513 F,
                                   TB_YYBB003 G,
                                   TB_YYFD010 H
                             WHERE     A.YMGT_JOB_ID = #YMGT_JOB_ID#
                                   AND A.SEAT_ATT_CD LIKE #SEAT_DV_CD#
                                   AND A.RUN_DT = B.RUN_DT
                                   AND A.TRN_NO = B.TRN_NO
                                   AND A.ZONE_SEG_GP_NO = B.SEG_GP_NO
                                   AND A.RUN_DT = C.RUN_DT
                                   AND A.TRN_NO = C.TRN_NO
                                   AND B.DPT_ZONE_NO = C.TRVL_ZONE_NO
                                   AND A.RUN_DT = D.RUN_DT
                                   AND A.TRN_NO = D.TRN_NO
                                   AND B.ARV_ZONE_NO = D.TRVL_ZONE_NO
                                   AND A.RUN_DT = E.RUN_DT
                                   AND A.TRN_NO = E.TRN_NO
                                   AND A.RUN_DT = #RUN_DT#
                                   AND (TRIM(#TRN_NO#) IS NULL OR A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0''))
                                   AND A.PSRM_CL_CD =
                                          DECODE (#PSRM_CL_CD#,
                                                  ''%'', ''1'',
                                                  #PSRM_CL_CD#)
                                   AND A.BKCL_CD = #BKCL_CD#
                                   AND E.UP_DN_DV_CD =
                                          DECODE (#UP_DN_DV_CD#,
                                                  ''%'', E.UP_DN_DV_CD,
                                                  #UP_DN_DV_CD#)
                                   AND C.STOP_RS_STN_CD <> D.STOP_RS_STN_CD
                                   AND C.RUN_ORDR <
                                          DECODE (E.UP_DN_DV_CD,
                                                  ''D'', D.RUN_ORDR,
                                                  ''U'', 100)
                                   AND D.RUN_ORDR >
                                          DECODE (E.UP_DN_DV_CD,
                                                  ''D'', C.RUN_ORDR,
                                                  ''U'', 0)
                                   AND C.RUN_ORDR >
                                          DECODE (E.UP_DN_DV_CD,
                                                  ''D'', 0,
                                                  ''U'', D.RUN_ORDR)
                                   AND F.RUN_DT = A.RUN_DT
                                   AND F.TRN_NO = A.TRN_NO
                                   AND SUBSTR (F.REST_SEAT_MG_ID, 14, 1) /* PSRM_CL_CD  */
                                                                        =
                                          A.PSRM_CL_CD
                                   AND A.BKCL_CD = F.BKCL_CD
                                   AND A.RUN_DT BETWEEN G.APL_ST_DT
                                                    AND G.APL_CLS_DT
                                   AND F.RUN_DT BETWEEN G.APL_ST_DT
                                                    AND G.APL_CLS_DT
                                   AND SUBSTR (F.REST_SEAT_MG_ID, 15, 3) /* SEAT_ATT_CD */
                                                                        LIKE
                                          #SEAT_DV_CD#
                                   AND A.YMGT_JOB_ID = H.YMGT_JOB_ID
                                   AND H.YMGT_PROC_DV_ID IN (''YP620'', ''YP625'')
                                   AND G.BKCL_CD = A.BKCL_CD
                          GROUP BY A.RUN_DT,
                                   A.TRN_NO,
                                   A.ZONE_SEG_GP_NO,
                                   E.UP_DN_DV_CD,
                                   C.STOP_RS_STN_CD,
                                   D.STOP_RS_STN_CD,
                                   C.RUN_ORDR,
                                   D.RUN_ORDR,
                                   A.YMGT_JOB_ID,
                                   A.GP_BKCL_FST_ALC_NUM,
                                   G.VLID_ST_DNO,
                                   G.VLID_CLS_DNO
                          ORDER BY A.RUN_DT,
                                   A.TRN_NO,
                                   A.ZONE_SEG_GP_NO,
                                   E.UP_DN_DV_CD,
                                   DECODE (E.UP_DN_DV_CD,
                                           ''D'', C.RUN_ORDR,
                                           ''U'', D.RUN_ORDR),
                                   DECODE (E.UP_DN_DV_CD,
                                           ''D'', D.RUN_ORDR,
                                           ''U'', C.RUN_ORDR) DESC) T,
                         /* R ALIAS */
                         (  SELECT A.RUN_DT,
                                   A.TRN_NO,
                                   A.ZONE_SEG_GP_NO /* (ASIS : ZONE_SEG_GP_NO ) */
                                                   ,
                                   D.RUN_ORDR,
                                   E.UP_DN_DV_CD,
                                   DECODE (
                                      E.UP_DN_DV_CD,
                                      ''D'',    (SELECT T2.KOR_STN_NM
                                                 FROM TB_YYDK001 T1,
                                                      TB_YYDK102 T2
                                                WHERE     T1.RS_STN_CD =
                                                             C.STOP_RS_STN_CD
                                                      AND T1.STN_CD = T2.STN_CD
                                                      AND TO_CHAR (SYSDATE,
                                                                   ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                                   AND T2.APL_CLS_DT)
                                           || ''-''
                                           || (SELECT T2.KOR_STN_NM
                                                 FROM TB_YYDK001 T1,
                                                      TB_YYDK102 T2
                                                WHERE     T1.RS_STN_CD =
                                                             D.STOP_RS_STN_CD
                                                      AND T1.STN_CD = T2.STN_CD
                                                      AND TO_CHAR (SYSDATE,
                                                                   ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                                   AND T2.APL_CLS_DT),
                                         (SELECT T2.KOR_STN_NM
                                            FROM TB_YYDK001 T1, TB_YYDK102 T2
                                           WHERE     T1.RS_STN_CD =
                                                        D.STOP_RS_STN_CD
                                                 AND T1.STN_CD = T2.STN_CD
                                                 AND TO_CHAR (SYSDATE,
                                                              ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                              AND T2.APL_CLS_DT)
                                      || ''-''
                                      || (SELECT T2.KOR_STN_NM
                                            FROM TB_YYDK001 T1, TB_YYDK102 T2
                                           WHERE     T1.RS_STN_CD =
                                                        C.STOP_RS_STN_CD
                                                 AND T1.STN_CD = T2.STN_CD
                                                 AND TO_CHAR (SYSDATE,
                                                              ''YYYYMMDD'') BETWEEN T2.APL_ST_DT
                                                                              AND T2.APL_CLS_DT))
                                      DPT_ARV,
                                   A.YMGT_JOB_ID,
                                   CASE
                                      WHEN (   (G.VLID_ST_DNO IS NULL)
                                            OR (  TO_DATE (A.RUN_DT, ''YYYYMMDD'')
                                                - TO_DATE (
                                                     TO_CHAR (SYSDATE,
                                                              ''YYYYMMDD''),
                                                     ''YYYYMMDD'') > G.VLID_CLS_DNO))
                                      THEN
                                         NVL (A.GP_BKCL_FST_ALC_NUM, 0)
                                      ELSE
                                         NVL (A.GP_BKCL_FST_ALC_NUM, 0)
                                   END
                                      AS GP_BKCL_FST_ALC_NUM,
                                   SUM (
                                      DECODE (#BKCL_CD#,
                                              ''F1'', NVL (A.GP_MRK_ALLW_NUM, 0),
                                              NVL (A.BKCL_MRK_ALLW_NUM, 0)))
                                      ALL_CNT,
                                   SUM (
                                      DECODE (#BKCL_CD#,
                                              ''F1'', NVL (A.GP_ALC_NUM, 0),
                                              NVL (A.BKCL_ALC_NUM, 0)))
                                      ALC_CNT,
                                   SUM (A.GP_BKCL_BORD_SNO) MRK_CNT
                              FROM TB_YYPD006 A,
                                   TB_YYDK308 B,
                                   TB_YYDK302 C,
                                   TB_YYDK302 D,
                                   TB_YYDK301 E,
                                   TB_YYDD513 F,
                                   TB_YYBB003 G,
                                   TB_YYFD010 H
                             WHERE     A.YMGT_JOB_ID = #YMGT_JOB_ID#
                                   AND A.SEAT_ATT_CD /* (ASIS : SEAT_ATT_CD ) */
                                                    LIKE #SEAT_DV_CD#
                                   AND A.RUN_DT = B.RUN_DT
                                   AND A.TRN_NO = B.TRN_NO
                                   AND A.ZONE_SEG_GP_NO = B.SEG_GP_NO /* (ASIS : ZONE_SEG_GP_NO ) */
                                   AND A.RUN_DT = C.RUN_DT
                                   AND A.TRN_NO = C.TRN_NO
                                   AND B.DPT_ZONE_NO = C.TRVL_ZONE_NO
                                   AND A.RUN_DT = D.RUN_DT
                                   AND A.TRN_NO = D.TRN_NO
                                   AND B.ARV_ZONE_NO = D.TRVL_ZONE_NO
                                   AND A.RUN_DT = E.RUN_DT
                                   AND A.TRN_NO = E.TRN_NO
                                   AND A.RUN_DT = #RUN_DT#
                                   AND (TRIM(#TRN_NO#) IS NULL OR A.TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0''))
                                   AND A.PSRM_CL_CD /* (ASIS : PSRM_CL_CD ) */
                                                   =
                                          DECODE (#PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                              ,
                                                  ''%'', ''2'',
                                                  #PSRM_CL_CD# /* (ASIS : PSRM_CL_CD ) */
                                                              )
                                   AND A.BKCL_CD = #BKCL_CD#
                                   AND E.UP_DN_DV_CD =
                                          DECODE (#UP_DN_DV_CD#,
                                                  ''%'', E.UP_DN_DV_CD,
                                                  #UP_DN_DV_CD#)
                                   AND C.STOP_RS_STN_CD <> D.STOP_RS_STN_CD
                                   AND C.RUN_ORDR <
                                          DECODE (E.UP_DN_DV_CD,
                                                  ''D'', D.RUN_ORDR,
                                                  ''U'', 100)
                                   AND D.RUN_ORDR >
                                          DECODE (E.UP_DN_DV_CD,
                                                  ''D'', C.RUN_ORDR,
                                                  ''U'', 0)
                                   AND C.RUN_ORDR >
                                          DECODE (E.UP_DN_DV_CD,
                                                  ''D'', 0,
                                                  ''U'', D.RUN_ORDR)
                                   AND F.RUN_DT = A.RUN_DT
                                   AND F.TRN_NO = A.TRN_NO
                                   AND SUBSTR (F.REST_SEAT_MG_ID, 14, 1) 
                                                                        =
                                          A.PSRM_CL_CD /* (ASIS : PSRM_CL_CD ) */
                                   AND A.BKCL_CD = F.BKCL_CD
                                   AND A.RUN_DT BETWEEN G.APL_ST_DT
                                                    AND G.APL_CLS_DT
                                   AND F.RUN_DT BETWEEN G.APL_ST_DT
                                                    AND G.APL_CLS_DT
                                   AND SUBSTR (F.REST_SEAT_MG_ID, 15, 3) 
                                                                        LIKE
                                          #SEAT_DV_CD#
                                   AND A.YMGT_JOB_ID = H.YMGT_JOB_ID
                                   AND H.YMGT_PROC_DV_ID IN (''YP620'', ''YP625'')
                                   AND G.BKCL_CD = A.BKCL_CD
                          GROUP BY A.RUN_DT,
                                   A.TRN_NO,
                                   A.ZONE_SEG_GP_NO,
                                   E.UP_DN_DV_CD,
                                   C.STOP_RS_STN_CD,
                                   D.STOP_RS_STN_CD,
                                   C.RUN_ORDR,
                                   D.RUN_ORDR,
                                   A.YMGT_JOB_ID,
                                   A.GP_BKCL_FST_ALC_NUM,
                                   G.VLID_ST_DNO,
                                   G.VLID_CLS_DNO
                          ORDER BY A.RUN_DT,
                                   A.TRN_NO,
                                   A.ZONE_SEG_GP_NO,
                                   E.UP_DN_DV_CD,
                                   DECODE (E.UP_DN_DV_CD,
                                           ''D'', C.RUN_ORDR,
                                           ''U'', D.RUN_ORDR),
                                   DECODE (E.UP_DN_DV_CD,
                                           ''D'', D.RUN_ORDR,
                                           ''U'', C.RUN_ORDR) DESC) R
                   WHERE     T.RUN_DT = R.RUN_DT
                         AND T.TRN_NO = R.TRN_NO
                         AND T.ZONE_SEG_GP_NO   /* (ASIS : ZONE_SEG_GP_NO ) */
                                             = R.ZONE_SEG_GP_NO /* (ASIS : ZONE_SEG_GP_NO ) */
                         AND T.DPT_ARV = R.DPT_ARV
                         AND T.YMGT_JOB_ID = R.YMGT_JOB_ID
                         AND T.ZONE_SEG_GP_NO   /* (ASIS : ZONE_SEG_GP_NO ) */
                                             LIKE #SEG_GP_NO# /* (ASIS : ZONE_SEG_GP_NO ) */
                GROUP BY T.RUN_DT,
                         T.TRN_NO,
                         T.ZONE_SEG_GP_NO       /* (ASIS : ZONE_SEG_GP_NO ) */
                                         ,
                         T.DPT_ARV,
                         T.YMGT_JOB_ID,
                         T.GP_BKCL_FST_ALC_NUM,
                         R.GP_BKCL_FST_ALC_NUM,
                         T.ALL_CNT,
                         R.ALL_CNT,
                         T.ALC_CNT,
                         R.ALC_CNT,
                         T.MRK_CNT,
                         R.MRK_CNT,
                         T.UP_DN_DV_CD,
                         T.RUN_ORDR,
                         R.RUN_ORDR
                ORDER BY T.RUN_DT,
                         T.TRN_NO,
                         T.ZONE_SEG_GP_NO       /* (ASIS : ZONE_SEG_GP_NO ) */
                                         ,
                         T.UP_DN_DV_CD,
                         DECODE (T.UP_DN_DV_CD,
                                 ''D'', T.RUN_ORDR,
                                 ''U'', R.RUN_ORDR),
                         DECODE (T.UP_DN_DV_CD,
                                 ''D'', T.RUN_ORDR,
                                 ''U'', R.RUN_ORDR) DESC) A
         WHERE TO_NUMBER (
                  TO_CHAR (
                     DECODE (A.ALC_CNT,
                             NULL, ''-'',
                             0, 0,
                             ROUND (A.MRK_CNT / A.ALC_CNT * 100, 2)),
                     999990.99)) >= #LIMIT_PER#)
]]>', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListRsvSaleAcvm', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListRsvSaleAcvm*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListRsvSaleAcvm */
               RUN_DT         AS RUN_DT 
              ,TRN_NO         AS TRN_NO 
              ,DPT_BF_DT_NUM  AS DPT_BF_DT_NUM 
              ,SUM( ACM_RSV_SEAT_NUM + ACM_SALE_SEAT_NUM - ACM_CNC_SEAT_NUM - ACM_RET_SEAT_NUM )
                              AS RSV_SALE_ACVM_PRNB 
          FROM TB_YYDD506 /* 열차단기보정내역 */
         WHERE RUN_DT = #RUN_DT#
           AND TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND DPT_BF_DT_NUM >= 0 
           AND DPT_BF_DT_NUM <= 60
           AND (#DPT_STGP_CD# IS NULL OR DPT_STGP_CD = #DPT_STGP_CD#)
           AND (#ARV_STGP_CD# IS NULL OR ARV_STGP_CD = #ARV_STGP_CD#)
         GROUP BY RUN_DT, TRN_NO, DPT_BF_DT_NUM
         ORDER BY DPT_BF_DT_NUM
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalJobDt', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalJobDt*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalJobDt */
			   D.YMGT_JOB_ID 						AS YMGT_JOB_ID 				/* 수익관리작업ID 		*/
			  ,A.RUN_DT 							AS RUN_DT 					/* 운행일자         		*/
			  ,A.TRN_NO 							AS TRN_NO_VAL 				/* 열차번호원본 		*/
			  ,LPAD(TO_NUMBER(A.TRN_NO), 5, '' '') 	AS TRN_NO 					/* 열차번호         		*/
			  ,A.STLB_TRN_CLSF_CD 					AS STLB_TRN_CLSF_CD 		/* 열차종별코드 		*/
			  ,A.RUN_DV_CD 							AS RUN_DV_CD  				/* 운행구분코드     		*/
			  ,A.YMS_APL_FLG 						AS YMS_APL_FLG 				/* YMS적용여부 		*/
			  ,D.TRN_ANAL_DV_CD 					AS TRN_ANAL_DV_CD 			/* 열차분석구분코드 	*/
			  ,DECODE(D.FCST_DMD, NULL, ''미실행'', TO_CHAR(D.FCST_DMD, ''9,999'') || ''명'') 
													AS FCST_DMD 				/* 예측수요 			*/
			  ,DECODE(D.REAL_SALE, NULL, ''없음'', TO_CHAR(D.REAL_SALE, ''9,999'') || ''명'') 
													AS REAL_SALE 				/* 예약발매실적 		*/
			  ,D.JOB_DTTM 							AS JOB_DTTM 				/* 작업시작일시 		*/
			  ,NVL(D.JOB_CLS_DTTM, ''-'') 			AS JOB_CLS_DTTM 			/* 작업종료일시 		*/
			  ,A.DPT_TM_VAL 						AS DPT_TM_VAL 				/* 출발시각 원본 		*/
			  ,D.SALE_GROUP1 						AS SALE_GROUP1 				/* 1구역 4주실적 		*/
			  ,D.SALE_GROUP2 						AS SALE_GROUP2 				/* 2구역 4주실적 		*/
			  ,D.FSCT_DMD_GROUP1 					AS FSCT_DMD_GROUP1 			/* 1구역 예측 			*/
			  ,D.FSCT_DMD_GROUP2 					AS FSCT_DMD_GROUP2 			/* 2구역 예측 			*/
			  ,TO_CHAR(D.AVG_ABRD_RT*100, ''FM9999D0'') AS AVG_ABRD_RT 			/* 4주실적승차율 		*/
			  ,TO_CHAR(ROUND(D.FCST_ABRD_RT*100,1), ''FM9999D0'')	AS FCST_ABRD_RT	/* 예측승차율 			*/
			  ,TO_CHAR(
				ROUND(ABS(D.AVG_ABRD_RT - D.FCST_ABRD_RT) * D.AVG_ABRD_RT * 100 * (ABS(60 - (TO_DATE(A.RUN_DT, ''YYYYMMDD'') - TO_DATE(SUBSTR(YMGT_JOB_ID,10,8), ''YYYYMMDD''))) /60),0)
 				, ''FM9999D00'') 						AS RISK 					/* 위험지수 			*/
			  ,A.RUN_INFO 							AS RUN_INFO 				/* 운행구간 			*/
			  ,A.ORG_RS_STN_CD						AS ORG_RS_STN_CD			/* 시발예발역코드 		*/
			  ,A.TMN_RS_STN_CD						AS TMN_RS_STN_CD			/* 종착예발역코드 		*/
			  ,A.ORG_RS_STN_CD_NM 					AS ORG_RS_STN_CD_NM			/* 시발예발역코드명	*/
			  ,A.TMN_RS_STN_CD_NM 					AS TMN_RS_STN_CD_NM			/* 종착예발역코드명	*/
			  ,A.DPT_TM_PRAM 						AS DPT_TM_PRAM				/* 출발시각(파라미터-시분초) */
			  ,A.ARV_TM_PRAM 						AS ARV_TM_PRAM				/* 도착시각(파라미터-시분초) */
		  FROM ( SELECT A.RUN_DT 						AS RUN_DT 					/* 운행일자         		*/
					   ,A.TRN_NO 						AS TRN_NO 					/* 열차번호         		*/
					   ,A.ROUT_CD 						AS ROUT_CD 					/* 노선코드         		*/
					   ,A.UP_DN_DV_CD 					AS UP_DN_DV_CD 				/* 상하행구분코드   		*/
					   ,A.STLB_TRN_CLSF_CD 				AS STLB_TRN_CLSF_CD 		/* 열차종별코드     		*/
					   ,A.RUN_DV_CD 					AS RUN_DV_CD 				/* 운행구분코드     		*/
					   ,A.YMS_APL_FLG 					AS YMS_APL_FLG 				/* YMS적용여부      		*/
					   ,SUBSTR(B.DPT_TM, 1, 2) 			AS DPT_TM 					/* 출발시각  			*/
					   ,B.DPT_TM 						AS DPT_TM_VAL 				/* 출발시각원본 		*/
					   ,( SELECT TRIM(Y.KOR_STN_NM)
							FROM TB_YYDK001 X
								,TB_YYDK102 Y
						   WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
							 AND X.STN_CD = Y.STN_CD
							 AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND  Y.APL_CLS_DT)
					 || ''-'' 
					 || ( SELECT TRIM(Y.KOR_STN_NM)
							FROM TB_YYDK001 X
								,TB_YYDK102 Y
						   WHERE X.RS_STN_CD = A.TMN_RS_STN_CD
							 AND X.STN_CD = Y.STN_CD
							 AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
					 || ''(''
					 || TO_CHAR(TO_DATE(B.DPT_TM, ''hh24miss''), ''hh24:mi'')
					 || ''-''
					 || TO_CHAR(TO_DATE(C.ARV_TM, ''hh24miss''), ''hh24:mi'')
					 || '')'' 							AS RUN_INFO 				/* 운행구간 			*/
			  			,A.ORG_RS_STN_CD				AS ORG_RS_STN_CD			/* 시발예발역코드 		*/
			  			,A.TMN_RS_STN_CD				AS TMN_RS_STN_CD			/* 종착예발역코드 		*/
						,( SELECT TRIM(Y.KOR_STN_NM)
							FROM TB_YYDK001 X
								,TB_YYDK102 Y
						   WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
							 AND X.STN_CD = Y.STN_CD
							 AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND  Y.APL_CLS_DT)
														AS ORG_RS_STN_CD_NM			/* 시발예발역코드명	*/
						,( SELECT TRIM(Y.KOR_STN_NM)
							FROM TB_YYDK001 X
								,TB_YYDK102 Y
						   WHERE X.RS_STN_CD = A.TMN_RS_STN_CD
							 AND X.STN_CD = Y.STN_CD
							 AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
														AS TMN_RS_STN_CD_NM			/* 종착예발역코드명	*/
					   ,TO_CHAR(TO_DATE(B.DPT_TM, ''hh24miss''), ''hh24:mi:ss'')
														AS DPT_TM_PRAM				/* 출발시각(파라미터-시분초) */
					   ,TO_CHAR(TO_DATE(C.ARV_TM, ''hh24miss''), ''hh24:mi:ss'')
														AS ARV_TM_PRAM				/* 도착시각(파라미터-시분초) */
				   FROM TB_YYDK301 A /* 열차기본TBL 		*/
					   ,TB_YYDK302 B /* 열차운행내역TBL 	*/
					   ,TB_YYDK302 C /* 열차운행내역TBL 	*/
					   ,TB_YYDK201 D /* 노선코드TBL 		*/
					   ,TB_YYBB004 E /* 열차별할당기본TBL 	*/
				  WHERE A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
					AND (#MRNT_CD# IS NULL OR D.MRNT_CD = #MRNT_CD#)
					AND D.MRNT_CD IN (''01'',''03'',''04'')
					AND ((D.EFC_ST_DT  <= #RUN_TRM_ST_DT#
							AND D.EFC_CLS_DT >= #RUN_TRM_CLS_DT#)
						OR (D.EFC_ST_DT  >= #RUN_TRM_ST_DT#
							AND D.EFC_CLS_DT <= #RUN_TRM_CLS_DT#))
					AND (#ROUT_CD# IS NULL OR  A.ROUT_CD = #ROUT_CD#)
					AND (#STLB_TRN_CLSF_CD# IS NULL OR A.STLB_TRN_CLSF_CD = #STLB_TRN_CLSF_CD#)
					AND (#UP_DN_DV_CD# = ''A'' OR A.UP_DN_DV_CD = #UP_DN_DV_CD#)
					AND A.RUN_DT 		= B.RUN_DT(+)
					AND A.TRN_NO 		= B.TRN_NO(+)
					AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD(+)  /* 시발예발역코드 = 정차예발역코드 */
					AND A.RUN_DT 		= C.RUN_DT(+)
					AND A.TRN_NO 		= C.TRN_NO(+)
					AND A.TMN_RS_STN_CD = C.STOP_RS_STN_CD(+)  /* 종착예발역코드 = 정차예발역코드 */
					AND A.ROUT_CD 		= D.ROUT_CD(+)
					AND A.RUN_DT 		= E.RUN_DT(+)
					AND A.TRN_NO 		= E.TRN_NO(+)
					AND ((DECODE(PSRM_CL_CD || BKCL_CD, ''1F1'',1,''1C1'',2,''1R1'',3,''1R2'',4,''1R3'',5,''2F1'',6,''2C1'',7,''2R1'',8,''2R2'',9,''2R3'',10,0) 
						= ( SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCL_CD,''1F1'',1,''1C1'',2,''1R1'',3,''1R2'',4,''1R3'',5,''2F1'',6,''2C1'',7,''2R1'',8,''2R2'',9,''2R3'',10,0))
							  FROM TB_YYBB004 X /* 열차별할당기본TBL */
								  ,TB_YYDK309 Y  /* 부킹클래스적용내역TBL */
							 WHERE X.RUN_DT 		= E.RUN_DT
							   AND X.TRN_NO 		= E.TRN_NO
							   AND X.RUN_DT 		= Y.RUN_DT
							   AND X.TRN_NO 		= Y.TRN_NO
							   AND X.PSRM_CL_CD 	= Y.PSRM_CL_CD
							   AND X.BKCL_CD 		= Y.BKCL_CD
							   AND Y.BKCL_USE_FLG 	= ''Y'')
						   AND PSRM_CL_CD IS NOT NULL)
						OR PSRM_CL_CD IS NULL) ) A
		 	   ,( SELECT A1.YMGT_JOB_ID 						AS YMGT_JOB_ID 		/* 수익관리작업ID		*/
						,A1.RUN_DT 								AS RUN_DT 			/* 운행일자             	*/
						,A1.TRN_NO 								AS TRN_NO 			/* 열차번호             	*/
						,A1.TRN_ANAL_DV_CD 						AS TRN_ANAL_DV_CD 	/* 열차분석구분코드 	*/
						,A1.JOB_DTTM 							AS JOB_DTTM 		/* 작업일시 			*/
						,A1.JOB_CLS_DTTM 						AS JOB_CLS_DTTM		/* 작업종료일시 		*/
						,B1.FCST_DMD 							AS FCST_DMD 		/* 예측수요 			*/
						,A1.REAL_SALE 							AS REAL_SALE 		/* 예약발매실적 		*/
						,TO_NUMBER(SUBSTR(A1.GROUP_SALE,1,5)) 	AS SALE_GROUP1 		/* 1구역 4주실적 		*/
						,TO_NUMBER(SUBSTR(A1.GROUP_SALE,6)) 	AS SALE_GROUP2 		/* 2구역 4주실적 		*/
						,B1.FSCT_DMD_GROUP1 					AS FSCT_DMD_GROUP1 	/* 1구역 예측 			*/
						,B1.FSCT_DMD_GROUP2 					AS FSCT_DMD_GROUP2 	/* 2구역 예측 			*/
						,C1.AVG_ABRD_RT 						AS AVG_ABRD_RT 		/* 4주실적승차율 		*/
						,C1.FCST_ABRD_RT 						AS FCST_ABRD_RT 	/* 예측승차율 			*/ 
					FROM ( SELECT A.YMGT_JOB_ID 							AS YMGT_JOB_ID /* 수익관리작업ID       */
								 ,A.RUN_DT 									AS RUN_DT /* 운행일자             */
								 ,A.TRN_NO 									AS TRN_NO /* 열차번호             */
								 ,A.TRN_ANAL_DV_CD 							AS TRN_ANAL_DV_CD /* 열차분석상태코드 */
								 ,( SELECT SUM(AA.RSV_SEAT_NUM + AA.SALE_SEAT_NUM - AA.RET_SEAT_NUM - AA.CNC_SEAT_NUM)
									  FROM TB_YYDS501 AA /* 예약발매실적집계TBL */
										  ,TB_YYDP503 N /* 열차특성상세TBL */
										  ,TB_YYDD505 M /* 열차구간내역TBL */
									 WHERE N.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
									   AND (#MRNT_CD# IS NULL OR N.MRNT_CD = #MRNT_CD#)
									   AND N.MRNT_CD IN (''01'',''03'',''04'')
									   AND (#ROUT_CD# IS NULL OR N.ROUT_CD = #ROUT_CD#)
									   AND (#UP_DN_DV_CD# = ''A'' OR N.UP_DN_DV_CD = #UP_DN_DV_CD#)
									   AND AA.RUN_DT = N.RUN_DT
									   AND AA.TRN_NO = N.TRN_NO
									   AND N.RUN_DT = M.RUN_DT
									   AND N.TRN_NO = M.TRN_NO
									   AND AA.RUN_DT = M.RUN_DT
									   AND AA.TRN_NO = M.TRN_NO
									   AND AA.DPT_STN_CONS_ORDR = M.DPT_STN_CONS_ORDR
									   AND AA.ARV_STN_CONS_ORDR = M.ARV_STN_CONS_ORDR
									   AND AA.RUN_DT = A.RUN_DT
									   AND AA.TRN_NO = A.TRN_NO) 			AS REAL_SALE
								 ,( SELECT LPAD(TO_CHAR(ROUND(SUM(DECODE(E.SEG_GP_NO,1, Z.RSV_SEAT_NUM +
										   Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM) ) /
										   COUNT(DISTINCT Z.RUN_DT),0) ),5, ''0'') ||
										   LPAD(TO_CHAR(ROUND(SUM(DECODE(E.SEG_GP_NO,2, 
										   Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM) ) /
										   COUNT(DISTINCT Z.RUN_DT),0) ),5, ''0'')
									  FROM TB_YYDS501 Z /* 예약발매실적집계TBL */
										  ,TB_YYDP503 N /* 열차특성상세TBL */
										  ,TB_YYDD505 M /* 열차구간내역TBL */
										  ,TB_YYDK302 C /* 열차운행내역TBL */
										  ,TB_YYDK302 D /* 열차운행내역TBL */
										  ,TB_YYDK308 E /* 구역별구간그룹내역TBL */
									 WHERE N.RUN_DT BETWEEN TO_CHAR(TO_DATE(A.RUN_DT, ''YYYYMMDD'') - 30, ''YYYYMMDD'')
									   AND TO_CHAR(TO_DATE(A.RUN_DT, ''YYYYMMDD'') - 2, ''YYYYMMDD'')
									   AND TO_CHAR(TO_DATE(N.RUN_DT, ''YYYYMMDD''), ''D'') =
											TO_CHAR(TO_DATE(A.RUN_DT, ''YYYYMMDD''), ''D'')
									   AND N.TRN_NO = A.TRN_NO
									   AND (#MRNT_CD# IS NULL OR N.MRNT_CD = #MRNT_CD#)
									   AND N.MRNT_CD IN (''01'',''03'',''04'')
									   AND (#ROUT_CD# IS NULL OR N.ROUT_CD = #ROUT_CD#)
									   AND (#UP_DN_DV_CD# = ''A'' OR N.UP_DN_DV_CD = #UP_DN_DV_CD#)
									   AND Z.RUN_DT = N.RUN_DT
									   AND Z.TRN_NO = N.TRN_NO
									   AND Z.RUN_DT = M.RUN_DT
									   AND Z.TRN_NO = M.TRN_NO
									   AND Z.DPT_STN_CONS_ORDR = M.DPT_STN_CONS_ORDR
									   AND Z.ARV_STN_CONS_ORDR = M.ARV_STN_CONS_ORDR
									   AND Z.RUN_DT = C.RUN_DT
									   AND Z.TRN_NO = C.TRN_NO
									   AND Z.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
									   AND Z.RUN_DT = D.RUN_DT
									   AND Z.TRN_NO = D.TRN_NO
									   AND Z.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
									   AND Z.RUN_DT = E.RUN_DT
									   AND Z.TRN_NO = E.TRN_NO
									   AND C.TRVL_ZONE_NO = DECODE(N.UP_DN_DV_CD, ''D'', E.DPT_ZONE_NO, E.ARV_ZONE_NO)  /* 여객구역번호 */
									   AND D.TRVL_ZONE_NO = DECODE(N.UP_DN_DV_CD, ''D'', E.ARV_ZONE_NO, E.DPT_ZONE_NO)  /* 여객구역번호 */
									   AND E.SEG_GP_NO IN(1, 2)
									   AND EXISTS( SELECT ''X'' 
													 FROM TB_YYDK003 A /* 카렌다내역TBL */
													WHERE A.BIZ_DD_STG_CD IN (''1'',''2'',''3'')
													  AND A.RUN_DT = Z.RUN_DT)) AS GROUP_SALE
								 ,D.JOB_DTTM 							AS JOB_DTTM
								 ,D.JOB_CLS_DTTM 						AS JOB_CLS_DTTM
							 FROM TB_YYFD011 A /* 수익관리대상열차내역TBL */
								 ,TB_YYFB009 D /* 수익관리작업결과기본TBL */
								 ,TB_YYDP503 Z /* 열차특성상세TBL */
							WHERE Z.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
							  AND (#MRNT_CD# IS NULL OR Z.MRNT_CD = #MRNT_CD#)
							  AND Z.MRNT_CD IN (''01'',''03'',''04'')
							  AND (#ROUT_CD# IS NULL OR Z.ROUT_CD = #ROUT_CD#)
							  AND (#UP_DN_DV_CD# = ''A'' OR Z.UP_DN_DV_CD = #UP_DN_DV_CD#)
							  AND A.REG_DTTM LIKE #JOB_DT# || ''%''
							  AND Z.RUN_DT = A.RUN_DT
							  AND Z.TRN_NO = A.TRN_NO
							  AND A.YMGT_JOB_ID = D.YMGT_JOB_ID
							  AND (D.JOB_DTTM, A.RUN_DT, A.TRN_NO) IN( SELECT MAX(S.JOB_DTTM)
																			 ,T.RUN_DT
																			 ,T.TRN_NO
																		 FROM TB_YYFD011 T /* 수익관리대상열차내역TBL */
																			 ,TB_YYFB009 S /* 수익관리작업결과기본TBL */
																			 ,TB_YYDP503 Y /* 열차특성상세TBL */
																		WHERE Y.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
																		  AND (#MRNT_CD# IS NULL OR Y.MRNT_CD = #MRNT_CD#) /* 주운행선코드 */
																		  AND Y.MRNT_CD IN (''01'',''03'',''04'')
																		  AND (#ROUT_CD# IS NULL OR Y.ROUT_CD = #ROUT_CD#) /* 노선코드 */
																		  AND (#UP_DN_DV_CD# = ''A'' OR Y.UP_DN_DV_CD = #UP_DN_DV_CD#)  /* 상행하행구분코드 */
																		  AND S.REG_DTTM LIKE #JOB_DT# || ''%''
																		  AND S.YMGT_JOB_ID = T.YMGT_JOB_ID
																		  AND Y.RUN_DT = T.RUN_DT
																		  AND Y.TRN_NO = T.TRN_NO
																		  AND (T.NON_NML_TRN_FLG = ''Y'' OR T.NON_NML_TRN_FLG = ''N'')
							GROUP BY T.RUN_DT, T.TRN_NO) ) A1
					   ,( SELECT A.RUN_DT 												AS RUN_DT
								,A.TRN_NO 												AS TRN_NO
								,A.YMGT_JOB_ID 											AS YMGT_JOB_ID /* 수익관리작업ID */
								,SUM(A.USR_CTL_EXPN_DMD_NUM) 							AS FCST_DMD
								,SUM(DECODE(E.SEG_GP_NO, 1, A.USR_CTL_EXPN_DMD_NUM) ) 	AS FSCT_DMD_GROUP1
								,SUM(DECODE(E.SEG_GP_NO, 2, A.USR_CTL_EXPN_DMD_NUM) ) 	AS FSCT_DMD_GROUP2
							FROM TB_YYFD410 A /* 최종탑승예측수요내역TBL */
								,TB_YYDK301 B /* 열차기본TBL */
								,TB_YYDK302 C /* 열차운행내역TBL */
								,TB_YYDK302 D /* 열차운행내역TBL */
								,TB_YYDK308 E /* 구역별구간그룹내역TBL */
						   WHERE A.RUN_DT 				BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
							 AND A.REG_DTTM 			LIKE #JOB_DT# || ''%''
							 AND A.RUN_DT 				= B.RUN_DT
							 AND A.TRN_NO 				= B.TRN_NO
							 AND A.RUN_DT 				= C.RUN_DT
							 AND A.TRN_NO 				= C.TRN_NO
							 AND A.DPT_STN_CONS_ORDR 	= C.STN_CONS_ORDR  /* 출발역구성순서 = 역구성순서*/
							 AND A.RUN_DT 				= D.RUN_DT
							 AND A.TRN_NO 				= D.TRN_NO
							 AND A.ARV_STN_CONS_ORDR 	= D.STN_CONS_ORDR  /* 도착역구성순서 = 역구성순서*/
							 AND A.RUN_DT 				= E.RUN_DT
							 AND A.TRN_NO 				= E.TRN_NO
							 AND C.TRVL_ZONE_NO 		= DECODE(B.UP_DN_DV_CD, ''D'', E.DPT_ZONE_NO, E.ARV_ZONE_NO)  /* 여객구역번호 */
							 AND D.TRVL_ZONE_NO 		= DECODE(B.UP_DN_DV_CD, ''D'', E.ARV_ZONE_NO, E.DPT_ZONE_NO)  /* 여객구역번호 */
						   GROUP BY A.RUN_DT, A.TRN_NO, A.YMGT_JOB_ID) B1 /* 수익관리작업ID */
					   ,( SELECT A1.RUN_DT
								,A1.TRN_NO
								,CASE WHEN TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT,1,4)) <> 0
									  THEN NVL(AVG_ABRD_RT1 *(TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT,5,4)) / TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT,1,4))),0) +
											NVL(AVG_ABRD_RT2 *(TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT,9,4)) / TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT,1,4))),0)
									  ELSE AVG_ABRD_RT1 + AVG_ABRD_RT2
									   END AS AVG_ABRD_RT
								,CASE WHEN A1.FCST_ABRD_PRNB <> 0 
									  THEN A1.ABRD_RT1 *(A1.ABRD_PRNB1 / A1.FCST_ABRD_PRNB) +
											A1.ABRD_RT2 *(A1.ABRD_PRNB2 / A1.FCST_ABRD_PRNB)
									  ELSE ABRD_RT1 + ABRD_RT2
									   END AS FCST_ABRD_RT
							FROM ( SELECT A.RUN_DT 													AS RUN_DT
										 ,A.TRN_NO 													AS TRN_NO
										 ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''1'', A.FCST_ABRD_RT)), 0) 	AS ABRD_RT1 /* 예측승차율 */
										 ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''2'', A.FCST_ABRD_RT)), 0) 	AS ABRD_RT2 /* 예측승차율 */
										 ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''1'', A.FCST_ABRD_PRNB)), 0) 	AS ABRD_PRNB1 /* 예측승차인원수 */
										 ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''2'', A.FCST_ABRD_PRNB)), 0) 	AS ABRD_PRNB2 /* 예측승차인원수 */
										 ,SUM(A.FCST_ABRD_PRNB) 									AS FCST_ABRD_PRNB /* 예측승차인원수 */
										 ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''1'', A.AVG_ABRD_RT)), 0) 	AS AVG_ABRD_RT1 /* 평균승차율 */
										 ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''2'', A.AVG_ABRD_RT)), 0) 	AS AVG_ABRD_RT2 /* 평균승차율 */
										 ,( SELECT LPAD(TO_CHAR(SUM(Z.SEAT_NUM)),4,''0'')
												|| LPAD(TO_CHAR(SUM(DECODE(Z.PSRM_CL_CD,''1'',Z.SEAT_NUM))),4,''0'')
												|| LPAD(TO_CHAR(SUM(DECODE(Z.PSRM_CL_CD,''2'',Z.SEAT_NUM))),4,''0'')
											  FROM TB_YYDS511 Z /* 열차별승차율집계TBL */
											 WHERE Z.RUN_DT = A.RUN_DT
											   AND Z.TRN_NO = A.TRN_NO) 							AS SEAT_ALL_CNT  /* 전체 좌석수 */
									 FROM TB_YYPD003 A /* 열차별부킹클래스통제내역TBL */
										 ,TB_YYDP503 B /* 열차특성상세TBL */
									WHERE B.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
									  AND (#MRNT_CD# IS NULL OR B.MRNT_CD = #MRNT_CD#)  /* 주운행선코드 */
									  AND B.MRNT_CD IN (''01'',''03'',''04'')
									  AND (#ROUT_CD# IS NULL OR B.ROUT_CD = #ROUT_CD#) /* 노선코드 */
									  AND (#UP_DN_DV_CD# = ''A'' OR B.UP_DN_DV_CD = #UP_DN_DV_CD#) /* 상행하행구분코드 */
									  AND A.RUN_DT = B.RUN_DT
									  AND A.TRN_NO = B.TRN_NO
									  AND A.BKCL_CD = ''F1'' /* 부킹클래스코드 */
									GROUP BY A.RUN_DT, A.TRN_NO) A1 ) C1
		 		 WHERE A1.YMGT_JOB_ID = B1.YMGT_JOB_ID  /* 수익관리작업ID */
				   AND A1.RUN_DT = B1.RUN_DT
				   AND A1.TRN_NO = B1.TRN_NO
				   AND A1.RUN_DT = C1.RUN_DT
				   AND A1.TRN_NO = C1.TRN_NO) D
		 WHERE A.RUN_DT = D.RUN_DT
		   AND A.TRN_NO = D.TRN_NO
		   AND ROUND(ABS(D.AVG_ABRD_RT - D.FCST_ABRD_RT) * D.AVG_ABRD_RT * 100,2) >= NVL(TO_NUMBER(#RISK_IDX#),0)
		 ORDER BY RUN_DT, TRN_NO, YMS_APL_FLG DESC
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalRunDt', '/*com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalRunDt*/ 
<![CDATA[
		SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalRunDt */
			   V.YMGT_JOB_ID 									AS YMGT_JOB_ID 				/* 수익관리작업ID 		*/
			  ,SUBSTR(V.YMGT_JOB_ID, 10, 8) 					AS JOB_DT 					/* 작업일자 			*/
			  ,A.RUN_DT 										AS RUN_DT 					/* 운행일자         		*/
			  ,A.TRN_NO_VAL 									AS TRN_NO_VAL 				/* 열차번호원본 		*/
			  ,LPAD(TO_NUMBER(A.TRN_NO), 5, '' '') 				AS TRN_NO 					/* 열차번호         		*/
			  ,A.STLB_TRN_CLSF_CD								AS STLB_TRN_CLSF_CD			/* 열차종별코드 		*/
			  ,A.RUN_DV_CD 										AS RUN_DV_CD 				/* 운행구분코드     		*/
			  ,A.YMS_APL_FLG 									AS YMS_APL_FLG 				/* YMS적용여부 		*/
			  ,A.RUN_INFO 										AS RUN_INFO 				/* 운행구간  			*/
			  ,V.TRN_ANAL_DV_CD 								AS TRN_ANAL_DV_CD 			/* 열차분석구분코드 	*/
			  ,V.JOB_DTTM 										AS JOB_DTTM 				/* 작업시작일시 		*/
			  ,NVL(V.JOB_CLS_DTTM, ''-'') 						AS JOB_CLS_DTTM 			/* 작업종료일시 		*/
			  ,A.DPT_TM_VAL 									AS DPT_TM_VAL 				/* 출발시각원본 		*/
			  ,DECODE(V.FCST_DMD, NULL, ''미실행'', TO_CHAR(V.FCST_DMD, ''9,999'') || ''명'')
																AS FCST_DMD 				/* 예측수요 			*/
			  ,DECODE(V.REAL_SALE, NULL, ''없음'', TO_CHAR(V.REAL_SALE, ''9,999'') || ''명'')
																AS REAL_SALE 				/* 예약발매실적 		*/
			  ,V.SALE_GROUP1 									AS SALE_GROUP1 				/* 1구역 4주실적 		*/
			  ,V.SALE_GROUP2 									AS SALE_GROUP2 				/* 2구역 4주실적 		*/
			  ,V.FSCT_DMD_GROUP1 								AS FSCT_DMD_GROUP1 			/* 1구역 예측 			*/
			  ,V.FSCT_DMD_GROUP2 								AS FSCT_DMD_GROUP2 			/* 2구역 예측 			*/
			  ,TO_CHAR(V.AVG_ABRD_RT*100, ''FM9999D0'') 			AS AVG_ABRD_RT 				/* 4주실적승차율 		*/
			  ,TO_CHAR(ROUND(V.FCST_ABRD_RT*100,1), ''FM9999D0'')	AS FCST_ABRD_RT				/* 예측승차율 			*/
			  ,TO_CHAR(
				ROUND(ABS(V.AVG_ABRD_RT - V.FCST_ABRD_RT) * V.AVG_ABRD_RT * 100 * (ABS(60 - (TO_DATE(A.RUN_DT, ''YYYYMMDD'') - TO_DATE(SUBSTR(V.YMGT_JOB_ID,10,8), ''YYYYMMDD''))) /60),0)  
				, ''FM9999D00'') 									AS RISK 					/* 위험지수 			*/
			  ,A.ORG_RS_STN_CD									AS ORG_RS_STN_CD			/* 시발예발역코드 		*/
			  ,A.TMN_RS_STN_CD									AS TMN_RS_STN_CD			/* 종착예발역코드 		*/
			  ,A.ORG_RS_STN_CD_NM 								AS ORG_RS_STN_CD_NM			/* 시발예발역코드명	*/
			  ,A.TMN_RS_STN_CD_NM 								AS TMN_RS_STN_CD_NM			/* 종착예발역코드명	*/
			  ,A.DPT_TM_PRAM 									AS DPT_TM_PRAM				/* 출발시각(파라미터-시분초) */
			  ,A.ARV_TM_PRAM 									AS ARV_TM_PRAM				/* 도착시각(파라미터-시분초) */
		  FROM ( SELECT N.RUN_DT 					AS RUN_DT 					/* 운행일자         		*/
					   ,N.TRN_NO 					AS TRN_NO 					/* 열차번호         		*/
					   ,N.TRN_NO 					AS TRN_NO_VAL 				/* 열차번호원본 		*/
					   ,N.STLB_TRN_CLSF_CD 			AS STLB_TRN_CLSF_CD 		/* 열차종별코드 		*/
					   ,N.ROUT_CD 					AS ROUT_CD 					/* 노선코드         		*/
					   ,N.UP_DN_DV_CD 				AS UP_DN_DV_CD 				/* 상하행구분코드   		*/
					   ,N.RUN_DV_CD 				AS RUN_DV_CD 				/* 운행구분코드     		*/
					   ,N.YMS_APL_FLG 				AS YMS_APL_FLG  			/* YMS적용여부      		*/
					   ,N.ORG_RS_STN_CD 			AS ORG_RS_STN_CD 			/* 시발예발역코드   		*/
					   ,N.TMN_RS_STN_CD 			AS TMN_RS_STN_CD 			/* 종착예발역코드   		*/
					   ,SUBSTR(B.DPT_TM, 1, 2) 		AS DPT_TM 					/* 출발시각  			*/
					   ,B.DPT_TM 					AS DPT_TM_VAL 				/* 출발시각원본 		*/
					   ,( SELECT TRIM(Y.KOR_STN_NM)
							FROM TB_YYDK001 X
								,TB_YYDK102 Y
						   WHERE X.RS_STN_CD = N.ORG_RS_STN_CD
							 AND X.STN_CD = Y.STN_CD
							 AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND  Y.APL_CLS_DT)
					 || ''-'' 
					 || ( SELECT TRIM(Y.KOR_STN_NM)
							FROM TB_YYDK001 X
								,TB_YYDK102 Y
						   WHERE X.RS_STN_CD = N.TMN_RS_STN_CD
							 AND X.STN_CD = Y.STN_CD
							 AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND  Y.APL_CLS_DT)
					 || ''(''
					 || TO_CHAR(TO_DATE(B.DPT_TM, ''hh24miss''), ''hh24:mi'')
					 || ''-'' 
					 || TO_CHAR(TO_DATE(C.ARV_TM, ''hh24miss''), ''hh24:mi'')
					 || '')'' 						AS RUN_INFO 				/* 운행구간 			*/
					   ,( SELECT TRIM(Y.KOR_STN_NM)
							FROM TB_YYDK001 X
								,TB_YYDK102 Y
						   WHERE X.RS_STN_CD = N.ORG_RS_STN_CD
							 AND X.STN_CD = Y.STN_CD
							 AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND  Y.APL_CLS_DT)
													AS ORG_RS_STN_CD_NM			/* 시발예발역코드명	*/
					   ,( SELECT TRIM(Y.KOR_STN_NM)
							FROM TB_YYDK001 X
								,TB_YYDK102 Y
						   WHERE X.RS_STN_CD = N.TMN_RS_STN_CD
							 AND X.STN_CD = Y.STN_CD
							 AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND  Y.APL_CLS_DT)
													AS TMN_RS_STN_CD_NM			/* 종착예발역코드명	*/
					   ,TO_CHAR(TO_DATE(B.DPT_TM, ''hh24miss''), ''hh24:mi:ss'')
													AS DPT_TM_PRAM				/* 출발시각(파라미터-시분초) */
					   ,TO_CHAR(TO_DATE(C.ARV_TM, ''hh24miss''), ''hh24:mi:ss'')
													AS ARV_TM_PRAM				/* 도착시각(파라미터-시분초) */
				   FROM TB_YYDK301 N /** 일일열차정보 TBL **/
					   ,TB_YYDK302 B /** 일일열차운행시각 **/
					   ,TB_YYDK302 C /** 일일열차운행시각 **/
					   ,TB_YYDK201 D /** 노선             **/
				  WHERE N.RUN_DT 		= B.RUN_DT(+)
					AND N.TRN_NO 		= B.TRN_NO(+)
					AND N.ORG_RS_STN_CD = B.STOP_RS_STN_CD(+)
					AND N.RUN_DT 		= C.RUN_DT(+)
					AND N.TRN_NO 		= C.TRN_NO(+)
					AND N.TMN_RS_STN_CD = C.STOP_RS_STN_CD(+)
					AND N.ROUT_CD 		= D.ROUT_CD(+)
					AND N.RUN_DT 		= #RUN_DT#
					AND (#TRN_NO# 		IS NULL OR N.TRN_NO = #TRN_NO#)
					AND (#STLB_TRN_CLSF_CD# IS NULL OR N.STLB_TRN_CLSF_CD = #STLB_TRN_CLSF_CD#)
					AND (#MRNT_CD# IS NULL OR D.MRNT_CD = #MRNT_CD#)
					AND D.MRNT_CD IN (''01'',''03'',''04'')
					AND D.EFC_ST_DT <= #RUN_DT#
					AND (#ROUT_CD# IS NULL OR N.ROUT_CD = #ROUT_CD#)
					AND (#UP_DN_DV_CD# = ''A'' OR N.UP_DN_DV_CD = #UP_DN_DV_CD#)) A
			  ,( SELECT A1.YMGT_JOB_ID 							AS YMGT_JOB_ID 		/* 수익관리작업ID		*/
					   ,A1.RUN_DT 								AS RUN_DT 			/* 운행일자			*/
					   ,A1.TRN_NO 								AS TRN_NO 			/* 열차번호			*/
					   ,A1.TRN_ANAL_DV_CD 						AS TRN_ANAL_DV_CD 	/* 열차분석구분코드 	*/
					   ,A1.REAL_SALE 							AS REAL_SALE 		/* 예약발매실적 		*/
					   ,TO_NUMBER(SUBSTR(A1.GROUP_SALE, 1, 5) ) AS SALE_GROUP1 		/* 1구역 4주실적 		*/
					   ,TO_NUMBER(SUBSTR(A1.GROUP_SALE, 6) ) 	AS SALE_GROUP2 		/* 2구역 4주실적 		*/
					   ,A1.JOB_DTTM 							AS JOB_DTTM	 		/* 작업시작일시		*/
					   ,A1.JOB_CLS_DTTM 						AS JOB_CLS_DTTM 	/* 작업종료일시 		*/
					   ,B1.FCST_DMD 							AS FCST_DMD 		/* 예측수요 			*/
					   ,B1.FSCT_DMD_GROUP1 						AS FSCT_DMD_GROUP1 	/* 1구역 예측 			*/
					   ,B1.FSCT_DMD_GROUP2 						AS FSCT_DMD_GROUP2 	/* 2구역 예측 			*/
					   ,C1.AVG_ABRD_RT 							AS AVG_ABRD_RT 		/* 4주실적승차율 		*/
					   ,C1.FCST_ABRD_RT 						AS FCST_ABRD_RT 	/* 예측승차율 			*/ 
				   FROM ( SELECT X.YMGT_JOB_ID 							AS YMGT_JOB_ID /* 수익관리작업ID       */
								,X.RUN_DT 								AS RUN_DT /* 운행일자             */
								,X.TRN_NO 								AS TRN_NO /* 열차번호             */
								,X.TRN_ANAL_DV_CD 						AS TRN_ANAL_DV_CD /* 열차분석구분코드 */
								,( SELECT SUM(AA.RSV_SEAT_NUM + AA.SALE_SEAT_NUM - AA.RET_SEAT_NUM - AA.CNC_SEAT_NUM) AS REAL_SALE
									 FROM TB_YYDS501 AA
										 ,TB_YYDP503 N
										 ,TB_YYDD505 M
									WHERE N.RUN_DT = #RUN_DT#
									  AND (#TRN_NO# IS NULL OR N.TRN_NO = #TRN_NO#)
									  AND (#MRNT_CD# IS NULL OR N.MRNT_CD = #MRNT_CD#)
									  AND N.MRNT_CD IN (''01'',''03'',''04'')
									  AND (#ROUT_CD# IS NULL OR N.ROUT_CD = #ROUT_CD#)
									  AND (#UP_DN_DV_CD# = ''A'' OR N.UP_DN_DV_CD = #UP_DN_DV_CD#)
									  AND N.RUN_DT = AA.RUN_DT
									  AND N.TRN_NO = AA.TRN_NO
									  AND N.RUN_DT = M.RUN_DT
									  AND N.TRN_NO = M.TRN_NO
									  AND M.RUN_DT = AA.RUN_DT
									  AND M.TRN_NO = AA.TRN_NO
									  AND M.DPT_STN_CONS_ORDR = AA.DPT_STN_CONS_ORDR
									  AND M.ARV_STN_CONS_ORDR = AA.ARV_STN_CONS_ORDR
									  AND AA.RUN_DT = X.RUN_DT
									  AND AA.TRN_NO = X.TRN_NO) 		AS REAL_SALE
								,( SELECT LPAD(TO_CHAR(ROUND(SUM(DECODE(
											E.SEG_GP_NO, 1, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM)
											) / COUNT(DISTINCT Z.RUN_DT), 0) ), 5, ''0'') 
									   || LPAD(TO_CHAR(ROUND(SUM(DECODE(
											E.SEG_GP_NO, 2, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM) 
											) / COUNT(DISTINCT Z.RUN_DT), 0) ), 5, ''0'')
									 FROM TB_YYDS501 Z
										 ,TB_YYDP503 N
										 ,TB_YYDD505 M
										 ,TB_YYDK302 C
										 ,TB_YYDK302 D
										 ,TB_YYDK308 E
									WHERE N.RUN_DT BETWEEN TO_CHAR(TO_DATE(X.RUN_DT, ''YYYYMMDD'') - 30, ''YYYYMMDD'')
															AND TO_CHAR(TO_DATE(X.RUN_DT, ''YYYYMMDD'') - 2, ''yyyymmdd'')
									  AND TO_CHAR(TO_DATE(N.RUN_DT, ''YYYYMMDD''), ''D'') = TO_CHAR(TO_DATE(X.RUN_DT, ''YYYYMMDD''), ''D'')
									  AND N.TRN_NO = X.TRN_NO
									  AND (#MRNT_CD# IS NULL OR N.MRNT_CD = #MRNT_CD#)
									  AND N.MRNT_CD IN (''01'',''03'',''04'')
									  AND (#ROUT_CD# IS NULL OR N.ROUT_CD = #ROUT_CD#)
									  AND (#UP_DN_DV_CD# = ''A'' OR N.UP_DN_DV_CD = #UP_DN_DV_CD#)
									  AND N.TRN_NO = X.TRN_NO
									  AND Z.RUN_DT = N.RUN_DT
									  AND Z.TRN_NO = N.TRN_NO
									  AND Z.RUN_DT = M.RUN_DT
									  AND Z.TRN_NO = M.TRN_NO
									  AND Z.DPT_STN_CONS_ORDR = M.DPT_STN_CONS_ORDR
									  AND Z.ARV_STN_CONS_ORDR = M.ARV_STN_CONS_ORDR
									  AND Z.RUN_DT = C.RUN_DT
									  AND Z.TRN_NO = C.TRN_NO
									  AND Z.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
									  AND Z.RUN_DT = D.RUN_DT
									  AND Z.TRN_NO = D.TRN_NO
									  AND Z.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
									  AND Z.RUN_DT = E.RUN_DT
									  AND Z.TRN_NO = E.TRN_NO
									  AND C.TRVL_ZONE_NO = DECODE(N.UP_DN_DV_CD, ''D'', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
									  AND D.TRVL_ZONE_NO = DECODE(N.UP_DN_DV_CD, ''D'', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
									  AND E.SEG_GP_NO IN(1, 2)
									  AND EXISTS( SELECT ''X''
													FROM TB_YYDK003 A
												   WHERE A.BIZ_DD_STG_CD IN(''1'', ''2'', ''3'')
													 AND A.RUN_DT = Z.RUN_DT) ) AS GROUP_SALE
								,D.JOB_DTTM AS JOB_DTTM
								,D.JOB_CLS_DTTM AS JOB_CLS_DTTM
							FROM TB_YYFD011 X
								,TB_YYFB009 D
								,TB_YYDP503 Z
						   WHERE Z.RUN_DT = #RUN_DT#
							 AND (#TRN_NO# IS NULL OR Z.TRN_NO = #TRN_NO#)
							 AND (#MRNT_CD# IS NULL OR Z.MRNT_CD = #MRNT_CD#)
							 AND Z.MRNT_CD IN (''01'',''03'',''04'')
							 AND (#ROUT_CD# IS NULL OR Z.ROUT_CD = #ROUT_CD#)
							 AND (#UP_DN_DV_CD# = ''A'' OR Z.UP_DN_DV_CD = #UP_DN_DV_CD#)
							 AND Z.RUN_DT = X.RUN_DT
							 AND Z.TRN_NO = X.TRN_NO
							 AND X.YMGT_JOB_ID = D.YMGT_JOB_ID
							 AND (D.JOB_DTTM, X.RUN_DT, X.TRN_NO) IN( SELECT MAX(S.JOB_DTTM)
																			,T.RUN_DT
																			,T.TRN_NO
																		FROM TB_YYFD011 T
																			,TB_YYFB009 S
																			,TB_YYDP503 Y
																	   WHERE Y.RUN_DT = #RUN_DT#
																		 AND (#TRN_NO# IS NULL OR Y.TRN_NO = #TRN_NO#)
																		 AND (#MRNT_CD# IS NULL OR Y.MRNT_CD = #MRNT_CD#)
																		 AND Y.MRNT_CD IN (''01'',''03'',''04'')
																		 AND (#ROUT_CD# IS NULL OR Y.ROUT_CD = #ROUT_CD#)
																		 AND (#UP_DN_DV_CD# = ''A'' OR Y.UP_DN_DV_CD = #UP_DN_DV_CD#)
																		 AND Y.RUN_DT = T.RUN_DT
																		 AND Y.TRN_NO = T.TRN_NO
																		 AND (T.NON_NML_TRN_FLG = ''Y'' OR T.NON_NML_TRN_FLG = ''N'')
																		 AND S.YMGT_JOB_ID = T.YMGT_JOB_ID
																	   GROUP BY T.RUN_DT, T.TRN_NO) ) A1
						,( SELECT A.RUN_DT AS RUN_DT
								 ,A.TRN_NO AS TRN_NO
								 ,A.YMGT_JOB_ID AS YMGT_JOB_ID
								 ,SUM(A.USR_CTL_EXPN_DMD_NUM) AS FCST_DMD
								 ,SUM(DECODE(E.SEG_GP_NO, 1, A.USR_CTL_EXPN_DMD_NUM) ) AS FSCT_DMD_GROUP1
								 ,SUM(DECODE(E.SEG_GP_NO, 2, A.USR_CTL_EXPN_DMD_NUM) ) AS FSCT_DMD_GROUP2
							 FROM TB_YYFD410 A
								 ,TB_YYDK301 B
								 ,TB_YYDK302 C
								 ,TB_YYDK302 D
								 ,TB_YYDK308 E
							WHERE A.RUN_DT = #RUN_DT#
							  AND (#TRN_NO# IS NULL OR A.TRN_NO = #TRN_NO#)
							  AND (#ROUT_CD# IS NULL OR B.ROUT_CD = #ROUT_CD#)
							  AND (#UP_DN_DV_CD# = ''A'' OR B.UP_DN_DV_CD = #UP_DN_DV_CD#)
							  AND A.RUN_DT = B.RUN_DT
							  AND A.TRN_NO = B.TRN_NO
							  AND A.RUN_DT = C.RUN_DT
							  AND A.TRN_NO = C.TRN_NO
							  AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
							  AND A.RUN_DT = D.RUN_DT
							  AND A.TRN_NO = D.TRN_NO
							  AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
							  AND A.RUN_DT = E.RUN_DT
							  AND A.TRN_NO = E.TRN_NO
							  AND C.TRVL_ZONE_NO = DECODE(B.UP_DN_DV_CD, ''D'', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
							  AND D.TRVL_ZONE_NO = DECODE(B.UP_DN_DV_CD, ''D'', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
							GROUP BY A.RUN_DT, A.TRN_NO, A.YMGT_JOB_ID) B1
						,( SELECT A1.RUN_DT
								 ,A1.TRN_NO
								 ,CASE WHEN TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT, 1, 4)) <> 0 
									   THEN NVL(AVG_ABRD_RT1 * TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT, 5, 4)) 
												/ TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT, 1, 4)), 0) 
												+ NVL(AVG_ABRD_RT2 * TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT, 9, 4)) 
												/ TO_NUMBER(SUBSTR(A1.SEAT_ALL_CNT, 1, 4)), 0) 
									   ELSE AVG_ABRD_RT1 + AVG_ABRD_RT2
										END AS AVG_ABRD_RT
								 ,CASE WHEN A1.FCST_ABRD_PRNB <> 0
									   THEN NVL(A1.ABRD_RT1 * A1.ABRD_PSNO1 / A1.FCST_ABRD_PRNB, 0) 
											+ NVL(A1.ABRD_RT2 * A1.ABRD_PSNO2 / A1.FCST_ABRD_PRNB, 0) 
									   ELSE ABRD_RT1 + ABRD_RT2
										END AS FCST_ABRD_RT
							 FROM ( SELECT A.RUN_DT AS RUN_DT
										  ,A.TRN_NO AS TRN_NO
										  ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''1'', A.FCST_ABRD_RT)), 0) AS ABRD_RT1
										  ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''2'', A.FCST_ABRD_RT)), 0) AS ABRD_RT2
										  ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''1'', A.FCST_ABRD_PRNB)), 0) AS ABRD_PSNO1
										  ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''2'', A.FCST_ABRD_PRNB)), 0) AS ABRD_PSNO2
										  ,SUM(A.FCST_ABRD_PRNB) AS FCST_ABRD_PRNB
										  ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''1'', A.AVG_ABRD_RT)), 0) AS AVG_ABRD_RT1
										  ,NVL(SUM(DECODE(A.PSRM_CL_CD, ''2'', A.AVG_ABRD_RT)), 0) AS AVG_ABRD_RT2
										  ,( SELECT LPAD(TO_CHAR(SUM(Z.SEAT_NUM) ), 4, ''0'') 
												 || LPAD(TO_CHAR(SUM(DECODE(Z.PSRM_CL_CD, ''1'', Z.SEAT_NUM) ) ), 4, ''0'')
												 || LPAD(TO_CHAR(SUM(DECODE(Z.PSRM_CL_CD, ''2'', Z.SEAT_NUM) ) ), 4, ''0'')
											   FROM TB_YYDS511 Z
											  WHERE Z.RUN_DT = A.RUN_DT
												AND Z.TRN_NO = A.TRN_NO) AS SEAT_ALL_CNT
									  FROM TB_YYPD003 A
										  ,TB_YYDP503 B
									 WHERE B.RUN_DT =#RUN_DT#
									   AND (#TRN_NO# IS NULL OR B.TRN_NO = #TRN_NO#)
									   AND (#MRNT_CD# IS NULL OR B.MRNT_CD = #MRNT_CD#)
									   AND B.MRNT_CD IN (''01'',''03'',''04'')
									   AND (#ROUT_CD# IS NULL OR B.ROUT_CD = #ROUT_CD#)
									   AND (#UP_DN_DV_CD# = ''A'' OR B.UP_DN_DV_CD = #UP_DN_DV_CD#)
									   AND A.RUN_DT = B.RUN_DT
									   AND A.TRN_NO = B.TRN_NO
									   AND A.BKCL_CD = ''F1''
									 GROUP BY A.RUN_DT, A.TRN_NO) A1) C1
					 WHERE A1.YMGT_JOB_ID = B1.YMGT_JOB_ID
					   AND A1.RUN_DT = B1.RUN_DT
					   AND A1.TRN_NO = B1.TRN_NO
					   AND A1.RUN_DT = C1.RUN_DT
					   AND A1.TRN_NO = C1.TRN_NO) V
		   WHERE A.RUN_DT = V.RUN_DT
			 AND A.TRN_NO = V.TRN_NO
			 AND ROUND(ABS(V.AVG_ABRD_RT - V.FCST_ABRD_RT) 
						* V.AVG_ABRD_RT * 100 
						* (ABS(60 - (TO_DATE(A.RUN_DT, ''YYYYMMDD'') - TO_DATE(SUBSTR(YMGT_JOB_ID,10,8), ''YYYYMMDD''))) /60),0)
				 >=  NVL(TO_NUMBER(#RISK_IDX#),0)
		 ORDER BY RUN_DT, TRN_NO, YMS_APL_FLG DESC
]]>
', TO_DATE('04/17/2014 18:30:06', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.insertRsvSaleDmnTrnData', '/*com.korail.yz.ys.ab.YSAB001QMDAO.insertRsvSaleDmnTrnData*/ 
<![CDATA[
INSERT INTO TB_YYDD514 (  EXC_PGM_ID         /* 실행프로그램ID */
                        , EXC_SQNO           /* 실행일련번호  */
                        , RCV_PRS_STT_CD     /* 수신처리상태코드 */
                        , REG_USR_ID         /* 등록사용자ID */
                        , REG_DTTM)			 /* 등록일시 */
     VALUES (  ''W_YS15120''                   
             , #EXC_SQNO#                    /*신규 실행일련번호 */
             , ''1''
             , #USER_ID#                     /*접속 유저ID */
             , TO_CHAR (SYSDATE, ''YYYYMMDDHH24MMDD''))
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnDtlLst', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnDtlLst*/ 
<![CDATA[
  SELECT /*+ com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnDtlLst */
	     T1.RUN_DT
       , LPAD (TO_NUMBER (T1.TRN_NO), 5, '' '') TRN_NO
       , T1.TRN_NO TRN_NO_VAL
       , NVL (
            (SELECT VLID_VAL_NM
               FROM TB_YYDK007
              WHERE XROIS_OLD_SRT_CD = ''Y003'' AND VLID_VAL = T1.FCST_PRS_STT_CD),
            ''-'')
            FCST_PRS_STT_CD                                       /* 에측진행상태코드 */
       , NVL (
            (SELECT VLID_VAL_NM
               FROM TB_YYDK007
              WHERE XROIS_OLD_SRT_CD = ''Y004'' AND VLID_VAL = T1.OTMZ_PRS_STT_CD),
            ''-'')
            OTMZ_PRS_STT_CD                                     /* 최적화진행상태코드 */
       , NVL (
            (SELECT VLID_VAL_NM
               FROM TB_YYDK007
              WHERE     XROIS_OLD_SRT_CD = ''Y006''
                    AND VLID_VAL = T1.RSV_SALE_TNSM_STT_CD),
            ''-'')
            RSV_SALE_TNSM_STT_CD                                       /* 예발전송상태코드 */
       , (SELECT VLID_VAL_NM
            FROM TB_YYDK007
           WHERE     XROIS_OLD_SRT_CD = ''Y010''
                 AND VLID_VAL = NVL (T2.ALC_PRS_STT_CD, 1))
            YMGT_ALC_PRS_STT_CD                                 /* 수익관리할당처리상태코드 */
       , NVL (
            (SELECT VLID_VAL_NM
               FROM TB_YYDK007
              WHERE     XROIS_OLD_SRT_CD = ''Y007''
                    AND VLID_VAL = T1.RSV_SALE_REFL_STT_CD),
            ''-'')
       ,    RSV_SALE_REFL_STT_CD                                          /* 예발반영상태코드 */
    FROM (SELECT *
            FROM TB_YYFD011
           WHERE YMGT_JOB_ID = #YMGT_JOB_ID#) T1
       , TB_YYBB004 T2
   WHERE     T1.RUN_DT = T2.RUN_DT(+)
         AND T1.TRN_NO = T2.TRN_NO(+)
         AND (   (    DECODE (PSRM_CL_CD || BKCL_CD 
                           ,  ''1F1'', 1 
                           ,  ''1C1'', 2 
                           ,  ''1R1'', 3 
                           ,  ''1R2'', 4 
                           ,  ''1R3'', 5 
                           ,  ''2F1'', 6 
                           ,  ''2C1'', 7 
                           ,  ''2R1'', 8 
                           ,  ''2R2'', 9 
                           ,  ''2R3'', 10 
                           ,  0) =
                         (SELECT MIN (
                                    DECODE (PSRM_CL_CD || BKCL_CD
                                         ,  ''1F1'', 1
                                         ,  ''1C1'', 2
                                         ,  ''1R1'', 3
                                         ,  ''1R2'', 4
                                         ,  ''1R3'', 5
                                         ,  ''2F1'', 6
                                         ,  ''2C1'', 7
                                         ,  ''2R1'', 8
                                         ,  ''2R2'', 9
                                         ,  ''2R3'', 10
                                         ,  0))
                            FROM TB_YYBB004
                           WHERE RUN_DT = T2.RUN_DT AND TRN_NO = T2.TRN_NO)
                  AND PSRM_CL_CD IS NOT NULL)
              OR PSRM_CL_CD IS NULL)
ORDER BY T1.RUN_DT, T1.TRN_NO

]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnLst', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnLst*/ 
<![CDATA[
  SELECT /*+ com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnLst */
		 DISTINCT T1.YMGT_JOB_ID							/*수익관리작업ID*/
                , T2.TRVL_USR_NM							/*작업요청담당자*/
                , NVL (T1.JOB_DTTM, ''-'') JOB_DTTM		/*작업시작일시   */
                , ''검증미완료'' CHK_RST					
    FROM TB_YYFB009 T1									/*수익관리작업결과기본*/
	   , TB_YYBB007 T2									/*사용자기본*/
   WHERE     T1.REG_USR_ID = T2.TRVL_USR_ID
         AND T1.YMGT_JOB_ID LIKE ''B_YD%''
         AND SUBSTR (T1.YMGT_JOB_ID, 10, 8) = #JOB_DT#
ORDER BY T1.YMGT_JOB_ID DESC
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK301', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK301*/ 
<![CDATA[
 SELECT DECODE( COUNT(*), 0, ''Y'',''N'') CHK_RST
 FROM TB_YYFD011 A                          
 WHERE A.YMGT_JOB_ID = #YMGT_JOB_ID#
 AND   NOT EXISTS (SELECT 1 FROM TB_YYDK301 WHERE run_dt = A.run_dt AND trn_no = A.trn_no )
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK302', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK302*/ 
<![CDATA[
 SELECT DECODE( COUNT(*), 0, ''Y'',''N'') CHK_RST
 FROM TB_YYFD011 A                          
 WHERE A.YMGT_JOB_ID = #YMGT_JOB_ID#
 AND   NOT EXISTS (SELECT 1 FROM TB_YYDK302 WHERE run_dt = A.run_dt AND trn_no = A.trn_no )
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK303', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK303*/ 
<![CDATA[
 SELECT DECODE( COUNT(*), 0, ''Y'',''N'') CHK_RST
 FROM TB_YYFD011 A                          
 WHERE A.YMGT_JOB_ID = #YMGT_JOB_ID#
 AND   NOT EXISTS (SELECT 1 FROM TB_YYDK303 WHERE run_dt = A.run_dt AND trn_no = A.trn_no )
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK305', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK305*/ 
<![CDATA[
 SELECT DECODE( COUNT(*), 0, ''Y'',''N'') CHK_RST
 FROM TB_YYFD011 A                          
 WHERE A.YMGT_JOB_ID = #YMGT_JOB_ID#
 AND   NOT EXISTS (SELECT 1 FROM TB_YYDK305 WHERE run_dt = A.run_dt AND trn_no = A.trn_no )
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK306', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK306*/ 
<![CDATA[
 SELECT DECODE( COUNT(*), 0, ''Y'',''N'') CHK_RST
 FROM TB_YYFD011 A                          
 WHERE A.YMGT_JOB_ID = #YMGT_JOB_ID#
 AND   NOT EXISTS (SELECT 1 FROM TB_YYDK306 WHERE run_dt = A.run_dt AND trn_no = A.trn_no )
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK307', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK307*/ 
<![CDATA[
 SELECT DECODE( COUNT(*), 0, ''Y'',''Y'') CHK_RST  /* 2007.03.01 새마을 수익관리에 의해서 변경*/
 FROM TB_YYFD011 A                          
 WHERE A.YMGT_JOB_ID = #YMGT_JOB_ID#
 AND   NOT EXISTS (SELECT 1 FROM TB_YYDK307 WHERE run_dt = A.run_dt AND trn_no = A.trn_no )
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK308', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK308*/ 
<![CDATA[
 SELECT DECODE( COUNT(*), 0, ''Y'',''N'') CHK_RST
 FROM TB_YYFD011 A                          
 WHERE A.YMGT_JOB_ID = #YMGT_JOB_ID#
 AND   NOT EXISTS (SELECT 1 FROM TB_YYDK308 WHERE run_dt = A.run_dt AND trn_no = A.trn_no )
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK309', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK309*/ 
<![CDATA[
 SELECT DECODE( COUNT(*), 0, ''Y'',''N'') CHK_RST
 FROM TB_YYFD011 A                          
 WHERE A.YMGT_JOB_ID = #YMGT_JOB_ID#
 AND   NOT EXISTS (SELECT 1 FROM TB_YYDK309 WHERE run_dt = A.run_dt AND trn_no = A.trn_no )
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK328', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK328*/ 
<![CDATA[
 SELECT DECODE( COUNT(*), 0, ''Y'',''N'') CHK_RST
 FROM TB_YYFD011 A                          
 WHERE A.YMGT_JOB_ID = #YMGT_JOB_ID#
 AND   NOT EXISTS (SELECT 1 FROM TB_YYDK328 WHERE run_dt = A.run_dt AND trn_no = A.trn_no )
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnRcvPrsStt', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnRcvPrsStt*/ 
<![CDATA[
SELECT /*+ com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnRcvPrsStt*/
       RCV_PRS_STT_CD    /*수신처리상태코드   */
     , EXC_PGM_ID        /*실행프로그램ID     */
     , EXC_SQNO          /*실행일련번호       */
     , RS_DMN_MSG_CONT   /*예발요청메시지내용 */
  FROM TB_YYDD514        /*예발요청열차자료수신내역*/
 WHERE EXC_SQNO = (SELECT MAX (EXC_SQNO) FROM TB_YYDD514)
]]>', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnSqnoMax', '/*com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnSqnoMax*/ 
<![CDATA[
SELECT /*+ com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnSqnoMax */
		TO_CHAR( NVL(EXC_SQNO,''0'') + 1 ) AS EXC_SQNO /* 신규 일련번호 */
  FROM  (SELECT MAX(EXC_SQNO) EXC_SQNO
         FROM   TB_YYDD514)
]]>
', TO_DATE('04/11/2014 11:47:25', 'MM/DD/YYYY HH24:MI:SS'), 'hhan');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlYmgtFcstBsTrn', '/*com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlYmgtFcstBsTrn*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlYmgtFcstBsTrn */
               DISTINCT 
               LPAD(LTRIM(TRN_NO, ''0''), 5, '' '') AS TRN_NO     /* 열차번호   */
              ,APL_ST_DT                        AS APL_ST_DT  /* 적용시작일 */
              ,APL_CLS_DT                       AS APL_CLS_DT /* 적용종료일 */
          FROM TB_YYFD412 /* 기본사용자조정예상수요내역TBL */
         WHERE APL_ST_DT  <= #RUN_DT#
           AND APL_CLS_DT >= #RUN_DT#
           AND (#TRN_NO# IS NULL OR TRN_NO = LPAD(TRIM(#TRN_NO#), 5, ''0''))
         ORDER BY TRN_NO
]]>
', TO_DATE('04/17/2014 18:56:17', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
Insert into YZAPP.SQL_MAP
   (SQL_ID, SQL_VALUE, UPDATE_TIME, UPDATE_USER)
 Values
   ('com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlYmgtFcstBsTrnDtl', '/*com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlYmgtFcstBsTrnDtl*/ 
<![CDATA[
        SELECT /*+ com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlYmgtFcstBsTrnDtl */ 
               LPAD(LTRIM(A.TRN_NO, ''0''), 5, '' '')    AS TRN_NO          /* 열차번호   */
              ,A.DAY_DV_CD                           AS DAY_DV_CD       /* 요일구분   */
              ,A.PSRM_CL_CD                          AS PSRM_CL_CD      /* 객실등급   */
              ,A.DPT_RS_STN_CD                       AS DPT_RS_STN_CD   /* 출발역코드 */
              ,A.ARV_RS_STN_CD                       AS ARV_RS_STN_CD   /* 도착역코드 */
              ,( SELECT Y.KOR_STN_NM /* 한글역명      */
                   FROM TB_YYDK001 X /* 예발역코드TBL */
                       ,TB_YYDK102 Y /* 역코드이력TBL */
                  WHERE X.RS_STN_CD = A.DPT_RS_STN_CD
                    AND X.STN_CD = Y.STN_CD
                    AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT) 
                                                     AS DPT_STN_NM       /* 출발역명  */
              ,( SELECT Y.KOR_STN_NM /* 한글역명      */
                   FROM TB_YYDK001 X /* 예발역코드TBL */
                       ,TB_YYDK102 Y /* 역코드이력TBL */
                  WHERE X.RS_STN_CD = A.ARV_RS_STN_CD
                    AND X.STN_CD = Y.STN_CD
                    AND TO_CHAR(SYSDATE,''YYYYMMDD'') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                                                     AS ARV_STN_NM       /* 도착역명         */
              ,A.BKCL_CD                             AS BKCL_CD          /* BC코드           */
              ,( SELECT BKCL_DSC_CONT /* 부킹클래스설명내용 */
                   FROM TB_YYBB003    /* 부킹클래스기본TBL  */
                  WHERE BKCL_CD = A.BKCL_CD
                    AND APL_ST_DT <= #APL_ST_DT#
                    AND APL_CLS_DT >= #APL_CLS_DT# ) AS BKCL_NM     /* BC코드명         */
              ,A.USR_CTL_EXPN_DMD_NUM                                /* 사용자조정예상수요*/
              ,( SELECT TRVL_USR_NM
                   FROM TB_YYBB007
                  WHERE TRVL_USR_ID = A.CHG_USR_ID ) AS CHG_USR_NM    /* 변경자이름       */
              ,A.CHG_DTTM                            AS CHG_DTTM      /* 변경일시         */
          FROM TB_YYFD412 A           /* 기본사용자조정예상수요내역TBL */
         WHERE A.APL_ST_DT  = #APL_ST_DT#
           AND A.APL_CLS_DT = #APL_CLS_DT#
           AND A.TRN_NO     = LPAD(TRIM(#TRN_NO#), 5, ''0'')
           AND (#DAY_DV_CD# IN (''0'',''8'',''9'') OR A.DAY_DV_CD = #DAY_DV_CD#) /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
]]>
<isEqual property = "DAY_DV_CD" compareValue = "9">
           AND A.DAY_DV_CD IN (''3'', ''4'', ''5'', ''6'')	/* 평요일(화~금) */
</isEqual>
<![CDATA[
         ORDER BY A.PSRM_CL_CD
                 ,A.DAY_DV_CD
                 ,A.DPT_RS_STN_CD
                 ,A.ARV_RS_STN_CD
                 ,BKCL_NM
]]>
', TO_DATE('04/17/2014 18:56:17', 'MM/DD/YYYY HH24:MI:SS'), 'r2sirrah');
COMMIT;
