		SELECT /*+com.korail.yz.yp.ab.YPAB002QMDAO.selectListODAlcRun*/
		      T1.RUN_DT
		      ,TO_NUMBER (T1.TRN_NO) TRN_NO
		      ,T1.RUN_DT RUN_DT_VAL
		      , (SELECT B.DPT_TM
		           FROM TB_YYDK301 A, TB_YYDK302 B
		          WHERE A.RUN_DT = T1.RUN_DT
		            AND A.TRN_NO = T1.TRN_NO
		            AND A.RUN_DT = B.RUN_DT
		            AND A.TRN_NO = B.TRN_NO
		            AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD)
		           DPT_TM
		      , (SELECT F.KOR_STN_NM || '-' || G.KOR_STN_NM || '(' || TO_CHAR (TO_DATE (B.DPT_TM, 'hh24miss'), 'hh24:mi') || '-' || TO_CHAR (TO_DATE (C.ARV_TM, 'hh24miss'), 'hh24:mi') || ')'
		           FROM TB_YYDK301 A
		               ,TB_YYDK302 B
		               ,TB_YYDK302 C
		               ,TB_YYDK001 F
		               ,TB_YYDK001 G
		          WHERE A.RUN_DT = T1.RUN_DT
		            AND A.TRN_NO = T1.TRN_NO
		            AND A.RUN_DT = B.RUN_DT
		            AND A.TRN_NO = B.TRN_NO
		            AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD
		            AND A.ORG_RS_STN_CD = F.RS_STN_CD
		            AND A.RUN_DT = C.RUN_DT
		            AND A.TRN_NO = C.TRN_NO
		            AND A.TMN_RS_STN_CD = C.STOP_RS_STN_CD
		            AND A.TMN_RS_STN_CD = G.RS_STN_CD)
		           RUN_INFO
		      ,T1.PSRM_CL_CD
		      ,T1.DPT_STN
		      ,T1.ARV_STN
		      ,T1.DPT_RS_STN_CD
		      ,T1.ARV_RS_STN_CD
		      ,T1.ALC_NUM_SUM
		      ,T1.EXPCT_DMD
		      ,T1.FCST_ACHV_DT
		      ,T1.UP_DN_DV_CD
		      ,T1.ROUT_CD
		      ,T1.MRNT_CD
		  FROM (  SELECT /*+RULE*/
		                A.RUN_DT
		                ,A.TRN_NO
		                ,A.PSRM_CL_CD
		                ,A.DPT_STN_CONS_ORDR
		                ,A.ARV_STN_CONS_ORDR
		                ,F.KOR_STN_NM DPT_STN
		                ,G.KOR_STN_NM ARV_STN
		                ,B.STOP_RS_STN_CD DPT_RS_STN_CD
		                ,C.STOP_RS_STN_CD ARV_RS_STN_CD
		                ,D.UP_DN_DV_CD
		                ,D.ROUT_CD
		                ,E.MRNT_CD
		                ,SUM (A.ALC_NUM) ALC_NUM_SUM
		                , (SELECT SUM (AA.LAST_ABRD_EXPN_DMD_NUM)
		                     FROM TB_YYFD410 AA, TB_YYDK301 BB, TB_YYDK201 CC
		                    WHERE BB.RUN_DT BETWEEN '20130601' AND '20140601'
		                      AND BB.TRN_NO = LPAD (TRIM ('101'), 5, '0')
		                      AND BB.STLB_TRN_CLSF_CD = '00'
		                      AND CC.MRNT_CD = DECODE ('', '', CC.MRNT_CD, '')
		                      AND BB.ROUT_CD = DECODE ('', '', BB.ROUT_CD, '')
		                      AND BB.ROUT_CD = CC.ROUT_CD
		                      AND BB.UP_DN_DV_CD = DECODE ('A', 'A', BB.UP_DN_DV_CD, 'A')
		                      AND AA.YMGT_JOB_ID = (SELECT SUBSTR (MAX (SUBSTR (AAA.REG_DTTM, 1, 8) || AAA.YMGT_JOB_ID), 9, 32)
		                                              FROM TB_YYFD011 AAA, TB_YYFD010 BBB
		                                             WHERE AAA.YMGT_JOB_ID = BBB.YMGT_JOB_ID
		                                               AND BBB.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                                               AND AAA.OTMZ_PRS_STT_CD = '11'
		                                               AND AAA.RUN_DT = A.RUN_DT
		                                               AND AAA.TRN_NO = A.TRN_NO)
		                      AND BB.RUN_DT = AA.RUN_DT
		                      AND BB.TRN_NO = AA.TRN_NO
		                      AND AA.PSRM_CL_CD = DECODE ('', '', AA.PSRM_CL_CD, '')
		                      AND AA.BKCL_CD = DECODE ('F1', '', AA.BKCL_CD, 'F1')
		                      AND AA.RUN_DT = A.RUN_DT
		                      AND AA.TRN_NO = A.TRN_NO
		                      AND AA.PSRM_CL_CD = A.PSRM_CL_CD
		                      AND AA.DPT_STN_CONS_ORDR = A.DPT_STN_CONS_ORDR
		                      AND AA.ARV_STN_CONS_ORDR = A.ARV_STN_CONS_ORDR)
		                     EXPCT_DMD
		                , (SELECT DISTINCT SUBSTR (BB.YMGT_JOB_ID, 14, 8)
		                     FROM TB_YYPD005 AA
		                         ,TB_YYFD010 BB
		                         ,TB_YYDK301 CC
		                         ,TB_YYDK201 DD
		                    WHERE CC.RUN_DT BETWEEN '20130601' AND '20140601'
		                      AND CC.TRN_NO = LPAD (TRIM ('101'), 5, '0')
		                      AND CC.STLB_TRN_CLSF_CD = '00'
		                      AND CC.ROUT_CD = DECODE ('', '', CC.ROUT_CD, '')
		                      AND DD.MRNT_CD = DECODE ('', '', DD.MRNT_CD, '')
		                      AND CC.ROUT_CD = DD.ROUT_CD
		                      AND CC.UP_DN_DV_CD = DECODE ('A', 'A', CC.UP_DN_DV_CD, 'A')
		                      AND AA.YMGT_JOB_ID = (SELECT SUBSTR (MAX (SUBSTR (AAA.REG_DTTM, 1, 8) || AAA.YMGT_JOB_ID), 9, 32)
		                                              FROM TB_YYFD011 AAA, TB_YYFD010 BBB
		                                             WHERE AAA.YMGT_JOB_ID = BBB.YMGT_JOB_ID
		                                               AND BBB.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                                               AND AAA.OTMZ_PRS_STT_CD = '11'
		                                               AND AAA.RUN_DT = A.RUN_DT
		                                               AND AAA.TRN_NO = A.TRN_NO)
		                      AND CC.RUN_DT = AA.RUN_DT
		                      AND CC.TRN_NO = AA.TRN_NO
		                      AND AA.PSRM_CL_CD = DECODE ('', '', AA.PSRM_CL_CD, '')
		                      AND AA.BKCL_CD = DECODE ('F1', '', AA.BKCL_CD, 'F1')
		                      AND AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                      AND BB.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                      AND AA.RUN_DT = A.RUN_DT
		                      AND AA.TRN_NO = A.TRN_NO)
		                     FCST_ACHV_DT
		            FROM TB_YYPD005 A
		                ,TB_YYDK302 B
		                ,TB_YYDK302 C
		                ,TB_YYDK301 D
		                ,TB_YYDK201 E
		                ,TB_YYDK001 F
		                ,TB_YYDK001 G
		                ,TB_YYBB003 H
		           WHERE D.RUN_DT BETWEEN '20130601' AND '20140601'
		             AND D.TRN_NO = LPAD (TRIM ('101'), 5, '0')
		             AND D.STLB_TRN_CLSF_CD = '00'
		             AND D.ROUT_CD = DECODE ('', '', D.ROUT_CD, '')
		             AND E.MRNT_CD = DECODE ('', '', E.MRNT_CD, '')
		             AND D.ROUT_CD = E.ROUT_CD
		             AND D.UP_DN_DV_CD = DECODE ('A', 'A', D.UP_DN_DV_CD, 'A')
		             AND A.YMGT_JOB_ID = (SELECT SUBSTR (MAX (SUBSTR (AAA.REG_DTTM, 1, 8) || AAA.YMGT_JOB_ID), 9, 32)
		                                    FROM TB_YYFD011 AAA, TB_YYFD010 BBB
		                                   WHERE AAA.YMGT_JOB_ID = BBB.YMGT_JOB_ID
		                                     AND BBB.YMGT_PROC_DV_ID IN ('YP620', 'YP625')
		                                     AND AAA.OTMZ_PRS_STT_CD = '11'
		                                     AND AAA.RUN_DT = A.RUN_DT
		                                     AND AAA.TRN_NO = A.TRN_NO)
		             AND D.RUN_DT = A.RUN_DT
		             AND D.TRN_NO = A.TRN_NO
		             AND A.PSRM_CL_CD = DECODE ('', '', A.PSRM_CL_CD, '')
		             AND A.BKCL_CD = DECODE ('F1', '', A.BKCL_CD, 'F1')
		             AND A.RUN_DT = B.RUN_DT
		             AND A.TRN_NO = B.TRN_NO
		             AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
		             AND A.RUN_DT = C.RUN_DT
		             AND A.TRN_NO = C.TRN_NO
		             AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
		             AND F.RS_STN_CD = B.STOP_RS_STN_CD
		             AND G.RS_STN_CD = C.STOP_RS_STN_CD
		             AND H.BKCL_USE_FLG = 'Y'
		             AND H.BKCL_CD = A.BKCL_CD
		             AND '20130601' >= H.APL_ST_DT
		             AND '20140601' <= H.APL_CLS_DT
		        GROUP BY A.RUN_DT
		                ,A.TRN_NO
		                ,A.PSRM_CL_CD
		                ,A.DPT_STN_CONS_ORDR
		                ,A.ARV_STN_CONS_ORDR
		                ,F.KOR_STN_NM
		                ,G.KOR_STN_NM
		                ,B.STOP_RS_STN_CD
		                ,C.STOP_RS_STN_CD
		                ,D.UP_DN_DV_CD
		                ,D.ROUT_CD
		                ,E.MRNT_CD
		        ORDER BY A.RUN_DT
		                ,A.TRN_NO
		                ,A.PSRM_CL_CD
		                ,A.DPT_STN_CONS_ORDR
		                ,A.ARV_STN_CONS_ORDR
		                ,C.STOP_RS_STN_CD) T1
		                
		                
		                
		                

튜닝 내용
  - rule 힌트 보다 nested 조인을 하기 위한 /*+ ORDERED */ 사용 검토 해 볼것.
  - 현재 응답속도 양호 함. 
