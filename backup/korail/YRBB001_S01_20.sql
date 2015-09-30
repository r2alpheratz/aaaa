		SELECT   /*전체 where절에서 dptStnCd, arvStnCd 삭제*/
				 MRNT_CD
		       , MN_RUN_LN_NM
		       , UP_DN_DV_CD
		       , UND_DV_NM
		       , RUN_DT
			   , RUN_DT_TXT
		       , TRN_NO
		       , DPT_NM
		       , ARV_NM
		       , DPT_TM
		       , PRNB1
		       , PRNB2
		       , ERR_RATE1
			   , ERR_RATE1_ORI
		       , PRNB3
		       , ERR_RATE2
			   , ERR_RATE2_ORI
		       , '' RMRK
		       , SEG_GP_NO
		FROM     (SELECT C.MRNT_CD
		               , (SELECT LN_NM
		                  FROM   TB_YYDK103
		                  WHERE  LN_CD IN(SELECT MRNT_CD
		                                  FROM   TB_YYDK201
		                                  WHERE  ROUT_DV_CD IN('10', '30')
		                                  AND    MRNT_CD IN ('01','03','04')
		                                  AND    ((EFC_ST_DT <= '20140101'
		                                           AND EFC_CLS_DT >= '20140131')
		                                          OR(EFC_ST_DT >= '20140101'
		                                             AND EFC_CLS_DT <= '20140131')))
		                  AND    APL_ST_DT <= TO_CHAR(SYSDATE, 'YYYYMMDD')
		                  AND    APL_CLS_DT >= TO_CHAR(SYSDATE, 'YYYYMMDD')
		                  AND    LN_CD = C.MRNT_CD) MN_RUN_LN_NM
		               , C.UP_DN_DV_CD
		               , (SELECT VLID_VAL_NM FROM TB_YYDK007 WHERE XROIS_OLD_SRT_CD = 'I103' AND VLID_VAL = C.UP_DN_DV_CD) UND_DV_NM
		               , T2.RUN_DT
		       		   , TO_CHAR(TO_DATE(T2.RUN_DT, 'YYYYMMDD'), 'YYYY.MM.DD')
		       			 || '('
		       			 || (SELECT SUBSTR(VLID_VAL_NM,1,1)
		           		 FROM TB_YYDK007
		           		 WHERE     XROIS_OLD_SRT_CD = 'I909'
		           		 AND VLID_VAL = (SELECT DAY_DV_CD
		                 	          FROM TB_YYDK002
		                    	      WHERE RUN_DT = T2.RUN_DT))
		       			 || ')' RUN_DT_TXT
		               , TO_NUMBER(T2.TRN_NO) TRN_NO
		               , A.RUN_ORDR DPT_RUN_ORDR
		               , B.RUN_ORDR ARV_RUN_ORDR
		               , (SELECT T2.KOR_STN_NM  FROM TB_YYDK001 T1, TB_YYDK102 T2 
		                   WHERE  T1.RS_STN_CD = A.STOP_RS_STN_CD AND T1.STN_CD  = T2.STN_CD 
		                     AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN T2.APL_ST_DT AND  T2.APL_CLS_DT) 
		                 || '(' || SUBSTR(A.DPT_TM, 1, 2) || ':' || SUBSTR(A.DPT_TM, 3, 2) || ')' AS DPT_NM
		               , (SELECT T2.KOR_STN_NM  FROM TB_YYDK001 T1, TB_YYDK102 T2 
		                   WHERE  T1.RS_STN_CD = B.STOP_RS_STN_CD AND T1.STN_CD  = T2.STN_CD 
		                     AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN T2.APL_ST_DT AND  T2.APL_CLS_DT) AS ARV_NM
		               , SUBSTR(A.DPT_TM, 1, 2) || ':' || SUBSTR(A.DPT_TM, 3, 2) || ':' || SUBSTR(A.DPT_TM, 5, 2) DPT_TM
		               , T2.PRNB1
		               , T2.PRNB2
		               , CASE WHEN T2.PRNB1 <= 9 THEN 0
		                      ELSE NVL( ROUND(ABS(100 - (T2.PRNB2 / T2.PRNB1) * 100), 0), 0)
		                 END  ERR_RATE1
		               , T2.PRNB3
		               , CASE WHEN T2.PRNB1 <= 9 THEN 0
		                      ELSE NVL( ROUND(ABS(100 - (T2.PRNB3 / T2.PRNB1) * 100), 0), 0)
		                 END  ERR_RATE2
		               , CASE WHEN T2.PRNB1 <= 9 THEN '-'
		                      ELSE TO_CHAR(ROUND(ABS(100 - (T2.PRNB2 / T2.PRNB1) * 100), 0))
		                 END  ERR_RATE1_ORI
		               , CASE WHEN T2.PRNB1 <= 9 THEN '-'
		                      ELSE TO_CHAR(ROUND(ABS(100 - (T2.PRNB3 / T2.PRNB1) * 100), 0))
		                 END  ERR_RATE2_ORI
		               , '0' SUM_FLAG
		               , D.SEG_GP_NO
		          FROM   TB_YYDK302 A
		               , TB_YYDK302 B
		               , TB_YYDP503 C
		               , TB_YYDK308 D
		               , (SELECT   T1.RUN_DT
		                         , T1.TRN_NO
		                         , T1.DPT_STN_CONS_ORDR
		                         , T1.ARV_STN_CONS_ORDR
		                         , SUM(DECODE(T1.FLAG, '1', PRNB, 0)) PRNB1
		                         , SUM(DECODE(T1.FLAG, '2', PRNB, 0)) PRNB2
		                         , SUM(DECODE(T1.FLAG, '3', PRNB, 0)) PRNB3
		                  FROM     (SELECT G.RUN_DT
		                                 , G.TRN_NO
		                                 , G.DPT_STN_CONS_ORDR
		                                 , G.ARV_STN_CONS_ORDR
		                                 , NVL(A.ABRD_PRNB, 0) PRNB
		                                 , '1' FLAG
		                            FROM   (SELECT   RUN_DT,
		                TRN_NO,
		                PSRM_CL_CD,
		                DECODE(BKCL_CD,'F2','F1',BKCL_CD) BKCL_CD,
		                DPT_STN_CONS_ORDR,
		                ARV_STN_CONS_ORDR,
		                SUM(ABRD_POSN_RT)   AS ABRD_POSN_RT,
		                SUM(ABRD_PRNB)      AS ABRD_PRNB,
		                SUM(SMG_ABRD_PRNB)  AS SMG_ABRD_PRNB,
		                SUM(CMTR_ABRD_PRNB) AS CMTR_ABRD_PRNB
		             FROM     TB_YYDS510
		             WHERE    RUN_DT BETWEEN '20140101' AND '20140131'
		             AND      TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		             AND      PSRM_CL_CD LIKE DECODE('', '', '%', '')
		             AND      BKCL_CD LIKE DECODE('' ,'', '%', '')
		             AND      SEAT_ATT_CD LIKE DECODE('', '', '%', '')
		             GROUP BY RUN_DT,
		                TRN_NO,
		                PSRM_CL_CD,
		                DECODE(BKCL_CD,'F2','F1',BKCL_CD),
		                DPT_STN_CONS_ORDR,
		                ARV_STN_CONS_ORDR) A
		                                 , (SELECT BB.RUN_DT
		                                         , BB.TRN_NO
		                                         , BB.DPT_STN_CONS_ORDR
		                                         , BB.ARV_STN_CONS_ORDR
		                                         , AA.BKCL_CD
		                                         , AA.PSRM_CL_CD
		                                    FROM   (SELECT   RUN_DT
		                                                   , TRN_NO
		                                                   , BKCL_CD
		                                                   , PSRM_CL_CD
		                                            FROM     TB_YYDD504
		                                            WHERE    RUN_DT BETWEEN '20140101' AND '20140131'
		                                            AND      TRN_NO = DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0'))
		                                            AND      PSRM_CL_CD LIKE DECODE('', '', '%', '')
		                                            AND      BKCL_CD LIKE DECODE('', '', '%', '')
		                                            AND      SEAT_ATT_CD LIKE DECODE('', '', '%', '')
		                                            GROUP BY RUN_DT
		                                                   , TRN_NO
		                                                   , BKCL_CD
		                                                   , PSRM_CL_CD) AA
		                                         , (SELECT /*+ INDEX ( D IX_YD330_02 )  */
		                                                   RUN_DT
		                                                 , TRN_NO
		                                                 , DPT_STN_CONS_ORDR
		                                                 , ARV_STN_CONS_ORDR
		                                            FROM   TB_YYDD505
		                                            WHERE  RUN_DT BETWEEN '20140101' AND '20140131'
		                                            AND    TRN_NO = DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0')) ) BB
		                                         , TB_YYDK301 ZZ
		                                    WHERE  AA.RUN_DT = BB.RUN_DT
		                                    AND    AA.TRN_NO = BB.TRN_NO
		                                    AND    AA.RUN_DT = ZZ.RUN_DT
		                                    AND    AA.TRN_NO = ZZ.TRN_NO
		                                    AND    ZZ.STLB_TRN_CLSF_CD LIKE DECODE('00', '', '%', '00')) G
		                            WHERE  A.RUN_DT(+) = G.RUN_DT
		                            AND    A.TRN_NO(+) = G.TRN_NO
		                            AND    A.DPT_STN_CONS_ORDR(+) = G.DPT_STN_CONS_ORDR
		                            AND    A.ARV_STN_CONS_ORDR(+) = G.ARV_STN_CONS_ORDR
		                            AND    A.PSRM_CL_CD(+) = G.PSRM_CL_CD
		                            AND    A.BKCL_CD(+) = G.BKCL_CD
		                            AND    A.RUN_DT BETWEEN '20140101' AND '20140131'
		                            AND    A.TRN_NO = DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0'))
		          UNION ALL
		                            SELECT G.RUN_DT
		                                 , G.TRN_NO
		                                 , G.DPT_STN_CONS_ORDR
		                                 , G.ARV_STN_CONS_ORDR
		                                 , NVL(A.USR_CTL_EXPN_DMD_NUM, 0)
		                                 , '2' FLAG
		                            FROM   TB_YYFD410 A
		                                 , (SELECT BB.RUN_DT
		                                         , BB.TRN_NO
		                                         , BB.DPT_STN_CONS_ORDR
		                                         , BB.ARV_STN_CONS_ORDR
		                                         , AA.BKCL_CD
		                                         , AA.PSRM_CL_CD
		                                    FROM   (SELECT   RUN_DT
		                                                   , TRN_NO
		                                                   , BKCL_CD
		                                                   , PSRM_CL_CD
		                                            FROM     TB_YYDD504
		                                            WHERE    RUN_DT BETWEEN '20140101' AND '20140131'
		                                            AND      TRN_NO = DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0'))
		                                            AND      PSRM_CL_CD LIKE DECODE('', '', '%', '')
		                                            AND      BKCL_CD LIKE DECODE('', '', '%', '')
		                                            AND      SEAT_ATT_CD LIKE DECODE('', '', '%', '')
		                                            GROUP BY RUN_DT
		                                                   , TRN_NO
		                                                   , BKCL_CD
		                                                   , PSRM_CL_CD) AA
		                                         , (SELECT /*+ INDEX ( D IX_YD330_02 )  */
		                                                   RUN_DT
		                                                 , TRN_NO
		                                                 , DPT_STN_CONS_ORDR
		                                                 , ARV_STN_CONS_ORDR
		                                            FROM   TB_YYDD505
		                                            WHERE  RUN_DT BETWEEN '20140101' AND '20140131'
		                                            AND    TRN_NO = DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0')) ) BB
		                                         , TB_YYDK301 ZZ
		                                    WHERE  AA.RUN_DT = BB.RUN_DT
		                                    AND    AA.TRN_NO = BB.TRN_NO
		                                    AND    AA.RUN_DT = ZZ.RUN_DT
		                                    AND    AA.TRN_NO = ZZ.TRN_NO
		                                    AND    ZZ.STLB_TRN_CLSF_CD LIKE DECODE('00', '', '%', '00')) G
		                            WHERE  A.RUN_DT(+) = G.RUN_DT
		                            AND    A.TRN_NO(+) = G.TRN_NO
		                            AND    A.DPT_STN_CONS_ORDR(+) = G.DPT_STN_CONS_ORDR
		                            AND    A.ARV_STN_CONS_ORDR(+) = G.ARV_STN_CONS_ORDR
		                            AND    A.PSRM_CL_CD(+) = G.PSRM_CL_CD
		                            AND    A.BKCL_CD(+) = G.BKCL_CD
		                            AND    A.YMGT_JOB_ID = (SELECT /*+ INDEX ( D IX_YZ930_01 )  */
		                                                          SUBSTR(MAX(SUBSTR(AA.REG_USR_ID, 1, 8) || AA.YMGT_JOB_ID), 7, 24)
		                                                   FROM   TB_YYFD011 AA
		                                                        , TB_YYFD010 BB
		                                                   WHERE  AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                                                   AND    BB.YMGT_PROC_DV_ID IN('YF540', 'YF940', 'YF950')
		                                                   AND    AA.FCST_PRS_STT_CD IN('11', '21')
		                                                   AND    AA.RUN_DT = A.RUN_DT
		                                                   AND    AA.TRN_NO = A.TRN_NO)
		                            AND    A.RUN_DT BETWEEN '20140101' AND '20140131'
		                            AND    A.TRN_NO = DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0'))
		                            UNION ALL
		                            SELECT G.RUN_DT
		                                 , G.TRN_NO
		                                 , G.DPT_STN_CONS_ORDR
		                                 , G.ARV_STN_CONS_ORDR
		                                 , NVL(A.ALC_NUM, 0)
		                                 , '3' FLAG
		                            FROM   TB_YYPD005 A
		                                 , (SELECT BB.RUN_DT
		                                         , BB.TRN_NO
		                                         , BB.DPT_STN_CONS_ORDR
		                                         , BB.ARV_STN_CONS_ORDR
		                                         , AA.BKCL_CD
		                                         , AA.PSRM_CL_CD
		                                    FROM   (SELECT   RUN_DT
		                                                   , TRN_NO
		                                                   , BKCL_CD
		                                                   , PSRM_CL_CD
		                                            FROM     TB_YYDD504
		                                            WHERE    RUN_DT BETWEEN '20140101' AND '20140131'
		                                            AND      TRN_NO = DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0'))
		                                            AND      PSRM_CL_CD LIKE DECODE('', '', '%', '')
		                                            AND      BKCL_CD LIKE DECODE('', '', '%', '')
		                                            AND      SEAT_ATT_CD LIKE DECODE('', '', '%', '')
		                                            GROUP BY RUN_DT
		                                                   , TRN_NO
		                                                   , BKCL_CD
		                                                   , PSRM_CL_CD) AA
		                                         , (SELECT /*+ INDEX ( D IX_YD330_02 )  */
		                                                   RUN_DT
		                                                 , TRN_NO
		                                                 , DPT_STN_CONS_ORDR
		                                                 , ARV_STN_CONS_ORDR
		                                            FROM   TB_YYDD505
		                                            WHERE  RUN_DT BETWEEN '20140101' AND '20140131'
		                                            AND    TRN_NO = DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0')) ) BB
		                                         , TB_YYDK301 ZZ
		                                    WHERE  AA.RUN_DT = BB.RUN_DT
		                                    AND    AA.TRN_NO = BB.TRN_NO
		                                    AND    AA.RUN_DT = ZZ.RUN_DT
		                                    AND    AA.TRN_NO = ZZ.TRN_NO
		                                    AND    ZZ.STLB_TRN_CLSF_CD LIKE DECODE('00', '', '%', '00')) G
		                            WHERE  A.RUN_DT(+) = G.RUN_DT
		                            AND    A.TRN_NO(+) = G.TRN_NO
		                            AND    A.DPT_STN_CONS_ORDR(+) = G.DPT_STN_CONS_ORDR
		                            AND    A.ARV_STN_CONS_ORDR(+) = G.ARV_STN_CONS_ORDR
		                            AND    A.PSRM_CL_CD(+) = G.PSRM_CL_CD
		                            AND    A.BKCL_CD(+) = G.BKCL_CD
		                            AND    A.YMGT_JOB_ID = (SELECT /*+ INDEX ( D IX_YZ930_01 )  */
		                                                          SUBSTR(MAX(SUBSTR(AA.REG_USR_ID, 1, 8) || AA.YMGT_JOB_ID), 7, 24)
		                                                   FROM   TB_YYFD011 AA
		                                                        , TB_YYFD010 BB
		                                                   WHERE  AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                                                   AND    BB.YMGT_PROC_DV_ID IN('YF540', 'YF940', 'YF950')
		                                                   AND    AA.FCST_PRS_STT_CD IN('11', '21')
		                                                   AND    AA.RUN_DT = A.RUN_DT
		                                                   AND    AA.TRN_NO = A.TRN_NO)
		                            AND    A.RUN_DT BETWEEN '20140101' AND '20140131'
		                            AND    A.TRN_NO = DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0')) ) T1
		                  GROUP BY T1.RUN_DT
		                         , T1.TRN_NO
		                         , T1.DPT_STN_CONS_ORDR
		                         , T1.ARV_STN_CONS_ORDR) T2
		          WHERE  T2.RUN_DT = A.RUN_DT
		          AND    T2.TRN_NO = A.TRN_NO
		          AND    T2.DPT_STN_CONS_ORDR = A.STN_CONS_ORDR
		          AND    T2.RUN_DT = B.RUN_DT
		          AND    T2.TRN_NO = B.TRN_NO
		          AND    T2.ARV_STN_CONS_ORDR = B.STN_CONS_ORDR
		          AND    T2.RUN_DT = C.RUN_DT
		          AND    T2.TRN_NO = C.TRN_NO
		          AND    C.MRNT_CD IN ('01','03','04')
		          AND    C.MRNT_CD LIKE DECODE('', '', '%', '')
		          AND    C.UP_DN_DV_CD LIKE DECODE('A', 'A', '%','A')
--		          AND    DECODE(T2.PRNB1, 0, 0, ROUND(ABS(100 - (T2.PRNB2 / T2.PRNB1) * 100), 0)) BETWEEN #ERR_RT_FROM# AND #ERR_RT_TO#
--		          AND    DECODE(T2.PRNB1, 0, 0, ROUND(ABS(100 - (T2.PRNB3 / T2.PRNB1) * 100), 0)) BETWEEN #ERR_RT_FROM# AND #ERR_RT_TO#
		          AND    T2.RUN_DT = D.RUN_DT
		          AND    T2.TRN_NO = D.TRN_NO
		          AND    A.TRVL_ZONE_NO = DECODE(C.UP_DN_DV_CD, 'D', D.DPT_ZONE_NO, D.ARV_ZONE_NO)
		          AND    B.TRVL_ZONE_NO = DECODE(C.UP_DN_DV_CD, 'D', D.ARV_ZONE_NO, D.DPT_ZONE_NO)
--		          AND    D.SEG_GP_NO BETWEEN TO_NUMBER(#SEG_GP_NO_FROM#) AND TO_NUMBER(#SEG_GP_NO_TO#)
)
		ORDER BY MRNT_CD
		       , RUN_DT
		       , TRN_NO
		       , SUM_FLAG
		       , SEG_GP_NO
		       , DPT_RUN_ORDR
		       , ARV_RUN_ORDR



튜닝 내용

  - 현재 응답속도 양호함. 
  
  - A.TRN_NO = DECODE(LPAD(  부분에 = 대신 LIKE 를 사용해야 하는 것이 아닌가 ?
  
  - 현재 사용중인 힌트는 의미가 없음 
  
  - TB_YYDK201 테이블이 있는 이유는 ?
     (AND    LN_CD = C.MRNT_CD 조건도 있고, AND    MRNT_CD IN ('01','03','04') 조건도 있음 ) 
  
