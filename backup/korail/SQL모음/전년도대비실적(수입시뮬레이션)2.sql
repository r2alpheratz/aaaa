  SELECT A1.DAY_DV_CD        AS DAY_DV_CD
        ,SUM (A1.ABRD_PRNB1) AS ABRD_PRNB1
        ,SUM (A1.SEAT_NUM1)  AS SEAT_NUM1
        ,SUM (A1.AMT1)       AS AMT1
        ,SUM (A1.WEEK_CNT1)  AS WEEK_CNT1
        ,SUM (A1.TRN_CNT1)   AS TRN_CNT1
        ,SUM (A1.TRN_NO1)    AS TRN_NO1
        ,0.0                 AS ABRD_PRNB_YUL2
        ,0.0                 AS ABRD_PRNB2
        ,0.0                 AS AMT_YUL2
        ,0.0                 AS AMT2
        ,MAX ( (SELECT COUNT (DISTINCT Z.TRN_NO)
                  FROM TB_YYDK301 Z, TB_YYDK002 Y, TB_YYDK201 X
                 WHERE Z.RUN_DT BETWEEN #RUN_TRM_ST_DT4# AND #RUN_TRM_CLS_DT4#
                   AND Z.RUN_DT = Y.RUN_DT
                   AND Y.DAY_DV_CD = A1.DAY_DV_CD
                   AND Z.STLB_TRN_CLSF_CD = NVL (#STLB_TRN_CLSF_CD#, Z.STLB_TRN_CLSF_CD)
                   AND Z.UP_DN_DV_CD = DECODE (#UP_DN_DV_CD#, 'A', Z.UP_DN_DV_CD)
                   AND Z.ROUT_CD = X.ROUT_CD
                   AND X.ROUT_DV_CD IN ('10', '30')
                   AND X.MRNT_CD = NVL (#MRNT_CD#, X.MRNT_CD)
                   AND X.MRNT_CD IN ('01', '03', '04')))
             AS TRN_NO2
    FROM (  SELECT C.DAY_DV_CD AS DAY_DV_CD
                  ,SUM (ABRD_PRNB) AS ABRD_PRNB1
                  ,SUM ( (SELECT SUM (Z.BS_SEAT_NUM)
                            FROM TB_YYDK305 Z
                           WHERE Z.RUN_DT = A.RUN_DT
                             AND Z.TRN_NO = A.TRN_NO
                             AND Z.GEN_SEAT_DUP_FLG = 'N'
                             AND Z.PSRM_CL_CD = A.PSRM_CL_CD))
                       AS SEAT_NUM1
                  ,SUM ( (SELECT SUM (Z.BIZ_RVN_AMT - Z.SMG_BIZ_RVN_AMT)
                            FROM TB_YYDS512 Z
                           WHERE Z.RUN_DT = A.RUN_DT
                             AND Z.TRN_NO = A.TRN_NO
                             AND Z.PSRM_CL_CD = A.PSRM_CL_CD))
                       AS AMT1
                  ,MIN (E.WEEK_CNT) AS WEEK_CNT1
                  ,MIN (F.TRN_CNT) AS TRN_CNT1
                  ,COUNT (DISTINCT A.TRN_NO) AS TRN_NO1
              FROM TB_YYDS511 A
                  ,TB_YYDK301 B
                  ,TB_YYDK002 C
                  ,TB_YYDK201 D
                  ,(  SELECT DAY_DV_CD, COUNT (DAY_DV_CD) AS WEEK_CNT
                        FROM TB_YYDK002
                       WHERE RUN_DT BETWEEN #RUN_TRN_ST_DT3# AND #RUN_TRN_CLS_DT3#
                    GROUP BY DAY_DV_CD) E
                  ,(  SELECT Y.DAY_DV_CD, COUNT (Z.RUN_DT) AS TRN_CNT
                        FROM TB_YYDK301 Z, TB_YYDK002 Y
                       WHERE Y.RUN_DT BETWEEN #RUN_TRN_ST_DT3# AND #RUN_TRN_CLS_DT3#
                         AND Z.RUN_DT = Y.RUN_DT
                    GROUP BY Y.DAY_DV_CD) F
             WHERE C.RUN_DT BETWEEN #RUN_TRN_ST_DT3# AND #RUN_TRN_CLS_DT3#
               AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
               AND A.RUN_DT = B.RUN_DT
               AND A.TRN_NO = B.TRN_NO
               AND B.STLB_TRN_CLSF_CD = NVL (#STLB_TRN_CLSF_CD#, B.STLB_TRN_CLSF_CD)
               AND B.UP_DN_DV_CD = NVL(#UP_DN_DV_CD#, B.UP_DN_DV_CD)
               AND A.RUN_DT = C.RUN_DT
               AND B.ROUT_CD = D.ROUT_CD
               AND D.ROUT_DV_CD IN ('10', '20')
               AND D.MRNT_CD = NVL(#MRNT_CD#, D.MRNT_CD)
               AND D.MRNT_CD IN ('01', '03', '04')
               AND C.DAY_DV_CD = E.DAY_DV_CD
               AND C.DAY_DV_CD = F.DAY_DV_CD
          GROUP BY C.DAY_DV_CD) A1
GROUP BY DAY_DV_CD