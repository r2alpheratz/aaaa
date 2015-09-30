  SELECT /*+ com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpSaleVs4Wk */
        A.START_TM AS START_TM
        ,TO_NUMBER (A.TRN_NO) AS TRN_NO
        ,A.TRN_NO AS TRN_NO1
        ,A.ABRD_PRNB AS ABRD_PRNB
        ,A.AVG_OF_ABRD_PRNB AS AVG_OF_ABRD_PRNB
        ,ROUND (A.ABRD_PRNB_PERCENTAGE, 1) AS ABRD_PRNB_PERCENTAGE
        ,ROUND (A.AVG_OF_ABRD_PRNB_PERCENTAGE, 1) AS AVG_OF_ABRD_PRNB_PERCENTAGE
        ,A.MOVE_CNT AS MOVE_CNT
        ,A.ESCAPE_CNT AS ESCAPE_CNT
        ,MAX (A.CLOSE_DAY) AS CLOSE_DAY
        ,NVL (MAX (DECODE (A.RNUM, 0, A.CNT)), 0) AS D_DAY_00
        ,NVL (MAX (DECODE (A.RNUM, 1, A.CNT)), 0) AS D_DAY_01
        ,NVL (MAX (DECODE (A.RNUM, 2, A.CNT)), 0) AS D_DAY_02
        ,NVL (MAX (DECODE (A.RNUM, 3, A.CNT)), 0) AS D_DAY_03
        ,NVL (MAX (DECODE (A.RNUM, 4, A.CNT)), 0) AS D_DAY_04
        ,NVL (MAX (DECODE (A.RNUM, 5, A.CNT)), 0) AS D_DAY_05
        ,NVL (MAX (DECODE (A.RNUM, 6, A.CNT)), 0) AS D_DAY_06
        ,NVL (MAX (DECODE (A.RNUM, 7, A.CNT)), 0) AS D_DAY_07
        ,NVL (MAX (DECODE (A.RNUM, 8, A.CNT)), 0) AS D_DAY_08
        ,NVL (MAX (DECODE (A.RNUM, 9, A.CNT)), 0) AS D_DAY_09
        ,NVL (MAX (DECODE (A.RNUM, 10, A.CNT)), 0) AS D_DAY_10
        ,NVL (MAX (DECODE (A.RNUM, 11, A.CNT)), 0) AS D_DAY_11
        ,NVL (MAX (DECODE (A.RNUM, 12, A.CNT)), 0) AS D_DAY_12
        ,NVL (MAX (DECODE (A.RNUM, 13, A.CNT)), 0) AS D_DAY_13
        ,NVL (MAX (DECODE (A.RNUM, 14, A.CNT)), 0) AS D_DAY_14
        ,NVL (MAX (DECODE (A.RNUM, 15, A.CNT)), 0) AS D_DAY_15
        ,NVL (MAX (DECODE (A.RNUM, 16, A.CNT)), 0) AS D_DAY_16
        ,NVL (MAX (DECODE (A.RNUM, 17, A.CNT)), 0) AS D_DAY_17
        ,NVL (MAX (DECODE (A.RNUM, 18, A.CNT)), 0) AS D_DAY_18
        ,NVL (MAX (DECODE (A.RNUM, 19, A.CNT)), 0) AS D_DAY_19
        ,NVL (MAX (DECODE (A.RNUM, 20, A.CNT)), 0) AS D_DAY_20
        ,NVL (MAX (DECODE (A.RNUM, 21, A.CNT)), 0) AS D_DAY_21
        ,NVL (MAX (DECODE (A.RNUM, 22, A.CNT)), 0) AS D_DAY_22
        ,NVL (MAX (DECODE (A.RNUM, 23, A.CNT)), 0) AS D_DAY_23
        ,NVL (MAX (DECODE (A.RNUM, 24, A.CNT)), 0) AS D_DAY_24
        ,NVL (MAX (DECODE (A.RNUM, 25, A.CNT)), 0) AS D_DAY_25
        ,NVL (MAX (DECODE (A.RNUM, 26, A.CNT)), 0) AS D_DAY_26
        ,NVL (MAX (DECODE (A.RNUM, 27, A.CNT)), 0) AS D_DAY_27
        ,NVL (MAX (DECODE (A.RNUM, 28, A.CNT)), 0) AS D_DAY_28
        ,NVL (MAX (DECODE (A.RNUM, 29, A.CNT)), 0) AS D_DAY_29
        ,NVL (MAX (DECODE (A.RNUM, 30, A.CNT)), 0) AS D_DAY_30
        ,NVL (MAX (DECODE (A.RNUM, 31, A.CNT)), 0) AS D_DAY_31
    FROM (  SELECT A2.START_TM
                  ,A2.TRN_NO
                  ,A2.ABRD_PRNB
                  ,A2.AVG_OF_ABRD_PRNB
                  ,A2.ABRD_PRNB_PERCENTAGE
                  ,A2.AVG_OF_ABRD_PRNB_PERCENTAGE
                  ,A2.MOVE_CNT
                  ,A2.ESCAPE_CNT
                  ,A2.D_DAY
                  ,B2.RNUM
                  ,A2.CLOSE_DAY
                  ,SUM (DECODE (A2.D_DAY, B2.RNUM, A2.CNT, 0)) OVER (PARTITION BY A2.START_TM, A2.TRN_NO ORDER BY A2.START_TM, A2.TRN_NO, B2.RNUM DESC RANGE UNBOUNDED PRECEDING) AS CNT
              FROM (SELECT A1.START_TM
                          ,A1.TRN_NO
                          ,A1.ABRD_PRNB
                          ,A1.AVG_OF_ABRD_PRNB AS AVG_OF_ABRD_PRNB
                          ,A1.ABRD_PRNB_PERCENTAGE * 100 AS ABRD_PRNB_PERCENTAGE
                          ,A1.AVG_OF_ABRD_PRNB_PERCENTAGE * 100 AS AVG_OF_ABRD_PRNB_PERCENTAGE
                          ,A1.MOVE_CNT AS MOVE_CNT
                          ,A1.ESCAPE_CNT AS ESCAPE_CNT
                          ,A1.RESERVE_CNT
                          ,A1.CANCEL_CNT
                          ,A1.SALE_CNT
                          ,A1.D_DAY
                          ,A1.CNT
                          ,A1.CLOSE_DAY
                          ,NVL (LEAD (A1.D_DAY) OVER (PARTITION BY A1.START_TM, A1.TRN_NO ORDER BY A1.START_TM, A1.TRN_NO, A1.D_DAY), 60) AS D_DAY_F
                      FROM (SELECT SUBSTR (A.START_TM, 1, 2) || ':' || SUBSTR (A.START_TM, 3, 2) AS START_TM
                                  ,A.TRN_NO AS TRN_NO
                                  ,A.ABRD_PRNB
                                  ,A.AVG_OF_ABRD_PRNB
                                  ,A.ABRD_PRNB_PERCENTAGE
                                  ,A.AVG_OF_ABRD_PRNB_PERCENTAGE
                                  ,A.MOVE_CNT
                                  ,A.ESCAPE_CNT
                                  ,B.D_DAY
                                  ,B.RESERVE_CNT
                                  ,B.CANCEL_CNT
                                  ,B.RESERVE_CNT - B.CANCEL_CNT AS SALE_CNT
                                  ,DECODE (NVL ('3', '3'),  '1', B.RESERVE_CNT,  '2', B.CANCEL_CNT,  '3', B.RESERVE_CNT - B.CANCEL_CNT) AS CNT
                                  ,B.CLOSE_DAY
                              FROM (SELECT A.START_TM
                                          ,A.TRN_NO
                                          ,A.ABRD_PRNB
                                          ,A.AVG_OF_ABRD_PRNB
                                          ,A.ABRD_PRNB_PERCENTAGE
                                          ,A.AVG_OF_ABRD_PRNB_PERCENTAGE
                                          ,  CASE
                                                 WHEN 0 > A.ABRD_PRNB - A.AVG_OF_ABRD_PRNB THEN A.ABRD_PRNB - A.AVG_OF_ABRD_PRNB
                                                 ELSE 0
                                             END
                                           * -1
                                               AS ESCAPE_CNT
                                          ,CASE
                                               WHEN 0 < A.ABRD_PRNB - A.AVG_OF_ABRD_PRNB THEN A.ABRD_PRNB - A.AVG_OF_ABRD_PRNB
                                               ELSE 0
                                           END
                                               AS MOVE_CNT
                                          ,A.SEG_GP_NO
                                      FROM (SELECT A.START_TM
                                                  ,A.TRN_NO
                                                  ,A.ABRD_PRNB
                                                  ,ROUND (C.AVG_OF_ABRD_PRNB) AS AVG_OF_ABRD_PRNB
                                                  ,B.SUM_OF_ABRD_PRNB
                                                  ,DECODE (B.SUM_OF_ABRD_PRNB, 0, 0, A.ABRD_PRNB / B.SUM_OF_ABRD_PRNB) AS ABRD_PRNB_PERCENTAGE
                                                  ,DECODE (D.SUM_OF_AVG_OF_ABRD_PRNB, 0, 0, C.AVG_OF_ABRD_PRNB / D.SUM_OF_AVG_OF_ABRD_PRNB) AS AVG_OF_ABRD_PRNB_PERCENTAGE
                                                  ,A.SEG_GP_NO
                                              FROM (  SELECT B.DPT_TM AS START_TM
                                                            ,A.TRN_NO AS TRN_NO
                                                            ,B.STOP_RS_STN_CD AS START_STN_CD
                                                            , (SELECT Y.KOR_STN_NM /* 한글역명           */
                                                                 FROM TB_YYDK001 X, TB_YYDK102 Y /* 역코드이력TBL     */
                                                                WHERE X.RS_STN_CD = B.STOP_RS_STN_CD
                                                                  AND X.STN_CD = Y.STN_CD
                                                                  AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                                                                 AS START_STN_NM
                                                            ,C.STOP_RS_STN_CD AS END_STN_CD
                                                            , (SELECT Y.KOR_STN_NM /* 한글역명           */
                                                                 FROM TB_YYDK001 X, TB_YYDK102 Y /* 역코드이력TBL     */
                                                                WHERE X.RS_STN_CD = C.STOP_RS_STN_CD
                                                                  AND X.STN_CD = Y.STN_CD
                                                                  AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                                                                 AS END_STN_NM
                                                            ,E.SEG_GP_NO AS SEG_GP_NO
                                                            ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                        FROM (  SELECT A.TRN_NO
                                                                      ,A.RUN_DT
                                                                      ,A.DPT_STN_CONS_ORDR
                                                                      ,A.ARV_STN_CONS_ORDR
                                                                      ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                  FROM TB_YYDS510 A, TB_YYDK002 B
                                                                 WHERE A.RUN_DT = '20140218'
                                                                   AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                   AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                                   AND A.RUN_DT = B.RUN_DT
                                                                   AND B.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                        FROM TB_YYDK002
                                                                                       WHERE RUN_DT = '20140218')
                                                              GROUP BY A.TRN_NO
                                                                      ,A.RUN_DT
                                                                      ,A.DPT_STN_CONS_ORDR
                                                                      ,A.ARV_STN_CONS_ORDR) A
                                                            ,TB_YYDK301 D
                                                            ,TB_YYDK302 B
                                                            ,TB_YYDK302 C
                                                            ,TB_YYDK308 E
                                                       WHERE A.TRN_NO = B.TRN_NO
                                                         AND A.RUN_DT = B.RUN_DT
                                                         AND B.STOP_RS_STN_CD = '0001'
                                                         AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                                                         AND A.TRN_NO = C.TRN_NO
                                                         AND A.RUN_DT = C.RUN_DT
                                                         AND C.STOP_RS_STN_CD = '0015'
                                                         AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                         AND A.TRN_NO = D.TRN_NO
                                                         AND A.RUN_DT = D.RUN_DT
                                                         AND ('00' IS NULL
                                                           OR D.STLB_TRN_CLSF_CD = '00')
                                                         AND A.TRN_NO = E.TRN_NO
                                                         AND A.RUN_DT = E.RUN_DT
                                                         AND B.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                                                         AND C.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                                                    GROUP BY B.DPT_TM
                                                            ,A.TRN_NO
                                                            ,E.SEG_GP_NO
                                                            ,B.STOP_RS_STN_CD
                                                            ,C.STOP_RS_STN_CD) A
                                                  ,(SELECT SUM (A.ABRD_PRNB) AS SUM_OF_ABRD_PRNB
                                                      FROM (  SELECT A.TRN_NO
                                                                    ,A.RUN_DT
                                                                    ,A.DPT_STN_CONS_ORDR
                                                                    ,A.ARV_STN_CONS_ORDR
                                                                    ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                FROM TB_YYDS510 A, TB_YYDK002 B
                                                               WHERE A.RUN_DT = '20140218'
                                                                 AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                 AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                                 AND A.RUN_DT = B.RUN_DT
                                                                 AND B.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                      FROM TB_YYDK002
                                                                                     WHERE RUN_DT = '20140218')
                                                            GROUP BY A.TRN_NO
                                                                    ,A.RUN_DT
                                                                    ,A.DPT_STN_CONS_ORDR
                                                                    ,A.ARV_STN_CONS_ORDR) A
                                                          ,TB_YYDK302 B
                                                          ,TB_YYDK302 C
                                                          ,TB_YYDK301 D
                                                          ,TB_YYDK308 E
                                                     WHERE A.TRN_NO = B.TRN_NO
                                                       AND B.RUN_DT = '20140218'
                                                       AND B.STOP_RS_STN_CD = '0001'
                                                       AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                                                       AND A.TRN_NO = C.TRN_NO
                                                       AND C.RUN_DT = '20140218'
                                                       AND C.STOP_RS_STN_CD = '0015'
                                                       AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                       AND A.TRN_NO = D.TRN_NO
                                                       AND D.RUN_DT = '20140218'
                                                       AND D.STLB_TRN_CLSF_CD = NVL ('00', D.STLB_TRN_CLSF_CD)
                                                       AND A.TRN_NO = E.TRN_NO
                                                       AND A.RUN_DT = E.RUN_DT
                                                       AND B.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                                                       AND C.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)) B
                                                  ,(  SELECT A.TRN_NO, SUM (A.AVG_OF_ABRD_PRNB) AS AVG_OF_ABRD_PRNB
                                                        FROM (  SELECT A.DPT_TM, A.TRN_NO, ROUND ( (A.ABRD_PRNB2 + A.ABRD_PRNB3 + A.ABRD_PRNB4 + A.ABRD_PRNB5) / 4) AS AVG_OF_ABRD_PRNB
                                                                  FROM (  SELECT A.DPT_TM
                                                                                ,A.TRN_NO
                                                                                ,A.BKCL_CD
                                                                                ,MAX (CASE
                                                                                          WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_1
                                                                                           AND REPLACE (A.RUN_DT, '-', NULL) = '20140218'
                                                                                          THEN
                                                                                              A.ABRD_PRNB
                                                                                          ELSE
0
                                                                                      END)
                                                                                     AS ABRD_PRNB1
                                                                                ,MAX (CASE
                                                                                          WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_5
                                                                                           AND REPLACE (A.RUN_DT, '-', NULL) <> '20140218'
                                                                                          THEN
                                                                                              A.ABRD_PRNB
                                                                                          ELSE
0
                                                                                      END)
                                                                                     AS ABRD_PRNB2
                                                                                ,MAX (CASE
                                                                                          WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_4
                                                                                           AND REPLACE (A.RUN_DT, '-', NULL) <> '20140218'
                                                                                          THEN
                                                                                              A.ABRD_PRNB
                                                                                          ELSE
0
                                                                                      END)
                                                                                     AS ABRD_PRNB3
                                                                                ,MAX (CASE
                                                                                          WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_3
                                                                                           AND REPLACE (A.RUN_DT, '-', NULL) <> '20140218'
                                                                                          THEN
                                                                                              A.ABRD_PRNB
                                                                                          ELSE
0
                                                                                      END)
                                                                                     AS ABRD_PRNB4
                                                                                ,MAX (CASE
                                                                                          WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_2
                                                                                           AND REPLACE (A.RUN_DT, '-', NULL) <> '20140218'
                                                                                          THEN
                                                                                              A.ABRD_PRNB
                                                                                          ELSE
0
                                                                                      END)
                                                                                     AS ABRD_PRNB5
                                                                            FROM (  SELECT A.DPT_TM
                                                                                          ,A.TRN_NO
                                                                                          ,A.RUN_DT
                                                                                          ,A.BKCL_CD
                                                                                          ,A.ABRD_PRNB
                                                                                      FROM (SELECT A.TRN_NO
                                                                                                  ,A.RUN_DT
                                                                                                  ,A.BKCL_CD
                                                                                                  ,A.ABRD_PRNB
                                                                                                  ,C.DPT_TM
                                                                                              FROM (  SELECT A.TRN_NO
                                                                                                            ,A.RUN_DT
                                                                                                            ,DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD) AS BKCL_CD
                                                                                                            ,A.DPT_STN_CONS_ORDR
                                                                                                            ,A.ARV_STN_CONS_ORDR
                                                                                                            ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                                                        FROM TB_YYDS510 A
                                                                                                       WHERE A.RUN_DT IN (SELECT A.RUN_DT
                                                                                                                            FROM (  SELECT A.RUN_DT
                                                                                                                                      FROM TB_YYDK002 A, TB_YYDK003 B
                                                                                                                                     WHERE A.RUN_DT = B.RUN_DT
                                                                                                                                       AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') - 56, 'YYYYMMDD')
                                                                                                                                                        AND '20140218'
                                                                                                                                       AND A.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                                                                                            FROM TB_YYDK002
                                                                                                                                                           WHERE RUN_DT = '20140218')
                                                                                                                                       AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                                                  ORDER BY A.RUN_DT DESC) A
                                                                                                                           WHERE ROWNUM < 6)
                                                                                                         AND A.TRN_NO IN (  SELECT DISTINCT A.TRN_NO
                                                                                                                              FROM (  SELECT A.TRN_NO
                                                                                                                                            ,A.RUN_DT
                                                                                                                                            ,A.DPT_STN_CONS_ORDR
                                                                                                                                            ,A.ARV_STN_CONS_ORDR
                                                                                                                                            ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                                                                                        FROM TB_YYDS510 A, TB_YYDK002 B
                                                                                                                                       WHERE A.RUN_DT = '20140218'
                                                                                                                                         AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                                                                                         AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                                                                                                         AND A.RUN_DT = B.RUN_DT
                                                                                                                                         AND B.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                                                                                              FROM TB_YYDK002
                                                                                                                                                             WHERE RUN_DT = '20140218')
                                                                                                                                    GROUP BY A.TRN_NO
                                                                                                                                            ,A.RUN_DT
                                                                                                                                            ,A.DPT_STN_CONS_ORDR
                                                                                                                                            ,A.ARV_STN_CONS_ORDR) A
                                                                                                                                  ,TB_YYDK302 B
                                                                                                                                  ,TB_YYDK302 C
                                                                                                                                  ,TB_YYDK301 D
                                                                                                                                  ,TB_YYDK308 E
                                                                                                                             WHERE A.TRN_NO = B.TRN_NO
                                                                                                                               AND A.RUN_DT = B.RUN_DT
                                                                                                                               AND B.STOP_RS_STN_CD = '0001'
                                                                                                                               AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                                                                                                                               AND A.TRN_NO = C.TRN_NO
                                                                                                                               AND A.RUN_DT = C.RUN_DT
                                                                                                                               AND C.STOP_RS_STN_CD = '0015'
                                                                                                                               AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                                                                                               AND A.TRN_NO = D.TRN_NO
                                                                                                                               AND A.RUN_DT = D.RUN_DT
                                                                                                                               AND D.STLB_TRN_CLSF_CD = NVL ('00', D.STLB_TRN_CLSF_CD)
                                                                                                                               AND A.TRN_NO = E.TRN_NO
                                                                                                                               AND A.RUN_DT = E.RUN_DT
                                                                                                                               AND B.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                                                                                                                               AND C.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                                                                                                                          GROUP BY B.DPT_TM
                                                                                                                                  ,A.TRN_NO
                                                                                                                                  ,E.SEG_GP_NO
                                                                                                                                  ,B.STOP_RS_STN_CD
                                                                                                                                  ,C.STOP_RS_STN_CD)
                                                                                                         AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                                                         AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                                                                    GROUP BY A.TRN_NO
                                                                                                            ,A.RUN_DT
                                                                                                            ,DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD)
                                                                                                            ,A.DPT_STN_CONS_ORDR
                                                                                                            ,A.ARV_STN_CONS_ORDR) A
                                                                                                  ,(  SELECT A.TRN_NO
                                                                                                            ,A.RUN_DT
                                                                                                            ,A.DPT_STN_CONS_ORDR
                                                                                                            ,A.ARV_STN_CONS_ORDR
                                                                                                            ,SUM (A.ABRD_PRNB) AS SUM_OF_ABRD_PRNB
                                                                                                        FROM TB_YYDS510 A
                                                                                                       WHERE A.RUN_DT IN (SELECT A.RUN_DT
                                                                                                                            FROM (  SELECT A.RUN_DT
                                                                                                                                      FROM TB_YYDK002 A, TB_YYDK003 B
                                                                                                                                     WHERE A.RUN_DT = B.RUN_DT
                                                                                                                                       AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') - 56, 'YYYYMMDD')
                                                                                                                                                        AND '20140218'
                                                                                                                                       AND A.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                                                                                            FROM TB_YYDK002
                                                                                                                                                           WHERE RUN_DT = '20140218')
                                                                                                                                       AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                                                  ORDER BY A.RUN_DT DESC) A
                                                                                                                           WHERE ROWNUM < 6)
                                                                                                         AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                                                         AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                                                                    GROUP BY A.TRN_NO
                                                                                                            ,A.RUN_DT
                                                                                                            ,A.DPT_STN_CONS_ORDR
                                                                                                            ,A.ARV_STN_CONS_ORDR) B
                                                                                                  ,TB_YYDK302 C
                                                                                                  ,TB_YYDK302 D
                                                                                                  ,TB_YYDK301 E
                                                                                                  ,TB_YYDK308 F
                                                                                             WHERE A.TRN_NO = B.TRN_NO
                                                                                               AND A.RUN_DT = B.RUN_DT
                                                                                               AND A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR
                                                                                               AND A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR
                                                                                               AND A.TRN_NO = C.TRN_NO
                                                                                               AND A.RUN_DT = C.RUN_DT
                                                                                               AND C.STOP_RS_STN_CD = '0001'
                                                                                               AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                                                               AND A.TRN_NO = D.TRN_NO
                                                                                               AND A.RUN_DT = D.RUN_DT
                                                                                               AND D.STOP_RS_STN_CD = '0015'
                                                                                               AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                                                                                               AND A.TRN_NO = E.TRN_NO
                                                                                               AND A.RUN_DT = E.RUN_DT
                                                                                               AND E.STLB_TRN_CLSF_CD = NVL ('00', E.STLB_TRN_CLSF_CD)
                                                                                               AND A.TRN_NO = F.TRN_NO
                                                                                               AND A.RUN_DT = F.RUN_DT
                                                                                               AND C.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', F.DPT_ZONE_NO, F.ARV_ZONE_NO)
                                                                                               AND D.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', F.ARV_ZONE_NO, F.DPT_ZONE_NO)) A
                                                                                  ORDER BY A.TRN_NO, A.DPT_TM, A.RUN_DT) A
                                                                                ,(SELECT MAX (DECODE (ROWNUM, 5, A.RUN_DT)) AS RUN_DT_5
                                                                                        ,MAX (DECODE (ROWNUM, 4, A.RUN_DT)) AS RUN_DT_4
                                                                                        ,MAX (DECODE (ROWNUM, 3, A.RUN_DT)) AS RUN_DT_3
                                                                                        ,MAX (DECODE (ROWNUM, 2, A.RUN_DT)) AS RUN_DT_2
                                                                                        ,MAX (DECODE (ROWNUM, 1, A.RUN_DT)) AS RUN_DT_1
                                                                                    FROM (  SELECT A.RUN_DT
                                                                                              FROM TB_YYDK002 A, TB_YYDK003 B
                                                                                             WHERE A.RUN_DT = B.RUN_DT
                                                                                               AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') - 56, 'YYYYMMDD') AND '20140218'
                                                                                               AND A.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                                                    FROM TB_YYDK002
                                                                                                                   WHERE RUN_DT = '20140218')
                                                                                               AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                          ORDER BY A.RUN_DT DESC) A) B
                                                                        GROUP BY A.DPT_TM, A.TRN_NO, A.BKCL_CD) A
                                                              ORDER BY A.DPT_TM, A.TRN_NO, A.BKCL_CD) A
                                                    GROUP BY A.TRN_NO) C
                                                  ,(SELECT SUM (A.AVG_OF_ABRD_PRNB) AS SUM_OF_AVG_OF_ABRD_PRNB
                                                      FROM (  SELECT A.TRN_NO, SUM (A.AVG_OF_ABRD_PRNB) AS AVG_OF_ABRD_PRNB
                                                                FROM (  SELECT A.DPT_TM, A.TRN_NO, ROUND ( (A.ABRD_PRNB2 + A.ABRD_PRNB3 + A.ABRD_PRNB4 + A.ABRD_PRNB5) / 4) AS AVG_OF_ABRD_PRNB
                                                                          FROM (  SELECT A.DPT_TM
                                                                                        ,A.TRN_NO
                                                                                        ,A.BKCL_CD
                                                                                        ,MAX (CASE
                                                                                                  WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_1
                                                                                                   AND REPLACE (A.RUN_DT, '-', NULL) = '20140218'
                                                                                                  THEN
                                                                                                      A.ABRD_PRNB
                                                                                                  ELSE
0
                                                                                              END)
                                                                                             AS ABRD_PRNB1
                                                                                        ,MAX (CASE
                                                                                                  WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_5
                                                                                                   AND REPLACE (A.RUN_DT, '-', NULL) <> '20140218'
                                                                                                  THEN
                                                                                                      A.ABRD_PRNB
                                                                                                  ELSE
0
                                                                                              END)
                                                                                             AS ABRD_PRNB2
                                                                                        ,MAX (CASE
                                                                                                  WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_4
                                                                                                   AND REPLACE (A.RUN_DT, '-', NULL) <> '20140218'
                                                                                                  THEN
                                                                                                      A.ABRD_PRNB
                                                                                                  ELSE
0
                                                                                              END)
                                                                                             AS ABRD_PRNB3
                                                                                        ,MAX (CASE
                                                                                                  WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_3
                                                                                                   AND REPLACE (A.RUN_DT, '-', NULL) <> '20140218'
                                                                                                  THEN
                                                                                                      A.ABRD_PRNB
                                                                                                  ELSE
0
                                                                                              END)
                                                                                             AS ABRD_PRNB4
                                                                                        ,MAX (CASE
                                                                                                  WHEN REPLACE (A.RUN_DT, '-', NULL) = B.RUN_DT_2
                                                                                                   AND REPLACE (A.RUN_DT, '-', NULL) <> '20140218'
                                                                                                  THEN
                                                                                                      A.ABRD_PRNB
                                                                                                  ELSE
0
                                                                                              END)
                                                                                             AS ABRD_PRNB5
                                                                                    FROM (  SELECT A.DPT_TM
                                                                                                  ,A.TRN_NO
                                                                                                  ,A.RUN_DT
                                                                                                  ,A.BKCL_CD
                                                                                                  ,A.ABRD_PRNB
                                                                                              FROM (SELECT A.TRN_NO
                                                                                                          ,A.RUN_DT
                                                                                                          ,A.BKCL_CD
                                                                                                          ,A.ABRD_PRNB
                                                                                                          ,C.DPT_TM
                                                                                                      FROM (  SELECT A.TRN_NO
                                                                                                                    ,A.RUN_DT
                                                                                                                    ,DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD) AS BKCL_CD
                                                                                                                    ,A.DPT_STN_CONS_ORDR
                                                                                                                    ,A.ARV_STN_CONS_ORDR
                                                                                                                    ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                                                                FROM TB_YYDS510 A
                                                                                                               WHERE A.RUN_DT IN (SELECT A.RUN_DT
                                                                                                                                    FROM (  SELECT A.RUN_DT
                                                                                                                                              FROM TB_YYDK002 A, TB_YYDK003 B
                                                                                                                                             WHERE A.RUN_DT = B.RUN_DT
                                                                                                                                               AND A.RUN_DT BETWEEN TO_CHAR
                                                                                                                                                                    (
                                                                                                                                                                        TO_DATE ('20140218', 'YYYYMMDD') - 56
                                                                                                                                                                       ,'YYYYMMDD'
                                                                                                                                                                    )
                                                                                                                                                                AND '20140218'
                                                                                                                                               AND A.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                                                                                                    FROM TB_YYDK002
                                                                                                                                                                   WHERE RUN_DT = '20140218')
                                                                                                                                               AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                                                          ORDER BY A.RUN_DT DESC) A
                                                                                                                                   WHERE ROWNUM < 6)
                                                                                                                 AND A.TRN_NO IN
                                                                                                                         (  SELECT DISTINCT A.TRN_NO
                                                                                                                              FROM (  SELECT A.TRN_NO
                                                                                                                                            ,A.RUN_DT
                                                                                                                                            ,A.DPT_STN_CONS_ORDR
                                                                                                                                            ,A.ARV_STN_CONS_ORDR
                                                                                                                                            ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                                                                                        FROM TB_YYDS510 A, TB_YYDK002 B
                                                                                                                                       WHERE A.RUN_DT = '20140218'
                                                                                                                                         AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                                                                                         AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                                                                                                         AND A.RUN_DT = B.RUN_DT
                                                                                                                                         AND B.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                                                                                              FROM TB_YYDK002
                                                                                                                                                             WHERE RUN_DT = '20140218')
                                                                                                                                    GROUP BY A.TRN_NO
                                                                                                                                            ,A.RUN_DT
                                                                                                                                            ,A.DPT_STN_CONS_ORDR
                                                                                                                                            ,A.ARV_STN_CONS_ORDR) A
                                                                                                                                  ,TB_YYDK302 B
                                                                                                                                  ,TB_YYDK302 C
                                                                                                                                  ,TB_YYDK301 D
                                                                                                                                  ,TB_YYDK308 E
                                                                                                                             WHERE A.TRN_NO = B.TRN_NO
                                                                                                                               AND A.RUN_DT = B.RUN_DT
                                                                                                                               AND B.STOP_RS_STN_CD = '0001'
                                                                                                                               AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                                                                                                                               AND A.TRN_NO = C.TRN_NO
                                                                                                                               AND A.RUN_DT = C.RUN_DT
                                                                                                                               AND C.STOP_RS_STN_CD = '0015'
                                                                                                                               AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                                                                                               AND A.TRN_NO = D.TRN_NO
                                                                                                                               AND A.RUN_DT = D.RUN_DT
                                                                                                                               AND D.STLB_TRN_CLSF_CD = NVL ('00', D.STLB_TRN_CLSF_CD)
                                                                                                                               AND A.TRN_NO = E.TRN_NO
                                                                                                                               AND A.RUN_DT = E.RUN_DT
                                                                                                                               AND B.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                                                                                                                               AND C.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                                                                                                                          GROUP BY B.DPT_TM
                                                                                                                                  ,A.TRN_NO
                                                                                                                                  ,E.SEG_GP_NO
                                                                                                                                  ,B.STOP_RS_STN_CD
                                                                                                                                  ,C.STOP_RS_STN_CD)
                                                                                                                 AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                                                                 AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                                                                            GROUP BY A.TRN_NO
                                                                                                                    ,A.RUN_DT
                                                                                                                    ,DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD)
                                                                                                                    ,A.DPT_STN_CONS_ORDR
                                                                                                                    ,A.ARV_STN_CONS_ORDR) A
                                                                                                          ,(  SELECT A.TRN_NO
                                                                                                                    ,A.RUN_DT
                                                                                                                    ,A.DPT_STN_CONS_ORDR
                                                                                                                    ,A.ARV_STN_CONS_ORDR
                                                                                                                    ,SUM (A.ABRD_PRNB) AS SUM_OF_ABRD_PRNB
                                                                                                                FROM TB_YYDS510 A
                                                                                                               WHERE A.RUN_DT IN (SELECT A.RUN_DT
                                                                                                                                    FROM (  SELECT A.RUN_DT
                                                                                                                                              FROM TB_YYDK002 A, TB_YYDK003 B
                                                                                                                                             WHERE A.RUN_DT = B.RUN_DT
                                                                                                                                               AND A.RUN_DT BETWEEN TO_CHAR
                                                                                                                                                                    (
                                                                                                                                                                        TO_DATE ('20140218', 'YYYYMMDD') - 56
                                                                                                                                                                       ,'YYYYMMDD'
                                                                                                                                                                    )
                                                                                                                                                                AND '20140218'
                                                                                                                                               AND A.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                                                                                                    FROM TB_YYDK002
                                                                                                                                                                   WHERE RUN_DT = '20140218')
                                                                                                                                               AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                                                          ORDER BY A.RUN_DT DESC) A
                                                                                                                                   WHERE ROWNUM < 6)
                                                                                                                 AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                                                                 AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                                                                            GROUP BY A.TRN_NO
                                                                                                                    ,A.RUN_DT
                                                                                                                    ,A.DPT_STN_CONS_ORDR
                                                                                                                    ,A.ARV_STN_CONS_ORDR) B
                                                                                                          ,TB_YYDK302 C
                                                                                                          ,TB_YYDK302 D
                                                                                                          ,TB_YYDK301 E
                                                                                                          ,TB_YYDK308 F
                                                                                                     WHERE A.TRN_NO = B.TRN_NO
                                                                                                       AND A.RUN_DT = B.RUN_DT
                                                                                                       AND A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR
                                                                                                       AND A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR
                                                                                                       AND A.TRN_NO = C.TRN_NO
                                                                                                       AND A.RUN_DT = C.RUN_DT
                                                                                                       AND C.STOP_RS_STN_CD = '0001'
                                                                                                       AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                                                                       AND A.TRN_NO = D.TRN_NO
                                                                                                       AND A.RUN_DT = D.RUN_DT
                                                                                                       AND D.STOP_RS_STN_CD = '0015'
                                                                                                       AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                                                                                                       AND A.TRN_NO = E.TRN_NO
                                                                                                       AND A.RUN_DT = E.RUN_DT
                                                                                                       AND E.STLB_TRN_CLSF_CD = NVL ('00', E.STLB_TRN_CLSF_CD)
                                                                                                       AND A.TRN_NO = F.TRN_NO
                                                                                                       AND A.RUN_DT = F.RUN_DT
                                                                                                       AND C.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', F.DPT_ZONE_NO, F.ARV_ZONE_NO)
                                                                                                       AND D.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', F.ARV_ZONE_NO, F.DPT_ZONE_NO)) A
                                                                                          ORDER BY A.TRN_NO, A.DPT_TM, A.RUN_DT) A
                                                                                        ,(SELECT MAX (DECODE (ROWNUM, 5, A.RUN_DT)) AS RUN_DT_5
                                                                                                ,MAX (DECODE (ROWNUM, 4, A.RUN_DT)) AS RUN_DT_4
                                                                                                ,MAX (DECODE (ROWNUM, 3, A.RUN_DT)) AS RUN_DT_3
                                                                                                ,MAX (DECODE (ROWNUM, 2, A.RUN_DT)) AS RUN_DT_2
                                                                                                ,MAX (DECODE (ROWNUM, 1, A.RUN_DT)) AS RUN_DT_1
                                                                                            FROM (  SELECT A.RUN_DT
                                                                                                      FROM TB_YYDK002 A, TB_YYDK003 B
                                                                                                     WHERE A.RUN_DT = B.RUN_DT
                                                                                                       AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') - 56, 'YYYYMMDD') AND '20140218'
                                                                                                       AND A.DAY_DV_CD = (SELECT DAY_DV_CD
                                                                                                                            FROM TB_YYDK002
                                                                                                                           WHERE RUN_DT = '20140218')
                                                                                                       AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                  ORDER BY A.RUN_DT DESC) A) B
                                                                                GROUP BY A.DPT_TM, A.TRN_NO, A.BKCL_CD) A
                                                                      ORDER BY A.DPT_TM, A.TRN_NO, A.BKCL_CD) A
                                                            GROUP BY A.TRN_NO) A) D
                                             WHERE A.TRN_NO = C.TRN_NO(+)) A) A
                                  ,(  SELECT A.TRN_NO
                                            ,A.D_DAY
                                            ,B.D_DAY AS CLOSE_DAY
                                            ,A.DPT_STN_CONS_ORDR
                                            ,A.ARV_STN_CONS_ORDR
                                            ,A.SEG_GP_NO
                                            ,A.RESERVE_CNT
                                            ,A.CANCEL_CNT
                                        FROM (  SELECT A.TRN_NO
                                                      ,TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (A.DEAL_DT, 'YYYYMMDD') AS D_DAY
                                                      ,A.DPT_STN_CONS_ORDR
                                                      ,A.ARV_STN_CONS_ORDR
                                                      ,D.SEG_GP_NO
                                                      ,SUM (A.RSV_SEAT_NUM) + SUM (A.SALE_SEAT_NUM) AS RESERVE_CNT
                                                      ,SUM (A.CNC_SEAT_NUM) + SUM (A.RET_SEAT_NUM) AS CANCEL_CNT
                                                  FROM TB_YYDS501 A
                                                      ,TB_YYDK302 B
                                                      ,TB_YYDK302 C
                                                      ,TB_YYDK308 D
                                                      ,TB_YYDK301 E
                                                 WHERE A.RUN_DT = '20140218'
                                                   AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                   AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                   AND A.RUN_DT >= A.DEAL_DT
                                                   AND A.TRN_NO = B.TRN_NO
                                                   AND A.RUN_DT = B.RUN_DT
                                                   AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                                                   AND B.STOP_RS_STN_CD = '0001'
                                                   AND A.TRN_NO = C.TRN_NO
                                                   AND A.RUN_DT = C.RUN_DT
                                                   AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                   AND C.STOP_RS_STN_CD = '0015'
                                                   AND A.TRN_NO = E.TRN_NO
                                                   AND A.RUN_DT = E.RUN_DT
                                                   AND A.TRN_NO = D.TRN_NO
                                                   AND A.RUN_DT = D.RUN_DT
                                                   AND B.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', D.DPT_ZONE_NO, D.ARV_ZONE_NO)
                                                   AND C.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', D.ARV_ZONE_NO, D.DPT_ZONE_NO)
                                              GROUP BY A.TRN_NO
                                                      ,TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (A.DEAL_DT, 'YYYYMMDD')
                                                      ,A.DPT_STN_CONS_ORDR
                                                      ,A.ARV_STN_CONS_ORDR
                                                      ,D.SEG_GP_NO
                                                      ,A.RUN_DT
                                                      ,A.DEAL_DT) A
                                            ,(  SELECT A.TRN_NO, A.ZONE_SEG_GP_NO, MAX (A.D_DAY) AS D_DAY
                                                  FROM (  SELECT A.TRN_NO, A.ZONE_SEG_GP_NO, TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (SUBSTR (A.YMGT_JOB_ID, 14, 8), 'YYYYMMDD') AS D_DAY
                                                            FROM TB_YYPD006 A
                                                           WHERE A.RUN_DT = '20140218'
                                                             AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                             AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                          HAVING DECODE ('',  'F1', SUM (NVL (A.GP_MRK_ALLW_NUM, 0)),  NULL, SUM (NVL (A.GP_MRK_ALLW_NUM, 0)),  SUM (NVL (A.BKCL_MRK_ALLW_NUM, 0))) = 0
                                                        GROUP BY A.RUN_DT
                                                                ,A.TRN_NO
                                                                ,A.ZONE_SEG_GP_NO
                                                                ,SUBSTR (A.YMGT_JOB_ID, 14, 8)
                                                        ORDER BY 1, 2, 3) A
                                              GROUP BY A.TRN_NO, A.ZONE_SEG_GP_NO) B
                                       WHERE A.TRN_NO = B.TRN_NO(+)
                                         AND A.SEG_GP_NO = B.ZONE_SEG_GP_NO(+)
                                         AND A.D_DAY = B.D_DAY(+)
                                    ORDER BY 1, 2) B
                             WHERE A.TRN_NO = B.TRN_NO
                               AND A.SEG_GP_NO = B.SEG_GP_NO
                               AND B.D_DAY <= '32') A1) A2
                  ,(SELECT ROWNUM - 1 AS RNUM
                      FROM TB_YYDK002
                     WHERE ROWNUM <= 32) B2
             WHERE B2.RNUM = A2.D_DAY
          ORDER BY A2.START_TM, A2.TRN_NO, B2.RNUM DESC) A
GROUP BY A.START_TM
        ,A.TRN_NO
        ,A.ABRD_PRNB
        ,A.AVG_OF_ABRD_PRNB
        ,A.ABRD_PRNB_PERCENTAGE
        ,A.AVG_OF_ABRD_PRNB_PERCENTAGE
        ,A.MOVE_CNT
        ,A.ESCAPE_CNT




튜닝 내용 

  - 힌트 추가 ( USE_MERGE(A B C D) ) : 위치 확인 할 것 . 103 줄에 추가 할 것.
     ( 각각의 view 가 응답이 양호함)
                


-------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                                                  | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                                           |            |     1 |   133 |  1027   (3)| 00:00:13 |
|   1 |  HASH GROUP BY                                             |            |     1 |   133 |  1027   (3)| 00:00:13 |
|   2 |   VIEW                                                     |            |     1 |   133 |  1026   (3)| 00:00:13 |
|   3 |    WINDOW SORT                                             |            |     1 |   157 |  1026   (3)| 00:00:13 |
|   4 |     MERGE JOIN CARTESIAN                                   |            |     1 |   157 |  1026   (3)| 00:00:13 |
|   5 |      NESTED LOOPS OUTER                                    |            |     1 |   144 |   476   (4)| 00:00:06 |
|   6 |       NESTED LOOPS                                         |            |     1 |   129 |   434   (3)| 00:00:06 |
|*  7 |        HASH JOIN                                           |            |     1 |    87 |   425   (3)| 00:00:06 |
|   8 |         NESTED LOOPS                                       |            |     4 |   296 |   424   (3)| 00:00:06 |
|   9 |          VIEW                                              |            |     1 |    13 |   199   (2)| 00:00:03 |
|  10 |           SORT AGGREGATE                                   |            |     1 |    13 |            |          |
|  11 |            VIEW                                            | VM_NWVW_9  |     1 |    13 |   199   (2)| 00:00:03 |
|  12 |             HASH GROUP BY                                  |            |     1 |   184 |   199   (2)| 00:00:03 |
|  13 |              NESTED LOOPS                                  |            |     1 |   184 |   197   (1)| 00:00:03 |
|  14 |               NESTED LOOPS                                 |            |     5 |   755 |   194   (1)| 00:00:03 |
|* 15 |                HASH JOIN                                   |            |    66 |  7392 |   154   (1)| 00:00:02 |
|* 16 |                 TABLE ACCESS BY INDEX ROWID                | TB_YYDK301 |   149 |  4768 |     9   (0)| 00:00:01 |
|* 17 |                  INDEX RANGE SCAN                          | PK_YYDK301 |   258 |       |     1   (0)| 00:00:01 |
|* 18 |                 HASH JOIN                                  |            |   162 | 12960 |   145   (1)| 00:00:02 |
|  19 |                  NESTED LOOPS                              |            |   156 |  7800 |    78   (0)| 00:00:01 |
|* 20 |                   TABLE ACCESS BY INDEX ROWID              | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|* 21 |                    INDEX UNIQUE SCAN                       | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|  22 |                    TABLE ACCESS BY INDEX ROWID             | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|* 23 |                     INDEX UNIQUE SCAN                      | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|* 24 |                   TABLE ACCESS BY INDEX ROWID              | TB_YYDK302 |   156 |  6084 |    77   (0)| 00:00:01 |
|* 25 |                    INDEX RANGE SCAN                        | PK_YYDK302 |  2233 |       |     3   (0)| 00:00:01 |
|  26 |                  TABLE ACCESS BY INDEX ROWID               | TB_YYDS510 |  2114 | 63420 |    66   (0)| 00:00:01 |
|* 27 |                   INDEX RANGE SCAN                         | PK_YYDS510 |  2114 |       |    37   (0)| 00:00:01 |
|* 28 |                TABLE ACCESS BY INDEX ROWID                 | TB_YYDK302 |     1 |    39 |     1   (0)| 00:00:01 |
|* 29 |                 INDEX UNIQUE SCAN                          | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|* 30 |               INDEX RANGE SCAN                             | PK_YYDK308 |     1 |    33 |     1   (0)| 00:00:01 |
|  31 |          VIEW                                              |            |     4 |   244 |   225   (4)| 00:00:03 |
|  32 |           SORT ORDER BY                                    |            |     4 |   336 |   225   (4)| 00:00:03 |
|  33 |            NESTED LOOPS OUTER                              |            |     4 |   336 |   224   (3)| 00:00:03 |
|  34 |             VIEW                                           |            |     4 |   268 |   191   (2)| 00:00:03 |
|  35 |              SORT GROUP BY                                 |            |     4 |   572 |   191   (2)| 00:00:03 |
|  36 |               NESTED LOOPS                                 |            |       |       |            |          |
|  37 |                NESTED LOOPS                                |            |     4 |   572 |   190   (1)| 00:00:03 |
|  38 |                 NESTED LOOPS                               |            |    24 |  2784 |   175   (1)| 00:00:03 |
|  39 |                  NESTED LOOPS                              |            |    26 |  2392 |   152   (1)| 00:00:02 |
|* 40 |                   HASH JOIN                                |            |    26 |  1690 |   136   (1)| 00:00:02 |
|  41 |                    TABLE ACCESS BY INDEX ROWID             | TB_YYDS501 |   101 |  4848 |   127   (1)| 00:00:02 |
|* 42 |                     INDEX RANGE SCAN                       | PK_YYDS501 |   101 |       |   123   (1)| 00:00:02 |
|  43 |                    TABLE ACCESS BY INDEX ROWID             | TB_YYDK301 |   258 |  4386 |     9   (0)| 00:00:01 |
|* 44 |                     INDEX RANGE SCAN                       | PK_YYDK301 |   258 |       |     1   (0)| 00:00:01 |
|* 45 |                   TABLE ACCESS BY INDEX ROWID              | TB_YYDK302 |     1 |    27 |     1   (0)| 00:00:01 |
|* 46 |                    INDEX UNIQUE SCAN                       | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|  47 |                  TABLE ACCESS BY INDEX ROWID               | TB_YYDK308 |     1 |    24 |     1   (0)| 00:00:01 |
|* 48 |                   INDEX RANGE SCAN                         | PK_YYDK308 |     1 |       |     1   (0)| 00:00:01 |
|* 49 |                 INDEX UNIQUE SCAN                          | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|* 50 |                TABLE ACCESS BY INDEX ROWID                 | TB_YYDK302 |     1 |    27 |     1   (0)| 00:00:01 |
|* 51 |             VIEW PUSHED PREDICATE                          |            |     1 |    17 |     8  (13)| 00:00:01 |
|  52 |              SORT GROUP BY                                 |            |     1 |    14 |     8  (13)| 00:00:01 |
|  53 |               VIEW                                         |            |     1 |    14 |     8  (13)| 00:00:01 |
|* 54 |                FILTER                                      |            |       |       |            |          |
|  55 |                 SORT GROUP BY                              |            |     1 |    53 |     8  (13)| 00:00:01 |
|  56 |                  TABLE ACCESS BY INDEX ROWID               | TB_YYPD006 |     9 |   477 |     7   (0)| 00:00:01 |
|* 57 |                   INDEX RANGE SCAN                         | PK_YYPD006 |     9 |       |     4   (0)| 00:00:01 |
|  58 |         VIEW                                               |            |    32 |   416 |     1   (0)| 00:00:01 |
|* 59 |          COUNT STOPKEY                                     |            |       |       |            |          |
|  60 |           INDEX FULL SCAN                                  | PK_YYDK002 |    32 |       |     1   (0)| 00:00:01 |
|* 61 |        VIEW PUSHED PREDICATE                               |            |     1 |    42 |     9  (23)| 00:00:01 |
|  62 |         SORT GROUP BY                                      |            |     1 |   139 |     9  (23)| 00:00:01 |
|  63 |          NESTED LOOPS                                      |            |       |       |            |          |
|  64 |           NESTED LOOPS                                     |            |     1 |   139 |     8  (13)| 00:00:01 |
|  65 |            NESTED LOOPS                                    |            |     1 |   115 |     7  (15)| 00:00:01 |
|  66 |             NESTED LOOPS                                   |            |     1 |    95 |     6  (17)| 00:00:01 |
|  67 |              NESTED LOOPS                                  |            |     1 |    61 |     5  (20)| 00:00:01 |
|  68 |               VIEW                                         |            |     1 |    34 |     4  (25)| 00:00:01 |
|  69 |                SORT GROUP BY                               |            |     1 |    41 |     4  (25)| 00:00:01 |
|  70 |                 NESTED LOOPS                               |            |     6 |   246 |     2   (0)| 00:00:01 |
|* 71 |                  TABLE ACCESS BY INDEX ROWID               | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|* 72 |                   INDEX UNIQUE SCAN                        | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|  73 |                   TABLE ACCESS BY INDEX ROWID              | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|* 74 |                    INDEX UNIQUE SCAN                       | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|  75 |                  TABLE ACCESS BY INDEX ROWID               | TB_YYDS510 |     6 |   180 |     1   (0)| 00:00:01 |
|* 76 |                   INDEX RANGE SCAN                         | PK_YYDS510 |     6 |       |     1   (0)| 00:00:01 |
|* 77 |               TABLE ACCESS BY INDEX ROWID                  | TB_YYDK302 |     1 |    27 |     1   (0)| 00:00:01 |
|* 78 |                INDEX UNIQUE SCAN                           | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|* 79 |              TABLE ACCESS BY INDEX ROWID                   | TB_YYDK302 |     1 |    34 |     1   (0)| 00:00:01 |
|* 80 |               INDEX UNIQUE SCAN                            | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|* 81 |             TABLE ACCESS BY INDEX ROWID                    | TB_YYDK301 |     1 |    20 |     1   (0)| 00:00:01 |
|* 82 |              INDEX UNIQUE SCAN                             | PK_YYDK301 |     1 |       |     1   (0)| 00:00:01 |
|* 83 |            INDEX RANGE SCAN                                | PK_YYDK308 |     1 |       |     1   (0)| 00:00:01 |
|  84 |           TABLE ACCESS BY INDEX ROWID                      | TB_YYDK308 |     1 |    24 |     1   (0)| 00:00:01 |
|  85 |       VIEW PUSHED PREDICATE                                |            |     1 |    15 |    42  (12)| 00:00:01 |
|  86 |        SORT GROUP BY                                       |            |     1 |    19 |    42  (12)| 00:00:01 |
|  87 |         VIEW                                               |            |     1 |    19 |    42  (12)| 00:00:01 |
|  88 |          SORT GROUP BY                                     |            |     1 |   163 |    42  (12)| 00:00:01 |
|  89 |           MERGE JOIN CARTESIAN                             |            |     1 |   163 |    41  (10)| 00:00:01 |
|  90 |            NESTED LOOPS                                    |            |     1 |   139 |    30  (14)| 00:00:01 |
|  91 |             NESTED LOOPS                                   |            |     1 |   139 |    24  (17)| 00:00:01 |
|  92 |              NESTED LOOPS                                  |            |     1 |   119 |    23  (18)| 00:00:01 |
|  93 |               NESTED LOOPS                                 |            |     1 |    98 |    22  (19)| 00:00:01 |
|  94 |                NESTED LOOPS                                |            |     1 |    71 |    21  (20)| 00:00:01 |
|  95 |                 VIEW                                       |            |     1 |    37 |    20  (20)| 00:00:01 |
|  96 |                  SORT GROUP BY                             |            |     1 |    45 |    20  (20)| 00:00:01 |
|* 97 |                   HASH JOIN SEMI                           |            |     1 |    45 |    19  (16)| 00:00:01 |
|  98 |                    NESTED LOOPS                            |            |       |       |            |          |
|  99 |                     NESTED LOOPS                           |            |    29 |  1131 |    10  (10)| 00:00:01 |
| 100 |                      VIEW                                  | VW_NSO_5   |     5 |    45 |     5   (0)| 00:00:01 |
| 101 |                       SORT UNIQUE                          |            |     5 |    60 |            |          |
|*102 |                        COUNT STOPKEY                       |            |       |       |            |          |
|*103 |                         VIEW                               |            |     6 |    72 |     4   (0)| 00:00:01 |
| 104 |                          NESTED LOOPS                      |            |       |       |            |          |
| 105 |                           NESTED LOOPS                     |            |     6 |   132 |     4   (0)| 00:00:01 |
|*106 |                            TABLE ACCESS BY INDEX ROWID     | TB_YYDK003 |    52 |   572 |     2   (0)| 00:00:01 |
|*107 |                             INDEX RANGE SCAN DESCENDING    | PK_YYDK003 |     8 |       |     1   (0)| 00:00:01 |
|*108 |                            INDEX UNIQUE SCAN               | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
| 109 |                           TABLE ACCESS BY INDEX ROWID      | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
| 110 |                          TABLE ACCESS BY INDEX ROWID       | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*111 |                           INDEX UNIQUE SCAN                | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|*112 |                      INDEX RANGE SCAN                      | PK_YYDS510 |     6 |       |     1   (0)| 00:00:01 |
| 113 |                     TABLE ACCESS BY INDEX ROWID            | TB_YYDS510 |     6 |   180 |     1   (0)| 00:00:01 |
| 114 |                    VIEW                                    | VW_NSO_6   |     1 |     6 |     8  (13)| 00:00:01 |
| 115 |                     SORT GROUP BY                          |            |     1 |    26 |     8  (13)| 00:00:01 |
| 116 |                      VIEW                                  | VM_NWVW_8  |     1 |    26 |     8  (13)| 00:00:01 |
| 117 |                       SORT GROUP BY                        |            |     1 |   191 |     8  (13)| 00:00:01 |
| 118 |                        NESTED LOOPS                        |            |       |       |            |          |
| 119 |                         NESTED LOOPS                       |            |     1 |   191 |     6   (0)| 00:00:01 |
| 120 |                          NESTED LOOPS                      |            |     1 |   155 |     5   (0)| 00:00:01 |
| 121 |                           NESTED LOOPS                     |            |     1 |   109 |     4   (0)| 00:00:01 |
| 122 |                            NESTED LOOPS                    |            |     1 |    70 |     3   (0)| 00:00:01 |
| 123 |                             NESTED LOOPS                   |            |     1 |    43 |     2   (0)| 00:00:01 |
|*124 |                              TABLE ACCESS BY INDEX ROWID   | TB_YYDK301 |     1 |    32 |     1   (0)| 00:00:01 |
|*125 |                               INDEX UNIQUE SCAN            | PK_YYDK301 |     1 |       |     1   (0)| 00:00:01 |
|*126 |                              TABLE ACCESS BY INDEX ROWID   | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*127 |                               INDEX UNIQUE SCAN            | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
| 128 |                               TABLE ACCESS BY INDEX ROWID  | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*129 |                                INDEX UNIQUE SCAN           | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|*130 |                             INDEX RANGE SCAN               | PK_YYDS510 |     1 |    27 |     1   (0)| 00:00:01 |
|*131 |                            TABLE ACCESS BY INDEX ROWID     | TB_YYDK302 |     1 |    39 |     1   (0)| 00:00:01 |
|*132 |                             INDEX UNIQUE SCAN              | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|*133 |                           TABLE ACCESS BY INDEX ROWID      | TB_YYDK302 |     1 |    46 |     1   (0)| 00:00:01 |
|*134 |                            INDEX UNIQUE SCAN               | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|*135 |                          INDEX RANGE SCAN                  | PK_YYDK308 |     1 |       |     1   (0)| 00:00:01 |
| 136 |                         TABLE ACCESS BY INDEX ROWID        | TB_YYDK308 |     1 |    36 |     1   (0)| 00:00:01 |
|*137 |                 TABLE ACCESS BY INDEX ROWID                | TB_YYDK302 |     1 |    34 |     1   (0)| 00:00:01 |
|*138 |                  INDEX UNIQUE SCAN                         | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|*139 |                TABLE ACCESS BY INDEX ROWID                 | TB_YYDK302 |     1 |    27 |     1   (0)| 00:00:01 |
|*140 |                 INDEX UNIQUE SCAN                          | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|*141 |               INDEX RANGE SCAN                             | PK_YYDK308 |     1 |    21 |     1   (0)| 00:00:01 |
|*142 |              TABLE ACCESS BY INDEX ROWID                   | TB_YYDK301 |     1 |    20 |     1   (0)| 00:00:01 |
|*143 |               INDEX UNIQUE SCAN                            | PK_YYDK301 |     1 |       |     1   (0)| 00:00:01 |
| 144 |             VIEW PUSHED PREDICATE                          |            |     1 |       |     6   (0)| 00:00:01 |
|*145 |              FILTER                                        |            |       |       |            |          |
| 146 |               SORT AGGREGATE                               |            |     1 |    40 |            |          |
|*147 |                HASH JOIN SEMI                              |            |     1 |    40 |     6   (0)| 00:00:01 |
| 148 |                 TABLE ACCESS BY INDEX ROWID                | TB_YYDS510 |     1 |    30 |     1   (0)| 00:00:01 |
|*149 |                  INDEX RANGE SCAN                          | PK_YYDS510 |     1 |       |     1   (0)| 00:00:01 |
|*150 |                 VIEW                                       | VW_NSO_4   |     5 |    50 |     5   (0)| 00:00:01 |
|*151 |                  COUNT STOPKEY                             |            |       |       |            |          |
|*152 |                   VIEW                                     |            |     6 |    72 |     4   (0)| 00:00:01 |
| 153 |                    NESTED LOOPS                            |            |       |       |            |          |
| 154 |                     NESTED LOOPS                           |            |     6 |   132 |     4   (0)| 00:00:01 |
|*155 |                      TABLE ACCESS BY INDEX ROWID           | TB_YYDK003 |    52 |   572 |     2   (0)| 00:00:01 |
|*156 |                       INDEX RANGE SCAN DESCENDING          | PK_YYDK003 |     8 |       |     1   (0)| 00:00:01 |
|*157 |                      INDEX UNIQUE SCAN                     | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
| 158 |                     TABLE ACCESS BY INDEX ROWID            | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
| 159 |                    TABLE ACCESS BY INDEX ROWID             | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*160 |                     INDEX UNIQUE SCAN                      | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
| 161 |            BUFFER SORT                                     |            |     1 |    24 |    36  (14)| 00:00:01 |
| 162 |             VIEW                                           |            |     1 |    24 |    11   (0)| 00:00:01 |
| 163 |              SORT AGGREGATE                                |            |     1 |    10 |            |          |
| 164 |               COUNT                                        |            |       |       |            |          |
| 165 |                VIEW                                        |            |     8 |    80 |    11   (0)| 00:00:01 |
| 166 |                 NESTED LOOPS                               |            |       |       |            |          |
| 167 |                  NESTED LOOPS                              |            |     8 |   176 |    10   (0)| 00:00:01 |
|*168 |                   TABLE ACCESS BY INDEX ROWID              | TB_YYDK002 |     8 |    88 |     5   (0)| 00:00:01 |
|*169 |                    INDEX RANGE SCAN DESCENDING             | PK_YYDK002 |    57 |       |     1   (0)| 00:00:01 |
| 170 |                    TABLE ACCESS BY INDEX ROWID             | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*171 |                     INDEX UNIQUE SCAN                      | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|*172 |                   INDEX RANGE SCAN                         | PK_YYDK003 |     1 |       |     1   (0)| 00:00:01 |
|*173 |                  TABLE ACCESS BY INDEX ROWID               | TB_YYDK003 |     1 |    11 |     1   (0)| 00:00:01 |
| 174 |      BUFFER SORT                                           |            |     1 |    13 |   984   (3)| 00:00:12 |
| 175 |       VIEW                                                 |            |     1 |    13 |   549   (2)| 00:00:07 |
| 176 |        SORT AGGREGATE                                      |            |     1 |    13 |            |          |
| 177 |         VIEW                                               |            |     1 |    13 |   549   (2)| 00:00:07 |
| 178 |          HASH GROUP BY                                     |            |     1 |    19 |   549   (2)| 00:00:07 |
| 179 |           VIEW                                             |            |     1 |    19 |   549   (2)| 00:00:07 |
| 180 |            HASH GROUP BY                                   |            |     1 |   159 |   549   (2)| 00:00:07 |
| 181 |             MERGE JOIN CARTESIAN                           |            |     1 |   159 |   548   (2)| 00:00:07 |
| 182 |              NESTED LOOPS                                  |            |     1 |   135 |   537   (2)| 00:00:07 |
| 183 |               NESTED LOOPS                                 |            |     1 |   135 |   531   (2)| 00:00:07 |
| 184 |                NESTED LOOPS                                |            |     1 |   114 |   530   (2)| 00:00:07 |
| 185 |                 NESTED LOOPS                               |            |     1 |    94 |   529   (2)| 00:00:07 |
| 186 |                  NESTED LOOPS                              |            |     6 |   360 |   525   (1)| 00:00:07 |
| 187 |                   VIEW                                     |            |    29 |   957 |   508   (2)| 00:00:07 |
| 188 |                    HASH GROUP BY                           |            |    29 |  1305 |   508   (2)| 00:00:07 |
|*189 |                     HASH JOIN RIGHT SEMI                   |            |    29 |  1305 |   507   (1)| 00:00:07 |
| 190 |                      VIEW                                  | VW_NSO_3   |     1 |     6 |   171   (2)| 00:00:03 |
| 191 |                       HASH GROUP BY                        |            |     1 |    26 |   171   (2)| 00:00:03 |
| 192 |                        VIEW                                | VM_NWVW_7  |     1 |    26 |   171   (2)| 00:00:03 |
| 193 |                         HASH GROUP BY                      |            |     1 |   191 |   171   (2)| 00:00:03 |
| 194 |                          NESTED LOOPS                      |            |       |       |            |          |
| 195 |                           NESTED LOOPS                     |            |     1 |   191 |   169   (1)| 00:00:03 |
| 196 |                            NESTED LOOPS                    |            |     5 |   775 |   165   (1)| 00:00:02 |
|*197 |                             HASH JOIN                      |            |    66 |  7194 |   125   (1)| 00:00:02 |
|*198 |                              TABLE ACCESS BY INDEX ROWID   | TB_YYDK301 |   149 |  4768 |     9   (0)| 00:00:01 |
|*199 |                               INDEX RANGE SCAN             | PK_YYDK301 |   258 |       |     1   (0)| 00:00:01 |
|*200 |                              HASH JOIN                     |            |   162 | 12474 |   116   (1)| 00:00:02 |
|*201 |                               TABLE ACCESS BY INDEX ROWID  | TB_YYDK302 |   156 |  6084 |    77   (0)| 00:00:01 |
|*202 |                                INDEX RANGE SCAN            | PK_YYDK302 |  2233 |       |     3   (0)| 00:00:01 |
| 203 |                               NESTED LOOPS                 |            |  2114 | 80332 |    38   (0)| 00:00:01 |
|*204 |                                TABLE ACCESS BY INDEX ROWID | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*205 |                                 INDEX UNIQUE SCAN          | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
| 206 |                                 TABLE ACCESS BY INDEX ROWID| TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*207 |                                  INDEX UNIQUE SCAN         | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|*208 |                                INDEX RANGE SCAN            | PK_YYDS510 |  2114 | 57078 |    37   (0)| 00:00:01 |
|*209 |                             TABLE ACCESS BY INDEX ROWID    | TB_YYDK302 |     1 |    46 |     1   (0)| 00:00:01 |
|*210 |                              INDEX UNIQUE SCAN             | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|*211 |                            INDEX RANGE SCAN                | PK_YYDK308 |     1 |       |     1   (0)| 00:00:01 |
| 212 |                           TABLE ACCESS BY INDEX ROWID      | TB_YYDK308 |     1 |    36 |     1   (0)| 00:00:01 |
| 213 |                      NESTED LOOPS                          |            |       |       |            |          |
| 214 |                       NESTED LOOPS                         |            | 10572 |   402K|   335   (1)| 00:00:05 |
| 215 |                        VIEW                                | VW_NSO_2   |     5 |    45 |     5   (0)| 00:00:01 |
| 216 |                         HASH UNIQUE                        |            |     5 |    60 |            |          |
|*217 |                          COUNT STOPKEY                     |            |       |       |            |          |
|*218 |                           VIEW                             |            |     6 |    72 |     4   (0)| 00:00:01 |
| 219 |                            NESTED LOOPS                    |            |       |       |            |          |
| 220 |                             NESTED LOOPS                   |            |     6 |   132 |     4   (0)| 00:00:01 |
|*221 |                              TABLE ACCESS BY INDEX ROWID   | TB_YYDK003 |    52 |   572 |     2   (0)| 00:00:01 |
|*222 |                               INDEX RANGE SCAN DESCENDING  | PK_YYDK003 |     8 |       |     1   (0)| 00:00:01 |
|*223 |                              INDEX UNIQUE SCAN             | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
| 224 |                             TABLE ACCESS BY INDEX ROWID    | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
| 225 |                            TABLE ACCESS BY INDEX ROWID     | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*226 |                             INDEX UNIQUE SCAN              | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|*227 |                        INDEX RANGE SCAN                    | PK_YYDS510 |  2114 |       |    37   (0)| 00:00:01 |
| 228 |                       TABLE ACCESS BY INDEX ROWID          | TB_YYDS510 |  2114 | 63420 |    66   (0)| 00:00:01 |
|*229 |                   TABLE ACCESS BY INDEX ROWID              | TB_YYDK302 |     1 |    27 |     1   (0)| 00:00:01 |
|*230 |                    INDEX UNIQUE SCAN                       | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|*231 |                  TABLE ACCESS BY INDEX ROWID               | TB_YYDK302 |     1 |    34 |     1   (0)| 00:00:01 |
|*232 |                   INDEX UNIQUE SCAN                        | PK_YYDK302 |     1 |       |     1   (0)| 00:00:01 |
|*233 |                 TABLE ACCESS BY INDEX ROWID                | TB_YYDK301 |     1 |    20 |     1   (0)| 00:00:01 |
|*234 |                  INDEX UNIQUE SCAN                         | PK_YYDK301 |     1 |       |     1   (0)| 00:00:01 |
|*235 |                INDEX RANGE SCAN                            | PK_YYDK308 |     1 |    21 |     1   (0)| 00:00:01 |
| 236 |               VIEW PUSHED PREDICATE                        |            |     1 |       |     6   (0)| 00:00:01 |
|*237 |                FILTER                                      |            |       |       |            |          |
| 238 |                 SORT AGGREGATE                             |            |     1 |    40 |            |          |
|*239 |                  HASH JOIN SEMI                            |            |     1 |    40 |     6   (0)| 00:00:01 |
| 240 |                   TABLE ACCESS BY INDEX ROWID              | TB_YYDS510 |     1 |    30 |     1   (0)| 00:00:01 |
|*241 |                    INDEX RANGE SCAN                        | PK_YYDS510 |     1 |       |     1   (0)| 00:00:01 |
|*242 |                   VIEW                                     | VW_NSO_1   |     5 |    50 |     5   (0)| 00:00:01 |
|*243 |                    COUNT STOPKEY                           |            |       |       |            |          |
|*244 |                     VIEW                                   |            |     6 |    72 |     4   (0)| 00:00:01 |
| 245 |                      NESTED LOOPS                          |            |       |       |            |          |
| 246 |                       NESTED LOOPS                         |            |     6 |   132 |     4   (0)| 00:00:01 |
|*247 |                        TABLE ACCESS BY INDEX ROWID         | TB_YYDK003 |    52 |   572 |     2   (0)| 00:00:01 |
|*248 |                         INDEX RANGE SCAN DESCENDING        | PK_YYDK003 |     8 |       |     1   (0)| 00:00:01 |
|*249 |                        INDEX UNIQUE SCAN                   | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
| 250 |                       TABLE ACCESS BY INDEX ROWID          | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
| 251 |                      TABLE ACCESS BY INDEX ROWID           | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*252 |                       INDEX UNIQUE SCAN                    | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
| 253 |              BUFFER SORT                                   |            |     1 |    24 |   543   (2)| 00:00:07 |
| 254 |               VIEW                                         |            |     1 |    24 |    11   (0)| 00:00:01 |
| 255 |                SORT AGGREGATE                              |            |     1 |    10 |            |          |
| 256 |                 COUNT                                      |            |       |       |            |          |
| 257 |                  VIEW                                      |            |     8 |    80 |    11   (0)| 00:00:01 |
| 258 |                   NESTED LOOPS                             |            |       |       |            |          |
| 259 |                    NESTED LOOPS                            |            |     8 |   176 |    10   (0)| 00:00:01 |
|*260 |                     TABLE ACCESS BY INDEX ROWID            | TB_YYDK002 |     8 |    88 |     5   (0)| 00:00:01 |
|*261 |                      INDEX RANGE SCAN DESCENDING           | PK_YYDK002 |    57 |       |     1   (0)| 00:00:01 |
| 262 |                      TABLE ACCESS BY INDEX ROWID           | TB_YYDK002 |     1 |    11 |     1   (0)| 00:00:01 |
|*263 |                       INDEX UNIQUE SCAN                    | PK_YYDK002 |     1 |       |     1   (0)| 00:00:01 |
|*264 |                     INDEX RANGE SCAN                       | PK_YYDK003 |     1 |       |     1   (0)| 00:00:01 |
|*265 |                    TABLE ACCESS BY INDEX ROWID             | TB_YYDK003 |     1 |    11 |     1   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------------------------------------

