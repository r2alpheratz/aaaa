		SELECT RUN_DT
		      ,TRN_NO
		      ,PSRM_CL_CD
		      ,ZONE_SEG_GP_NO
		      ,DPT_ARV
		      ,GP_BKCL_FST_ALC_NUM
		      ,ALC_CNT
		      ,ALL_CNT
		      ,EXPCT_DMD
		      ,DECODE ('F1', 'F1', BS_SEAT_NUM, '') BS_SEAT_NUM
		      ,DECODE ('F1', 'F1', NOTY_SALE_SEAT_NUM, '') NOTY_SALE_SEAT_CNT
		      ,DECODE ('F1', 'F1', MAX_ALL_CNT - PSRM_CL_CD_SUM_ALC_CNT, '') REMAIN
		      ,FCST_ACHV_DT
		      ,DECODE ('F1', 'F1', DECODE(ALL_CNT,  0, '0%',  NULL, '-',  TO_CHAR(ROUND (ALL_CNT / MAX_ALL_CNT, 4) * 100 , '999.99')), '') PER
		      ,DPT_TM
		      ,RUN_INFO
		  FROM (SELECT T1.RUN_DT RUN_DT
		              ,TO_NUMBER(T1.TRN_NO) TRN_NO
		              , (SELECT VLID_VAL_NM
		                   FROM TB_YYDK007
		                  WHERE XROIS_OLD_SRT_CD = 'R408'
		                    AND VLID_VAL = T1.PSRM_CL_CD)
		                   PSRM_CL_NM
					  ,T1.PSRM_CL_CD PSRM_CL_CD
		              ,T1.ZONE_SEG_GP_NO
		              ,T1.DPT_ARV
		              , (SELECT B.DPT_TM
		                   FROM TB_YYDK301 A, TB_YYDK302 B
		                  WHERE A.RUN_DT = T1.RUN_DT
		                    AND A.TRN_NO = T1.TRN_NO
		                    AND A.RUN_DT = B.RUN_DT
		                    AND A.TRN_NO = B.TRN_NO
		                    AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD)
		                   DPT_TM
		              , (SELECT    (SELECT T2.KOR_STN_NM
		                              FROM TB_YYDK001 T1, TB_YYDK102 T2
		                             WHERE T1.RS_STN_CD = A.ORG_RS_STN_CD
		                               AND T1.STN_CD = T2.STN_CD
		                               AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
		                        || '-'
		                        || (SELECT T2.KOR_STN_NM
		                              FROM TB_YYDK001 T1, TB_YYDK102 T2
		                             WHERE T1.RS_STN_CD = A.TMN_RS_STN_CD
		                               AND T1.STN_CD = T2.STN_CD
		                               AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
		                        || '('
		                        || TO_CHAR (TO_DATE (B.DPT_TM, 'HH24MISS'), 'HH24:MI')
		                        || '-'
		                        || TO_CHAR (TO_DATE (C.ARV_TM, 'HH24MISS'), 'HH24:MI')
		                        || ')'
		                   FROM TB_YYDK301 A, TB_YYDK302 B, TB_YYDK302 C
		                  WHERE A.RUN_DT = T1.RUN_DT
		                    AND A.TRN_NO = T1.TRN_NO
		                    AND A.RUN_DT = B.RUN_DT
		                    AND A.TRN_NO = B.TRN_NO
		                    AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD
		                    AND A.RUN_DT = C.RUN_DT
		                    AND A.TRN_NO = C.TRN_NO
		                    AND A.TMN_RS_STN_CD = C.STOP_RS_STN_CD)
		                   RUN_INFO
		              ,DECODE (T1.GP_BKCL_FST_ALC_NUM, 999, 0, T1.GP_BKCL_FST_ALC_NUM) GP_BKCL_FST_ALC_NUM
		              ,T1.ALC_CNT
		              ,T1.ALL_CNT
		              , (SELECT SUM (A.USR_CTL_EXPN_DMD_NUM)
		                   FROM TB_YYFD410 A
		                       ,TB_YYDK302 B
		                       ,TB_YYDK302 C
		                       ,TB_YYDK308 D
		                       ,TB_YYDK301 E
		                       ,TB_YYDK201 Z
		                  WHERE A.YMGT_JOB_ID = (SELECT MAX (AA.YMGT_JOB_ID)
		                                           FROM TB_YYFD011 AA, TB_YYFD010 BB
		                                          WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                                            AND BB.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                                            AND AA.RUN_DT = A.RUN_DT
		                                            AND AA.TRN_NO = A.TRN_NO
		                                            AND AA.OTMZ_PRS_STT_CD = '11'
		                                            AND AA.REG_DTTM >= '20140218'
		                                            AND AA.REG_DTTM < TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') + 1, 'YYYYMMDD'))
		                    AND A.RUN_DT >= '20140218'
		                    AND A.TRN_NO = DECODE ('', NULL, E.TRN_NO, LPAD(TRIM(''), 5, '0'))
		                    AND A.BKCL_CD = 'F1'
		                    AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
		                    AND A.RUN_DT = E.RUN_DT
		                    AND A.TRN_NO = E.TRN_NO
		                    AND Z.MRNT_CD = DECODE ('', NULL, Z.MRNT_CD, '')
		                    AND E.ROUT_CD = DECODE ('', NULL, E.ROUT_CD, '')
		                    AND E.ROUT_CD = Z.ROUT_CD
		                    AND E.UP_DN_DV_CD = DECODE ('A', 'A', E.UP_DN_DV_CD, 'A')
		                    AND A.RUN_DT = B.RUN_DT
		                    AND A.TRN_NO = B.TRN_NO
		                    AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
		                    AND A.RUN_DT = C.RUN_DT
		                    AND A.TRN_NO = C.TRN_NO
		                    AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
		                    AND A.RUN_DT = D.RUN_DT
		                    AND A.TRN_NO = D.TRN_NO
		                    AND B.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', D.DPT_ZONE_NO, D.ARV_ZONE_NO)
		                    AND C.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', D.ARV_ZONE_NO, D.DPT_ZONE_NO)
		                    AND A.RUN_DT = T1.RUN_DT
		                    AND A.TRN_NO = T1.TRN_NO
		                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD
		                    AND D.SEG_GP_NO = T1.ZONE_SEG_GP_NO)
		                   EXPCT_DMD
		              , (SELECT SUM (DECODE ('F1', 'F1', A.GP_MRK_ALLW_NUM, A.BKCL_MRK_ALLW_NUM))
		                   FROM TB_YYPD006 A, TB_YYDK301 B, TB_YYDK201 C
		                  WHERE A.YMGT_JOB_ID = (SELECT MAX (AA.YMGT_JOB_ID)
		                                           FROM TB_YYFD011 AA, TB_YYFD010 BB
		                                          WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                                            AND BB.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                                            AND AA.RUN_DT = A.RUN_DT
		                                            AND AA.TRN_NO = A.TRN_NO
		                                            AND AA.OTMZ_PRS_STT_CD = '11'
		                                            AND AA.REG_DTTM >= '20140218'
		                                            AND AA.REG_DTTM < TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') + 1, 'YYYYMMDD'))
		                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15 /* 좌석속성코드가 일반좌석 */
		                    AND A.ZONE_SEG_GP_NO = (SELECT MIN (ZONE_SEG_GP_NO)
		                                         FROM TB_YYPD006
		                                        WHERE RUN_DT = A.RUN_DT
		                                          AND TRN_NO = A.TRN_NO
		                                          AND PSRM_CL_CD = A.PSRM_CL_CD)
		                    AND A.RUN_DT >= '20140218'
		                    AND A.TRN_NO = DECODE ('', NULL, A.TRN_NO, LPAD(TRIM(''), 5, '0'))
		                    AND A.BKCL_CD = 'F1'
		                    AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
		                    AND A.RUN_DT = B.RUN_DT
		                    AND A.TRN_NO = B.TRN_NO
		                    AND C.MRNT_CD = DECODE ('', NULL, C.MRNT_CD, '')
		                    AND B.ROUT_CD = DECODE ('', NULL, B.ROUT_CD, '')
		                    AND B.ROUT_CD = C.ROUT_CD
		                    AND B.UP_DN_DV_CD = DECODE ('A', 'A', B.UP_DN_DV_CD, 'A')
		                    AND A.RUN_DT = T1.RUN_DT
		                    AND A.TRN_NO = T1.TRN_NO
		                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD)
		                   MAX_ALL_CNT
		              , (SELECT SUM (DECODE ('F1', 'F1', A.GP_ALC_NUM, A.BKCL_ALC_NUM))
		                   FROM TB_YYPD006 A, TB_YYDK301 B, TB_YYDK201 C
		                  WHERE A.YMGT_JOB_ID = (SELECT MAX (AA.YMGT_JOB_ID)
		                                           FROM TB_YYFD011 AA, TB_YYFD010 BB
		                                          WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                                            AND BB.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                                            AND AA.RUN_DT = A.RUN_DT
		                                            AND AA.TRN_NO = A.TRN_NO
		                                            AND AA.OTMZ_PRS_STT_CD = '11'
		                                            AND AA.REG_DTTM >= '20140218'
		                                            AND AA.REG_DTTM < TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') + 1, 'YYYYMMDD'))
		                    AND A.RUN_DT >= '20140218'
		                    AND A.TRN_NO = DECODE ('', NULL, A.TRN_NO, LPAD(TRIM(''), 5, '0'))
		                    AND A.BKCL_CD = 'F1'
		                    AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
		                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15 /* 좌석속성코드가 일반좌석 */
		                    AND A.RUN_DT = B.RUN_DT
		                    AND A.TRN_NO = B.TRN_NO
		                    AND C.MRNT_CD = DECODE ('', NULL, C.MRNT_CD, '')
		                    AND B.ROUT_CD = DECODE ('', NULL, B.ROUT_CD, '')
		                    AND B.ROUT_CD = C.ROUT_CD
		                    AND B.UP_DN_DV_CD = DECODE ('A', 'A', B.UP_DN_DV_CD, 'A')
		                    AND A.RUN_DT = T1.RUN_DT
		                    AND A.TRN_NO = T1.TRN_NO
		                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD)
		                   PSRM_CL_CD_SUM_ALC_CNT
		              , (SELECT DISTINCT SUBSTR(B.JOB_DTTM, 1, 8)
		                   FROM TB_YYPD006 A
		                       ,TB_YYFD010 B
		                       ,TB_YYDK301 C
		                       ,TB_YYDK201 D
		                  WHERE A.YMGT_JOB_ID = (SELECT MAX (AA.YMGT_JOB_ID)
		                                           FROM TB_YYFD011 AA, TB_YYFD010 BB
		                                          WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                                            AND BB.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                                            AND AA.RUN_DT = A.RUN_DT
		                                            AND AA.TRN_NO = A.TRN_NO
		                                            AND AA.OTMZ_PRS_STT_CD = '11'
		                                            AND AA.REG_DTTM >= '20140218'
		                                            AND AA.REG_DTTM < TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') + 1, 'YYYYMMDD'))
		                    AND A.RUN_DT >= '20140218'
		                    AND A.TRN_NO = DECODE ('', NULL, A.TRN_NO, LPAD(TRIM(''), 5, '0'))
		                    AND A.BKCL_CD = 'F1'
		                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15
		                    AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
		                    AND A.YMGT_JOB_ID = B.YMGT_JOB_ID
		                    AND B.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                    AND A.RUN_DT = C.RUN_DT
		                    AND A.TRN_NO = C.TRN_NO
		                    AND D.MRNT_CD = DECODE ('', NULL, D.MRNT_CD, '')
		                    AND C.ROUT_CD = DECODE ('', NULL, C.ROUT_CD, '')
		                    AND C.ROUT_CD = D.ROUT_CD
		                    AND C.UP_DN_DV_CD = DECODE ('A', 'A', C.UP_DN_DV_CD, 'A')
		                    AND A.RUN_DT = T1.RUN_DT
		                    AND A.TRN_NO = T1.TRN_NO)
		                   FCST_ACHV_DT
		              , (SELECT DISTINCT A.BS_SEAT_NUM
		                   FROM TB_YYDK305 A
		                  WHERE A.RUN_DT = T1.RUN_DT
		                    AND A.TRN_NO = T1.TRN_NO
		                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD
		                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15)
		                   BS_SEAT_NUM
		              , (SELECT DISTINCT A.NOTY_SALE_SEAT_NUM
		                   FROM TB_YYDK305 A
		                  WHERE A.RUN_DT = T1.RUN_DT
		                    AND A.TRN_NO = T1.TRN_NO
		                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD
		                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15)
		                   NOTY_SALE_SEAT_NUM
		          FROM (  SELECT A.RUN_DT
		                        ,A.TRN_NO
		                        ,A.PSRM_CL_CD
		                        ,A.ZONE_SEG_GP_NO
		                        ,E.UP_DN_DV_CD
		                        ,C.STOP_RS_STN_CD STOP_1
		                        ,D.STOP_RS_STN_CD STOP_2
		                        ,C.RUN_ORDR
		                        ,D.RUN_ORDR
		                        ,DECODE
		                         (
		                             E.UP_DN_DV_CD
		                            ,'D',    (SELECT T2.KOR_STN_NM
		                                        FROM TB_YYDK001 T1, TB_YYDK102 T2
		                                       WHERE T1.RS_STN_CD = C.STOP_RS_STN_CD
		                                         AND T1.STN_CD = T2.STN_CD
		                                         AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
		                                  || '-'
		                                  || (SELECT T2.KOR_STN_NM
		                                        FROM TB_YYDK001 T1, TB_YYDK102 T2
		                                       WHERE T1.RS_STN_CD = D.STOP_RS_STN_CD
		                                         AND T1.STN_CD = T2.STN_CD
		                                         AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
		                            ,   (SELECT T2.KOR_STN_NM
		                                   FROM TB_YYDK001 T1, TB_YYDK102 T2
		                                  WHERE T1.RS_STN_CD = D.STOP_RS_STN_CD
		                                    AND T1.STN_CD = T2.STN_CD
		                                    AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
		                             || '-'
		                             || (SELECT T2.KOR_STN_NM
		                                   FROM TB_YYDK001 T1, TB_YYDK102 T2
		                                  WHERE T1.RS_STN_CD = C.STOP_RS_STN_CD
		                                    AND T1.STN_CD = T2.STN_CD
		                                    AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
		                         )
		                             DPT_ARV
		                        ,SUM (DECODE ('F1', 'F1', A.GP_ALC_NUM, A.BKCL_ALC_NUM)) ALC_CNT
		                        ,CASE
		                             WHEN ( (G.VLID_ST_DNO IS NULL)
		                                OR (TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (TO_CHAR (SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') > G.VLID_CLS_DNO))
		                             THEN
		                                 NVL (A.GP_BKCL_FST_ALC_NUM, 0)
		                             ELSE
		                                 NVL (F.GP_FST_ALC_SEAT_NUM, 0)
		                         END
		                             AS GP_BKCL_FST_ALC_NUM
		                        ,SUM (DECODE ('F1', 'F1', A.GP_MRK_ALLW_NUM, A.BKCL_MRK_ALLW_NUM)) ALL_CNT
		                    FROM TB_YYPD006 A
		                        ,TB_YYDK308 B
		                        ,TB_YYDK302 C
		                        ,TB_YYDK302 D
		                        ,TB_YYDK301 E
		                        ,TB_YYDK201 Z
		                        ,TB_YYDK328 F
		                        ,TB_YYBB003 G
		                        ,TB_YYFD010 H
		                   WHERE A.YMGT_JOB_ID = (SELECT MAX (AA.YMGT_JOB_ID)
		                                            FROM TB_YYFD011 AA, TB_YYFD010 BB
		                                           WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                                             AND BB.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                                             AND AA.RUN_DT = A.RUN_DT
		                                             AND AA.TRN_NO = A.TRN_NO
		                                             AND AA.OTMZ_PRS_STT_CD = '11'
		                                             AND AA.REG_DTTM >= '20140218'
		                                             AND AA.REG_DTTM < TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') + 1, 'YYYYMMDD'))
		                     AND A.RUN_DT >= '20140218'
		                     AND A.TRN_NO = DECODE ('', NULL, A.TRN_NO, LPAD(TRIM(''), 5, '0'))
		                     AND A.BKCL_CD = 'F1'
		                     AND TO_NUMBER(A.SEAT_ATT_CD) = 15
		                     AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
		                     AND (A.GP_MRK_ALLW_NUM IS NOT NULL
		                       OR A.BKCL_MRK_ALLW_NUM IS NOT NULL)
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
		                     AND Z.MRNT_CD = DECODE ('', NULL, Z.MRNT_CD, '')
		                     AND E.ROUT_CD = DECODE ('', NULL, E.ROUT_CD, '')
		                     AND E.ROUT_CD = Z.ROUT_CD
		                     AND E.UP_DN_DV_CD = DECODE ('A', 'A', E.UP_DN_DV_CD, 'A')
		                     AND C.STOP_RS_STN_CD <> D.STOP_RS_STN_CD
		                     AND C.RUN_ORDR < DECODE (E.UP_DN_DV_CD,  'D', D.RUN_ORDR,  'U', 100)
		                     AND D.RUN_ORDR > DECODE
		                                      (
		                                          E.UP_DN_DV_CD
		                                         ,'D', C.RUN_ORDR
		                                         ,'U'
												,0
		                                      )
		                     AND C.RUN_ORDR > DECODE (E.UP_DN_DV_CD,  'D', 0,  'U', D.RUN_ORDR)
		                     AND F.RUN_DT = A.RUN_DT
		                     AND F.TRN_NO = A.TRN_NO
		                     AND SUBSTR(F.REST_SEAT_MG_ID, 14, 1) = A.PSRM_CL_CD
							 AND TO_NUMBER(SUBSTR(F.REST_SEAT_MG_ID, 15, 3)) = TO_NUMBER(A.SEAT_ATT_CD)
		                     AND A.ZONE_SEG_GP_NO = F.SEG_GP_NO
		                     AND A.RUN_DT BETWEEN G.APL_ST_DT AND G.APL_CLS_DT
		                     AND F.RUN_DT BETWEEN G.APL_ST_DT AND G.APL_CLS_DT
		                     AND A.YMGT_JOB_ID = H.YMGT_JOB_ID
		                     AND H.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                     AND F.DEAL_DT = (SELECT MAX (DEAL_DT)
		                                        FROM TB_YYDK328
		                                       WHERE RUN_DT = A.RUN_DT
		                                         AND TRN_NO = A.TRN_NO)
		                     AND SUBSTR(F.REST_SEAT_MG_ID, 15, 3 ) = '015'
		                     AND SUBSTR(F.REST_SEAT_MG_ID, 15, 3 ) = '015'
		                     AND G.BKCL_CD = A.BKCL_CD
		                GROUP BY A.RUN_DT
		                        ,A.TRN_NO
		                        ,A.PSRM_CL_CD
		                        ,A.ZONE_SEG_GP_NO
		                        ,E.UP_DN_DV_CD
		                        ,C.STOP_RS_STN_CD
		                        ,D.STOP_RS_STN_CD
		                        ,C.RUN_ORDR
		                        ,D.RUN_ORDR
		                        ,A.GP_BKCL_FST_ALC_NUM
		                        ,F.GP_FST_ALC_SEAT_NUM
		                        ,G.VLID_ST_DNO
		                        ,G.VLID_CLS_DNO
		                ORDER BY A.RUN_DT
		                        ,A.TRN_NO
		                        ,A.PSRM_CL_CD
		                        ,A.ZONE_SEG_GP_NO
		                        ,E.UP_DN_DV_CD
		                        ,DECODE (E.UP_DN_DV_CD,  'D', C.RUN_ORDR,  'U', D.RUN_ORDR)
		                        ,DECODE (E.UP_DN_DV_CD,  'D', D.RUN_ORDR,  'U', C.RUN_ORDR) DESC) T1) TMP
		                        
		                        

현재 인덱스 
YZDBA                TB_YYDK328                     PK_YYDK328                       12647639  => RUN_DT,TRN_NO,REST_SEAT_MG_ID,SEG_GP_NO,DEAL_DT		                        


튜닝 내용
  - YPAA001_S01_17 와 동일함 

  - sub query 부분에 AND A.ZONE_SEG_GP_NO = SEG_GP_NO  조건을 추가 해야 하는 것이 아닌지 확인 바람.
    조건을 추가 하지 않아야 한다면 
    TB_YYDK328 테이블의 인덱스를 RUN_DT,TRN_NO,DEAL_DT ,  SEG_GP_NO,REST_SEAT_MG_ID   순서로 해야 함. 
