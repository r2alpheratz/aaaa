SELECT /*+ com.korail.yz.ys.ec.YSEC002QMDAO.selectListRvnSimlBfmmVsAcvmDay */
       AA.*,
       DECODE(AA.AVG_AMT, 0, 0, NULL, 0, ROUND(((AA.AVG_AMT - AA.BKCL_AMT) / AA.AVG_AMT ) * 100, 1)) AS DCNT_RT /* «“¿Œ¿≤ */
FROM
       (SELECT 
               A2.DAY_DV_CD,
               ROUND (A2.ABRD_EXPECT / B2.DAY_CNT  , 0) AS ABRD_EXPECT,
               ROUND (A2.ABRD_PRNB   / #DAY_CNT# , 0) AS ABRD_PRNB,
               ROUND (A2.F1_AMT      / #DAY_CNT# , 0) AS F1_AMT,
               ROUND (A2.BKCL_AMT    / #DAY_CNT# , 0) AS BKCL_AMT,
               ROUND (A2.EXPECT_AMT  / B2.DAY_CNT  , 0) AS EXPECT_AMT,
               ROUND (A2.AVG_AMT     / #DAY_CNT# , 0) AS AVG_AMT
          FROM (  SELECT E1.DAY_DV_CD                    AS DAY_DV_CD,
                         SUM (A1.LAST_ABRD_EXPN_DMD_NUM) AS ABRD_EXPECT,
                         SUM (A1.ABRD_PRNB)              AS ABRD_PRNB,
                         SUM (A1.F1_AMT)                 AS F1_AMT,
                         SUM (A1.BKCL_AMT)               AS BKCL_AMT,
                         SUM (  YZDBA.FN_YZYB_GETPRICEGB (A1.RUN_DT,
                                                 A1.TRN_NO,
                                                 A1.PSRM_CL_CD,
                                                 D1.ROUT_CD,
                                                 D1.STLB_TRN_CLSF_CD,
                                                 B1.STN_CONS_ORDR,
                                                 C1.STN_CONS_ORDR,
                                                 NULL)
                              * A1.LAST_ABRD_EXPN_DMD_NUM)
                            AS EXPECT_AMT,
                         SUM (  YZDBA.FN_YZYB_GETPRICEGB (A1.RUN_DT,
                                                 A1.TRN_NO,
                                                 A1.PSRM_CL_CD,
                                                 D1.ROUT_CD,
                                                 D1.STLB_TRN_CLSF_CD,
                                                 B1.STOP_RS_STN_CD,
                                                 C1.STOP_RS_STN_CD,
                                                 NULL)
                              * A1.ABRD_PRNB)
                            AS AVG_AMT
                    FROM (  SELECT RUN_DT                    AS RUN_DT,
                                   TRN_NO                    AS TRN_NO,
                                   PSRM_CL_CD                AS PSRM_CL_CD,
                                   DPT_STN_CONS_ORDR         AS DPT_STN_CONS_ORDR,
                                   ARV_STN_CONS_ORDR         AS ARV_STN_CONS_ORDR,
                                   SUM (LAST_ABRD_EXPN_DMD_NUM) AS LAST_ABRD_EXPN_DMD_NUM,
                                   SUM (ABRD_PRNB)           AS ABRD_PRNB,
                                   SUM (F1_AMT)              AS F1_AMT,
                                   SUM (BKCL_AMT)            AS BKCL_AMT
                              FROM (  SELECT A.RUN_DT,
                                             A.TRN_NO,
                                             A.PSRM_CL_CD,
                                             A.DPT_STN_CONS_ORDR,
                                             A.ARV_STN_CONS_ORDR,
                                             SUM (A.LAST_ABRD_EXPN_DMD_NUM) AS LAST_ABRD_EXPN_DMD_NUM,
                                             0                              AS ABRD_PRNB,
                                             0                              AS F1_AMT,
                                             0                              AS BKCL_AMT
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
                                                    WHERE     Z.RUN_DT BETWEEN #RUN_TRM_ST_DT#
                                                                           AND #RUN_TRM_CLS_DT#
                                                          AND Z.TRN_NO           = DECODE (TRIM (#TRN_NO#), NULL, Z.TRN_NO, LPAD (TRIM (#TRN_NO#), 5, '0'))
                                                          AND Z.PSRM_CL_CD       = NVL (#PSRM_CL_CD#, Z.PSRM_CL_CD)
                                                          AND Z.BKCL_CD          = NVL (#BKCL_CD#, Z.BKCL_CD)
                                                          AND Z.RUN_DT           = Y.RUN_DT
                                                          AND Z.TRN_NO           = Y.TRN_NO
                                                          AND Y.UP_DN_DV_CD      = DECODE (#UP_DN_DV_CD#, 'A', Y.UP_DN_DV_CD, #UP_DN_DV_CD#)
                                                          AND Y.STLB_TRN_CLSF_CD = NVL (#STLB_TRN_CLSF_CD#, Y.STLB_TRN_CLSF_CD)
                                                          AND Y.ROUT_CD          = X.ROUT_CD
                                                          AND X.MRNT_CD          = NVL (#MRNT_CD#, X.MRNT_CD)
                                                          AND X.MRNT_CD          IN ('01', '03', '04')
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
                                       WHERE     A.RUN_DT           IN ($RUN_DT_ARR$)
                                             AND A.TRN_NO           = DECODE (TRIM (#TRN_NO#), NULL, A.TRN_NO, LPAD (TRIM (#TRN_NO#), 5, '0'))
                                             AND A.PSRM_CL_CD       = NVL (#PSRM_CL_CD#, A.PSRM_CL_CD)
                                             AND A.BKCL_CD          LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                             AND A.RUN_DT           = B.RUN_DT
                                             AND A.TRN_NO           = B.TRN_NO
                                             AND B.UP_DN_DV_CD      = DECODE (#UP_DN_DV_CD#, 'A', B.UP_DN_DV_CD, #UP_DN_DV_CD#)
                                             AND B.STLB_TRN_CLSF_CD = NVL (#STLB_TRN_CLSF_CD#, B.STLB_TRN_CLSF_CD)
                                             AND B.ROUT_CD          = C.ROUT_CD
                                             AND C.MRNT_CD          = NVL (#MRNT_CD#, C.MRNT_CD)
                                             AND C.MRNT_CD          IN ('01', '03', '04')
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
                                             SUM (BIZ_RVN_AMT - SMG_BIZ_RVN_AMT) AS F1_AMT,
                                             SUM (DECODE (#BKCL_CD#, NULL, BIZ_RVN_AMT - SMG_BIZ_RVN_AMT, 
                                                                     DECODE ( DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD), #BKCL_CD#,   
                                                                                      BIZ_RVN_AMT - SMG_BIZ_RVN_AMT)))
                                                AS BKCL_AMT
                                        FROM TB_YYDS512 A, 
                                             TB_YYDK301 B, 
                                             TB_YYDK201 C
                                       WHERE     A.RUN_DT           IN ($RUN_DT_ARR$)
                                             AND A.TRN_NO           = DECODE (TRIM (#TRN_NO#), NULL, A.TRN_NO, LPAD (TRIM (#TRN_NO#), 5, '0'))
                                             AND A.PSRM_CL_CD       = NVL (#PSRM_CL_CD#, A.PSRM_CL_CD)
                                             AND A.RUN_DT           = B.RUN_DT
                                             AND A.TRN_NO           = B.TRN_NO
                                             AND B.UP_DN_DV_CD      = DECODE (#UP_DN_DV_CD#, 'A', B.UP_DN_DV_CD, #UP_DN_DV_CD#)
                                             AND B.STLB_TRN_CLSF_CD = NVL (#STLB_TRN_CLSF_CD#, B.STLB_TRN_CLSF_CD)
                                             AND B.ROUT_CD          = C.ROUT_CD
                                             AND C.MRNT_CD          = NVL (#MRNT_CD#, C.MRNT_CD)
                                             AND C.MRNT_CD          IN ('01', '03', '04')
                                    GROUP BY A.RUN_DT,
                                             A.TRN_NO,
                                             A.PSRM_CL_CD,
                                             A.DPT_STN_CONS_ORDR,
                                             A.ARV_STN_CONS_ORDR)
                          GROUP BY RUN_DT,
                                   TRN_NO,
                                   PSRM_CL_CD,
                                   DPT_STN_CONS_ORDR,
                                   ARV_STN_CONS_ORDR) A1,
                         TB_YYDK302 B1,
                         TB_YYDK302 C1,
                         TB_YYDK301 D1,
                         TB_YYDK002 E1
                   WHERE     A1.RUN_DT            = B1.RUN_DT
                         AND A1.TRN_NO            = B1.TRN_NO
                         AND A1.DPT_STN_CONS_ORDR = B1.STN_CONS_ORDR
                         AND A1.RUN_DT            = C1.RUN_DT
                         AND A1.TRN_NO            = C1.TRN_NO
                         AND A1.ARV_STN_CONS_ORDR = C1.STN_CONS_ORDR
                         AND A1.RUN_DT            = D1.RUN_DT
                         AND A1.TRN_NO            = D1.TRN_NO
                         AND A1.RUN_DT            = E1.RUN_DT
                GROUP BY E1.DAY_DV_CD) A2,
               (  SELECT TO_CHAR (TO_DATE (RUN_DT, 'YYYYMMDD'), 'D') AS DAY_GB,
                         COUNT (RUN_DT) AS DAY_CNT
                    FROM TB_YYDK002
                   WHERE     RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
                         AND DAY_DV_CD = DECODE(#DAY_DV_CD#, '0', DAY_DV_CD, '8', DAY_DV_CD, '9', DAY_DV_CD, #DAY_DV_CD#)                         
                GROUP BY TO_CHAR (TO_DATE (RUN_DT, 'YYYYMMDD'), 'D')) B2
         WHERE A2.DAY_DV_CD = B2.DAY_GB
         ) AA