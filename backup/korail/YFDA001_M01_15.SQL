  SELECT /*+com.korail.yz.yf.da.YFDA001QMDAO.selectListDtAllInfo*/
     A5.RUN_DT
        ,A5.DAY_DV_CD
        ,A5.DAY_DV_NM
        ,A5.LAST_ABRD_EXPCT_DMD_SUM
        ,A5.LAST_ABRD_EXPCT_DMD_AVG
        ,A5.EXPN_POTT_DMD_NUM_SUM
        ,A5.EXPN_POTT_DMD_NUM_AVG
        ,A5.FCST_ABRD_RT
        ,A5.SALE_NUM_SUM
        ,A5.SALE_NUM_AVG
        ,A5.CANCEL_NUM_AVG
        ,A5.CANCEL_NUM_SUM
        ,B5.PAST_NUM PAST_NUM_SUM
        ,B5.PAST_NUM / DECODE (B5.PAST_TRN_NO_NUM, 0, 1, B5.PAST_TRN_NO_NUM) PAST_NUM_AVG
        ,B5.PAST_SALE_NUM PAST_SALE_NUM_SUM
        ,B5.PAST_SALE_NUM / DECODE (B5.PAST_TRN_NO_NUM, 0, 1, B5.PAST_TRN_NO_NUM) PAST_SALE_NUM_AVG
        ,B5.PAST_CANCEL_NUM
        ,B5.PAST_CANCEL_NUM / DECODE (B5.PAST_TRN_NO_NUM, 0, 1, B5.PAST_TRN_NO_NUM) PAST_CANCEL_NUM_AVG
        ,A5.PRICE_SUM
        ,A5.PRICE_AVG
        ,A5.TOT_NUM_SUM
        ,A5.TOT_NUM_AVG
    FROM (  SELECT /*+RULE*/
           A4.RUN_DT
                  ,MIN (A4.DAY_DV_CD) DAY_DV_CD
                  ,MIN (B4.VLID_VAL_KOR_AVVR_NM) DAY_DV_NM
                  ,SUM (A4.LAST_ABRD_EXPCT_DMD) LAST_ABRD_EXPCT_DMD_SUM
                  ,SUM (A4.LAST_ABRD_EXPCT_DMD) / DECODE (COUNT (DISTINCT A4.TRN_NO), 0, 1, COUNT (DISTINCT A4.TRN_NO)) LAST_ABRD_EXPCT_DMD_AVG
                  ,SUM (A4.EXPN_POTT_DMD_NUM) EXPN_POTT_DMD_NUM_SUM
                  ,SUM (A4.EXPN_POTT_DMD_NUM) / DECODE (COUNT (DISTINCT A4.TRN_NO), 0, 1, COUNT (DISTINCT A4.TRN_NO)) EXPN_POTT_DMD_NUM_AVG
                  ,SUM (A4.FCST_ABRD_RT) / DECODE (COUNT (DISTINCT A4.TRN_NO), 0, 1, COUNT (DISTINCT A4.TRN_NO)) * 100 FCST_ABRD_RT
                  ,SUM (A4.SALE_NUM) SALE_NUM_SUM
                  ,SUM (A4.SALE_NUM) / DECODE (COUNT (DISTINCT A4.TRN_NO), 0, 1, COUNT (DISTINCT A4.TRN_NO)) SALE_NUM_AVG
                  ,SUM (A4.CANCEL_NUM) / DECODE (COUNT (DISTINCT A4.TRN_NO), 0, 1, COUNT (DISTINCT A4.TRN_NO)) CANCEL_NUM_AVG
                  ,SUM (A4.CANCEL_NUM) CANCEL_NUM_SUM
                  ,SUM (A4.PRICE) PRICE_SUM
                  ,SUM (A4.PRICE) / DECODE (COUNT (DISTINCT A4.TRN_NO), 0, 1, COUNT (DISTINCT A4.TRN_NO)) PRICE_AVG
                  ,SUM (A4.TOT_NUM) TOT_NUM_SUM
                  ,SUM (A4.TOT_NUM) / DECODE (COUNT (DISTINCT A4.TRN_NO), 0, 1, COUNT (DISTINCT A4.TRN_NO)) TOT_NUM_AVG
              FROM (SELECT A3.RUN_DT
                          ,A3.TRN_NO
                          ,C3.DAY_DV_CD
                          ,A3.FCST_PSN_RT FCST_ABRD_RT
                          ,B3.SALE_NUM
                          ,B3.CANCEL_NUM
                          ,A3.PRICE
                          ,A3.LAST_ABRD_EXPCT_DMD
                          ,A3.EXPN_POTT_DMD_NUM
                          ,B3.TOT_NUM
                      FROM (SELECT A1.TRN_NO
                                  ,A1.RUN_DT RUN_DT
                                  ,A1.EXPN_RVN_AMT PRICE
                                  ,A1.FCST_ABRD_PRNB LAST_ABRD_EXPCT_DMD
                                  ,ROUND
                                   (
                                       CASE
                                           WHEN #PSRM_CL_CD# = '1'
                                           THEN
                                               A1.ABRD_RT1
                                           WHEN #PSRM_CL_CD# = '2'
                                           THEN
                                               A1.ABRD_RT2
                                           WHEN #PSRM_CL_CD# IS NULL
                                           THEN
                                               CASE
                                                   WHEN A1.ABRD_RT1 <> 0
                                                    AND A1.ABRD_RT2 <> 0
                                                   THEN
                                                       A1.ABRD_RT1 * (A1.ABRD_PRNB1 / A1.FCST_ABRD_PRNB) + A1.ABRD_RT2 * (A1.ABRD_PRNB2 / A1.FCST_ABRD_PRNB)
                                                   ELSE
                                                       ABRD_RT1 + ABRD_RT2
                                               END
                                       END
                                      ,3
                                   )
                                       FCST_PSN_RT
                                  , (SELECT SUM (Z.EXPN_POTT_DMD_NUM)
                                       FROM TB_YYFD410 Z /*최종탑승예측수요 TBL*/
                                      WHERE Z.RUN_DT = A1.RUN_DT
                                        AND Z.TRN_NO = A1.TRN_NO
                                        AND Z.PSRM_CL_CD = DECODE (#PSRM_CL_CD#, '', Z.PSRM_CL_CD, #PSRM_CL_CD#)
                                        AND (Z.FCST_ACHV_DT, Z.YMGT_JOB_ID) = (SELECT SUBSTR (MAX (Y.FCST_ACHV_DT || Y.YMGT_JOB_ID), 1, 8), SUBSTR (MAX (Y.FCST_ACHV_DT || Y.YMGT_JOB_ID), 9)
                                                                                 FROM TB_YYFD410 Y /*최종탑습수요 TBL*/
                                                                                WHERE Z.RUN_DT = Y.RUN_DT
                                                                                  AND Z.TRN_NO = Y.TRN_NO
                                                                                  AND Z.PSRM_CL_CD = Y.PSRM_CL_CD
                                                                                  AND Z.BKCL_CD = Y.BKCL_CD
                                                                                  AND Z.DPT_STN_CONS_ORDR = Y.DPT_STN_CONS_ORDR
                                                                                  AND Z.ARV_STN_CONS_ORDR = Y.ARV_STN_CONS_ORDR))
                                       EXPN_POTT_DMD_NUM
                              FROM (  SELECT A.RUN_DT
                                            ,A.TRN_NO
                                            ,SUM (A.EXPN_RVN_AMT) EXPN_RVN_AMT
                                            ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.FCST_ABRD_RT)), 0) ABRD_RT1
                                            ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.FCST_ABRD_RT)), 0) ABRD_RT2
                                            ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.FCST_ABRD_PRNB)), 0) ABRD_PRNB1
                                            ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.FCST_ABRD_PRNB)), 0) ABRD_PRNB2
                                            ,SUM (A.FCST_ABRD_PRNB) FCST_ABRD_PRNB
                                        FROM TB_YYPD003 A, TB_YYDK301 C, /*일일열차정보*/
                                                                        TB_YYDK201 D /*열차별BookingClass통제정보*/
                                       WHERE A.RUN_DT IN (SELECT RUN_DT
                                                            FROM TB_YYDK002
                                                           WHERE DAY_DV_CD = DECODE (#DAY_DV_CD#, '0', DAY_DV_CD, #DAY_DV_CD#)
                                                             AND RUN_DT BETWEEN #RUN_DT_ST# AND #RUN_DT_CLS#)
                                         AND A.TRN_NO = DECODE (#TRN_NO#, '', A.TRN_NO, LPAD (#TRN_NO#, 5, '0'))
                                         AND A.PSRM_CL_CD = DECODE (#PSRM_CL_CD#, '', A.PSRM_CL_CD, #PSRM_CL_CD#)
                                         AND A.RUN_DT = C.RUN_DT
                                         AND A.TRN_NO = C.TRN_NO
                                         AND C.UP_DN_DV_CD = DECODE (#UP_DN_DV_CD#, 'A', C.UP_DN_DV_CD, #UP_DN_DV_CD#)
                                         AND C.STLB_TRN_CLSF_CD = DECODE (#STLB_TRN_CLSF_CD#, '', C.STLB_TRN_CLSF_CD, #STLB_TRN_CLSF_CD#)
                                         AND C.ROUT_CD = D.ROUT_CD
                                         AND D.MRNT_CD = DECODE (#MRNT_CD#, '', D.MRNT_CD, #MRNT_CD#)
                                         AND D.MRNT_CD IN ('01', '03', '04')
                                         AND A.BKCL_CD = 'F1'
                                    GROUP BY A.RUN_DT, A.TRN_NO) A1) A3
                          ,(  SELECT A.RUN_DT
                                    ,A.TRN_NO
                                    ,SUM (A.RSV_SEAT_NUM + A.SALE_SEAT_NUM) SALE_NUM
                                    ,SUM (A.CNC_SEAT_NUM + A.RET_SEAT_NUM) CANCEL_NUM
                                    ,SUM (A.RSV_SEAT_NUM + A.SALE_SEAT_NUM - A.CNC_SEAT_NUM - A.RET_SEAT_NUM) TOT_NUM
                                FROM TB_YYDS501 A, /*예약발매실적 TBL*/
                                                  TB_YYDK301 B, /*열차별 BookingClass통제정보 TBL*/
                                                               TB_YYDK201 C /*노선 TBL*/
                               WHERE A.RUN_DT IN (SELECT RUN_DT
                                                    FROM TB_YYDK002
                                                   WHERE DAY_DV_CD = DECODE (#DAY_DV_CD#, '0', DAY_DV_CD, #DAY_DV_CD#)
                                                     AND RUN_DT BETWEEN #RUN_DT_ST# AND #RUN_DT_CLS#)
                                 AND A.TRN_NO = DECODE (#TRN_NO#, '', A.TRN_NO, LPAD (#TRN_NO#, 5, '0'))
                                 AND A.PSRM_CL_CD = DECODE (#PSRM_CL_CD#, '', A.PSRM_CL_CD, #PSRM_CL_CD#)
                                 AND B.UP_DN_DV_CD = DECODE (#UP_DN_DV_CD#, 'A', B.UP_DN_DV_CD, #UP_DN_DV_CD#)
                                 AND B.STLB_TRN_CLSF_CD = DECODE (#STLB_TRN_CLSF_CD#, '', B.STLB_TRN_CLSF_CD, #STLB_TRN_CLSF_CD#)
                                 AND A.RUN_DT = B.RUN_DT
                                 AND A.TRN_NO = B.TRN_NO
                                 AND B.ROUT_CD = C.ROUT_CD
                                 AND C.MRNT_CD = DECODE (#MRNT_CD#, '', C.MRNT_CD, #MRNT_CD#)
                                 AND C.MRNT_CD IN ('01', '03', '04')
                            GROUP BY A.RUN_DT, A.TRN_NO) B3
                          ,TB_YYDK002 C3
                     WHERE A3.RUN_DT = B3.RUN_DT(+)
                       AND A3.TRN_NO = B3.TRN_NO(+)
                       AND A3.RUN_DT = C3.RUN_DT) A4
                  ,TB_YYDK007 B4
             WHERE A4.DAY_DV_CD = B4.VLID_VAL
               AND B4.XROIS_OLD_SRT_CD = 'I909'
          GROUP BY A4.RUN_DT, A4.DAY_DV_CD) A5
        ,(  SELECT B1.DAY_DV_CD
                  ,SUM (A1.PAST_NUM) PAST_NUM
                  ,SUM (A1.PAST_SALE_NUM) PAST_SALE_NUM
                  ,SUM (A1.PAST_CANCEL_NUM) PAST_CANCEL_NUM
                  ,COUNT (DISTINCT TRN_NO_MAX) PAST_TRN_NO_NUM
              FROM (  SELECT A.RUN_DT
                            ,SUM (A.RSV_SEAT_NUM + A.SALE_SEAT_NUM - A.CNC_SEAT_NUM - A.RET_SEAT_NUM) PAST_NUM
                            ,SUM (A.RSV_SEAT_NUM + A.SALE_SEAT_NUM) PAST_SALE_NUM
                            ,SUM (A.CNC_SEAT_NUM + A.RET_SEAT_NUM) PAST_CANCEL_NUM
                            ,MAX (A.RUN_DT || A.TRN_NO) TRN_NO_MAX
                        FROM TB_YYDS501 A, TB_YYDK301 B, TB_YYDK201 C
                       WHERE A.RUN_DT IN ($RUN_DT_ARR$)
                         AND A.TRN_NO = DECODE (#TRN_NO#, '', A.TRN_NO, LPAD (#TRN_NO#, 5, '0'))
                         AND A.PSRM_CL_CD = DECODE (#PSRM_CL_CD#, '', A.PSRM_CL_CD, #PSRM_CL_CD#)
                         AND B.UP_DN_DV_CD = DECODE (#UP_DN_DV_CD#, 'A', B.UP_DN_DV_CD, #UP_DN_DV_CD#)
                         AND B.STLB_TRN_CLSF_CD = DECODE (#STLB_TRN_CLSF_CD#, '', B.STLB_TRN_CLSF_CD, #STLB_TRN_CLSF_CD#)
                         AND A.RUN_DT = B.RUN_DT
                         AND A.TRN_NO = B.TRN_NO
                         AND B.ROUT_CD = C.ROUT_CD
                         AND C.MRNT_CD = DECODE (#MRNT_CD#, '', C.MRNT_CD, #MRNT_CD#)
                         AND C.MRNT_CD IN ('01', '03', '04')
                    GROUP BY A.RUN_DT) A1
                  ,TB_YYDK002 B1
             WHERE A1.RUN_DT = B1.RUN_DT
          GROUP BY B1.DAY_DV_CD) B5
   WHERE A5.DAY_DV_CD = B5.DAY_DV_CD
ORDER BY RUN_DT, DAY_DV_CD



튜닝 내용
     - com.korail.yz.yf.da.YFDA001QMDAO.selectListAllTrnInfo  와 동일

