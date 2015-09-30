  SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalRunDt */
        V.YMGT_JOB_ID AS YMGT_JOB_ID /* 수익관리작업ID         */
        ,SUBSTR (V.YMGT_JOB_ID, 14, 8) AS JOB_DT /* 작업일자             */
        ,A.RUN_DT AS RUN_DT /* 운행일자                 */
        ,A.TRN_NO_VAL AS TRN_NO_VAL /* 열차번호원본         */
        ,TO_NUMBER (A.TRN_NO) AS TRN_NO /* 열차번호                 */
        ,A.STLB_TRN_CLSF_CD AS STLB_TRN_CLSF_CD /* 열차종별코드         */
        ,A.RUN_DV_CD AS RUN_DV_CD /* 운행구분코드             */
        ,A.YMS_APL_FLG AS YMS_APL_FLG /* YMS적용여부         */
        ,A.RUN_INFO AS RUN_INFO /* 운행구간              */
        ,V.TRN_ANAL_DV_CD AS TRN_ANAL_DV_CD /* 열차분석구분코드     */
        ,V.JOB_DTTM AS JOB_DTTM /* 작업시작일시         */
        ,NVL (V.JOB_CLS_DTTM, '-') AS JOB_CLS_DTTM /* 작업종료일시         */
        ,A.DPT_TM_VAL AS DPT_TM_VAL /* 출발시각원본         */
        ,DECODE (V.FCST_DMD, NULL, '미실행', TO_CHAR (V.FCST_DMD, '9,999')) AS FCST_DMD /* 예측수요             */
        ,DECODE (V.REAL_SALE, NULL, '없음', TO_CHAR (V.REAL_SALE, '9,999')) AS REAL_SALE /* 예약발매실적         */
        ,V.SALE_GROUP1 AS SALE_GROUP1 /* 1구역 4주실적         */
        ,V.SALE_GROUP2 AS SALE_GROUP2 /* 2구역 4주실적         */
        ,V.FSCT_DMD_GROUP1 AS FSCT_DMD_GROUP1 /* 1구역 예측             */
        ,V.FSCT_DMD_GROUP2 AS FSCT_DMD_GROUP2 /* 2구역 예측             */
        ,TO_CHAR (V.AVG_ABRD_RT * 100, 'FM9999D0') AS AVG_ABRD_RT /* 4주실적승차율         */
        ,TO_CHAR (ROUND (V.FCST_ABRD_RT * 100, 1), 'FM9999D0') AS FCST_ABRD_RT /* 예측승차율             */
        ,TO_CHAR
         (
             ROUND (ABS (V.AVG_ABRD_RT - V.FCST_ABRD_RT) * V.AVG_ABRD_RT * 100 * (ABS (60 - (TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (SUBSTR (V.YMGT_JOB_ID, 14, 8), 'YYYYMMDD'))) / 60), 0)
            ,'FM9990D00'
         )
             AS RISK /* 위험지수             */
        ,A.ORG_RS_STN_CD AS ORG_RS_STN_CD /* 시발예발역코드         */
        ,A.TMN_RS_STN_CD AS TMN_RS_STN_CD /* 종착예발역코드         */
        ,A.ORG_RS_STN_CD_NM AS ORG_RS_STN_CD_NM /* 시발예발역코드명    */
        ,A.TMN_RS_STN_CD_NM AS TMN_RS_STN_CD_NM /* 종착예발역코드명    */
        ,A.DPT_TM_PRAM AS DPT_TM_PRAM /* 출발시각(파라미터-시분초) */
        ,A.ARV_TM_PRAM AS ARV_TM_PRAM /* 도착시각(파라미터-시분초) */
    FROM (SELECT N.RUN_DT AS RUN_DT /* 운행일자                 */
                ,N.TRN_NO AS TRN_NO /* 열차번호                 */
                ,N.TRN_NO AS TRN_NO_VAL /* 열차번호원본         */
                ,N.STLB_TRN_CLSF_CD AS STLB_TRN_CLSF_CD /* 열차종별코드         */
                ,N.ROUT_CD AS ROUT_CD /* 노선코드                 */
                ,N.UP_DN_DV_CD AS UP_DN_DV_CD /* 상하행구분코드           */
                ,N.RUN_DV_CD AS RUN_DV_CD /* 운행구분코드             */
                ,N.YMS_APL_FLG AS YMS_APL_FLG /* YMS적용여부              */
                ,N.ORG_RS_STN_CD AS ORG_RS_STN_CD /* 시발예발역코드           */
                ,N.TMN_RS_STN_CD AS TMN_RS_STN_CD /* 종착예발역코드           */
                ,SUBSTR (B.DPT_TM, 1, 2) AS DPT_TM /* 출발시각              */
                ,B.DPT_TM AS DPT_TM_VAL /* 출발시각원본         */
                ,   (SELECT TRIM (Y.KOR_STN_NM)
                       FROM TB_YYDK001 X, TB_YYDK102 Y
                      WHERE X.RS_STN_CD = N.ORG_RS_STN_CD
                        AND X.STN_CD = Y.STN_CD
                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                 || '-'
                 || (SELECT TRIM (Y.KOR_STN_NM)
                       FROM TB_YYDK001 X, TB_YYDK102 Y
                      WHERE X.RS_STN_CD = N.TMN_RS_STN_CD
                        AND X.STN_CD = Y.STN_CD
                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                 || '('
                 || TO_CHAR (TO_DATE (B.DPT_TM, 'hh24miss'), 'hh24:mi')
                 || '-'
                 || TO_CHAR (TO_DATE (C.ARV_TM, 'hh24miss'), 'hh24:mi')
                 || ')'
                     AS RUN_INFO /* 운행구간             */
                , (SELECT TRIM (Y.KOR_STN_NM)
                     FROM TB_YYDK001 X, TB_YYDK102 Y
                    WHERE X.RS_STN_CD = N.ORG_RS_STN_CD
                      AND X.STN_CD = Y.STN_CD
                      AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                     AS ORG_RS_STN_CD_NM /* 시발예발역코드명    */
                , (SELECT TRIM (Y.KOR_STN_NM)
                     FROM TB_YYDK001 X, TB_YYDK102 Y
                    WHERE X.RS_STN_CD = N.TMN_RS_STN_CD
                      AND X.STN_CD = Y.STN_CD
                      AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                     AS TMN_RS_STN_CD_NM /* 종착예발역코드명    */
                ,TO_CHAR (TO_DATE (B.DPT_TM, 'hh24miss'), 'hh24:mi:ss') AS DPT_TM_PRAM /* 출발시각(파라미터-시분초) */
                ,TO_CHAR (TO_DATE (C.ARV_TM, 'hh24miss'), 'hh24:mi:ss') AS ARV_TM_PRAM /* 도착시각(파라미터-시분초) */
            FROM TB_YYDK301 N /** 일일열차정보 TBL    **/
                ,TB_YYDK302 B /** 일일열차운행시각TBL **/
                ,TB_YYDK302 C /** 일일열차운행시각TBL **/
                ,TB_YYDK201 D /** 노선TBL           **/
           WHERE N.RUN_DT = B.RUN_DT(+)
             AND N.TRN_NO = B.TRN_NO(+)
             AND N.ORG_RS_STN_CD = B.STOP_RS_STN_CD(+)
             AND N.RUN_DT = C.RUN_DT(+)
             AND N.TRN_NO = C.TRN_NO(+)
             AND N.TMN_RS_STN_CD = C.STOP_RS_STN_CD(+)
             AND N.ROUT_CD = D.ROUT_CD(+)
             AND N.RUN_DT = '20140218'
             AND N.TRN_NO = DECODE (TRIM (''), NULL, N.TRN_NO, LPAD (TRIM (''), 5, '0'))
             AND N.STLB_TRN_CLSF_CD = NVL ('00', N.STLB_TRN_CLSF_CD)
             AND D.MRNT_CD = NVL ('', D.MRNT_CD)
             AND D.MRNT_CD IN ('01', '03', '04')
             AND D.EFC_ST_DT <= '20140218'
             AND N.ROUT_CD = NVL ('', N.ROUT_CD)
             AND N.UP_DN_DV_CD = DECODE ('A', 'A', N.UP_DN_DV_CD, 'A')) A
        ,(SELECT A1.YMGT_JOB_ID AS YMGT_JOB_ID /* 수익관리작업ID        */
                ,A1.RUN_DT AS RUN_DT /* 운행일자            */
                ,A1.TRN_NO AS TRN_NO /* 열차번호            */
                ,A1.TRN_ANAL_DV_CD AS TRN_ANAL_DV_CD /* 열차분석구분코드     */
                ,A1.REAL_SALE AS REAL_SALE /* 예약발매실적         */
                ,TO_NUMBER (NVL (LTRIM (SUBSTR (A1.GROUP_SALE, 1, 5), '0'), '0')) AS SALE_GROUP1 /* 1구역 4주실적         */
                ,TO_NUMBER (NVL (LTRIM (SUBSTR (A1.GROUP_SALE, 6, 5), '0'), '0')) AS SALE_GROUP2 /* 2구역 4주실적         */
                ,A1.JOB_DTTM AS JOB_DTTM /* 작업시작일시        */
                ,A1.JOB_CLS_DTTM AS JOB_CLS_DTTM /* 작업종료일시         */
                ,B1.FCST_DMD AS FCST_DMD /* 예측수요             */
                ,B1.FSCT_DMD_GROUP1 AS FSCT_DMD_GROUP1 /* 1구역 예측             */
                ,B1.FSCT_DMD_GROUP2 AS FSCT_DMD_GROUP2 /* 2구역 예측             */
                ,C1.AVG_ABRD_RT AS AVG_ABRD_RT /* 4주실적승차율         */
                ,C1.FCST_ABRD_RT AS FCST_ABRD_RT /* 예측승차율             */
            FROM (SELECT X.YMGT_JOB_ID AS YMGT_JOB_ID /* 수익관리작업ID       */
                        ,X.RUN_DT AS RUN_DT /* 운행일자             */
                        ,X.TRN_NO AS TRN_NO /* 열차번호             */
                        ,X.TRN_ANAL_DV_CD AS TRN_ANAL_DV_CD /* 열차분석구분코드 */
                        , (SELECT SUM (AA.RSV_SEAT_NUM + AA.SALE_SEAT_NUM - AA.RET_SEAT_NUM - AA.CNC_SEAT_NUM) AS REAL_SALE
                             FROM TB_YYDS501 AA, TB_YYDP503 N, TB_YYDD505 M
                            WHERE N.RUN_DT = '20140218'
                              AND N.TRN_NO = DECODE (TRIM (''), NULL, N.TRN_NO, LPAD (TRIM (''), 5, '0'))
                              AND N.MRNT_CD = NVL ('', N.MRNT_CD)
                              AND N.MRNT_CD IN ('01', '03', '04')
                              AND N.ROUT_CD = NVL ('', N.ROUT_CD)
                              AND N.UP_DN_DV_CD = DECODE ('A', 'A', N.UP_DN_DV_CD, 'A')
                              AND N.RUN_DT = AA.RUN_DT
                              AND N.TRN_NO = AA.TRN_NO
                              AND N.RUN_DT = M.RUN_DT
                              AND N.TRN_NO = M.TRN_NO
                              AND M.RUN_DT = AA.RUN_DT
                              AND M.TRN_NO = AA.TRN_NO
                              AND M.DPT_STN_CONS_ORDR = AA.DPT_STN_CONS_ORDR
                              AND M.ARV_STN_CONS_ORDR = AA.ARV_STN_CONS_ORDR
                              AND AA.RUN_DT = X.RUN_DT
                              AND AA.TRN_NO = X.TRN_NO)
                             AS REAL_SALE
                        , (SELECT    LPAD (ROUND (SUM (DECODE (E.SEG_GP_NO, 1, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM, 0)) / COUNT (DISTINCT Z.RUN_DT)), 5, '0')
                                  || LPAD (ROUND (SUM (DECODE (E.SEG_GP_NO, 2, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM, 0)) / COUNT (DISTINCT Z.RUN_DT)), 5, '0')
                             FROM TB_YYDS501 Z
                                 ,TB_YYDP503 N
                                 ,TB_YYDD505 M
                                 ,TB_YYDK302 C
                                 ,TB_YYDK302 D
                                 ,TB_YYDK308 E
                            WHERE N.RUN_DT BETWEEN TO_CHAR (TO_DATE (X.RUN_DT, 'YYYYMMDD') - 30, 'YYYYMMDD') AND TO_CHAR (TO_DATE (X.RUN_DT, 'YYYYMMDD') - 2, 'yyyymmdd')
                              AND N.DAY_DV_CD = TO_CHAR (TO_DATE (X.RUN_DT, 'YYYYMMDD'), 'D')
                              AND N.TRN_NO = X.TRN_NO
                              AND N.MRNT_CD = NVL ('', N.MRNT_CD)
                              AND N.MRNT_CD IN ('01', '03', '04')
                              AND N.ROUT_CD = NVL ('', N.ROUT_CD)
                              AND N.UP_DN_DV_CD = DECODE ('A', 'A', N.UP_DN_DV_CD, 'A')
                              AND N.TRN_NO = X.TRN_NO
                              AND Z.RUN_DT = N.RUN_DT
                              AND Z.TRN_NO = N.TRN_NO
                              AND Z.RUN_DT = M.RUN_DT
                              AND Z.TRN_NO = M.TRN_NO
                              AND Z.DPT_STN_CONS_ORDR = M.DPT_STN_CONS_ORDR
                              AND Z.ARV_STN_CONS_ORDR = M.ARV_STN_CONS_ORDR
                              AND Z.RUN_DT = C.RUN_DT
                              AND Z.TRN_NO = C.TRN_NO
                              AND Z.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                              AND Z.RUN_DT = D.RUN_DT
                              AND Z.TRN_NO = D.TRN_NO
                              AND Z.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                              AND Z.RUN_DT = E.RUN_DT
                              AND Z.TRN_NO = E.TRN_NO
                              AND C.TRVL_ZONE_NO = DECODE (N.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                              AND D.TRVL_ZONE_NO = DECODE (N.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                              AND E.SEG_GP_NO IN (1, 2)
                              AND EXISTS
                                      (SELECT 'X'
                                         FROM TB_YYDK003 A
                                        WHERE A.BIZ_DD_STG_CD IN ('1', '2', '3')
                                          AND A.RUN_DT = Z.RUN_DT))
                             AS GROUP_SALE
                        ,D.JOB_DTTM AS JOB_DTTM
                        ,D.JOB_CLS_DTTM AS JOB_CLS_DTTM
                    FROM TB_YYFD011 X, TB_YYFB009 D, TB_YYDP503 Z
                   WHERE Z.RUN_DT = '20140218'
                     AND Z.TRN_NO = DECODE (TRIM (''), NULL, Z.TRN_NO, LPAD (TRIM (''), 5, '0'))
                     AND Z.MRNT_CD = NVL ('', Z.MRNT_CD)
                     AND Z.MRNT_CD IN ('01', '03', '04')
                     AND Z.ROUT_CD = NVL ('', Z.ROUT_CD)
                     AND Z.UP_DN_DV_CD = DECODE ('A', 'A', Z.UP_DN_DV_CD, 'A')
                     AND Z.RUN_DT = X.RUN_DT
                     AND Z.TRN_NO = X.TRN_NO
                     AND X.YMGT_JOB_ID = D.YMGT_JOB_ID
                     AND (D.JOB_DTTM, X.RUN_DT, X.TRN_NO) IN (  SELECT MAX (S.JOB_DTTM), T.RUN_DT, T.TRN_NO
                                                                  FROM TB_YYFD011 T, TB_YYFB009 S, TB_YYDP503 Y
                                                                 WHERE Y.RUN_DT = '20140218'
                                                                   AND Y.TRN_NO = DECODE (TRIM (''), NULL, Y.TRN_NO, LPAD (TRIM (''), 5, '0'))
                                                                   AND Y.MRNT_CD = NVL ('', Y.MRNT_CD)
                                                                   AND Y.MRNT_CD IN ('01', '03', '04')
                                                                   AND Y.ROUT_CD = NVL ('', Y.ROUT_CD)
                                                                   AND Y.UP_DN_DV_CD = DECODE ('A', 'A', Y.UP_DN_DV_CD, 'A')
                                                                   AND Y.RUN_DT = T.RUN_DT
                                                                   AND Y.TRN_NO = T.TRN_NO
                                                                   AND T.NON_NML_TRN_FLG IN ('Y', 'N')
                                                                   AND S.YMGT_JOB_ID = T.YMGT_JOB_ID
                                                              GROUP BY T.RUN_DT, T.TRN_NO)) A1
                ,(  SELECT A.RUN_DT AS RUN_DT
                          ,A.TRN_NO AS TRN_NO
                          ,A.YMGT_JOB_ID AS YMGT_JOB_ID
                          ,SUM (A.USR_CTL_EXPN_DMD_NUM) AS FCST_DMD
                          ,SUM (DECODE (E.SEG_GP_NO, 1, A.USR_CTL_EXPN_DMD_NUM)) AS FSCT_DMD_GROUP1
                          ,SUM (DECODE (E.SEG_GP_NO, 2, A.USR_CTL_EXPN_DMD_NUM)) AS FSCT_DMD_GROUP2
                      FROM TB_YYFD410 A
                          ,TB_YYDK301 B
                          ,TB_YYDK302 C
                          ,TB_YYDK302 D
                          ,TB_YYDK308 E
                     WHERE A.RUN_DT = '20140218'
                       AND A.TRN_NO = DECODE (TRIM (''), NULL, A.TRN_NO, LPAD (TRIM (''), 5, '0'))
                       AND B.ROUT_CD = NVL ('', B.ROUT_CD)
                       AND B.UP_DN_DV_CD = DECODE ('A', 'A', B.UP_DN_DV_CD, 'A')
                       AND A.RUN_DT = B.RUN_DT
                       AND A.TRN_NO = B.TRN_NO
                       AND A.RUN_DT = C.RUN_DT
                       AND A.TRN_NO = C.TRN_NO
                       AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                       AND A.RUN_DT = D.RUN_DT
                       AND A.TRN_NO = D.TRN_NO
                       AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                       AND A.RUN_DT = E.RUN_DT
                       AND A.TRN_NO = E.TRN_NO
                       AND C.TRVL_ZONE_NO = DECODE (B.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                       AND D.TRVL_ZONE_NO = DECODE (B.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                  GROUP BY A.RUN_DT, A.TRN_NO, A.YMGT_JOB_ID) B1
                ,(SELECT A1.RUN_DT
                        ,A1.TRN_NO
                        ,CASE
                             WHEN TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 1, 4)) <> 0
                             THEN
                                   NVL (AVG_ABRD_RT1 * TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 5, 4)) / TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 1, 4)), 0)
                                 + NVL (AVG_ABRD_RT2 * TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 9, 4)) / TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 1, 4)), 0)
                             ELSE
                                 AVG_ABRD_RT1 + AVG_ABRD_RT2
                         END
                             AS AVG_ABRD_RT
                        ,CASE
                             WHEN A1.FCST_ABRD_PRNB <> 0 THEN NVL (A1.ABRD_RT1 * A1.ABRD_PSNO1 / A1.FCST_ABRD_PRNB, 0) + NVL (A1.ABRD_RT2 * A1.ABRD_PSNO2 / A1.FCST_ABRD_PRNB, 0)
                             ELSE ABRD_RT1 + ABRD_RT2
                         END
                             AS FCST_ABRD_RT
                    FROM (  SELECT A.RUN_DT AS RUN_DT
                                  ,A.TRN_NO AS TRN_NO
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.FCST_ABRD_RT)), 0) AS ABRD_RT1
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.FCST_ABRD_RT)), 0) AS ABRD_RT2
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.FCST_ABRD_PRNB)), 0) AS ABRD_PSNO1
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.FCST_ABRD_PRNB)), 0) AS ABRD_PSNO2
                                  ,SUM (A.FCST_ABRD_PRNB) AS FCST_ABRD_PRNB
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.AVG_ABRD_RT)), 0) AS AVG_ABRD_RT1
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.AVG_ABRD_RT)), 0) AS AVG_ABRD_RT2
                                  , (SELECT    LPAD (TO_CHAR (SUM (Z.SEAT_NUM)), 4, '0')
                                            || LPAD (TO_CHAR (SUM (DECODE (Z.PSRM_CL_CD, '1', Z.SEAT_NUM))), 4, '0')
                                            || LPAD (TO_CHAR (SUM (DECODE (Z.PSRM_CL_CD, '2', Z.SEAT_NUM))), 4, '0')
                                       FROM TB_YYDS511 Z
                                      WHERE Z.RUN_DT = A.RUN_DT
                                        AND Z.TRN_NO = A.TRN_NO)
                                       AS SEAT_ALL_CNT
                              FROM TB_YYPD003 A, TB_YYDP503 B
                             WHERE B.RUN_DT = '20140218'
                               AND B.TRN_NO = DECODE (TRIM (''), NULL, B.TRN_NO, LPAD (TRIM (''), 5, '0'))
                               AND B.MRNT_CD = NVL ('', B.MRNT_CD)
                               AND B.MRNT_CD IN ('01', '03', '04')
                               AND B.ROUT_CD = NVL ('', B.ROUT_CD)
                               AND B.UP_DN_DV_CD = DECODE ('A', 'A', B.UP_DN_DV_CD, 'A')
                               AND A.RUN_DT = B.RUN_DT
                               AND A.TRN_NO = B.TRN_NO
                               AND A.BKCL_CD = 'F1'
                          GROUP BY A.RUN_DT, A.TRN_NO) A1) C1
           WHERE A1.YMGT_JOB_ID = B1.YMGT_JOB_ID
             AND A1.RUN_DT = B1.RUN_DT
             AND A1.TRN_NO = B1.TRN_NO
             AND A1.RUN_DT = C1.RUN_DT
             AND A1.TRN_NO = C1.TRN_NO) V
   WHERE A.RUN_DT = V.RUN_DT
     AND A.TRN_NO = V.TRN_NO
     AND ROUND (ABS (V.AVG_ABRD_RT - V.FCST_ABRD_RT) * V.AVG_ABRD_RT * 100 * (ABS (60 - (TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (SUBSTR (V.YMGT_JOB_ID, 14, 8), 'YYYYMMDD'))) / 60), 0) >=
             NVL (TO_NUMBER ('0.0'), 0)
ORDER BY RUN_DT, TRN_NO, YMS_APL_FLG DESC




튜닝 내용
  alias GROUP_SALE 부분은  YSAA002_M01 (수익관리대상열차 일별분석) - 작업일자별 조회 프로그램 참조 
   
   추가 ( 아래 sql 문장은 scalar subquery 를 in-line view 로 수정한 sql임) 
   
   SELECT X.YMGT_JOB_ID AS YMGT_JOB_ID /* 수익관리작업ID       */
                        ,X.RUN_DT AS RUN_DT /* 운행일자             */
                        ,X.TRN_NO AS TRN_NO /* 열차번호             */
                        ,X.TRN_ANAL_DV_CD AS TRN_ANAL_DV_CD /* 열차분석구분코드 */
--                        , (SELECT SUM (AA.RSV_SEAT_NUM + AA.SALE_SEAT_NUM - AA.RET_SEAT_NUM - AA.CNC_SEAT_NUM) AS REAL_SALE
--                             FROM TB_YYDS501 AA, TB_YYDP503 N, TB_YYDD505 M
--                            WHERE N.RUN_DT = '20140218'
--                              AND N.TRN_NO = DECODE (TRIM (''), NULL, N.TRN_NO, LPAD (TRIM (''), 5, '0'))
--                              AND N.MRNT_CD = NVL ('', N.MRNT_CD)
--                              AND N.MRNT_CD IN ('01', '03', '04')
--                              AND N.ROUT_CD = NVL ('', N.ROUT_CD)
--                              AND N.UP_DN_DV_CD = DECODE ('A', 'A', N.UP_DN_DV_CD, 'A')
--                              AND N.RUN_DT = AA.RUN_DT
--                              AND N.TRN_NO = AA.TRN_NO
--                              AND N.RUN_DT = M.RUN_DT
--                              AND N.TRN_NO = M.TRN_NO
--                              AND M.RUN_DT = AA.RUN_DT
--                              AND M.TRN_NO = AA.TRN_NO
--                              AND M.DPT_STN_CONS_ORDR = AA.DPT_STN_CONS_ORDR
--                              AND M.ARV_STN_CONS_ORDR = AA.ARV_STN_CONS_ORDR
--                              AND AA.RUN_DT = X.RUN_DT
--                              AND AA.TRN_NO = X.TRN_NO)
--                             AS REAL_SALE
                        ,    TA.GROUP_SALE AS GROUP_SALE
                        ,D.JOB_DTTM AS JOB_DTTM
                        ,D.JOB_CLS_DTTM AS JOB_CLS_DTTM
                    FROM TB_YYFD011 X, TB_YYFB009 D, TB_YYDP503 Z
                    ,(SELECT /*+ ORDERED */    n.day_dv_cd, n.trn_no, 
                                LPAD (ROUND (SUM (DECODE (E.SEG_GP_NO, 1, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM, 0)) / COUNT (DISTINCT Z.RUN_DT)), 5, '0')
                                  || LPAD (ROUND (SUM (DECODE (E.SEG_GP_NO, 2, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM, 0)) / COUNT (DISTINCT Z.RUN_DT)), 5, '0') AS GROUP_SALE
                             FROM TB_YYDP503 N /* 열차특성상세TBL */
                                 ,TB_YYDK308 E /* 구역별구간그룹내역TBL */
                                 ,TB_YYDK302 C /* 열차운행내역TBL */
                                 ,TB_YYDK302 D /* 열차운행내역TBL */
                                 ,TB_YYDS501 Z /* 예약발매실적집계TBL */  
                                 ,TB_YYDD505 M /* 열차구간내역TBL */                                   
                            WHERE N.RUN_DT BETWEEN TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') - 30, 'YYYYMMDD') AND TO_CHAR (TO_DATE ('20140218', 'YYYYMMDD') - 2, 'yyyymmdd')
--                              AND N.DAY_DV_CD = TO_CHAR (TO_DATE (X.RUN_DT, 'YYYYMMDD'), 'D')
--                              AND N.TRN_NO = X.TRN_NO
                              AND N.MRNT_CD = NVL ('', N.MRNT_CD)
                              AND N.MRNT_CD IN ('01', '03', '04')
                              AND N.ROUT_CD = NVL ('', N.ROUT_CD)
                              AND N.UP_DN_DV_CD = DECODE ('A', 'A', N.UP_DN_DV_CD, 'A')
--                              AND N.TRN_NO = X.TRN_NO
                              AND Z.RUN_DT = d.RUN_DT
                              AND Z.TRN_NO = d.TRN_NO
                              AND Z.RUN_DT = M.RUN_DT
                              AND Z.TRN_NO = M.TRN_NO
                              AND Z.DPT_STN_CONS_ORDR = M.DPT_STN_CONS_ORDR
                              AND Z.ARV_STN_CONS_ORDR = M.ARV_STN_CONS_ORDR
                              AND n.RUN_DT = C.RUN_DT
                              AND n.TRN_NO = C.TRN_NO
                              AND Z.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                              AND n.RUN_DT = D.RUN_DT
                              AND n.TRN_NO = D.TRN_NO
                              AND Z.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                              AND n.RUN_DT = E.RUN_DT
                              AND n.TRN_NO = E.TRN_NO
                              AND C.TRVL_ZONE_NO = DECODE (N.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO)
                              AND D.TRVL_ZONE_NO = DECODE (N.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO)
                              AND E.SEG_GP_NO IN (1, 2)
                              AND EXISTS
                                      (SELECT /*+ NL_SJ */ 'X'
                                         FROM TB_YYDK003 A
                                        WHERE A.BIZ_DD_STG_CD IN ('1', '2', '3')
                                          AND A.RUN_DT = N.RUN_DT)
                              group by n.day_dv_cd, n.trn_no
                              ) ta
                   WHERE Z.RUN_DT = '20140218'
                     AND Z.TRN_NO = DECODE (TRIM (''), NULL, Z.TRN_NO, LPAD (TRIM (''), 5, '0'))
                     AND Z.MRNT_CD = NVL ('', Z.MRNT_CD)
                     AND Z.MRNT_CD IN ('01', '03', '04')
                     AND Z.ROUT_CD = NVL ('', Z.ROUT_CD)
                     AND Z.UP_DN_DV_CD = DECODE ('A', 'A', Z.UP_DN_DV_CD, 'A')
                     AND Z.RUN_DT = X.RUN_DT
                     AND Z.TRN_NO = X.TRN_NO
                     AND X.YMGT_JOB_ID = D.YMGT_JOB_ID
                     AND (D.JOB_DTTM, X.RUN_DT, X.TRN_NO) IN (  SELECT MAX (S.JOB_DTTM), T.RUN_DT, T.TRN_NO
                                                                  FROM TB_YYFD011 T, TB_YYFB009 S, TB_YYDP503 Y
                                                                 WHERE Y.RUN_DT = '20140218'
                                                                   AND Y.TRN_NO = DECODE (TRIM (''), NULL, Y.TRN_NO, LPAD (TRIM (''), 5, '0'))
                                                                   AND Y.MRNT_CD = NVL ('', Y.MRNT_CD)
                                                                   AND Y.MRNT_CD IN ('01', '03', '04')
                                                                   AND Y.ROUT_CD = NVL ('', Y.ROUT_CD)
                                                                   AND Y.UP_DN_DV_CD = DECODE ('A', 'A', Y.UP_DN_DV_CD, 'A')
                                                                   AND Y.RUN_DT = T.RUN_DT
                                                                   AND Y.TRN_NO = T.TRN_NO
                                                                   AND T.NON_NML_TRN_FLG IN ('Y', 'N')
                                                                   AND S.YMGT_JOB_ID = T.YMGT_JOB_ID
                                                              GROUP BY T.RUN_DT, T.TRN_NO)
--                              AND TA.RUN_DT BETWEEN TO_CHAR (TO_DATE (Z.RUN_DT, 'YYYYMMDD') - 30, 'YYYYMMDD') AND TO_CHAR (TO_DATE (Z.RUN_DT, 'YYYYMMDD') - 2, 'yyyymmdd')
                              AND TA.DAY_DV_CD = TO_CHAR (TO_DATE (Z.RUN_DT, 'YYYYMMDD'), 'D')
                              AND TA.TRN_NO = Z.TRN_NO  
