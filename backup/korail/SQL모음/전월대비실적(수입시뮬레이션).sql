        SELECT /*+ com.korail.yz.ys.ec.YSEC001QMDAO.selectListRvnSimlBfmmVsAcvmWhl */
               A2.*,
               DECODE(A2.AVG_AMT, 0, 0, NULL, 0, ROUND(((A2.AVG_AMT - A2.BKCL_AMT) / A2.AVG_AMT ) * 100, 1)) AS DCNT_RT /* «“¿Œ¿≤ */ 
        FROM(
                SELECT LPAD(LTRIM(A1.TRN_NO, '0'), 5, ' ') TRN_NO,
                       MAX (A1.RUN_DT) RUN_DT,
                       SUM (A1.LAST_ABRD_EXPN_DMD_NUM) AS ABRD_EXPECT,
                       SUM (A1.ABRD_PRNB) / TO_NUMBER(#DAY_CNT#) AS ABRD_PRNB,
                       SUM (A1.F1_AMT) / TO_NUMBER(#DAY_CNT#) AS F1_AMT,
                       SUM (A1.BKCL_AMT) / TO_NUMBER(#DAY_CNT#) AS BKCL_AMT,
                       SUM (  YZDBA.FN_YZYB_GETPRICEGB (A1.RUN_DT,
                                               A1.TRN_NO,
                                               A1.PSRM_CL_CD,
                                               D1.ROUT_CD,
                                               D1.STLB_TRN_CLSF_CD,
                                               B1.STN_CONS_ORDR,
                                               C1.STN_CONS_ORDR,
                                               NULL) * A1.LAST_ABRD_EXPN_DMD_NUM)
                          AS EXPECT_AMT,
                       SUM (  YZDBA.FN_YZYB_GETPRICEGB (A1.RUN_DT,
                                               A1.TRN_NO,
                                               A1.PSRM_CL_CD,
                                               D1.ROUT_CD,
                                               D1.STLB_TRN_CLSF_CD,
                                               B1.STN_CONS_ORDR,
                                               C1.STN_CONS_ORDR,
                                               NULL) * A1.ABRD_PRNB
                           ) / TO_NUMBER(#DAY_CNT#)
                          AS AVG_AMT
                 FROM (  SELECT A.RUN_DT,
                                A.TRN_NO,
                                A.PSRM_CL_CD,
                                A.DPT_STN_CONS_ORDR,
                                A.ARV_STN_CONS_ORDR,
                                SUM (A.LAST_ABRD_EXPN_DMD_NUM) AS LAST_ABRD_EXPN_DMD_NUM,
                                0 AS ABRD_PRNB,
                                0 AS F1_AMT,
                                0 AS BKCL_AMT
                           FROM TB_YYFD410 A
                          WHERE (A.RUN_DT,
                                 A.TRN_NO,
                                 A.PSRM_CL_CD,
                                 A.BKCL_CD,
                                 A.FCST_ACHV_DT,
                                 A.YMGT_JOB_ID) IN
                                   (  SELECT Z.RUN_DT,
                                             Z.TRN_NO,
                                             Z.PSRM_CL_CD,
                                             Z.BKCL_CD,
                                             SUBSTR (MAX (Z.FCST_ACHV_DT || Z.YMGT_JOB_ID), 1, 8),
                                             SUBSTR (MAX (Z.FCST_ACHV_DT || Z.YMGT_JOB_ID), 9)
                                        FROM TB_YYFD410 Z, 
                                             TB_YYDK301 Y, 
                                             TB_YYDK201 X
                                       WHERE     Z.RUN_DT = #RUN_DT#
                                             AND Z.PSRM_CL_CD = NVL(#PSRM_CL_CD#, Z.PSRM_CL_CD)
                                             AND Z.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, Z.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                             AND Z.RUN_DT = Y.RUN_DT
                                             AND Z.TRN_NO = Y.TRN_NO
                                             AND Y.UP_DN_DV_CD = NVL(#UP_DN_DV_CD#, Y.UP_DN_DV_CD)
                                             AND Y.STLB_TRN_CLSF_CD = NVL(#STLB_TRN_CLSF_CD#, Y.STLB_TRN_CLSF_CD)
                                             AND Y.ROUT_CD = X.ROUT_CD
                                             AND X.ROUT_DV_CD IN ('10','30')
                                             AND X.MRNT_CD = NVL(#MRNT_CD#, X.MRNT_CD)
                                             AND X.MRNT_CD IN ('01', '03', '04')
                                    GROUP BY Z.RUN_DT,
                                             Z.TRN_NO,
                                             Z.PSRM_CL_CD,
                                             Z.BKCL_CD)
                       GROUP BY A.RUN_DT,
                                A.TRN_NO,
                                A.PSRM_CL_CD,
                                A.DPT_STN_CONS_ORDR,
                                A.ARV_STN_CONS_ORDR
                       UNION ALL
                         SELECT A.RUN_DT,
                                A.TRN_NO,
                                A.PSRM_CL_CD,
                                A.DPT_STN_CONS_ORDR,
                                A.ARV_STN_CONS_ORDR,
                                0 AS LAST_ABRD_EXPN_DMD_NUM, 
                                SUM (ABRD_PRNB) AS ABRD_PRNB,
                                0 AS F1_AMT,
                                0 AS BKCL_AMT
                           FROM TB_YYDS510 A, 
                                TB_YYDK301 B, 
                                TB_YYDK201 C
                          WHERE     A.RUN_DT IN ($RUN_DT_ARR$)
                                AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                AND A.RUN_DT = B.RUN_DT
                                AND A.TRN_NO = B.TRN_NO
                                AND B.UP_DN_DV_CD = NVL(#UP_DN_DV_CD#, B.UP_DN_DV_CD)
                                AND B.STLB_TRN_CLSF_CD = NVL(#STLB_TRN_CLSF_CD#, B.STLB_TRN_CLSF_CD)
                                AND B.ROUT_CD = C.ROUT_CD
                                AND C.ROUT_DV_CD IN ('10','30') 
                                AND C.MRNT_CD = NVL(#MRNT_CD#, C.MRNT_CD)
                                AND C.MRNT_CD IN ('01', '03', '04')
                       GROUP BY A.RUN_DT,
                                A.TRN_NO,
                                A.PSRM_CL_CD,
                                A.DPT_STN_CONS_ORDR,
                                A.ARV_STN_CONS_ORDR
                       UNION ALL
                         SELECT A.RUN_DT,
                                A.TRN_NO,
                                A.PSRM_CL_CD,
                                A.DPT_STN_CONS_ORDR,
                                A.ARV_STN_CONS_ORDR,
                                0 AS LAST_ABRD_EXPN_DMD_NUM,
                                0 AS ABRD_PRNB,
                                SUM (A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT) F1_AMT,
                                SUM (
                                   DECODE (#BKCL_CD#, NULL, A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT,
                                      DECODE (DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD),
                                              #BKCL_CD#, A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT)))
                                   AS BKCL_AMT
                           FROM TB_YYDS512 A, 
                                TB_YYDK301 B, 
                                TB_YYDK201 C
                          WHERE     A.RUN_DT IN ($RUN_DT_ARR$)
                                AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                AND A.RUN_DT = B.RUN_DT
                                AND A.TRN_NO = B.TRN_NO
                                AND B.UP_DN_DV_CD = NVL(#UP_DN_DV_CD#, B.UP_DN_DV_CD)
                                AND B.STLB_TRN_CLSF_CD = NVL(#STLB_TRN_CLSF_CD#, B.STLB_TRN_CLSF_CD)
                                AND B.ROUT_CD = C.ROUT_CD
                                AND C.ROUT_DV_CD IN ('10','30') 
                                AND C.MRNT_CD = NVL(#MRNT_CD#, C.MRNT_CD)
                                AND C.MRNT_CD IN ('01', '03', '04')
                       GROUP BY A.RUN_DT,
                                A.TRN_NO,
                                A.PSRM_CL_CD,
                                A.DPT_STN_CONS_ORDR,
                                A.ARV_STN_CONS_ORDR) A1,
                       TB_YYDK302 B1,
                       TB_YYDK302 C1,
                       TB_YYDK301 D1
                 WHERE    A1.RUN_DT            = B1.RUN_DT
                      AND A1.TRN_NO            = B1.TRN_NO
                      AND A1.DPT_STN_CONS_ORDR = B1.STN_CONS_ORDR
                      AND A1.RUN_DT            = C1.RUN_DT
                      AND A1.TRN_NO            = C1.TRN_NO
                      AND A1.ARV_STN_CONS_ORDR = C1.STN_CONS_ORDR
                      AND A1.TRN_NO            = D1.TRN_NO
                      AND A1.RUN_DT            = D1.RUN_DT
                 GROUP BY A1.TRN_NO
        ) A2