  SELECT A1.DAY_DV_CD
        ,SUM (A1.ABRD_PRNB1) AS ABRD_PRNB1
        ,SUM (A1.SEAT_NUM1)  AS SEAT_NUM1
        ,SUM (A1.AMT1)       AS AMT1
        ,SUM (A1.ABRD_PRNB2) AS ABRD_PRNB2
        ,SUM (A1.SEAT_NUM2)  AS SEAT_NUM2
        ,SUM (A1.AMT2)       AS AMT2
        ,SUM (A1.WEEK_CNT1)  AS WEEK_CNT1
        ,SUM (A1.WEEK_CNT2)  AS WEEK_CNT2
        ,SUM (A1.TRN_CNT1)   AS TRN_CNT1
        ,SUM (A1.TRN_CNT2)   AS TRN_CNT2
        ,SUM (A1.TRN_NO1)    AS TRN_NO1
        ,SUM (A1.TRN_NO2)    AS TRN_NO2
    FROM (  SELECT C.DAY_DV_CD     AS DAY_DV_CD
                  ,SUM (ABRD_PRNB) AS ABRD_PRNB1
                  ,SUM ( (SELECT SUM (Z.BS_SEAT_NUM) /* 기본좌석수 */
                            FROM TB_YYDK305 Z /* 잔여석기본TBL */
                           WHERE Z.RUN_DT = A.RUN_DT
                             AND Z.TRN_NO = A.TRN_NO
                             AND Z.GEN_SEAT_DUP_FLG = 'N' /* 일반좌석중복여부  */
                             AND Z.PSRM_CL_CD = A.PSRM_CL_CD))
                       AS SEAT_NUM1
                  ,SUM ( (SELECT SUM (Z.BIZ_RVN_AMT - Z.SMG_BIZ_RVN_AMT) /* 영업수입금액 - 특단영업수입금액 */
                            FROM TB_YYDS512 Z /* 수입금집계TBL  */
                           WHERE Z.RUN_DT = A.RUN_DT
                             AND Z.TRN_NO = A.TRN_NO
                             AND Z.PSRM_CL_CD = A.PSRM_CL_CD))
                       AS AMT1
                  ,COUNT (DISTINCT A.TRN_NO) AS TRN_NO1
                  ,0 AS ABRD_PRNB2
                  ,0 AS SEAT_NUM2
                  ,0 AS AMT2
                  ,MIN (E.WEEK_CNT) AS WEEK_CNT1
                  ,0 AS WEEK_CNT2
                  ,MIN (F.TRN_CNT) AS TRN_CNT1
                  ,0 AS TRN_CNT2
                  ,0 AS TRN_NO2
              FROM TB_YYDS511 A /* 열차별승차율집계TBL */
                  ,TB_YYDK301 B
                  ,TB_YYDK002 C
                  ,TB_YYDK201 D /* 노선TBL */
                  ,(  SELECT DAY_DV_CD, COUNT (DAY_DV_CD) WEEK_CNT
                        FROM TB_YYDK002
                       WHERE RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
                    GROUP BY DAY_DV_CD) E
                  ,(  SELECT Y.DAY_DV_CD, COUNT (Z.RUN_DT) TRN_CNT
                        FROM TB_YYDK301 Z, TB_YYDK002 Y
                       WHERE Y.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
                         AND Z.RUN_DT = Y.RUN_DT
                    GROUP BY Y.DAY_DV_CD) F
             WHERE C.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
               AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
               AND A.RUN_DT = B.RUN_DT
               AND A.TRN_NO = B.TRN_NO
               AND B.STLB_TRN_CLSF_CD = NVL(#STLB_TRN_CLSF_CD#, B.STLB_TRN_CLSF_CD)
               AND B.UP_DN_DV_CD = DECODE(#UP_DN_DV_CD#, 'A', B.UP_DN_DV_CD, #UP_DN_DV_CD#)
               AND A.RUN_DT = C.RUN_DT
               AND B.ROUT_CD = D.ROUT_CD
               AND D.ROUT_DV_CD IN ('10','30')
               AND D.MRNT_CD = NVL(#MRNT_CD#, D.MRNT_CD)
               AND D.MRNT_CD IN ('01', '03', '04')
               AND C.DAY_DV_CD = E.DAY_DV_CD
               AND C.DAY_DV_CD = F.DAY_DV_CD
          GROUP BY C.DAY_DV_CD
          UNION ALL
            SELECT C.DAY_DV_CD AS DAY_DV_CD
                  ,0 AS ABRD_PRNB1
                  ,0 AS SEAT_NUM1
                  ,0 AS AMT1
                  ,0 AS TRN_NO1
                  ,SUM (ABRD_PRNB) AS ABRD_PRNB2
                  ,SUM ( (SELECT SUM (Z.BS_SEAT_NUM)
                            FROM TB_YYDK305 Z
                           WHERE Z.RUN_DT = A.RUN_DT
                             AND TRN_NO = A.TRN_NO
                             AND GEN_SEAT_DUP_FLG = 'N'
                             AND PSRM_CL_CD = A.PSRM_CL_CD)) 
                     AS SEAT_NUM2
                  ,SUM ( (SELECT SUM (Z.BIZ_RVN_AMT - Z.SMG_BIZ_RVN_AMT)
                            FROM TB_YYDS512 Z
                           WHERE Z.RUN_DT = A.RUN_DT
                             AND Z.TRN_NO = A.TRN_NO
                             AND Z.PSRM_CL_CD = A.PSRM_CL_CD))
                     AS AMT2
                  ,0 AS WEEK_CNT1
                  ,MIN (E.WEEK_CNT) AS WEEK_CNT2
                  ,0 AS TRN_CNT1
                  ,MIN (F.TRN_CNT)  AS TRN_CNT2
                  ,COUNT (DISTINCT A.TRN_NO) AS TRN_NO2
              FROM TB_YYDS511 A
                  ,TB_YYDK301 B
                  ,TB_YYDK002 C
                  ,TB_YYDK201 D
                  ,(  SELECT DAY_DV_CD, COUNT (DAY_DV_CD) WEEK_CNT
                        FROM TB_YYDK002
                       WHERE RUN_DT BETWEEN #RUN_TRM_ST_DT2# AND #RUN_TRM_CLS_DT2#
                    GROUP BY DAY_DV_CD) E
                  ,(  SELECT Y.DAY_DV_CD, COUNT (Z.RUN_DT) TRN_CNT
                        FROM TB_YYDK301 Z, TB_YYDK002 Y
                       WHERE Y.RUN_DT BETWEEN #RUN_TRM_ST_DT2# AND #RUN_TRM_CLS_DT2#
                         AND Z.RUN_DT = Y.RUN_DT
                    GROUP BY Y.DAY_DV_CD) F
             WHERE C.RUN_DT BETWEEN #RUN_TRM_ST_DT2# AND #RUN_TRM_CLS_DT2#
               AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
               AND A.RUN_DT = B.RUN_DT
               AND A.TRN_NO = B.TRN_NO
               AND B.STLB_TRN_CLSF_CD = NVL(#STLB_TRN_CLSF_CD#, B.STLB_TRN_CLSF_CD)
               AND B.UP_DN_DV_CD = DECODE(#UP_DN_DV_CD#, NULL, B.UP_DN_DV_CD, #UP_DN_DV_CD#)
               AND A.RUN_DT = C.RUN_DT
               AND B.ROUT_CD = D.ROUT_CD
               AND D.ROUT_DV_CD IN ('10','30')
               AND D.MRNT_CD = NVL(#MRNT_CD#, D.MRNT_CD)
               AND D.MRNT_CD IN ('01', '03', '04')
               AND C.DAY_DV_CD = E.DAY_DV_CD
               AND C.DAY_DV_CD = F.DAY_DV_CD
          GROUP BY C.DAY_DV_CD) A1
GROUP BY DAY_DV_CD