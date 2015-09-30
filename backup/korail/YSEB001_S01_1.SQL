  SELECT /*+ com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpFcstVs4Wk */
        A.START_TM
        ,A.TRN_NO
        ,A.ABRD_PRNB
        ,A.EXPCT_ABRD_PRNB
        ,A.AVG_OF_ABRD_PRNB
        ,ROUND (A.ABRD_PRNB_PERCENTAGE, 1) AS ABRD_PRNB_PERCENTAGE
        ,ROUND (A.EXPCT_ABRD_PRNB_PERCENTAGE, 1) AS EXPCT_ABRD_PRNB_PERCENTAGE
        ,ROUND (A.AVG_OF_ABRD_PRNB_PERCENTAGE, 1) AS AVG_OF_ABRD_PRNB_PERCENTAGE
        ,A.MOVE_CNT
        ,A.ESCAPE_CNT
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
    FROM (SELECT A2.START_TM
                ,A2.TRN_NO
                ,A2.ABRD_PRNB
                ,A2.EXPCT_ABRD_PRNB
                ,A2.AVG_OF_ABRD_PRNB
                ,A2.ABRD_PRNB_PERCENTAGE
                ,A2.EXPCT_ABRD_PRNB_PERCENTAGE
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
                        ,A1.EXPCT_ABRD_PRNB
                        ,A1.AVG_OF_ABRD_PRNB AS AVG_OF_ABRD_PRNB
                        ,A1.ABRD_PRNB_PERCENTAGE * 100 AS ABRD_PRNB_PERCENTAGE
                        ,A1.EXPCT_ABRD_PRNB_PERCENTAGE * 100 AS EXPCT_ABRD_PRNB_PERCENTAGE
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
                                ,TO_CHAR (TO_NUMBER (A.TRN_NO)) AS TRN_NO
                                ,A.ABRD_PRNB
                                ,A.EXPCT_ABRD_PRNB
                                ,A.AVG_OF_ABRD_PRNB
                                ,A.ABRD_PRNB_PERCENTAGE
                                ,A.EXPCT_ABRD_PRNB_PERCENTAGE
                                ,A.AVG_OF_ABRD_PRNB_PERCENTAGE
                                ,A.MOVE_CNT
                                ,A.ESCAPE_CNT
                                ,B.D_DAY
                                ,B.RESERVE_CNT
                                ,B.CANCEL_CNT
                                ,B.RESERVE_CNT - B.CANCEL_CNT AS SALE_CNT
                                ,DECODE ('3',  '1', B.RESERVE_CNT,  '2', B.CANCEL_CNT,  '3', B.RESERVE_CNT - B.CANCEL_CNT) AS CNT
                                ,B.CLOSE_DAY
                            FROM (SELECT A.START_TM
                                        ,A.TRN_NO
                                        ,A.ABRD_PRNB
                                        ,A.EXPCT_ABRD_PRNB
                                        ,A.AVG_OF_ABRD_PRNB
                                        ,A.ABRD_PRNB_PERCENTAGE
                                        ,A.EXPCT_ABRD_PRNB_PERCENTAGE
                                        ,A.AVG_OF_ABRD_PRNB_PERCENTAGE
                                        ,  CASE
                                               WHEN 0 > A.EXPCT_ABRD_PRNB - A.AVG_OF_ABRD_PRNB THEN A.EXPCT_ABRD_PRNB - A.AVG_OF_ABRD_PRNB
                                               ELSE 0
                                           END
                                         * -1
                                             AS ESCAPE_CNT
                                        ,CASE
                                             WHEN 0 < A.EXPCT_ABRD_PRNB - A.AVG_OF_ABRD_PRNB THEN A.EXPCT_ABRD_PRNB - A.AVG_OF_ABRD_PRNB
                                             ELSE 0
                                         END
                                             AS MOVE_CNT
                                        ,A.SEG_GP_NO
                                    FROM (SELECT A.START_TM
                                                ,A.TRN_NO
                                                ,A.ABRD_PRNB
                                                ,A.EXPCT_ABRD_PRNB
                                                ,ROUND (C.AVG_OF_ABRD_PRNB) AS AVG_OF_ABRD_PRNB
                                                ,B.SUM_OF_ABRD_PRNB
                                                ,B.SUM_OF_EXPCT_ABRD_PRNB
                                                ,DECODE (B.SUM_OF_ABRD_PRNB, 0, 0, A.ABRD_PRNB / B.SUM_OF_ABRD_PRNB) AS ABRD_PRNB_PERCENTAGE
                                                ,DECODE (B.SUM_OF_EXPCT_ABRD_PRNB, 0, 0, A.EXPCT_ABRD_PRNB / B.SUM_OF_EXPCT_ABRD_PRNB) AS EXPCT_ABRD_PRNB_PERCENTAGE
                                                ,DECODE (D.SUM_OF_AVG_OF_ABRD_PRNB, 0, 0, C.AVG_OF_ABRD_PRNB / D.SUM_OF_AVG_OF_ABRD_PRNB) AS AVG_OF_ABRD_PRNB_PERCENTAGE
                                                ,A.SEG_GP_NO
                                            FROM (  SELECT /*+ ORDERED USE_NL(A D)*/
                                                          B.DPT_TM AS START_TM
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
                                                          ,SUM (F.EXPCT_ABRD_PRNB) AS EXPCT_ABRD_PRNB
                                                      FROM (  SELECT A.TRN_NO
                                                                    ,A.RUN_DT
                                                                    ,A.DPT_STN_CONS_ORDR
                                                                    ,A.ARV_STN_CONS_ORDR
                                                                    ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                FROM TB_YYDS510 A
                                                               WHERE A.RUN_DT = '20140218'
                                                                 AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                 AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                            GROUP BY A.TRN_NO
                                                                    ,A.RUN_DT
                                                                    ,A.DPT_STN_CONS_ORDR
                                                                    ,A.ARV_STN_CONS_ORDR) A
                                                          ,TB_YYDK302 B
                                                          ,TB_YYDK302 C
                                                          ,TB_YYDK301 D
                                                          ,TB_YYDK308 E
                                                          ,(  SELECT F.TRN_NO
                                                                    ,F.RUN_DT
                                                                    ,F.DPT_STN_CONS_ORDR
                                                                    ,F.ARV_STN_CONS_ORDR
                                                                    ,SUM (F.LAST_ABRD_EXPN_DMD_NUM) AS EXPCT_ABRD_PRNB
                                                                FROM (  SELECT RUN_DT, TRN_NO, MAX (YMGT_JOB_ID) YMGT_JOB_ID
                                                                          FROM TB_YYFD011
                                                                         WHERE RUN_DT = '20140218'
                                                                      GROUP BY RUN_DT, TRN_NO) Z
                                                                    ,TB_YYFD410 F
                                                               WHERE Z.RUN_DT = '20140218'
                                                                 AND F.PSRM_CL_CD = NVL ('1', F.PSRM_CL_CD)
                                                                 AND F.BKCL_CD LIKE DECODE ('',  NULL, F.BKCL_CD,  'F1', 'F%',  '')
                                                                 AND F.RUN_DT = Z.RUN_DT
                                                                 AND F.TRN_NO = Z.TRN_NO
                                                                 AND F.YMGT_JOB_ID = Z.YMGT_JOB_ID
                                                            GROUP BY F.TRN_NO
                                                                    ,F.RUN_DT
                                                                    ,F.DPT_STN_CONS_ORDR
                                                                    ,F.ARV_STN_CONS_ORDR) F
                                                     WHERE A.TRN_NO = F.TRN_NO
                                                       AND A.RUN_DT = F.RUN_DT
                                                       AND A.DPT_STN_CONS_ORDR = F.DPT_STN_CONS_ORDR
                                                       AND A.ARV_STN_CONS_ORDR = F.ARV_STN_CONS_ORDR
                                                       AND A.TRN_NO = B.TRN_NO
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
                                                          ,C.STOP_RS_STN_CD) A
                                                ,(SELECT /*+ ORDERED USE_HASH(A D) */
                                                        SUM (A.ABRD_PRNB) AS SUM_OF_ABRD_PRNB, SUM (F.EXPCT_ABRD_PRNB) AS SUM_OF_EXPCT_ABRD_PRNB
                                                    FROM (  SELECT A.TRN_NO
                                                                  ,A.RUN_DT
                                                                  ,A.DPT_STN_CONS_ORDR
                                                                  ,A.ARV_STN_CONS_ORDR
                                                                  ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                              FROM TB_YYDS510 A
                                                             WHERE A.RUN_DT = '20140218'
                                                               AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                               AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
                                                          GROUP BY A.TRN_NO
                                                                  ,A.RUN_DT
                                                                  ,A.DPT_STN_CONS_ORDR
                                                                  ,A.ARV_STN_CONS_ORDR) A
                                                        ,TB_YYDK302 B
                                                        ,TB_YYDK302 C
                                                        ,TB_YYDK301 D
                                                        ,TB_YYDK308 E
                                                        ,(  SELECT F.TRN_NO
                                                                  ,F.RUN_DT
                                                                  ,F.DPT_STN_CONS_ORDR
                                                                  ,F.ARV_STN_CONS_ORDR
                                                                  ,SUM (F.LAST_ABRD_EXPN_DMD_NUM) AS EXPCT_ABRD_PRNB
                                                              FROM (  SELECT RUN_DT, TRN_NO, MAX (YMGT_JOB_ID) YMGT_JOB_ID
                                                                        FROM TB_YYFD011
                                                                       WHERE RUN_DT = '20140218'
                                                                    GROUP BY RUN_DT, TRN_NO) Z
                                                                  ,TB_YYFD410 F
                                                             WHERE F.PSRM_CL_CD = NVL ('1', F.PSRM_CL_CD)
                                                               AND F.BKCL_CD LIKE DECODE ('',  NULL, F.BKCL_CD,  'F1', 'F%',  '')
                                                               AND F.RUN_DT = Z.RUN_DT
                                                               AND F.TRN_NO = Z.TRN_NO
                                                               AND F.YMGT_JOB_ID = Z.YMGT_JOB_ID
                                                          GROUP BY F.TRN_NO
                                                                  ,F.RUN_DT
                                                                  ,F.DPT_STN_CONS_ORDR
                                                                  ,F.ARV_STN_CONS_ORDR) F
                                                   WHERE A.TRN_NO = F.TRN_NO
                                                     AND A.RUN_DT = F.RUN_DT
                                                     AND A.DPT_STN_CONS_ORDR = F.DPT_STN_CONS_ORDR
                                                     AND A.ARV_STN_CONS_ORDR = F.ARV_STN_CONS_ORDR
                                                     AND A.TRN_NO = B.TRN_NO
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
                                                                                        WHEN A.RUN_DT = B.RUN_DT_1
                                                                                         AND A.RUN_DT = '20140218'
                                                                                        THEN
                                                                                            A.ABRD_PRNB
                                                                                        ELSE
0
                                                                                    END)
                                                                                   AS ABRD_PRNB1
                                                                              ,MAX (CASE
                                                                                        WHEN A.RUN_DT = B.RUN_DT_5
                                                                                         AND A.RUN_DT <> '20140218'
                                                                                        THEN
                                                                                            A.ABRD_PRNB
                                                                                        ELSE
0
                                                                                    END)
                                                                                   AS ABRD_PRNB2
                                                                              ,MAX (CASE
                                                                                        WHEN A.RUN_DT = B.RUN_DT_4
                                                                                         AND A.RUN_DT <> '20140218'
                                                                                        THEN
                                                                                            A.ABRD_PRNB
                                                                                        ELSE
0
                                                                                    END)
                                                                                   AS ABRD_PRNB3
                                                                              ,MAX (CASE
                                                                                        WHEN A.RUN_DT = B.RUN_DT_3
                                                                                         AND A.RUN_DT <> '20140218'
                                                                                        THEN
                                                                                            A.ABRD_PRNB
                                                                                        ELSE
0
                                                                                    END)
                                                                                   AS ABRD_PRNB4
                                                                              ,MAX (CASE
                                                                                        WHEN A.RUN_DT = B.RUN_DT_2
                                                                                         AND A.RUN_DT <> '20140218'
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
                                                                                                                                      FROM TB_YYDS510 A
                                                                                                                                     WHERE A.RUN_DT = '20140218'
                                                                                                                                       AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                                                                                       AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
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
                                                                                                WHEN A.RUN_DT = B.RUN_DT_1
                                                                                                 AND A.RUN_DT = '20140218'
                                                                                                THEN
                                                                                                    A.ABRD_PRNB
                                                                                                ELSE
0
                                                                                            END)
                                                                                           AS ABRD_PRNB1
                                                                                      ,MAX (CASE
                                                                                                WHEN A.RUN_DT = B.RUN_DT_5
                                                                                                 AND A.RUN_DT <> '20140218'
                                                                                                THEN
                                                                                                    A.ABRD_PRNB
                                                                                                ELSE
0
                                                                                            END)
                                                                                           AS ABRD_PRNB2
                                                                                      ,MAX (CASE
                                                                                                WHEN A.RUN_DT = B.RUN_DT_4
                                                                                                 AND A.RUN_DT <> '20140218'
                                                                                                THEN
                                                                                                    A.ABRD_PRNB
                                                                                                ELSE
0
                                                                                            END)
                                                                                           AS ABRD_PRNB3
                                                                                      ,MAX (CASE
                                                                                                WHEN A.RUN_DT = B.RUN_DT_3
                                                                                                 AND A.RUN_DT <> '20140218'
                                                                                                THEN
                                                                                                    A.ABRD_PRNB
                                                                                                ELSE
0
                                                                                            END)
                                                                                           AS ABRD_PRNB4
                                                                                      ,MAX (CASE
                                                                                                WHEN A.RUN_DT = B.RUN_DT_2
                                                                                                 AND A.RUN_DT <> '20140218'
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
                                                                                                                                      FROM TB_YYDS510 A
                                                                                                                                     WHERE A.RUN_DT = '20140218'
                                                                                                                                       AND A.PSRM_CL_CD = NVL ('1', A.PSRM_CL_CD)
                                                                                                                                       AND A.BKCL_CD LIKE DECODE ('',  NULL, A.BKCL_CD,  'F1', 'F%',  '')
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
           WHERE B2.RNUM = A2.D_DAY) A
GROUP BY A.START_TM
        ,A.TRN_NO
        ,A.ABRD_PRNB
        ,A.EXPCT_ABRD_PRNB
        ,A.AVG_OF_ABRD_PRNB
        ,A.ABRD_PRNB_PERCENTAGE
        ,A.EXPCT_ABRD_PRNB_PERCENTAGE
        ,A.AVG_OF_ABRD_PRNB_PERCENTAGE
        ,A.MOVE_CNT
        ,A.ESCAPE_CNT
ORDER BY START_TM, TRN_NO



인덱스 

YZDBA                          TB_YYFD410                     PK_YYFD410                       57864772
 => RUN_DT,TRN_NO,PSRM_CL_CD,BKCL_CD,DPT_STN_CONS_ORDR,ARV_STN_CONS_ORDR,FCST_ACHV_DT,YMGT_JOB_ID
 
YZDBA                          TB_YYPD006                     PK_YYPD006                       37573700
 => RUN_DT,TRN_NO,PSRM_CL_CD,BKCL_CD,ZONE_SEG_GP_NO,YMGT_JOB_ID,SEAT_ATT_CD


튜닝 내용 

  - 입력 조건 중 BKCL_CD 부분을 '=' 로 수정 할 수 있도록 할 것.
     현재 : AND F.BKCL_CD LIKE DECODE ('',  NULL, F.BKCL_CD,  'F1', 'F%',  '')
     수정 : AND F.BKCL_CD = 'F1' 
     
  - 힌트 추가 ( USE_MERGE(A B C D) ) : 위치 확인 할 것 . 112 줄에 추가 할 것.
                USE_HASH(A B C D E) : 위치 확인 할 것 .  658 줄에 추가 할 것.
                
  - BKCL_CD(할인등급) 컬럼 확인 필요
    현재의 SQL문장에서는 조회 조건이나, 조인 조건으로 사용되고 있지 않음.
    사용되고 있지 않으면, TB_YYFD410, TB_YYPD006 테이블의 PK 에서 맨 뒤에 위치 할 것. 
  
  
--------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                                                | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                                         |               |     1 |   175 |  2536   (2)| 00:00:31 |
|   1 |  SORT GROUP BY                                           |               |     1 |   175 |  2536   (2)| 00:00:31 |
|   2 |   VIEW                                                   |               |     1 |   175 |  2535   (2)| 00:00:31 |
|   3 |    WINDOW SORT                                           |               |     1 |   181 |  2535   (2)| 00:00:31 |
|   4 |     MERGE JOIN CARTESIAN                                 |               |     1 |   181 |  2534   (2)| 00:00:31 |
|   5 |      NESTED LOOPS OUTER                                  |               |     1 |   168 |  1375   (2)| 00:00:17 |
|   6 |       NESTED LOOPS                                       |               |     1 |   153 |  1260   (2)| 00:00:16 |
|*  7 |        HASH JOIN                                         |               |     1 |   100 |  1092   (2)| 00:00:14 |
|   8 |         NESTED LOOPS                                     |               |     3 |   261 |  1089   (1)| 00:00:14 |
|   9 |          VIEW                                            |               |     1 |    26 |   542   (1)| 00:00:07 |
|  10 |           SORT AGGREGATE                                 |               |     1 |   140 |            |          |
|  11 |            NESTED LOOPS                                  |               |     1 |   140 |   542   (1)| 00:00:07 |
|  12 |             NESTED LOOPS                                 |               |     1 |   127 |   526   (1)| 00:00:07 |
|* 13 |              HASH JOIN                                   |               |     1 |   106 |   524   (1)| 00:00:07 |
|  14 |               NESTED LOOPS                               |               |       |       |            |          |
|  15 |                NESTED LOOPS                              |               |     1 |    86 |   491   (1)| 00:00:06 |
|* 16 |                 HASH JOIN                                |               |    28 |  1680 |   444   (1)| 00:00:06 |
|  17 |                  VIEW                                    |               |  1383 | 47022 |   160   (2)| 00:00:02 |
|  18 |                   HASH GROUP BY                          |               |  1383 | 40107 |   160   (2)| 00:00:02 |
|  19 |                    TABLE ACCESS BY INDEX ROWID           | TB_YYDS510    |  1383 | 40107 |   159   (1)| 00:00:02 |
|* 20 |                     INDEX RANGE SCAN                     | PK_YYDS510    |  1383 |       |   116   (1)| 00:00:02 |
|* 21 |                  TABLE ACCESS BY INDEX ROWID             | TB_YYDK302    |    28 |   728 |   284   (1)| 00:00:04 |
|* 22 |                   INDEX RANGE SCAN                       | PK_YYDK302    |  2228 |       |    11   (0)| 00:00:01 |
|* 23 |                 INDEX UNIQUE SCAN                        | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|* 24 |                TABLE ACCESS BY INDEX ROWID               | TB_YYDK302    |     1 |    26 |     2   (0)| 00:00:01 |
|* 25 |               TABLE ACCESS BY INDEX ROWID                | TB_YYDK301    |   143 |  2860 |    32   (0)| 00:00:01 |
|* 26 |                INDEX RANGE SCAN                          | PK_YYDK301    |   256 |       |     3   (0)| 00:00:01 |
|* 27 |              INDEX RANGE SCAN                            | PK_YYDK308    |     1 |    21 |     2   (0)| 00:00:01 |
|  28 |             VIEW PUSHED PREDICATE                        |               |     1 |    13 |    16   (0)| 00:00:01 |
|* 29 |              FILTER                                      |               |       |       |            |          |
|  30 |               SORT AGGREGATE                             |               |     1 |    86 |            |          |
|  31 |                NESTED LOOPS                              |               |       |       |            |          |
|  32 |                 NESTED LOOPS                             |               |     1 |    86 |    16   (0)| 00:00:01 |
|  33 |                  VIEW                                    |               |     1 |    32 |     3   (0)| 00:00:01 |
|  34 |                   SORT GROUP BY                          |               |     1 |    40 |     3   (0)| 00:00:01 |
|* 35 |                    FILTER                                |               |       |       |            |          |
|* 36 |                     INDEX RANGE SCAN                     | IX_YYFD011_01 |    18 |   720 |     3   (0)| 00:00:01 |
|* 37 |                  INDEX RANGE SCAN                        | PK_YYFD410    |     1 |       |    12   (0)| 00:00:01 |
|  38 |                 TABLE ACCESS BY INDEX ROWID              | TB_YYFD410    |     1 |    54 |    13   (0)| 00:00:01 |
|  39 |          VIEW                                            |               |     3 |   183 |   548   (2)| 00:00:07 |
|  40 |           SORT ORDER BY                                  |               |     3 |   252 |   548   (2)| 00:00:07 |
|  41 |            NESTED LOOPS OUTER                            |               |     3 |   252 |   547   (1)| 00:00:07 |
|  42 |             VIEW                                         |               |     3 |   201 |   505   (1)| 00:00:07 |
|  43 |              SORT GROUP BY                               |               |     3 |   420 |   505   (1)| 00:00:07 |
|  44 |               NESTED LOOPS                               |               |       |       |            |          |
|  45 |                NESTED LOOPS                              |               |     3 |   420 |   504   (1)| 00:00:07 |
|  46 |                 NESTED LOOPS                             |               |    13 |  1508 |   466   (1)| 00:00:06 |
|  47 |                  NESTED LOOPS                            |               |    10 |   990 |   447   (1)| 00:00:06 |
|  48 |                   NESTED LOOPS                           |               |    28 |  2044 |   396   (1)| 00:00:05 |
|* 49 |                    TABLE ACCESS BY INDEX ROWID           | TB_YYDK302    |    28 |   728 |   284   (1)| 00:00:04 |
|* 50 |                     INDEX RANGE SCAN                     | PK_YYDK302    |  2228 |       |    11   (0)| 00:00:01 |
|  51 |                    TABLE ACCESS BY INDEX ROWID           | TB_YYDS501    |     1 |    47 |     4   (0)| 00:00:01 |
|* 52 |                     INDEX RANGE SCAN                     | PK_YYDS501    |     1 |       |     3   (0)| 00:00:01 |
|* 53 |                   TABLE ACCESS BY INDEX ROWID            | TB_YYDK302    |     1 |    26 |     2   (0)| 00:00:01 |
|* 54 |                    INDEX UNIQUE SCAN                     | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|  55 |                  TABLE ACCESS BY INDEX ROWID             | TB_YYDK301    |     1 |    17 |     2   (0)| 00:00:01 |
|* 56 |                   INDEX UNIQUE SCAN                      | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|* 57 |                 INDEX RANGE SCAN                         | PK_YYDK308    |     1 |       |     2   (0)| 00:00:01 |
|  58 |                TABLE ACCESS BY INDEX ROWID               | TB_YYDK308    |     1 |    24 |     3   (0)| 00:00:01 |
|* 59 |             VIEW PUSHED PREDICATE                        |               |     1 |    17 |    14   (8)| 00:00:01 |
|  60 |              SORT GROUP BY                               |               |     1 |    14 |    14   (8)| 00:00:01 |
|  61 |               VIEW                                       |               |     1 |    14 |    14   (8)| 00:00:01 |
|* 62 |                FILTER                                    |               |       |       |            |          |
|  63 |                 SORT GROUP BY                            |               |     1 |    53 |    14   (8)| 00:00:01 |
|  64 |                  TABLE ACCESS BY INDEX ROWID             | TB_YYPD006    |     5 |   265 |    13   (0)| 00:00:01 |
|* 65 |                   INDEX RANGE SCAN                       | PK_YYPD006    |     5 |       |     8   (0)| 00:00:01 |
|  66 |         VIEW                                             |               |    32 |   416 |     2   (0)| 00:00:01 |
|* 67 |          COUNT STOPKEY                                   |               |       |       |            |          |
|  68 |           INDEX FAST FULL SCAN                           | PK_YYDK002    |    32 |       |     2   (0)| 00:00:01 |
|* 69 |        VIEW PUSHED PREDICATE                             |               |     1 |    53 |   168   (2)| 00:00:03 |
|  70 |         SORT GROUP BY                                    |               |     4 |   532 |   168   (2)| 00:00:03 |
|  71 |          NESTED LOOPS                                    |               |       |       |            |          |
|  72 |           NESTED LOOPS                                   |               |     4 |   532 |   167   (2)| 00:00:03 |
|  73 |            VIEW                                          | VW_GBC_34     |   136 | 15368 |    30   (7)| 00:00:01 |
|  74 |             SORT GROUP BY                                |               |   136 | 17680 |    30   (7)| 00:00:01 |
|  75 |              NESTED LOOPS                                |               |   136 | 17680 |    29   (4)| 00:00:01 |
|  76 |               NESTED LOOPS                               |               |     1 |   117 |    13   (8)| 00:00:01 |
|  77 |                NESTED LOOPS                              |               |     1 |    93 |    10  (10)| 00:00:01 |
|  78 |                 NESTED LOOPS                             |               |     1 |    60 |     8  (13)| 00:00:01 |
|  79 |                  VIEW                                    |               |     1 |    34 |     6  (17)| 00:00:01 |
|  80 |                   SORT GROUP BY                          |               |     1 |    29 |     6  (17)| 00:00:01 |
|  81 |                    TABLE ACCESS BY INDEX ROWID           | TB_YYDS510    |     2 |    58 |     5   (0)| 00:00:01 |
|* 82 |                     INDEX RANGE SCAN                     | PK_YYDS510    |     2 |       |     4   (0)| 00:00:01 |
|* 83 |                  TABLE ACCESS BY INDEX ROWID             | TB_YYDK302    |     1 |    26 |     2   (0)| 00:00:01 |
|* 84 |                   INDEX UNIQUE SCAN                      | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|* 85 |                 TABLE ACCESS BY INDEX ROWID              | TB_YYDK302    |     1 |    33 |     2   (0)| 00:00:01 |
|* 86 |                  INDEX UNIQUE SCAN                       | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|  87 |                TABLE ACCESS BY INDEX ROWID               | TB_YYDK308    |     1 |    24 |     3   (0)| 00:00:01 |
|* 88 |                 INDEX RANGE SCAN                         | PK_YYDK308    |     1 |       |     2   (0)| 00:00:01 |
|  89 |               VIEW PUSHED PREDICATE                      |               |     1 |    13 |    16   (0)| 00:00:01 |
|* 90 |                FILTER                                    |               |       |       |            |          |
|  91 |                 SORT AGGREGATE                           |               |     1 |    87 |            |          |
|* 92 |                  FILTER                                  |               |       |       |            |          |
|  93 |                   NESTED LOOPS                           |               |       |       |            |          |
|  94 |                    NESTED LOOPS                          |               |     1 |    87 |    16   (0)| 00:00:01 |
|  95 |                     VIEW                                 |               |     1 |    33 |     3   (0)| 00:00:01 |
|  96 |                      SORT GROUP BY                       |               |     1 |    40 |     3   (0)| 00:00:01 |
|* 97 |                       FILTER                             |               |       |       |            |          |
|* 98 |                        INDEX RANGE SCAN                  | IX_YYFD011_01 |    18 |   720 |     3   (0)| 00:00:01 |
|* 99 |                     INDEX RANGE SCAN                     | PK_YYFD410    |     1 |       |    12   (0)| 00:00:01 |
| 100 |                    TABLE ACCESS BY INDEX ROWID           | TB_YYFD410    |     1 |    54 |    13   (0)| 00:00:01 |
|*101 |            INDEX UNIQUE SCAN                             | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|*102 |           TABLE ACCESS BY INDEX ROWID                    | TB_YYDK301    |     1 |    20 |     2   (0)| 00:00:01 |
| 103 |       VIEW PUSHED PREDICATE                              |               |     1 |    15 |   114   (7)| 00:00:02 |
| 104 |        SORT GROUP BY                                     |               |     1 |    19 |   114   (7)| 00:00:02 |
| 105 |         VIEW                                             |               |     2 |    38 |   114   (7)| 00:00:02 |
| 106 |          SORT GROUP BY                                   |               |     2 |   322 |   114   (7)| 00:00:02 |
| 107 |           NESTED LOOPS                                   |               |     2 |   322 |   113   (6)| 00:00:02 |
| 108 |            NESTED LOOPS                                  |               |     1 |   161 |    91   (7)| 00:00:02 |
| 109 |             NESTED LOOPS                                 |               |     1 |   141 |    89   (7)| 00:00:02 |
| 110 |              NESTED LOOPS                                |               |     1 |   120 |    87   (7)| 00:00:02 |
| 111 |               NESTED LOOPS                               |               |     1 |    87 |    85   (8)| 00:00:02 |
| 112 |                NESTED LOOPS                              |               |     1 |    61 |    83   (8)| 00:00:01 |
| 113 |                 VIEW                                     |               |     1 |    24 |    32   (7)| 00:00:01 |
| 114 |                  SORT AGGREGATE                          |               |     1 |    13 |            |          |
| 115 |                   COUNT                                  |               |       |       |            |          |
|*116 |                    VIEW                                  |               |    57 |   741 |    30   (7)| 00:00:01 |
| 117 |                     SORT ORDER BY                        |               |    57 |  1254 |    30   (7)| 00:00:01 |
|*118 |                      HASH JOIN                           |               |    57 |  1254 |    29   (4)| 00:00:01 |
|*119 |                       TABLE ACCESS FULL                  | TB_YYDK002    |    57 |   627 |    14   (0)| 00:00:01 |
|*120 |                       TABLE ACCESS FULL                  | TB_YYDK003    |   332 |  3652 |    14   (0)| 00:00:01 |
| 121 |                     TABLE ACCESS BY INDEX ROWID          | TB_YYDK002    |     1 |    11 |     2   (0)| 00:00:01 |
|*122 |                      INDEX UNIQUE SCAN                   | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
| 123 |                 VIEW                                     |               |     1 |    37 |    51   (8)| 00:00:01 |
| 124 |                  SORT GROUP BY                           |               |     1 |    44 |    51   (8)| 00:00:01 |
|*125 |                   HASH JOIN SEMI                         |               |     1 |    44 |    50   (6)| 00:00:01 |
| 126 |                    NESTED LOOPS                          |               |       |       |            |          |
| 127 |                     NESTED LOOPS                         |               |    13 |   494 |    35   (3)| 00:00:01 |
| 128 |                      VIEW                                | VW_NSO_5      |     5 |    45 |    17   (0)| 00:00:01 |
| 129 |                       SORT UNIQUE                        |               |     5 |    60 |            |          |
|*130 |                        COUNT STOPKEY                     |               |       |       |            |          |
|*131 |                         VIEW                             |               |     5 |    60 |    15   (0)| 00:00:01 |
| 132 |                          NESTED LOOPS                    |               |       |       |            |          |
| 133 |                           NESTED LOOPS                   |               |     5 |   110 |    15   (0)| 00:00:01 |
| 134 |                            TABLE ACCESS BY INDEX ROWID   | TB_YYDK002    |    57 |   627 |     4   (0)| 00:00:01 |
|*135 |                             INDEX RANGE SCAN DESCENDING  | PK_YYDK002    |     6 |       |     2   (0)| 00:00:01 |
|*136 |                            INDEX RANGE SCAN              | PK_YYDK003    |     1 |       |     1   (0)| 00:00:01 |
|*137 |                           TABLE ACCESS BY INDEX ROWID    | TB_YYDK003    |     1 |    11 |     2   (0)| 00:00:01 |
| 138 |                          TABLE ACCESS BY INDEX ROWID     | TB_YYDK002    |     1 |    11 |     2   (0)| 00:00:01 |
|*139 |                           INDEX UNIQUE SCAN              | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
|*140 |                      INDEX RANGE SCAN                    | PK_YYDS510    |     2 |       |     3   (0)| 00:00:01 |
| 141 |                     TABLE ACCESS BY INDEX ROWID          | TB_YYDS510    |     3 |    87 |     4   (0)| 00:00:01 |
| 142 |                    VIEW                                  | VW_NSO_6      |     1 |     6 |    14   (8)| 00:00:01 |
| 143 |                     SORT GROUP BY                        |               |     1 |    26 |    14   (8)| 00:00:01 |
| 144 |                      VIEW                                | VM_NWVW_8     |     1 |    26 |    14   (8)| 00:00:01 |
| 145 |                       SORT GROUP BY                      |               |     1 |   177 |    14   (8)| 00:00:01 |
| 146 |                        NESTED LOOPS                      |               |       |       |            |          |
| 147 |                         NESTED LOOPS                     |               |     1 |   177 |    13   (0)| 00:00:01 |
| 148 |                          NESTED LOOPS                    |               |     1 |   141 |    10   (0)| 00:00:01 |
| 149 |                           NESTED LOOPS                   |               |     1 |   103 |     8   (0)| 00:00:01 |
| 150 |                            NESTED LOOPS                  |               |     1 |    58 |     6   (0)| 00:00:01 |
|*151 |                             TABLE ACCESS BY INDEX ROWID  | TB_YYDK301    |     1 |    32 |     3   (0)| 00:00:01 |
|*152 |                              INDEX UNIQUE SCAN           | PK_YYDK301    |     1 |       |     2   (0)| 00:00:01 |
|*153 |                             INDEX RANGE SCAN             | PK_YYDS510    |     1 |    26 |     3   (0)| 00:00:01 |
|*154 |                            TABLE ACCESS BY INDEX ROWID   | TB_YYDK302    |     1 |    45 |     2   (0)| 00:00:01 |
|*155 |                             INDEX UNIQUE SCAN            | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*156 |                           TABLE ACCESS BY INDEX ROWID    | TB_YYDK302    |     1 |    38 |     2   (0)| 00:00:01 |
|*157 |                            INDEX UNIQUE SCAN             | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*158 |                          INDEX RANGE SCAN                | PK_YYDK308    |     1 |       |     2   (0)| 00:00:01 |
| 159 |                         TABLE ACCESS BY INDEX ROWID      | TB_YYDK308    |     1 |    36 |     3   (0)| 00:00:01 |
|*160 |                TABLE ACCESS BY INDEX ROWID               | TB_YYDK302    |     1 |    26 |     2   (0)| 00:00:01 |
|*161 |                 INDEX UNIQUE SCAN                        | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*162 |               TABLE ACCESS BY INDEX ROWID                | TB_YYDK302    |     1 |    33 |     2   (0)| 00:00:01 |
|*163 |                INDEX UNIQUE SCAN                         | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*164 |              INDEX RANGE SCAN                            | PK_YYDK308    |     1 |    21 |     2   (0)| 00:00:01 |
|*165 |             TABLE ACCESS BY INDEX ROWID                  | TB_YYDK301    |     1 |    20 |     2   (0)| 00:00:01 |
|*166 |              INDEX UNIQUE SCAN                           | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
| 167 |            VIEW PUSHED PREDICATE                         |               |     1 |       |    23   (5)| 00:00:01 |
|*168 |             FILTER                                       |               |       |       |            |          |
| 169 |              SORT AGGREGATE                              |               |     1 |    39 |            |          |
|*170 |               HASH JOIN SEMI                             |               |     1 |    39 |    23   (5)| 00:00:01 |
| 171 |                TABLE ACCESS BY INDEX ROWID               | TB_YYDS510    |     1 |    29 |     5   (0)| 00:00:01 |
|*172 |                 INDEX RANGE SCAN                         | PK_YYDS510    |     1 |       |     4   (0)| 00:00:01 |
|*173 |                VIEW                                      | VW_NSO_4      |     5 |    50 |    17   (0)| 00:00:01 |
|*174 |                 COUNT STOPKEY                            |               |       |       |            |          |
|*175 |                  VIEW                                    |               |     5 |    60 |    15   (0)| 00:00:01 |
| 176 |                   NESTED LOOPS                           |               |       |       |            |          |
| 177 |                    NESTED LOOPS                          |               |     5 |   110 |    15   (0)| 00:00:01 |
| 178 |                     TABLE ACCESS BY INDEX ROWID          | TB_YYDK002    |    57 |   627 |     4   (0)| 00:00:01 |
|*179 |                      INDEX RANGE SCAN DESCENDING         | PK_YYDK002    |     6 |       |     2   (0)| 00:00:01 |
|*180 |                     INDEX RANGE SCAN                     | PK_YYDK003    |     1 |       |     1   (0)| 00:00:01 |
|*181 |                    TABLE ACCESS BY INDEX ROWID           | TB_YYDK003    |     1 |    11 |     2   (0)| 00:00:01 |
| 182 |                   TABLE ACCESS BY INDEX ROWID            | TB_YYDK002    |     1 |    11 |     2   (0)| 00:00:01 |
|*183 |                    INDEX UNIQUE SCAN                     | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
| 184 |      BUFFER SORT                                         |               |     1 |    13 |  2421   (2)| 00:00:30 |
| 185 |       VIEW                                               |               |     1 |    13 |  1160   (2)| 00:00:14 |
| 186 |        SORT AGGREGATE                                    |               |     1 |    13 |            |          |
| 187 |         VIEW                                             |               |     1 |    13 |  1160   (2)| 00:00:14 |
| 188 |          HASH GROUP BY                                   |               |     1 |    19 |  1160   (2)| 00:00:14 |
| 189 |           VIEW                                           |               |     1 |    19 |  1160   (2)| 00:00:14 |
| 190 |            HASH GROUP BY                                 |               |     1 |   157 |  1160   (2)| 00:00:14 |
| 191 |             NESTED LOOPS                                 |               |    18 |  2826 |  1159   (2)| 00:00:14 |
| 192 |              NESTED LOOPS                                |               |     1 |   157 |  1136   (2)| 00:00:14 |
| 193 |               NESTED LOOPS                               |               |     1 |   136 |  1134   (2)| 00:00:14 |
| 194 |                NESTED LOOPS                              |               |     1 |   110 |  1132   (2)| 00:00:14 |
| 195 |                 NESTED LOOPS                             |               |     1 |    77 |  1130   (2)| 00:00:14 |
| 196 |                  NESTED LOOPS                            |               |     1 |    57 |  1128   (2)| 00:00:14 |
| 197 |                   VIEW                                   |               |     1 |    24 |    32   (7)| 00:00:01 |
| 198 |                    SORT AGGREGATE                        |               |     1 |    13 |            |          |
| 199 |                     COUNT                                |               |       |       |            |          |
|*200 |                      VIEW                                |               |    57 |   741 |    30   (7)| 00:00:01 |
| 201 |                       SORT ORDER BY                      |               |    57 |  1254 |    30   (7)| 00:00:01 |
|*202 |                        HASH JOIN                         |               |    57 |  1254 |    29   (4)| 00:00:01 |
|*203 |                         TABLE ACCESS FULL                | TB_YYDK002    |    57 |   627 |    14   (0)| 00:00:01 |
|*204 |                         TABLE ACCESS FULL                | TB_YYDK003    |   332 |  3652 |    14   (0)| 00:00:01 |
| 205 |                       TABLE ACCESS BY INDEX ROWID        | TB_YYDK002    |     1 |    11 |     2   (0)| 00:00:01 |
|*206 |                        INDEX UNIQUE SCAN                 | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
| 207 |                   VIEW                                   |               |     1 |    33 |  1096   (2)| 00:00:14 |
| 208 |                    SORT GROUP BY                         |               |     1 |    44 |  1096   (2)| 00:00:14 |
|*209 |                     HASH JOIN RIGHT SEMI                 |               |    12 |   528 |  1095   (1)| 00:00:14 |
| 210 |                      VIEW                                | VW_NSO_3      |     1 |     6 |   416   (1)| 00:00:05 |
| 211 |                       SORT GROUP BY                      |               |     1 |    26 |   416   (1)| 00:00:05 |
| 212 |                        VIEW                              | VM_NWVW_7     |     1 |    26 |   415   (1)| 00:00:05 |
| 213 |                         SORT GROUP BY                    |               |     1 |   177 |   415   (1)| 00:00:05 |
| 214 |                          NESTED LOOPS                    |               |       |       |            |          |
| 215 |                           NESTED LOOPS                   |               |     1 |   177 |   414   (1)| 00:00:05 |
| 216 |                            NESTED LOOPS                  |               |     1 |   141 |   411   (1)| 00:00:05 |
| 217 |                             NESTED LOOPS                 |               |     1 |   109 |   409   (1)| 00:00:05 |
| 218 |                              NESTED LOOPS                |               |    28 |  1792 |   368   (1)| 00:00:05 |
|*219 |                               TABLE ACCESS BY INDEX ROWID| TB_YYDK302    |    28 |  1064 |   284   (1)| 00:00:04 |
|*220 |                                INDEX RANGE SCAN          | PK_YYDK302    |  2228 |       |    11   (0)| 00:00:01 |
|*221 |                               INDEX RANGE SCAN           | PK_YYDS510    |     1 |    26 |     3   (0)| 00:00:01 |
|*222 |                              TABLE ACCESS BY INDEX ROWID | TB_YYDK302    |     1 |    45 |     2   (0)| 00:00:01 |
|*223 |                               INDEX UNIQUE SCAN          | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*224 |                             TABLE ACCESS BY INDEX ROWID  | TB_YYDK301    |     1 |    32 |     2   (0)| 00:00:01 |
|*225 |                              INDEX UNIQUE SCAN           | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|*226 |                            INDEX RANGE SCAN              | PK_YYDK308    |     1 |       |     2   (0)| 00:00:01 |
| 227 |                           TABLE ACCESS BY INDEX ROWID    | TB_YYDK308    |     1 |    36 |     3   (0)| 00:00:01 |
| 228 |                      NESTED LOOPS                        |               |       |       |            |          |
| 229 |                       NESTED LOOPS                       |               |  6916 |   256K|   679   (1)| 00:00:09 |
| 230 |                        VIEW                              | VW_NSO_2      |     5 |    45 |    17   (0)| 00:00:01 |
| 231 |                         SORT UNIQUE                      |               |     5 |    60 |            |          |
|*232 |                          COUNT STOPKEY                   |               |       |       |            |          |
|*233 |                           VIEW                           |               |     5 |    60 |    15   (0)| 00:00:01 |
| 234 |                            NESTED LOOPS                  |               |       |       |            |          |
| 235 |                             NESTED LOOPS                 |               |     5 |   110 |    15   (0)| 00:00:01 |
| 236 |                              TABLE ACCESS BY INDEX ROWID | TB_YYDK002    |    57 |   627 |     4   (0)| 00:00:01 |
|*237 |                               INDEX RANGE SCAN DESCENDING| PK_YYDK002    |     6 |       |     2   (0)| 00:00:01 |
|*238 |                              INDEX RANGE SCAN            | PK_YYDK003    |     1 |       |     1   (0)| 00:00:01 |
|*239 |                             TABLE ACCESS BY INDEX ROWID  | TB_YYDK003    |     1 |    11 |     2   (0)| 00:00:01 |
| 240 |                            TABLE ACCESS BY INDEX ROWID   | TB_YYDK002    |     1 |    11 |     2   (0)| 00:00:01 |
|*241 |                             INDEX UNIQUE SCAN            | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
|*242 |                        INDEX RANGE SCAN                  | PK_YYDS510    |  1383 |       |   115   (1)| 00:00:02 |
| 243 |                       TABLE ACCESS BY INDEX ROWID        | TB_YYDS510    |  1383 | 40107 |   158   (1)| 00:00:02 |
|*244 |                  TABLE ACCESS BY INDEX ROWID             | TB_YYDK301    |     1 |    20 |     2   (0)| 00:00:01 |
|*245 |                   INDEX UNIQUE SCAN                      | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|*246 |                 TABLE ACCESS BY INDEX ROWID              | TB_YYDK302    |     1 |    33 |     2   (0)| 00:00:01 |
|*247 |                  INDEX UNIQUE SCAN                       | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*248 |                TABLE ACCESS BY INDEX ROWID               | TB_YYDK302    |     1 |    26 |     2   (0)| 00:00:01 |
|*249 |                 INDEX UNIQUE SCAN                        | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*250 |               INDEX RANGE SCAN                           | PK_YYDK308    |     1 |    21 |     2   (0)| 00:00:01 |
| 251 |              VIEW PUSHED PREDICATE                       |               |     1 |       |    23   (5)| 00:00:01 |
|*252 |               FILTER                                     |               |       |       |            |          |
| 253 |                SORT AGGREGATE                            |               |     1 |    39 |            |          |
|*254 |                 HASH JOIN SEMI                           |               |     1 |    39 |    23   (5)| 00:00:01 |
| 255 |                  TABLE ACCESS BY INDEX ROWID             | TB_YYDS510    |     1 |    29 |     5   (0)| 00:00:01 |
|*256 |                   INDEX RANGE SCAN                       | PK_YYDS510    |     1 |       |     4   (0)| 00:00:01 |
|*257 |                  VIEW                                    | VW_NSO_1      |     5 |    50 |    17   (0)| 00:00:01 |
|*258 |                   COUNT STOPKEY                          |               |       |       |            |          |
|*259 |                    VIEW                                  |               |     5 |    60 |    15   (0)| 00:00:01 |
| 260 |                     NESTED LOOPS                         |               |       |       |            |          |
| 261 |                      NESTED LOOPS                        |               |     5 |   110 |    15   (0)| 00:00:01 |
| 262 |                       TABLE ACCESS BY INDEX ROWID        | TB_YYDK002    |    57 |   627 |     4   (0)| 00:00:01 |
|*263 |                        INDEX RANGE SCAN DESCENDING       | PK_YYDK002    |     6 |       |     2   (0)| 00:00:01 |
|*264 |                       INDEX RANGE SCAN                   | PK_YYDK003    |     1 |       |     1   (0)| 00:00:01 |
|*265 |                      TABLE ACCESS BY INDEX ROWID         | TB_YYDK003    |     1 |    11 |     2   (0)| 00:00:01 |
| 266 |                     TABLE ACCESS BY INDEX ROWID          | TB_YYDK002    |     1 |    11 |     2   (0)| 00:00:01 |
|*267 |                      INDEX UNIQUE SCAN                   | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------------------------------------

