        SELECT /*+ com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpFcstVs4Wk */ 
             A.START_TM,
             A.TRN_NO,
             A.ABRD_PRNB,
             A.EXPCT_ABRD_PRNB,
             A.AVG_OF_ABRD_PRNB,
             A.ABRD_PRNB_PERCENTAGE,
             A.EXPCT_ABRD_PRNB_PERCENTAGE,
             A.AVG_OF_ABRD_PRNB_PERCENTAGE,
             A.MOVE_CNT,
             A.ESCAPE_CNT,
             MAX (A.CLOSE_DAY) AS CLOSE_DAY,
             NVL (MAX (DECODE (A.RNUM, 0, A.CNT)), 0) AS D_DAY_00,
             NVL (MAX (DECODE (A.RNUM, 1, A.CNT)), 0) AS D_DAY_01,
             NVL (MAX (DECODE (A.RNUM, 2, A.CNT)), 0) AS D_DAY_02,
             NVL (MAX (DECODE (A.RNUM, 3, A.CNT)), 0) AS D_DAY_03,
             NVL (MAX (DECODE (A.RNUM, 4, A.CNT)), 0) AS D_DAY_04,
             NVL (MAX (DECODE (A.RNUM, 5, A.CNT)), 0) AS D_DAY_05,
             NVL (MAX (DECODE (A.RNUM, 6, A.CNT)), 0) AS D_DAY_06,
             NVL (MAX (DECODE (A.RNUM, 7, A.CNT)), 0) AS D_DAY_07,
             NVL (MAX (DECODE (A.RNUM, 8, A.CNT)), 0) AS D_DAY_08,
             NVL (MAX (DECODE (A.RNUM, 9, A.CNT)), 0) AS D_DAY_09,
             NVL (MAX (DECODE (A.RNUM, 10, A.CNT)), 0) AS D_DAY_10,
             NVL (MAX (DECODE (A.RNUM, 11, A.CNT)), 0) AS D_DAY_11,
             NVL (MAX (DECODE (A.RNUM, 12, A.CNT)), 0) AS D_DAY_12,
             NVL (MAX (DECODE (A.RNUM, 13, A.CNT)), 0) AS D_DAY_13,
             NVL (MAX (DECODE (A.RNUM, 14, A.CNT)), 0) AS D_DAY_14,
             NVL (MAX (DECODE (A.RNUM, 15, A.CNT)), 0) AS D_DAY_15,
             NVL (MAX (DECODE (A.RNUM, 16, A.CNT)), 0) AS D_DAY_16,
             NVL (MAX (DECODE (A.RNUM, 17, A.CNT)), 0) AS D_DAY_17,
             NVL (MAX (DECODE (A.RNUM, 18, A.CNT)), 0) AS D_DAY_18,
             NVL (MAX (DECODE (A.RNUM, 19, A.CNT)), 0) AS D_DAY_19,
             NVL (MAX (DECODE (A.RNUM, 20, A.CNT)), 0) AS D_DAY_20,
             NVL (MAX (DECODE (A.RNUM, 21, A.CNT)), 0) AS D_DAY_21,
             NVL (MAX (DECODE (A.RNUM, 22, A.CNT)), 0) AS D_DAY_22,
             NVL (MAX (DECODE (A.RNUM, 23, A.CNT)), 0) AS D_DAY_23,
             NVL (MAX (DECODE (A.RNUM, 24, A.CNT)), 0) AS D_DAY_24,
             NVL (MAX (DECODE (A.RNUM, 25, A.CNT)), 0) AS D_DAY_25,
             NVL (MAX (DECODE (A.RNUM, 26, A.CNT)), 0) AS D_DAY_26,
             NVL (MAX (DECODE (A.RNUM, 27, A.CNT)), 0) AS D_DAY_27,
             NVL (MAX (DECODE (A.RNUM, 28, A.CNT)), 0) AS D_DAY_28,
             NVL (MAX (DECODE (A.RNUM, 29, A.CNT)), 0) AS D_DAY_29,
             NVL (MAX (DECODE (A.RNUM, 30, A.CNT)), 0) AS D_DAY_30,
             NVL (MAX (DECODE (A.RNUM, 31, A.CNT)), 0) AS D_DAY_31
        FROM (  SELECT A2.START_TM,
                       A2.TRN_NO,
                       A2.ABRD_PRNB,
                       A2.EXPCT_ABRD_PRNB,
                       A2.AVG_OF_ABRD_PRNB,
                       A2.ABRD_PRNB_PERCENTAGE,
                       A2.EXPCT_ABRD_PRNB_PERCENTAGE,
                       A2.AVG_OF_ABRD_PRNB_PERCENTAGE,
                       A2.MOVE_CNT,
                       A2.ESCAPE_CNT,
                       A2.D_DAY,
                       B2.RNUM,
                       A2.CLOSE_DAY,
                       SUM (DECODE (A2.D_DAY, B2.RNUM, A2.CNT, 0))
                       OVER (PARTITION BY A2.START_TM, A2.TRN_NO
                             ORDER BY A2.START_TM, A2.TRN_NO, B2.RNUM DESC
                             RANGE UNBOUNDED PRECEDING)
                          AS CNT
                  FROM (SELECT A1.START_TM,
                               A1.TRN_NO,
                               A1.ABRD_PRNB,
                               A1.EXPCT_ABRD_PRNB,
                               A1.AVG_OF_ABRD_PRNB AS AVG_OF_ABRD_PRNB,
                               A1.ABRD_PRNB_PERCENTAGE * 100 AS ABRD_PRNB_PERCENTAGE,
                               A1.EXPCT_ABRD_PRNB_PERCENTAGE * 100 AS EXPCT_ABRD_PRNB_PERCENTAGE,
                               A1.AVG_OF_ABRD_PRNB_PERCENTAGE * 100 AS AVG_OF_ABRD_PRNB_PERCENTAGE,
                               A1.MOVE_CNT AS MOVE_CNT,
                               A1.ESCAPE_CNT AS ESCAPE_CNT,
                               A1.RESERVE_CNT,
                               A1.CANCEL_CNT,
                               A1.SALE_CNT,
                               A1.D_DAY,
                               A1.CNT,
                               A1.CLOSE_DAY,
                               NVL (LEAD (A1.D_DAY)
                                  OVER (PARTITION BY A1.START_TM, A1.TRN_NO
                                        ORDER BY A1.START_TM, A1.TRN_NO, A1.D_DAY), 60)
                                  AS D_DAY_F
                          FROM (SELECT    SUBSTR (A.START_TM, 1, 2)
                                       || ':'
                                       || SUBSTR (A.START_TM, 3, 2)
                                          AS START_TM,
                                       TO_CHAR (TO_NUMBER (A.TRN_NO)) AS TRN_NO,
                                       A.ABRD_PRNB,
                                       A.EXPCT_ABRD_PRNB,
                                       A.AVG_OF_ABRD_PRNB,
                                       A.ABRD_PRNB_PERCENTAGE,
                                       A.EXPCT_ABRD_PRNB_PERCENTAGE,
                                       A.AVG_OF_ABRD_PRNB_PERCENTAGE,
                                       A.MOVE_CNT,
                                       A.ESCAPE_CNT,
                                       B.D_DAY,
                                       B.RESERVE_CNT,
                                       B.CANCEL_CNT,
                                       B.RESERVE_CNT - B.CANCEL_CNT AS SALE_CNT,
                                       DECODE (#ACVM_DV_CD#, '1', B.RESERVE_CNT, '2', B.CANCEL_CNT, '3', B.RESERVE_CNT - B.CANCEL_CNT)
                                          AS CNT,
                                       B.CLOSE_DAY
                                  FROM (SELECT A.START_TM,
                                               A.TRN_NO,
                                               A.ABRD_PRNB,
                                               A.EXPCT_ABRD_PRNB,
                                               A.AVG_OF_ABRD_PRNB,
                                               A.ABRD_PRNB_PERCENTAGE,
                                               A.EXPCT_ABRD_PRNB_PERCENTAGE,
                                               A.AVG_OF_ABRD_PRNB_PERCENTAGE,
                                                 CASE
                                                    WHEN 0 > A.EXPCT_ABRD_PRNB - A.AVG_OF_ABRD_PRNB
                                                    THEN A.EXPCT_ABRD_PRNB - A.AVG_OF_ABRD_PRNB
                                                    ELSE 0
                                                 END * -1
                                                  AS ESCAPE_CNT,
                                               CASE
                                                  WHEN 0 < A.EXPCT_ABRD_PRNB - A.AVG_OF_ABRD_PRNB
                                                  THEN A.EXPCT_ABRD_PRNB - A.AVG_OF_ABRD_PRNB
                                                  ELSE 0
                                               END
                                                  AS MOVE_CNT,
                                               A.SEG_GP_NO
                                          FROM (SELECT A.START_TM,
                                                       A.TRN_NO,
                                                       A.ABRD_PRNB,
                                                       A.EXPCT_ABRD_PRNB,
                                                       ROUND (C.AVG_OF_ABRD_PRNB) AS AVG_OF_ABRD_PRNB,
                                                       B.SUM_OF_ABRD_PRNB,
                                                       B.SUM_OF_EXPCT_ABRD_PRNB,
                                                       DECODE (B.SUM_OF_ABRD_PRNB, 0, 0, A.ABRD_PRNB / B.SUM_OF_ABRD_PRNB)
                                                          AS ABRD_PRNB_PERCENTAGE,
                                                       DECODE (B.SUM_OF_EXPCT_ABRD_PRNB, 0, 0, A.EXPCT_ABRD_PRNB / B.SUM_OF_EXPCT_ABRD_PRNB)
                                                          AS EXPCT_ABRD_PRNB_PERCENTAGE,
                                                       DECODE (D.SUM_OF_AVG_OF_ABRD_PRNB, 0, 0, C.AVG_OF_ABRD_PRNB / D.SUM_OF_AVG_OF_ABRD_PRNB)
                                                          AS AVG_OF_ABRD_PRNB_PERCENTAGE,
                                                       A.SEG_GP_NO
                                                  FROM (  SELECT B.DPT_TM AS START_TM,
                                                                 A.TRN_NO AS TRN_NO,
                                                                 B.STOP_RS_STN_CD AS START_STN_CD,
                                                                 (SELECT Y.KOR_STN_NM /* 한글역명           */
                                                                    FROM TB_YYDK001 X, /* 예발역코드TBL     */
                                                                         TB_YYDK102 Y /* 역코드이력TBL     */
                                                                   WHERE     X.RS_STN_CD = B.STOP_RS_STN_CD
                                                                         AND X.STN_CD = Y.STN_CD
                                                                         AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                                                                    AS START_STN_NM,
                                                                 C.STOP_RS_STN_CD
                                                                    AS END_STN_CD,
                                                                 (SELECT Y.KOR_STN_NM /* 한글역명           */
                                                                    FROM TB_YYDK001 X, /* 예발역코드TBL     */
                                                                         TB_YYDK102 Y  /* 역코드이력TBL     */
                                                                   WHERE X.RS_STN_CD = C.STOP_RS_STN_CD
                                                                     AND X.STN_CD = Y.STN_CD
                                                                     AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                                                                    AS END_STN_NM,
                                                                 E.SEG_GP_NO AS SEG_GP_NO,
                                                                 SUM (A.ABRD_PRNB) AS ABRD_PRNB,
                                                                 SUM (F.EXPCT_ABRD_PRNB) AS EXPCT_ABRD_PRNB
                                                            FROM (  SELECT A.TRN_NO,
                                                                           A.RUN_DT,
                                                                           A.DPT_STN_CONS_ORDR,
                                                                           A.ARV_STN_CONS_ORDR,
                                                                           SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                      FROM TB_YYDS510 A
                                                                     WHERE     A.RUN_DT = #RUN_DT#
                                                                           AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                                           AND A.SEAT_ATT_CD BETWEEN '001' AND '036'
                                                                           AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                  GROUP BY A.TRN_NO,
                                                                           A.RUN_DT,
                                                                           A.DPT_STN_CONS_ORDR,
                                                                           A.ARV_STN_CONS_ORDR
                                                                 ) A,
                                                                 TB_YYDK302 B,
                                                                 TB_YYDK302 C,
                                                                 TB_YYDK301 D,
                                                                 TB_YYDK308 E,
                                                                 (  SELECT F.TRN_NO,
                                                                           F.RUN_DT,
                                                                           F.DPT_STN_CONS_ORDR,
                                                                           F.ARV_STN_CONS_ORDR,
                                                                           SUM (F.LAST_ABRD_EXPN_DMD_NUM) AS EXPCT_ABRD_PRNB
                                                                      FROM (  SELECT RUN_DT,
                                                                                     TRN_NO,
                                                                                     MAX (YMGT_JOB_ID) YMGT_JOB_ID
                                                                                FROM TB_YYFD011
                                                                               WHERE RUN_DT = #RUN_DT#
                                                                            GROUP BY RUN_DT, TRN_NO
                                                                           ) Z,
                                                                           TB_YYFD410 F
                                                                     WHERE     Z.RUN_DT = #RUN_DT#
                                                                           AND F.PSRM_CL_CD = NVL(#PSRM_CL_CD#, F.PSRM_CL_CD)
                                                                           AND F.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, F.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                           AND F.RUN_DT = Z.RUN_DT
                                                                           AND F.TRN_NO = Z.TRN_NO
                                                                           AND F.YMGT_JOB_ID = Z.YMGT_JOB_ID
                                                                  GROUP BY F.TRN_NO,
                                                                           F.RUN_DT,
                                                                           F.DPT_STN_CONS_ORDR,
                                                                           F.ARV_STN_CONS_ORDR) F
                                                           WHERE     A.TRN_NO = F.TRN_NO
                                                                 AND A.RUN_DT = F.RUN_DT
                                                                 AND A.DPT_STN_CONS_ORDR = F.DPT_STN_CONS_ORDR
                                                                 AND A.ARV_STN_CONS_ORDR = F.ARV_STN_CONS_ORDR
                                                                 AND A.TRN_NO = B.TRN_NO
                                                                 AND A.RUN_DT = B.RUN_DT
                                                                 AND B.STOP_RS_STN_CD = #DPT_RS_STN_CD#
                                                                 AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                                                                 AND A.TRN_NO = C.TRN_NO
                                                                 AND A.RUN_DT = C.RUN_DT
                                                                 AND C.STOP_RS_STN_CD = #ARV_RS_STN_CD#
                                                                 AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                                 AND A.TRN_NO = D.TRN_NO
                                                                 AND A.RUN_DT = D.RUN_DT
                                                                 AND D.STLB_TRN_CLSF_CD = NVL(#STLB_TRN_CLSF_CD#, D.STLB_TRN_CLSF_CD)
                                                                 AND A.TRN_NO = E.TRN_NO
                                                                 AND A.RUN_DT = E.RUN_DT
                                                                 AND B.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                                                                 AND C.TRVL_ZONE_NO = DECODE (D.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                                                        GROUP BY B.DPT_TM,
                                                                 A.TRN_NO,
                                                                 E.SEG_GP_NO,
                                                                 B.STOP_RS_STN_CD,
                                                                 C.STOP_RS_STN_CD
                                                       ) A,
                                                       (  SELECT SUM (A.ABRD_PRNB) AS SUM_OF_ABRD_PRNB,
                                                                 SUM (F.EXPCT_ABRD_PRNB) AS SUM_OF_EXPCT_ABRD_PRNB
                                                            FROM (  SELECT A.TRN_NO,
                                                                           A.RUN_DT,
                                                                           A.DPT_STN_CONS_ORDR,
                                                                           A.ARV_STN_CONS_ORDR,
                                                                           SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                      FROM TB_YYDS510 A
                                                                     WHERE     A.RUN_DT = #RUN_DT#
                                                                           AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                                           AND A.SEAT_ATT_CD BETWEEN '001' AND '036'
                                                                           AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                GROUP BY A.TRN_NO,
                                                                         A.RUN_DT,
                                                                         A.DPT_STN_CONS_ORDR,
                                                                         A.ARV_STN_CONS_ORDR
                                                               ) A,
                                                               TB_YYDK302 B,
                                                               TB_YYDK302 C,
                                                               TB_YYDK301 D,
                                                               TB_YYDK308 E,
                                                               (  SELECT F.TRN_NO,
                                                                         F.RUN_DT,
                                                                         F.DPT_STN_CONS_ORDR,
                                                                         F.ARV_STN_CONS_ORDR,
                                                                         SUM (F.LAST_ABRD_EXPN_DMD_NUM) AS EXPCT_ABRD_PRNB
                                                                    FROM (  SELECT RUN_DT,
                                                                                   TRN_NO,
                                                                                   MAX (YMGT_JOB_ID) YMGT_JOB_ID
                                                                              FROM TB_YYFD011
                                                                             WHERE RUN_DT = #RUN_DT#
                                                                          GROUP BY RUN_DT,
                                                                                   TRN_NO
                                                                         ) Z,
                                                                         TB_YYFD410 F
                                                                   WHERE     F.PSRM_CL_CD = NVL(#PSRM_CL_CD#, F.PSRM_CL_CD)
                                                                         AND F.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, F.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                         AND F.RUN_DT = Z.RUN_DT
                                                                         AND F.TRN_NO = Z.TRN_NO
                                                                         AND F.YMGT_JOB_ID = Z.YMGT_JOB_ID
                                                                GROUP BY F.TRN_NO,
                                                                         F.RUN_DT,
                                                                         F.DPT_STN_CONS_ORDR,
                                                                         F.ARV_STN_CONS_ORDR
                                                               ) F
                                                         WHERE     A.TRN_NO            = F.TRN_NO
                                                               AND A.RUN_DT            = F.RUN_DT
                                                               AND A.DPT_STN_CONS_ORDR = F.DPT_STN_CONS_ORDR
                                                               AND A.ARV_STN_CONS_ORDR = F.ARV_STN_CONS_ORDR
                                                               AND A.TRN_NO            = B.TRN_NO
                                                               AND B.RUN_DT            = #RUN_DT#
                                                               AND B.STOP_RS_STN_CD    = #DPT_RS_STN_CD#
                                                               AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                                                               AND A.TRN_NO            = C.TRN_NO
                                                               AND C.RUN_DT            = #RUN_DT#
                                                               AND C.STOP_RS_STN_CD    = #ARV_RS_STN_CD#
                                                               AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                               AND A.TRN_NO            = D.TRN_NO
                                                               AND D.RUN_DT            = #RUN_DT#
                                                               AND D.STLB_TRN_CLSF_CD  = NVL(#STLB_TRN_CLSF_CD#, D.STLB_TRN_CLSF_CD)
                                                               AND A.TRN_NO            = E.TRN_NO
                                                               AND A.RUN_DT            = E.RUN_DT
                                                               AND B.TRVL_ZONE_NO      = DECODE (D.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                                                               AND C.TRVL_ZONE_NO      = DECODE (D.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                                                       ) B,
                                                       (  SELECT A.TRN_NO,
                                                                 SUM (A.AVG_OF_ABRD_PRNB) AS AVG_OF_ABRD_PRNB
                                                            FROM (  SELECT A.DPT_TM,
                                                                           A.TRN_NO,
                                                                           ROUND ( (  A.ABRD_PRNB2 + A.ABRD_PRNB3 + A.ABRD_PRNB4 + A.ABRD_PRNB5) / 4) AS AVG_OF_ABRD_PRNB
                                                                      FROM (  SELECT A.DPT_TM,
                                                                                     A.TRN_NO,
                                                                                     A.BKCL_CD,
                                                                                     MAX (
                                                                                        CASE
                                                                                           WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_1
                                                                                                AND REPLACE (A.RUN_DT, '-', '') = #RUN_DT#
                                                                                           THEN A.ABRD_PRNB
                                                                                           ELSE 0
                                                                                        END)
                                                                                        AS ABRD_PRNB1,
                                                                                     MAX (
                                                                                        CASE
                                                                                           WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_5
                                                                                                AND REPLACE (A.RUN_DT, '-', '') <> #RUN_DT#
                                                                                           THEN A.ABRD_PRNB
                                                                                           ELSE 0
                                                                                        END)
                                                                                        AS ABRD_PRNB2,
                                                                                     MAX (
                                                                                        CASE
                                                                                           WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_4
                                                                                                AND REPLACE (A.RUN_DT, '-', '') <> #RUN_DT#
                                                                                           THEN A.ABRD_PRNB
                                                                                           ELSE 0
                                                                                        END)
                                                                                        AS ABRD_PRNB3,
                                                                                     MAX (
                                                                                        CASE
                                                                                           WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_3
                                                                                                AND REPLACE (A.RUN_DT, '-', '') <> #RUN_DT#
                                                                                           THEN A.ABRD_PRNB
                                                                                           ELSE 0
                                                                                        END)
                                                                                        AS ABRD_PRNB4,
                                                                                     MAX (
                                                                                        CASE
                                                                                           WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_2
                                                                                                AND REPLACE (A.RUN_DT, '-', '') <> #RUN_DT#
                                                                                           THEN A.ABRD_PRNB
                                                                                           ELSE 0
                                                                                        END)
                                                                                        AS ABRD_PRNB5
                                                                                FROM (  SELECT A.DPT_TM,
                                                                                               A.TRN_NO,
                                                                                               A.RUN_DT,
                                                                                               A.BKCL_CD,
                                                                                               A.ABRD_PRNB
                                                                                          FROM (  SELECT A.TRN_NO,
                                                                                                         A.RUN_DT,
                                                                                                         A.BKCL_CD,
                                                                                                         A.ABRD_PRNB,
                                                                                                         C.DPT_TM
                                                                                                    FROM (  SELECT A.TRN_NO,
                                                                                                                   A.RUN_DT,
                                                                                                                   DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD) AS BKCL_CD,
                                                                                                                   A.DPT_STN_CONS_ORDR,
                                                                                                                   A.ARV_STN_CONS_ORDR,
                                                                                                                   SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                                                              FROM TB_YYDS510 A
                                                                                                           WHERE     A.RUN_DT IN (  SELECT A.RUN_DT
                                                                                                                                      FROM (  SELECT A.RUN_DT
                                                                                                                                                FROM TB_YYDK002 A,
                                                                                                                                                     TB_YYDK003 B
                                                                                                                                               WHERE A.RUN_DT = B.RUN_DT
                                                                                                                                                 AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE (#RUN_DT#, 'YYYYMMDD') - 56, 'YYYYMMDD') 
                                                                                                                                                                  AND #RUN_DT#
                                                                                                                                                 AND A.DAY_DV_CD = (  SELECT DAY_DV_CD
                                                                                                                                                                        FROM TB_YYDK002
                                                                                                                                                                       WHERE RUN_DT = #RUN_DT#
                                                                                                                                                                   )
                                                                                                                                                 AND B.TRN_OPR_BZ_DV_CD = '001' 
                                                                                                                                                 AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                                                            ORDER BY A.RUN_DT DESC
                                                                                                                                           ) A
                                                                                                                                     WHERE ROWNUM < 6
                                                                                                                                 )
                                                                                                                 AND A.TRN_NO IN (  SELECT DISTINCT
                                                                                                                                           A.TRN_NO
                                                                                                                                      FROM (  SELECT A.TRN_NO,
                                                                                                                                                     A.RUN_DT,
                                                                                                                                                     A.DPT_STN_CONS_ORDR,
                                                                                                                                                     A.ARV_STN_CONS_ORDR,
                                                                                                                                                     SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                                                                                                FROM TB_YYDS510 A
                                                                                                                                               WHERE     A.RUN_DT = #RUN_DT#
                                                                                                                                                     AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                                                                                                                     AND A.SEAT_ATT_CD BETWEEN '001' AND '036'
                                                                                                                                                     AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                                                                                            GROUP BY A.TRN_NO,
                                                                                                                                                     A.RUN_DT,
                                                                                                                                                     A.DPT_STN_CONS_ORDR,
                                                                                                                                                     A.ARV_STN_CONS_ORDR
                                                                                                                                           ) A,
                                                                                                                                           TB_YYDK302 B,
                                                                                                                                           TB_YYDK302 C,
                                                                                                                                           TB_YYDK301 D,
                                                                                                                                           TB_YYDK308 E
                                                                                                                                     WHERE     A.TRN_NO            = B.TRN_NO
                                                                                                                                           AND A.RUN_DT            = B.RUN_DT
                                                                                                                                           AND B.STOP_RS_STN_CD    = #DPT_RS_STN_CD#
                                                                                                                                           AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                                                                                                                                           AND A.TRN_NO            = C.TRN_NO
                                                                                                                                           AND A.RUN_DT            = C.RUN_DT
                                                                                                                                           AND C.STOP_RS_STN_CD    = #ARV_RS_STN_CD#
                                                                                                                                           AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                                                                                                           AND A.TRN_NO            = D.TRN_NO
                                                                                                                                           AND A.RUN_DT            = D.RUN_DT
                                                                                                                                           AND D.STLB_TRN_CLSF_CD  = NVL(#STLB_TRN_CLSF_CD#, D.STLB_TRN_CLSF_CD)
                                                                                                                                           AND A.TRN_NO            = E.TRN_NO
                                                                                                                                           AND A.RUN_DT            = E.RUN_DT
                                                                                                                                           AND B.TRVL_ZONE_NO      = DECODE (D.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                                                                                                                                           AND C.TRVL_ZONE_NO      = DECODE (D.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                                                                                                                                      GROUP BY B.DPT_TM,
                                                                                                                                               A.TRN_NO,
                                                                                                                                               E.SEG_GP_NO,
                                                                                                                                               B.STOP_RS_STN_CD,
                                                                                                                                               C.STOP_RS_STN_CD
                                                                                                                                     )
                                                                                                                 AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                                                                                 AND A.SEAT_ATT_CD BETWEEN '001' AND '036'
                                                                                                                 AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                                                        GROUP BY A.TRN_NO,
                                                                                                                 A.RUN_DT,
                                                                                                                 DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD),
                                                                                                                 A.DPT_STN_CONS_ORDR,
                                                                                                                 A.ARV_STN_CONS_ORDR
                                                                                                       ) A,
                                                                                                       (  SELECT A.TRN_NO,
                                                                                                                 A.RUN_DT,
                                                                                                                 A.DPT_STN_CONS_ORDR,
                                                                                                                 A.ARV_STN_CONS_ORDR,
                                                                                                                 SUM (A.ABRD_PRNB) AS SUM_OF_ABRD_PRNB
                                                                                                            FROM TB_YYDS510 A
                                                                                                           WHERE     A.RUN_DT IN (  SELECT A.RUN_DT
                                                                                                                                      FROM (  SELECT A.RUN_DT
                                                                                                                                                FROM TB_YYDK002 A,
                                                                                                                                                     TB_YYDK003 B
                                                                                                                                               WHERE A.RUN_DT = B.RUN_DT
                                                                                                                                                 AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE (#RUN_DT#, 'YYYYMMDD') - 56, 'YYYYMMDD') 
                                                                                                                                                                  AND #RUN_DT#
                                                                                                                                                 AND A.DAY_DV_CD = (  SELECT DAY_DV_CD
                                                                                                                                                                        FROM TB_YYDK002
                                                                                                                                                                       WHERE RUN_DT = #RUN_DT#
                                                                                                                                                                   )
                                                                                                                                                 AND B.TRN_OPR_BZ_DV_CD = '001' 
                                                                                                                                                 AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                                                            ORDER BY A.RUN_DT DESC
                                                                                                                                           ) A
                                                                                                                                     WHERE ROWNUM < 6
                                                                                                                                 )
                                                                                                                 AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                                                                                 AND A.SEAT_ATT_CD BETWEEN '001' AND '036' 
                                                                                                                 AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                                                        GROUP BY A.TRN_NO,
                                                                                                                 A.RUN_DT,
                                                                                                                 A.DPT_STN_CONS_ORDR,
                                                                                                                 A.ARV_STN_CONS_ORDR
                                                                                                       ) B,
                                                                                                       TB_YYDK302 C,
                                                                                                       TB_YYDK302 D,
                                                                                                       TB_YYDK301 E,
                                                                                                       TB_YYDK308 F
                                                                                                 WHERE     A.TRN_NO            = B.TRN_NO
                                                                                                       AND A.RUN_DT            = B.RUN_DT
                                                                                                       AND A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR
                                                                                                       AND A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR
                                                                                                       AND A.TRN_NO            = C.TRN_NO
                                                                                                       AND A.RUN_DT            = C.RUN_DT
                                                                                                       AND C.STOP_RS_STN_CD    = #DPT_RS_STN_CD#
                                                                                                       AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                                                                       AND A.TRN_NO            = D.TRN_NO
                                                                                                       AND A.RUN_DT            = D.RUN_DT
                                                                                                       AND D.STOP_RS_STN_CD    = #ARV_RS_STN_CD#
                                                                                                       AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                                                                                                       AND A.TRN_NO            = E.TRN_NO
                                                                                                       AND A.RUN_DT            = E.RUN_DT
                                                                                                       AND E.STLB_TRN_CLSF_CD  = NVL(#STLB_TRN_CLSF_CD#, E.STLB_TRN_CLSF_CD)
                                                                                                       AND A.TRN_NO            = F.TRN_NO
                                                                                                       AND A.RUN_DT            = F.RUN_DT
                                                                                                       AND C.TRVL_ZONE_NO      = DECODE (E.UP_DN_DV_CD, 'D', F.DPT_ZONE_NO, F.ARV_ZONE_NO)
                                                                                                       AND D.TRVL_ZONE_NO      = DECODE (E.UP_DN_DV_CD, 'D', F.ARV_ZONE_NO, F.DPT_ZONE_NO)
                                                                                               ) A
                                                                                      ORDER BY A.TRN_NO,
                                                                                               A.DPT_TM,
                                                                                               A.RUN_DT
                                                                                     ) A,
                                                                                     (  SELECT MAX (DECODE (ROWNUM, 5, A.RUN_DT)) AS RUN_DT_5,
                                                                                               MAX (DECODE (ROWNUM, 4, A.RUN_DT)) AS RUN_DT_4,
                                                                                               MAX (DECODE (ROWNUM, 3, A.RUN_DT)) AS RUN_DT_3,
                                                                                               MAX (DECODE (ROWNUM, 2, A.RUN_DT)) AS RUN_DT_2,
                                                                                               MAX (DECODE (ROWNUM, 1, A.RUN_DT)) AS RUN_DT_1
                                                                                        FROM (  SELECT A.RUN_DT
                                                                                                  FROM TB_YYDK002 A,
                                                                                                       TB_YYDK003 B
                                                                                                 WHERE A.RUN_DT = B.RUN_DT
                                                                                                   AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE (#RUN_DT#, 'YYYYMMDD') - 56, 'YYYYMMDD') 
                                                                                                                    AND #RUN_DT#
                                                                                                   AND A.DAY_DV_CD = (  SELECT DAY_DV_CD
                                                                                                                          FROM TB_YYDK002
                                                                                                                         WHERE RUN_DT = #RUN_DT#
                                                                                                                     )
                                                                                                   AND B.TRN_OPR_BZ_DV_CD = '001' 
                                                                                                   AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                              ORDER BY A.RUN_DT DESC
                                                                                             ) A
                                                                                     ) B
                                                                            GROUP BY A.DPT_TM,
                                                                                     A.TRN_NO,
                                                                                     A.BKCL_CD
                                                                           ) A
                                                                  ORDER BY A.DPT_TM,
                                                                           A.TRN_NO,
                                                                           A.BKCL_CD
                                                                 ) A
                                                        GROUP BY A.TRN_NO
                                                       ) C,
                                                       (  SELECT SUM (A.AVG_OF_ABRD_PRNB) AS SUM_OF_AVG_OF_ABRD_PRNB
                                                            FROM (  SELECT A.TRN_NO,
                                                                           SUM (A.AVG_OF_ABRD_PRNB) AS AVG_OF_ABRD_PRNB
                                                                      FROM (  SELECT A.DPT_TM,
                                                                                     A.TRN_NO,
                                                                                     ROUND ( (  A.ABRD_PRNB2 + A.ABRD_PRNB3 + A.ABRD_PRNB4 + A.ABRD_PRNB5) / 4) AS AVG_OF_ABRD_PRNB
                                                                                FROM (  SELECT A.DPT_TM,
                                                                                               A.TRN_NO,
                                                                                               A.BKCL_CD,
                                                                                               MAX (
                                                                                                  CASE
                                                                                                     WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_1
                                                                                                          AND REPLACE (A.RUN_DT, '-', '') = #RUN_DT#
                                                                                                     THEN A.ABRD_PRNB
                                                                                                     ELSE 0
                                                                                                  END)
                                                                                                  AS ABRD_PRNB1,
                                                                                               MAX (
                                                                                                  CASE
                                                                                                     WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_5
                                                                                                          AND REPLACE (A.RUN_DT, '-', '') <> #RUN_DT#
                                                                                                     THEN A.ABRD_PRNB
                                                                                                     ELSE 0
                                                                                                  END)
                                                                                                  AS ABRD_PRNB2,
                                                                                               MAX (
                                                                                                  CASE
                                                                                                     WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_4
                                                                                                          AND REPLACE (A.RUN_DT, '-', '') <> #RUN_DT#
                                                                                                     THEN A.ABRD_PRNB
                                                                                                     ELSE 0
                                                                                                  END)
                                                                                                  AS ABRD_PRNB3,
                                                                                               MAX (
                                                                                                  CASE
                                                                                                     WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_3
                                                                                                          AND REPLACE (A.RUN_DT, '-','') <> #RUN_DT#
                                                                                                     THEN A.ABRD_PRNB
                                                                                                     ELSE 0
                                                                                                  END)
                                                                                                  AS ABRD_PRNB4,
                                                                                               MAX (
                                                                                                  CASE
                                                                                                     WHEN     REPLACE (A.RUN_DT, '-', '') = B.RUN_DT_2
                                                                                                          AND REPLACE (A.RUN_DT, '-', '') <> #RUN_DT#
                                                                                                     THEN A.ABRD_PRNB
                                                                                                     ELSE 0
                                                                                                  END)
                                                                                                  AS ABRD_PRNB5
                                                                                          FROM (  SELECT A.DPT_TM,
                                                                                                         A.TRN_NO,
                                                                                                         A.RUN_DT,
                                                                                                         A.BKCL_CD,
                                                                                                         A.ABRD_PRNB
                                                                                                    FROM (  SELECT A.TRN_NO,
                                                                                                                   A.RUN_DT,
                                                                                                                   A.BKCL_CD,
                                                                                                                   A.ABRD_PRNB,
                                                                                                                   C.DPT_TM
                                                                                                              FROM (  SELECT A.TRN_NO,
                                                                                                                             A.RUN_DT,
                                                                                                                             DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD) AS BKCL_CD,
                                                                                                                             A.DPT_STN_CONS_ORDR,
                                                                                                                             A.ARV_STN_CONS_ORDR,
                                                                                                                             SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                                                                        FROM TB_YYDS510 A
                                                                                                                       WHERE     A.RUN_DT IN (  SELECT A.RUN_DT
                                                                                                                                                  FROM (  SELECT A.RUN_DT
                                                                                                                                                            FROM TB_YYDK002 A,
                                                                                                                                                                 TB_YYDK003 B
                                                                                                                                                           WHERE A.RUN_DT = B.RUN_DT
                                                                                                                                                             AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE (#RUN_DT#, 'YYYYMMDD') - 56, 'YYYYMMDD') 
                                                                                                                                                                              AND #RUN_DT#
                                                                                                                                                             AND A.DAY_DV_CD = (  SELECT DAY_DV_CD
                                                                                                                                                                                    FROM TB_YYDK002
                                                                                                                                                                                   WHERE RUN_DT = #RUN_DT#
                                                                                                                                                                               )
                                                                                                                                                             AND B.TRN_OPR_BZ_DV_CD = '001' 
                                                                                                                                                             AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                                                                        ORDER BY A.RUN_DT DESC
                                                                                                                                                       ) A
                                                                                                                                                 WHERE ROWNUM < 6
                                                                                                                                             )
                                                                                                                         AND A.TRN_NO IN (  SELECT DISTINCT
                                                                                                                                                   A.TRN_NO
                                                                                                                                              FROM (  SELECT A.TRN_NO,
                                                                                                                                                             A.RUN_DT,
                                                                                                                                                             A.DPT_STN_CONS_ORDR,
                                                                                                                                                             A.ARV_STN_CONS_ORDR,
                                                                                                                                                             SUM (A.ABRD_PRNB) AS ABRD_PRNB
                                                                                                                                                        FROM TB_YYDS510 A
                                                                                                                                                       WHERE     A.RUN_DT = #RUN_DT#
                                                                                                                                                             AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                                                                                                                             AND A.SEAT_ATT_CD BETWEEN '001' AND '036'
                                                                                                                                                             AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                                                                                                        GROUP BY A.TRN_NO,
                                                                                                                                                                 A.RUN_DT,
                                                                                                                                                                 A.DPT_STN_CONS_ORDR,
                                                                                                                                                                 A.ARV_STN_CONS_ORDR
                                                                                                                                                   ) A,
                                                                                                                                                   TB_YYDK302 B,
                                                                                                                                                   TB_YYDK302 C,
                                                                                                                                                   TB_YYDK301 D,
                                                                                                                                                   TB_YYDK308 E
                                                                                                                                             WHERE     A.TRN_NO            = B.TRN_NO
                                                                                                                                                   AND A.RUN_DT            = B.RUN_DT
                                                                                                                                                   AND B.STOP_RS_STN_CD    = #DPT_RS_STN_CD#
                                                                                                                                                   AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                                                                                                                                                   AND A.TRN_NO            = C.TRN_NO
                                                                                                                                                   AND A.RUN_DT            = C.RUN_DT
                                                                                                                                                   AND C.STOP_RS_STN_CD    = #ARV_RS_STN_CD#
                                                                                                                                                   AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                                                                                                                   AND A.TRN_NO            = D.TRN_NO
                                                                                                                                                   AND A.RUN_DT            = D.RUN_DT
                                                                                                                                                   AND D.STLB_TRN_CLSF_CD  = NVL(#STLB_TRN_CLSF_CD#, D.STLB_TRN_CLSF_CD)
                                                                                                                                                   AND A.TRN_NO            = E.TRN_NO
                                                                                                                                                   AND A.RUN_DT            = E.RUN_DT
                                                                                                                                                   AND B.TRVL_ZONE_NO      = DECODE (D.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                                                                                                                                                   AND C.TRVL_ZONE_NO      = DECODE (D.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                                                                                                                                          GROUP BY B.DPT_TM,
                                                                                                                                                   A.TRN_NO,
                                                                                                                                                   E.SEG_GP_NO,
                                                                                                                                                   B.STOP_RS_STN_CD,
                                                                                                                                                   C.STOP_RS_STN_CD
                                                                                                                                         )
                                                                                                                         AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                                                                                         AND A.SEAT_ATT_CD BETWEEN '001' AND '036'
                                                                                                                         AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                                                                GROUP BY A.TRN_NO,
                                                                                                                         A.RUN_DT,
                                                                                                                         DECODE (A.BKCL_CD, 'F2', 'F1', A.BKCL_CD),
                                                                                                                         A.DPT_STN_CONS_ORDR,
                                                                                                                         A.ARV_STN_CONS_ORDR
                                                                                                               ) A,
                                                                                                               (  SELECT A.TRN_NO,
                                                                                                                         A.RUN_DT,
                                                                                                                         A.DPT_STN_CONS_ORDR,
                                                                                                                         A.ARV_STN_CONS_ORDR,
                                                                                                                         SUM (A.ABRD_PRNB) AS SUM_OF_ABRD_PRNB
                                                                                                                    FROM TB_YYDS510 A
                                                                                                                   WHERE     A.RUN_DT IN (  SELECT A.RUN_DT
                                                                                                                                              FROM (  SELECT A.RUN_DT
                                                                                                                                                        FROM TB_YYDK002 A,
                                                                                                                                                             TB_YYDK003 B
                                                                                                                                                       WHERE A.RUN_DT = B.RUN_DT
                                                                                                                                                         AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE (#RUN_DT#, 'YYYYMMDD') - 56, 'YYYYMMDD') 
                                                                                                                                                                          AND #RUN_DT#
                                                                                                                                                         AND A.DAY_DV_CD = (  SELECT DAY_DV_CD
                                                                                                                                                                                FROM TB_YYDK002
                                                                                                                                                                               WHERE RUN_DT = #RUN_DT#
                                                                                                                                                                           )
                                                                                                                                                         AND B.TRN_OPR_BZ_DV_CD = '001' 
                                                                                                                                                         AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                                                                    ORDER BY A.RUN_DT DESC
                                                                                                                                                   ) A
                                                                                                                                             WHERE ROWNUM < 6
                                                                                                                                         )
                                                                                                                         AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                                                                                         AND A.SEAT_ATT_CD BETWEEN '001' AND '036'
                                                                                                                         AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                                                                GROUP BY A.TRN_NO,
                                                                                                                         A.RUN_DT,
                                                                                                                         A.DPT_STN_CONS_ORDR,
                                                                                                                         A.ARV_STN_CONS_ORDR
                                                                                                               ) B,
                                                                                                               TB_YYDK302 C,
                                                                                                               TB_YYDK302 D,
                                                                                                               TB_YYDK301 E,
                                                                                                               TB_YYDK308 F
                                                                                                         WHERE     A.TRN_NO            = B.TRN_NO
                                                                                                               AND A.RUN_DT            = B.RUN_DT
                                                                                                               AND A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR
                                                                                                               AND A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR
                                                                                                               AND A.TRN_NO            = C.TRN_NO
                                                                                                               AND A.RUN_DT            = C.RUN_DT
                                                                                                               AND C.STOP_RS_STN_CD    = #DPT_RS_STN_CD#
                                                                                                               AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                                                                               AND A.TRN_NO            = D.TRN_NO
                                                                                                               AND A.RUN_DT            = D.RUN_DT
                                                                                                               AND D.STOP_RS_STN_CD    = #ARV_RS_STN_CD#
                                                                                                               AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                                                                                                               AND A.TRN_NO            = E.TRN_NO
                                                                                                               AND A.RUN_DT            = E.RUN_DT
                                                                                                               AND E.STLB_TRN_CLSF_CD  = NVL(#STLB_TRN_CLSF_CD#, E.STLB_TRN_CLSF_CD)
                                                                                                               AND A.TRN_NO            = F.TRN_NO
                                                                                                               AND A.RUN_DT            = F.RUN_DT
                                                                                                               AND C.TRVL_ZONE_NO      = DECODE (E.UP_DN_DV_CD, 'D', F.DPT_ZONE_NO, F.ARV_ZONE_NO)
                                                                                                               AND D.TRVL_ZONE_NO      = DECODE (E.UP_DN_DV_CD, 'D', F.ARV_ZONE_NO, F.DPT_ZONE_NO)
                                                                                                         ) A
                                                                                                ORDER BY A.TRN_NO,
                                                                                                         A.DPT_TM,
                                                                                                         A.RUN_DT
                                                                                               ) A,
                                                                                               (  SELECT MAX (DECODE (ROWNUM,5, A.RUN_DT)) AS RUN_DT_5,
                                                                                                         MAX (DECODE (ROWNUM,4, A.RUN_DT)) AS RUN_DT_4,
                                                                                                         MAX (DECODE (ROWNUM,3, A.RUN_DT)) AS RUN_DT_3,
                                                                                                         MAX (DECODE (ROWNUM,2, A.RUN_DT)) AS RUN_DT_2,
                                                                                                         MAX (DECODE (ROWNUM,1, A.RUN_DT)) AS RUN_DT_1
                                                                                                    FROM (  SELECT A.RUN_DT
                                                                                                              FROM TB_YYDK002 A,
                                                                                                                   TB_YYDK003 B
                                                                                                             WHERE A.RUN_DT = B.RUN_DT
                                                                                                               AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE (#RUN_DT#, 'YYYYMMDD') - 56, 'YYYYMMDD') 
                                                                                                                                AND #RUN_DT#
                                                                                                               AND A.DAY_DV_CD = (  SELECT DAY_DV_CD
                                                                                                                                      FROM TB_YYDK002
                                                                                                                                     WHERE RUN_DT = #RUN_DT#
                                                                                                                                 )
                                                                                                               AND B.TRN_OPR_BZ_DV_CD = '001' 
                                                                                                               AND B.BIZ_DD_STG_CD IN ('1', '2', '3') /*평일, 주중, 표준(공휴일, 명절대수송 제외)*/
                                                                                                          ORDER BY A.RUN_DT DESC
                                                                                                         ) A
                                                                                               ) B
                                                                                      GROUP BY A.DPT_TM,
                                                                                               A.TRN_NO,
                                                                                               A.BKCL_CD
                                                                                     ) A
                                                                            ORDER BY A.DPT_TM,
                                                                                     A.TRN_NO,
                                                                                     A.BKCL_CD
                                                                           ) A
                                                                  GROUP BY A.TRN_NO
                                                                 ) A
                                                       ) D
                                                 WHERE A.TRN_NO = C.TRN_NO(+)
                                               ) A
                                       ) A,
                                       (  SELECT A.TRN_NO,
                                                 A.D_DAY,
                                                 B.D_DAY AS CLOSE_DAY,
                                                 A.DPT_STN_CONS_ORDR,
                                                 A.ARV_STN_CONS_ORDR,
                                                 A.SEG_GP_NO,
                                                 A.RESERVE_CNT,
                                                 A.CANCEL_CNT
                                            FROM (  SELECT A.TRN_NO,
                                                           TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (A.DEAL_DT, 'YYYYMMDD') AS D_DAY,
                                                           A.DPT_STN_CONS_ORDR,
                                                           A.ARV_STN_CONS_ORDR,
                                                           D.SEG_GP_NO,
                                                           SUM (A.RSV_SEAT_NUM) + SUM (A.SALE_SEAT_NUM) AS RESERVE_CNT,
                                                           SUM (A.CNC_SEAT_NUM) + SUM (A.RET_SEAT_NUM) AS CANCEL_CNT
                                                      FROM TB_YYDS501 A,
                                                           TB_YYDK302 B,
                                                           TB_YYDK302 C,
                                                           TB_YYDK308 D,
                                                           TB_YYDK301 E
                                                     WHERE     A.RUN_DT            = #RUN_DT#
                                                           AND A.PSRM_CL_CD        = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                           AND A.SEAT_ATT_CD BETWEEN '001' AND '036'
                                                           AND A.BKCL_CD           LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                           AND A.RUN_DT           >= A.DEAL_DT
                                                           AND A.TRN_NO            = B.TRN_NO
                                                           AND A.RUN_DT            = B.RUN_DT
                                                           AND A.DPT_STN_CONS_ORDR =B.STN_CONS_ORDR
                                                           AND B.STOP_RS_STN_CD    = #DPT_RS_STN_CD#
                                                           AND A.TRN_NO            = C.TRN_NO
                                                           AND A.RUN_DT            = C.RUN_DT
                                                           AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                                                           AND C.STOP_RS_STN_CD    = #ARV_RS_STN_CD#
                                                           AND A.TRN_NO            = E.TRN_NO
                                                           AND A.RUN_DT            = E.RUN_DT
                                                           AND A.TRN_NO            = D.TRN_NO
                                                           AND A.RUN_DT            = D.RUN_DT
                                                           AND B.TRVL_ZONE_NO      = DECODE (E.UP_DN_DV_CD, 'D', D.DPT_ZONE_NO, D.ARV_ZONE_NO)
                                                           AND C.TRVL_ZONE_NO      = DECODE (E.UP_DN_DV_CD, 'D', D.ARV_ZONE_NO, D.DPT_ZONE_NO)
                                                  GROUP BY A.TRN_NO,
                                                           TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (A.DEAL_DT, 'YYYYMMDD'),
                                                           A.DPT_STN_CONS_ORDR,
                                                           A.ARV_STN_CONS_ORDR,
                                                           D.SEG_GP_NO,
                                                           A.RUN_DT,
                                                           A.DEAL_DT
                                                 ) A,
                                                 (  SELECT A.TRN_NO,
                                                           A.ZONE_SEG_GP_NO,
                                                           MAX (A.D_DAY) AS D_DAY
                                                      FROM (  SELECT A.TRN_NO,
                                                                     A.ZONE_SEG_GP_NO,
                                                                     TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (SUBSTR (A.YMGT_JOB_ID, 10, 8), 'YYYYMMDD') AS D_DAY
                                                                FROM TB_YYPD006 A
                                                               WHERE     A.RUN_DT = #RUN_DT#
                                                                     AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                                                     AND A.BKCL_CD LIKE DECODE(#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                                     AND A.SEAT_ATT_CD BETWEEN '001' AND '036'
                                                              HAVING DECODE (#BKCL_CD#, 'F1', SUM (NVL (A.GP_MRK_ALLW_NUM, 0))
                                                                                      , NULL  , SUM (NVL (A.GP_MRK_ALLW_NUM, 0))
                                                                                      , SUM (NVL (A.BKCL_MRK_ALLW_NUM, 0))) = 0
                                                            GROUP BY A.RUN_DT,
                                                                     A.TRN_NO,
                                                                     A.ZONE_SEG_GP_NO,
                                                                     SUBSTR (A.YMGT_JOB_ID, 10, 8)
                                                            ORDER BY 1, 2, 3
                                                           ) A
                                                  GROUP BY A.TRN_NO, A.ZONE_SEG_GP_NO
                                                 ) B
                                           WHERE     A.TRN_NO = B.TRN_NO(+)
                                                 AND A.SEG_GP_NO = B.ZONE_SEG_GP_NO(+)
                                                 AND A.D_DAY = B.D_DAY(+)
                                        ORDER BY 1, 2
                                       ) B
                                 WHERE     A.TRN_NO = B.TRN_NO
                                       AND A.SEG_GP_NO = B.SEG_GP_NO
                                       AND B.D_DAY <= '32'
                               ) A1
                       ) A2,
                       (  SELECT ROWNUM - 1 AS RNUM
                            FROM TB_YYDK002
                           WHERE ROWNUM <= 32
                       ) B2
                 WHERE B2.RNUM = A2.D_DAY
              ORDER BY A2.START_TM, A2.TRN_NO, B2.RNUM DESC
             ) A
    GROUP BY A.START_TM,
             A.TRN_NO,
             A.ABRD_PRNB,
             A.EXPCT_ABRD_PRNB,
             A.AVG_OF_ABRD_PRNB,
             A.ABRD_PRNB_PERCENTAGE,
             A.EXPCT_ABRD_PRNB_PERCENTAGE,
             A.AVG_OF_ABRD_PRNB_PERCENTAGE,
             A.MOVE_CNT,
             A.ESCAPE_CNT