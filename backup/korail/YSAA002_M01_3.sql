  SELECT /*+ com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalJobDt */
        D.YMGT_JOB_ID AS YMGT_JOB_ID /* ���Ͱ����۾�ID         */
        ,A.RUN_DT AS RUN_DT /* ��������                 */
        ,A.TRN_NO AS TRN_NO_VAL /* ������ȣ����         */
        ,TO_NUMBER (A.TRN_NO) AS TRN_NO /* ������ȣ                 */
        ,A.STLB_TRN_CLSF_CD AS STLB_TRN_CLSF_CD /* ���������ڵ�         */
        ,A.RUN_DV_CD AS RUN_DV_CD /* ���౸���ڵ�             */
        ,A.YMS_APL_FLG AS YMS_APL_FLG /* YMS���뿩��         */
        ,D.TRN_ANAL_DV_CD AS TRN_ANAL_DV_CD /* �����м������ڵ�     */
        ,DECODE (D.FCST_DMD, NULL, '�̽���', TO_CHAR (D.FCST_DMD, '9,999')) AS FCST_DMD /* ��������             */
        ,DECODE (D.REAL_SALE, NULL, '����', TO_CHAR (D.REAL_SALE, '9,999')) AS REAL_SALE /* ����߸Ž���         */
        ,D.JOB_DTTM AS JOB_DTTM /* �۾������Ͻ�         */
        ,NVL (D.JOB_CLS_DTTM, '-') AS JOB_CLS_DTTM /* �۾������Ͻ�         */
        ,A.DPT_TM_VAL AS DPT_TM_VAL /* ��߽ð� ����         */
        ,D.SALE_GROUP1 AS SALE_GROUP1 /* 1���� 4�ֽ���         */
        ,D.SALE_GROUP2 AS SALE_GROUP2 /* 2���� 4�ֽ���         */
        ,D.FSCT_DMD_GROUP1 AS FSCT_DMD_GROUP1 /* 1���� ����             */
        ,D.FSCT_DMD_GROUP2 AS FSCT_DMD_GROUP2 /* 2���� ����             */
        ,TO_CHAR (D.AVG_ABRD_RT * 100, 'FM9999D0') AS AVG_ABRD_RT /* 4�ֽ���������         */
        ,TO_CHAR (ROUND (D.FCST_ABRD_RT * 100, 1), 'FM9999D0') AS FCST_ABRD_RT /* ����������             */
        ,TO_CHAR
         (
             ROUND (ABS (D.AVG_ABRD_RT - D.FCST_ABRD_RT) * D.AVG_ABRD_RT * 100 * (ABS (60 - (TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (SUBSTR (YMGT_JOB_ID, 14, 8), 'YYYYMMDD'))) / 60), 0)
            ,'FM9990D00'
         )
             AS RISK /* ��������             */
        ,A.RUN_INFO AS RUN_INFO /* ���౸��             */
        ,A.ORG_RS_STN_CD AS ORG_RS_STN_CD /* �ù߿��߿��ڵ�         */
        ,A.TMN_RS_STN_CD AS TMN_RS_STN_CD /* �������߿��ڵ�         */
        ,A.ORG_RS_STN_CD_NM AS ORG_RS_STN_CD_NM /* �ù߿��߿��ڵ��    */
        ,A.TMN_RS_STN_CD_NM AS TMN_RS_STN_CD_NM /* �������߿��ڵ��    */
        ,A.DPT_TM_PRAM AS DPT_TM_PRAM /* ��߽ð�(�Ķ����-�ú���) */
        ,A.ARV_TM_PRAM AS ARV_TM_PRAM /* �����ð�(�Ķ����-�ú���) */
    FROM (SELECT A.RUN_DT AS RUN_DT /* ��������                 */
                ,A.TRN_NO AS TRN_NO /* ������ȣ                 */
                ,A.ROUT_CD AS ROUT_CD /* �뼱�ڵ�                 */
                ,A.UP_DN_DV_CD AS UP_DN_DV_CD /* �����౸���ڵ�           */
                ,A.STLB_TRN_CLSF_CD AS STLB_TRN_CLSF_CD /* ���������ڵ�             */
                ,A.RUN_DV_CD AS RUN_DV_CD /* ���౸���ڵ�             */
                ,A.YMS_APL_FLG AS YMS_APL_FLG /* YMS���뿩��              */
                ,SUBSTR (B.DPT_TM, 1, 2) AS DPT_TM /* ��߽ð�              */
                ,B.DPT_TM AS DPT_TM_VAL /* ��߽ð�����         */
                ,   (SELECT TRIM (Y.KOR_STN_NM)
                       FROM TB_YYDK001 X, TB_YYDK102 Y
                      WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
                        AND X.STN_CD = Y.STN_CD
                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                 || '-'
                 || (SELECT TRIM (Y.KOR_STN_NM)
                       FROM TB_YYDK001 X, TB_YYDK102 Y
                      WHERE X.RS_STN_CD = A.TMN_RS_STN_CD
                        AND X.STN_CD = Y.STN_CD
                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                 || '('
                 || TO_CHAR (TO_DATE (B.DPT_TM, 'hh24miss'), 'hh24:mi')
                 || '-'
                 || TO_CHAR (TO_DATE (C.ARV_TM, 'hh24miss'), 'hh24:mi')
                 || ')'
                     AS RUN_INFO /* ���౸��             */
                ,A.ORG_RS_STN_CD AS ORG_RS_STN_CD /* �ù߿��߿��ڵ�         */
                ,A.TMN_RS_STN_CD AS TMN_RS_STN_CD /* �������߿��ڵ�         */
                , (SELECT TRIM (Y.KOR_STN_NM)
                     FROM TB_YYDK001 X, TB_YYDK102 Y
                    WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
                      AND X.STN_CD = Y.STN_CD
                      AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                     AS ORG_RS_STN_CD_NM /* �ù߿��߿��ڵ��    */
                , (SELECT TRIM (Y.KOR_STN_NM)
                     FROM TB_YYDK001 X, TB_YYDK102 Y
                    WHERE X.RS_STN_CD = A.TMN_RS_STN_CD
                      AND X.STN_CD = Y.STN_CD
                      AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                     AS TMN_RS_STN_CD_NM /* �������߿��ڵ��    */
                ,TO_CHAR (TO_DATE (B.DPT_TM, 'hh24miss'), 'hh24:mi:ss') AS DPT_TM_PRAM /* ��߽ð�(�Ķ����-�ú���) */
                ,TO_CHAR (TO_DATE (C.ARV_TM, 'hh24miss'), 'hh24:mi:ss') AS ARV_TM_PRAM /* �����ð�(�Ķ����-�ú���) */
            FROM TB_YYDK301 A /* �����⺻TBL         */
                ,TB_YYDK302 B /* �������೻��TBL     */
                ,TB_YYDK302 C /* �������೻��TBL     */
                ,TB_YYDK201 D /* �뼱�ڵ�TBL         */
                ,TB_YYBB004 E /* �������Ҵ�⺻TBL     */
           WHERE A.RUN_DT BETWEEN '20140218' AND '20140331'
             AND D.MRNT_CD = NVL ('', D.MRNT_CD)
             AND D.MRNT_CD IN ('01', '03', '04')
             AND ( (D.EFC_ST_DT <= '20140218'
                AND D.EFC_CLS_DT >= '20140331')
               OR (D.EFC_ST_DT >= '20140218'
               AND D.EFC_CLS_DT <= '20140331'))
             AND A.ROUT_CD = NVL ('', A.ROUT_CD)
             AND A.STLB_TRN_CLSF_CD = NVL ('00', A.STLB_TRN_CLSF_CD)
             AND A.UP_DN_DV_CD = DECODE ('A', 'A', A.UP_DN_DV_CD, 'A')
             AND A.RUN_DT = B.RUN_DT(+)
             AND A.TRN_NO = B.TRN_NO(+)
             AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD(+) /* �ù߿��߿��ڵ� = �������߿��ڵ� */
             AND A.RUN_DT = C.RUN_DT(+)
             AND A.TRN_NO = C.TRN_NO(+)
             AND A.TMN_RS_STN_CD = C.STOP_RS_STN_CD(+) /* �������߿��ڵ� = �������߿��ڵ� */
             AND A.ROUT_CD = D.ROUT_CD(+)
             AND A.RUN_DT = E.RUN_DT(+)
             AND A.TRN_NO = E.TRN_NO(+)
             AND ( (DECODE (PSRM_CL_CD || BKCL_CD,  '1F1', 1,  '1C1', 2,  '1R1', 3,  '1R2', 4,  '1R3', 5,  '2F1', 6,  '2C1', 7,  '2R1', 8,  '2R2', 9,  '2R3', 10,  0) =
                        (SELECT MIN (DECODE (X.PSRM_CL_CD || X.BKCL_CD,  '1F1', 1,  '1C1', 2,  '1R1', 3,  '1R2', 4,  '1R3', 5,  '2F1', 6,  '2C1', 7,  '2R1', 8,  '2R2', 9,  '2R3', 10,  0))
                           FROM TB_YYBB004 X, TB_YYDK309 Y /* ��ŷŬ�������볻��TBL */
                          WHERE X.RUN_DT = E.RUN_DT
                            AND X.TRN_NO = E.TRN_NO
                            AND X.RUN_DT = Y.RUN_DT
                            AND X.TRN_NO = Y.TRN_NO
                            AND X.PSRM_CL_CD = Y.PSRM_CL_CD
                            AND X.BKCL_CD = Y.BKCL_CD
                            AND Y.BKCL_USE_FLG = 'Y')
                AND PSRM_CL_CD IS NOT NULL)
               OR PSRM_CL_CD IS NULL)) A
        ,(SELECT A1.YMGT_JOB_ID AS YMGT_JOB_ID /* ���Ͱ����۾�ID        */
                ,A1.RUN_DT AS RUN_DT /* ��������                 */
                ,A1.TRN_NO AS TRN_NO /* ������ȣ                 */
                ,A1.TRN_ANAL_DV_CD AS TRN_ANAL_DV_CD /* �����м������ڵ�     */
                ,A1.JOB_DTTM AS JOB_DTTM /* �۾��Ͻ�             */
                ,A1.JOB_CLS_DTTM AS JOB_CLS_DTTM /* �۾������Ͻ�         */
                ,B1.FCST_DMD AS FCST_DMD /* ��������             */
                ,A1.REAL_SALE AS REAL_SALE /* ����߸Ž���         */
                ,TO_NUMBER (NVL (LTRIM (SUBSTR (A1.GROUP_SALE, 1, 5), '0'), '0')) AS SALE_GROUP1 /* 1���� 4�ֽ���         */
                ,TO_NUMBER (NVL (LTRIM (SUBSTR (A1.GROUP_SALE, 6, 5), '0'), '0')) AS SALE_GROUP2 /* 2���� 4�ֽ���         */
                ,B1.FSCT_DMD_GROUP1 AS FSCT_DMD_GROUP1 /* 1���� ����             */
                ,B1.FSCT_DMD_GROUP2 AS FSCT_DMD_GROUP2 /* 2���� ����             */
                ,C1.AVG_ABRD_RT AS AVG_ABRD_RT /* 4�ֽ���������         */
                ,C1.FCST_ABRD_RT AS FCST_ABRD_RT /* ����������             */
            FROM (SELECT A.YMGT_JOB_ID AS YMGT_JOB_ID /* ���Ͱ����۾�ID       */
                        ,A.RUN_DT AS RUN_DT /* ��������             */
                        ,A.TRN_NO AS TRN_NO /* ������ȣ             */
                        ,A.TRN_ANAL_DV_CD AS TRN_ANAL_DV_CD /* �����м������ڵ� */
                        , (SELECT SUM (AA.RSV_SEAT_NUM + AA.SALE_SEAT_NUM - AA.RET_SEAT_NUM - AA.CNC_SEAT_NUM)
                             FROM TB_YYDS501 AA, TB_YYDP503 N, TB_YYDD505 M /* ������������TBL */
                            WHERE N.RUN_DT BETWEEN '20140218' AND '20140331'
                              AND N.MRNT_CD = NVL ('', N.MRNT_CD)
                              AND N.MRNT_CD IN ('01', '03', '04')
                              AND N.ROUT_CD = NVL ('', N.ROUT_CD)
                              AND N.UP_DN_DV_CD = DECODE ('A', 'A', N.UP_DN_DV_CD, 'A')
                              AND AA.RUN_DT = N.RUN_DT
                              AND AA.TRN_NO = N.TRN_NO
                              AND N.RUN_DT = M.RUN_DT
                              AND N.TRN_NO = M.TRN_NO
                              AND AA.RUN_DT = M.RUN_DT
                              AND AA.TRN_NO = M.TRN_NO
                              AND AA.DPT_STN_CONS_ORDR = M.DPT_STN_CONS_ORDR
                              AND AA.ARV_STN_CONS_ORDR = M.ARV_STN_CONS_ORDR
                              AND AA.RUN_DT = A.RUN_DT
                              AND AA.TRN_NO = A.TRN_NO)
                             AS REAL_SALE
                        , (SELECT    LPAD (TO_CHAR (ROUND (SUM (DECODE (E.SEG_GP_NO, 1, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM)) / COUNT (DISTINCT Z.RUN_DT), 0)), 5, '0')
                                  || LPAD (TO_CHAR (ROUND (SUM (DECODE (E.SEG_GP_NO, 2, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM)) / COUNT (DISTINCT Z.RUN_DT), 0)), 5, '0')
                             FROM TB_YYDS501 Z /* ����߸Ž�������TBL */
                                 ,TB_YYDP503 N /* ����Ư����TBL */
                                 ,TB_YYDD505 M /* ������������TBL */
                                 ,TB_YYDK302 C /* �������೻��TBL */
                                 ,TB_YYDK302 D /* �������೻��TBL */
                                 ,TB_YYDK308 E /* �����������׷쳻��TBL */
                            WHERE N.RUN_DT BETWEEN TO_CHAR (TO_DATE (A.RUN_DT, 'YYYYMMDD') - 30, 'YYYYMMDD') AND TO_CHAR (TO_DATE (A.RUN_DT, 'YYYYMMDD') - 2, 'YYYYMMDD')
                              AND N.DAY_DV_CD = TO_CHAR (TO_DATE (A.RUN_DT, 'YYYYMMDD'), 'D')
                              AND N.TRN_NO = A.TRN_NO
                              AND N.MRNT_CD = NVL ('', N.MRNT_CD)
                              AND N.MRNT_CD IN ('01', '03', '04')
                              AND N.ROUT_CD = NVL ('', N.ROUT_CD)
                              AND N.UP_DN_DV_CD = DECODE ('A', 'A', N.UP_DN_DV_CD, 'A')
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
                              AND C.TRVL_ZONE_NO = DECODE (N.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO) /* ����������ȣ */
                              AND D.TRVL_ZONE_NO = DECODE (N.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO) /* ����������ȣ */
                              AND E.SEG_GP_NO IN (1, 2)
                              AND EXISTS
                                      (SELECT 'X'
                                         FROM TB_YYDK003 A /* ī���ٳ���TBL */
                                        WHERE A.BIZ_DD_STG_CD IN ('1', '2', '3')
                                          AND A.RUN_DT = Z.RUN_DT))
                             AS GROUP_SALE
                        ,D.JOB_DTTM AS JOB_DTTM
                        ,D.JOB_CLS_DTTM AS JOB_CLS_DTTM
                    FROM TB_YYFD011 A, TB_YYFB009 D, TB_YYDP503 Z /* ����Ư����TBL */
                   WHERE Z.RUN_DT BETWEEN '20140218' AND '20140331'
                     AND Z.MRNT_CD = NVL ('', Z.MRNT_CD)
                     AND Z.MRNT_CD IN ('01', '03', '04')
                     AND Z.ROUT_CD = NVL ('', Z.ROUT_CD)
                     AND Z.UP_DN_DV_CD = DECODE ('A', 'A', Z.UP_DN_DV_CD, 'A')
                     AND A.REG_DTTM LIKE '20140218' || '%'
                     AND Z.RUN_DT = A.RUN_DT
                     AND Z.TRN_NO = A.TRN_NO
                     AND A.YMGT_JOB_ID = D.YMGT_JOB_ID
                     AND (D.JOB_DTTM, A.RUN_DT, A.TRN_NO) IN (  SELECT MAX (S.JOB_DTTM), T.RUN_DT, T.TRN_NO
                                                                  FROM TB_YYFD011 T, TB_YYFB009 S, TB_YYDP503 Y /* ����Ư����TBL */
                                                                 WHERE Y.RUN_DT BETWEEN '20140218' AND '20140331'
                                                                   AND Y.MRNT_CD = NVL ('', Y.MRNT_CD)
                                                                   AND Y.MRNT_CD IN ('01', '03', '04')
                                                                   AND Y.ROUT_CD = NVL ('', Y.ROUT_CD)
                                                                   AND Y.UP_DN_DV_CD = DECODE ('A', 'A', Y.UP_DN_DV_CD, 'A')
                                                                   AND S.REG_DTTM LIKE '20140218' || '%'
                                                                   AND S.YMGT_JOB_ID = T.YMGT_JOB_ID
                                                                   AND Y.RUN_DT = T.RUN_DT
                                                                   AND Y.TRN_NO = T.TRN_NO
                                                                   AND (T.NON_NML_TRN_FLG = 'Y'
                                                                     OR T.NON_NML_TRN_FLG = 'N')
                                                              GROUP BY T.RUN_DT, T.TRN_NO)) A1
                ,(  SELECT A.RUN_DT AS RUN_DT
                          ,A.TRN_NO AS TRN_NO
                          ,A.YMGT_JOB_ID AS YMGT_JOB_ID /* ���Ͱ����۾�ID */
                          ,SUM (A.USR_CTL_EXPN_DMD_NUM) AS FCST_DMD
                          ,SUM (DECODE (E.SEG_GP_NO, 1, A.USR_CTL_EXPN_DMD_NUM)) AS FSCT_DMD_GROUP1
                          ,SUM (DECODE (E.SEG_GP_NO, 2, A.USR_CTL_EXPN_DMD_NUM)) AS FSCT_DMD_GROUP2
                      FROM TB_YYFD410 A /* ����ž�¿������䳻��TBL */
                          ,TB_YYDK301 B /* �����⺻TBL */
                          ,TB_YYDK302 C /* �������೻��TBL */
                          ,TB_YYDK302 D /* �������೻��TBL */
                          ,TB_YYDK308 E /* �����������׷쳻��TBL */
                     WHERE A.RUN_DT BETWEEN '20140218' AND '20140331'
                       AND A.REG_DTTM LIKE '20140218' || '%'
                       AND SUBSTR (A.YMGT_JOB_ID, 14, 8) = '20140218'
                       AND A.RUN_DT = B.RUN_DT
                       AND A.TRN_NO = B.TRN_NO
                       AND A.RUN_DT = C.RUN_DT
                       AND A.TRN_NO = C.TRN_NO
                       AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR /* ��߿��������� = ����������*/
                       AND A.RUN_DT = D.RUN_DT
                       AND A.TRN_NO = D.TRN_NO
                       AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR /* �������������� = ����������*/
                       AND A.RUN_DT = E.RUN_DT
                       AND A.TRN_NO = E.TRN_NO
                       AND C.TRVL_ZONE_NO = DECODE (B.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO) /* ����������ȣ */
                       AND D.TRVL_ZONE_NO = DECODE (B.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO) /* ����������ȣ */
                  GROUP BY A.RUN_DT, A.TRN_NO, A.YMGT_JOB_ID) B1 /* ���Ͱ����۾�ID */
                ,(SELECT A1.RUN_DT
                        ,A1.TRN_NO
                        ,CASE
                             WHEN TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 1, 4)) <> 0
                             THEN
                                   NVL (AVG_ABRD_RT1 * (TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 5, 4)) / TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 1, 4))), 0)
                                 + NVL (AVG_ABRD_RT2 * (TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 9, 4)) / TO_NUMBER (SUBSTR (A1.SEAT_ALL_CNT, 1, 4))), 0)
                             ELSE
                                 AVG_ABRD_RT1 + AVG_ABRD_RT2
                         END
                             AS AVG_ABRD_RT
                        ,CASE
                             WHEN A1.FCST_ABRD_PRNB <> 0 THEN A1.ABRD_RT1 * (A1.ABRD_PRNB1 / A1.FCST_ABRD_PRNB) + A1.ABRD_RT2 * (A1.ABRD_PRNB2 / A1.FCST_ABRD_PRNB)
                             ELSE ABRD_RT1 + ABRD_RT2
                         END
                             AS FCST_ABRD_RT
                    FROM (  SELECT A.RUN_DT AS RUN_DT
                                  ,A.TRN_NO AS TRN_NO
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.FCST_ABRD_RT)), 0) AS ABRD_RT1 /* ���������� */
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.FCST_ABRD_RT)), 0) AS ABRD_RT2 /* ���������� */
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.FCST_ABRD_PRNB)), 0) AS ABRD_PRNB1 /* ���������ο��� */
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.FCST_ABRD_PRNB)), 0) AS ABRD_PRNB2 /* ���������ο��� */
                                  ,SUM (A.FCST_ABRD_PRNB) AS FCST_ABRD_PRNB /* ���������ο��� */
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.AVG_ABRD_RT)), 0) AS AVG_ABRD_RT1 /* ��ս����� */
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.AVG_ABRD_RT)), 0) AS AVG_ABRD_RT2 /* ��ս����� */
                                  , (SELECT    LPAD (TO_CHAR (SUM (Z.SEAT_NUM)), 4, '0')
                                            || LPAD (TO_CHAR (SUM (DECODE (Z.PSRM_CL_CD, '1', Z.SEAT_NUM))), 4, '0')
                                            || LPAD (TO_CHAR (SUM (DECODE (Z.PSRM_CL_CD, '2', Z.SEAT_NUM))), 4, '0')
                                       FROM TB_YYDS511 Z /* ����������������TBL */
                                      WHERE Z.RUN_DT = A.RUN_DT
                                        AND Z.TRN_NO = A.TRN_NO)
                                       AS SEAT_ALL_CNT /* ��ü �¼��� */
                              FROM TB_YYPD003 A, TB_YYDP503 B /* ����Ư����TBL */
                             WHERE B.RUN_DT BETWEEN '20140218' AND '20140331'
                               AND B.MRNT_CD = NVL ('', B.MRNT_CD)
                               AND B.MRNT_CD IN ('01', '03', '04')
                               AND B.ROUT_CD = NVL ('', B.ROUT_CD)
                               AND B.UP_DN_DV_CD = DECODE ('A', 'A', B.UP_DN_DV_CD, 'A') /* �������౸���ڵ� */
                               AND A.RUN_DT = B.RUN_DT
                               AND A.TRN_NO = B.TRN_NO
                               AND A.BKCL_CD = 'F1' /* ��ŷŬ�����ڵ� */
                          GROUP BY A.RUN_DT, A.TRN_NO) A1) C1
           WHERE A1.YMGT_JOB_ID = B1.YMGT_JOB_ID /* ���Ͱ����۾�ID */
             AND A1.RUN_DT = B1.RUN_DT
             AND A1.TRN_NO = B1.TRN_NO
             AND A1.RUN_DT = C1.RUN_DT
             AND A1.TRN_NO = C1.TRN_NO) D
   WHERE A.RUN_DT = D.RUN_DT
     AND A.TRN_NO = D.TRN_NO
     AND ROUND (ABS (D.AVG_ABRD_RT - D.FCST_ABRD_RT) * D.AVG_ABRD_RT * 100 * (ABS (60 - (TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (SUBSTR (YMGT_JOB_ID, 14, 8), 'YYYYMMDD'))) / 60), 0) >=
             NVL (TO_NUMBER ('0.0'), 0)
ORDER BY RUN_DT, TRN_NO, YMS_APL_FLG DESC





YZDBA                          TB_YYDP503                     IX_YYDP503_01                      330544 => TRN_NO,DAY_DV_CD,BIZ_DD_STG_CD,RUN_DT
YZDBA                          TB_YYDP503                     PK_YYDP503                         330544 => RUN_DT,TRN_NO


YZDBA                          TB_YYFD011                     IX_YYFD011_01                      560992 => RUN_DT,TRN_NO,YMGT_JOB_ID
YZDBA                          TB_YYFD011                     IX_YYFD011_02                      560992 => YMGT_JOB_ID,FCST_YMGT_JOB_ID,RUN_DT,TRN_NO
YZDBA                          TB_YYFD011                     PK_YYFD011                         560992 => YMGT_JOB_ID,RUN_DT,TRN_NO

YZDBA                          TB_YYFD410                     PK_YYFD410                       57709479 => RUN_DT,TRN_NO,PSRM_CL_CD,BKCL_CD,DPT_STN_CONS_ORDR,ARV_STN_CONS_ORDR,FCST_ACHV_DT,YMGT_JOB_ID


Ʃ�� ����


 
�ε��� ���� 
   TB_YYFD011 (  REG_DTTM  �Ǵ� REG_DTTM + RUN_DT, ���� ��õ
   TB_YYFD410 ( REG_DTTM ) �Ǵ� REG_DTTM + RUN_DT , ���� ��õ 
   
   alias GROUP_SALE ���� ���� ���� �κ� 
       1. AND n.BIZ_DD_STG_CD IN ('1', '2', '3') ���� �߰� ���� (IX_YYDP503_01 �ε����� ���ԵǾ� �ֱ� ������)
       2. on line ���α׷����� �ϱ� ���ؼ��� ��� ���̺� ���� ���� (TB_YYDS501 Z /* ����߸Ž�������TBL */ ) 
       3. �Ʒ��� alias GROUP_SALE ���� ( �� ���̺�������)
       
       ���� sql (�ҹ��� Ȯ�� ) --  ALIAS M �� ���� �ص� �Ǵ� ������ Ȯ�� �ʿ�
                     (SELECT   /*+ ordered  */
                                    LPAD (TO_CHAR (ROUND (SUM (DECODE (E.SEG_GP_NO, 1, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM)) / COUNT (DISTINCT Z.RUN_DT), 0)), 5, '0')
                                  || LPAD (TO_CHAR (ROUND (SUM (DECODE (E.SEG_GP_NO, 2, Z.RSV_SEAT_NUM + Z.SALE_SEAT_NUM - Z.RET_SEAT_NUM - Z.CNC_SEAT_NUM)) / COUNT (DISTINCT Z.RUN_DT), 0)), 5, '0')
                             from tb_yydp503 n /* ����Ư����tbl */
                                 ,tb_yydk308 e /* �����������׷쳻��tbl */
                                 ,tb_yydk302 c /* �������೻��tbl */
                                 ,tb_yydk302 d /* �������೻��tbl */
                                 ,tb_yyds501 z /* ����߸Ž�������tbl */  
                                 ,tb_yydd505 m /* ������������tbl */  
                            WHERE N.RUN_DT BETWEEN TO_CHAR (TO_DATE (A.RUN_DT, 'YYYYMMDD') - 30, 'YYYYMMDD') AND TO_CHAR (TO_DATE (A.RUN_DT, 'YYYYMMDD') - 2, 'YYYYMMDD')
                              AND N.DAY_DV_CD = TO_CHAR (TO_DATE (A.RUN_DT, 'YYYYMMDD'), 'D')
                              AND N.TRN_NO = A.TRN_NO
                              AND N.MRNT_CD = NVL ('', N.MRNT_CD)
                              AND N.MRNT_CD IN ('01', '03', '04')
                              AND N.ROUT_CD = NVL ('', N.ROUT_CD)
                              AND N.UP_DN_DV_CD = DECODE ('A', 'A', N.UP_DN_DV_CD, 'A')
                              AND Z.RUN_DT = d.RUN_DT               --
                              AND Z.TRN_NO = d.TRN_NO               -- 
                              AND Z.RUN_DT = M.RUN_DT
                              AND Z.TRN_NO = M.TRN_NO
                              AND Z.DPT_STN_CONS_ORDR = M.DPT_STN_CONS_ORDR
                              AND Z.ARV_STN_CONS_ORDR = M.ARV_STN_CONS_ORDR
                              AND n.RUN_DT = C.RUN_DT               --
                              AND n.TRN_NO = C.TRN_NO               --
                              AND Z.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                              AND n.RUN_DT = D.RUN_DT               -- 
                              AND n.TRN_NO = D.TRN_NO               --
                              AND Z.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                              AND n.RUN_DT = E.RUN_DT               -- 
                              AND n.TRN_NO = E.TRN_NO               --
                              AND C.TRVL_ZONE_NO = DECODE (N.UP_DN_DV_CD, 'D', E.DPT_ZONE_NO, E.ARV_ZONE_NO) /* ����������ȣ */
                              AND D.TRVL_ZONE_NO = DECODE (N.UP_DN_DV_CD, 'D', E.ARV_ZONE_NO, E.DPT_ZONE_NO) /* ����������ȣ */
                              AND E.SEG_GP_NO IN (1, 2)
                              AND EXISTS
                                      (SELECT /*+ nl_sj */  'X'
                                         FROM TB_YYDK003 A /* ī���ٳ���TBL */
                                        WHERE A.BIZ_DD_STG_CD IN ('1', '2', '3')
                                          AND A.RUN_DT = n.RUN_DT))  
       
-----------------------------------------------------------------------------------------------------------
| Id  | Operation                                 | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                          |               |     1 |   366 |  1333   (1)| 00:00:16 |
|   1 |  SORT AGGREGATE                           |               |     1 |    79 |            |          |
|*  2 |   FILTER                                  |               |       |       |            |          |
|   3 |    NESTED LOOPS                           |               |     1 |    79 |     3   (0)| 00:00:01 |
|   4 |     NESTED LOOPS                          |               |     1 |    58 |     2   (0)| 00:00:01 |
|*  5 |      TABLE ACCESS BY INDEX ROWID          | TB_YYDP503    |     1 |    25 |     1   (0)| 00:00:01 |
|*  6 |       INDEX UNIQUE SCAN                   | PK_YYDP503    |     1 |       |     1   (0)| 00:00:01 |
|   7 |      TABLE ACCESS BY INDEX ROWID          | TB_YYDS501    |     1 |    33 |     1   (0)| 00:00:01 |
|*  8 |       INDEX RANGE SCAN                    | PK_YYDS501    |     1 |       |     1   (0)| 00:00:01 |
|*  9 |     INDEX UNIQUE SCAN                     | PK_YYDD505    |     1 |    21 |     1   (0)| 00:00:01 |
|  10 |  SORT GROUP BY                            |               |     1 |   160 |            |          |
|  11 |   NESTED LOOPS SEMI                       |               |     1 |   160 |     7   (0)| 00:00:01 |
|  12 |    NESTED LOOPS                           |               |     1 |   149 |     6   (0)| 00:00:01 |
|  13 |     NESTED LOOPS                          |               |     1 |   125 |     5   (0)| 00:00:01 |
|  14 |      NESTED LOOPS                         |               |     1 |   103 |     4   (0)| 00:00:01 |
|  15 |       NESTED LOOPS                        |               |     1 |    81 |     3   (0)| 00:00:01 |
|  16 |        NESTED LOOPS                       |               |     1 |    60 |     2   (0)| 00:00:01 |
|* 17 |         TABLE ACCESS BY INDEX ROWID       | TB_YYDP503    |     1 |    27 |     1   (0)| 00:00:01 |
|* 18 |          INDEX RANGE SCAN                 | IX_YYDP503_01 |     1 |       |     1   (0)| 00:00:01 |
|  19 |         TABLE ACCESS BY INDEX ROWID       | TB_YYDS501    |     1 |    33 |     1   (0)| 00:00:01 |
|* 20 |          INDEX RANGE SCAN                 | PK_YYDS501    |     1 |       |     1   (0)| 00:00:01 |
|* 21 |        INDEX UNIQUE SCAN                  | PK_YYDD505    |     1 |    21 |     1   (0)| 00:00:01 |
|  22 |       TABLE ACCESS BY INDEX ROWID         | TB_YYDK302    |     1 |    22 |     1   (0)| 00:00:01 |
|* 23 |        INDEX UNIQUE SCAN                  | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|  24 |      TABLE ACCESS BY INDEX ROWID          | TB_YYDK302    |     1 |    22 |     1   (0)| 00:00:01 |
|* 25 |       INDEX UNIQUE SCAN                   | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|* 26 |     TABLE ACCESS BY INDEX ROWID           | TB_YYDK308    |     1 |    24 |     1   (0)| 00:00:01 |
|* 27 |      INDEX RANGE SCAN                     | PK_YYDK308    |     1 |       |     1   (0)| 00:00:01 |
|* 28 |    TABLE ACCESS BY INDEX ROWID            | TB_YYDK003    |     1 |    11 |     1   (0)| 00:00:01 |
|* 29 |     INDEX RANGE SCAN                      | PK_YYDK003    |     1 |       |     1   (0)| 00:00:01 |
|  30 |  SORT AGGREGATE                           |               |     1 |    21 |            |          |
|  31 |   TABLE ACCESS BY INDEX ROWID             | TB_YYDS511    |     1 |    21 |     1   (0)| 00:00:01 |
|* 32 |    INDEX RANGE SCAN                       | PK_YYDS511    |     1 |       |     1   (0)| 00:00:01 |
|  33 |  NESTED LOOPS                             |               |     1 |    48 |     2   (0)| 00:00:01 |
|  34 |   TABLE ACCESS BY INDEX ROWID             | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|* 35 |    INDEX UNIQUE SCAN                      | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|* 36 |   TABLE ACCESS BY INDEX ROWID             | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|* 37 |    INDEX RANGE SCAN                       | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
|  38 |    NESTED LOOPS                           |               |     1 |    48 |     2   (0)| 00:00:01 |
|  39 |     TABLE ACCESS BY INDEX ROWID           | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|* 40 |      INDEX UNIQUE SCAN                    | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|* 41 |     TABLE ACCESS BY INDEX ROWID           | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|* 42 |      INDEX RANGE SCAN                     | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
|  43 |  NESTED LOOPS                             |               |     1 |    48 |     2   (0)| 00:00:01 |
|  44 |   TABLE ACCESS BY INDEX ROWID             | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|* 45 |    INDEX UNIQUE SCAN                      | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|* 46 |   TABLE ACCESS BY INDEX ROWID             | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|* 47 |    INDEX RANGE SCAN                       | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
|  48 |  NESTED LOOPS                             |               |     1 |    48 |     2   (0)| 00:00:01 |
|  49 |   TABLE ACCESS BY INDEX ROWID             | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|* 50 |    INDEX UNIQUE SCAN                      | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|* 51 |   TABLE ACCESS BY INDEX ROWID             | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|* 52 |    INDEX RANGE SCAN                       | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
|  53 |  SORT ORDER BY                            |               |     1 |   366 |  1333   (1)| 00:00:16 |
|* 54 |   FILTER                                  |               |       |       |            |          |
|  55 |    NESTED LOOPS                           |               |     1 |   366 |  1332   (1)| 00:00:16 |
|  56 |     NESTED LOOPS OUTER                    |               |     1 |   327 |  1319   (1)| 00:00:16 |
|  57 |      NESTED LOOPS OUTER                   |               |     1 |   300 |  1318   (1)| 00:00:16 |
|  58 |       NESTED LOOPS OUTER                  |               |     1 |   273 |  1317   (1)| 00:00:16 |
|  59 |        NESTED LOOPS SEMI                  |               |     1 |   253 |  1316   (1)| 00:00:16 |
|  60 |         NESTED LOOPS                      |               |    16 |  3728 |  1268   (1)| 00:00:16 |
|  61 |          NESTED LOOPS                     |               |    16 |  2848 |  1263   (1)| 00:00:16 |
|  62 |           NESTED LOOPS                    |               |    16 |  2448 |  1254   (1)| 00:00:16 |
|  63 |            NESTED LOOPS                   |               |    82 | 10086 |  1090   (1)| 00:00:14 |
|* 64 |             HASH JOIN                     |               |   235 | 15275 |   384   (1)| 00:00:05 |
|* 65 |              TABLE ACCESS FULL            | TB_YYDK201    |   237 |  6162 |    36   (0)| 00:00:01 |
|* 66 |              TABLE ACCESS BY INDEX ROWID  | TB_YYDK301    |  6262 |   238K|   347   (0)| 00:00:05 |
|* 67 |               INDEX RANGE SCAN            | PK_YYDK301    | 10839 |       |    12   (0)| 00:00:01 |
|* 68 |             TABLE ACCESS BY INDEX ROWID   | TB_YYFD011    |     1 |    58 |     3   (0)| 00:00:01 |
|* 69 |              INDEX RANGE SCAN             | IX_YYFD011_01 |     8 |       |     1   (0)| 00:00:01 |
|* 70 |            VIEW PUSHED PREDICATE          |               |     1 |    30 |     2   (0)| 00:00:01 |
|  71 |             SORT GROUP BY                 |               |     1 |    55 |     2   (0)| 00:00:01 |
|* 72 |              FILTER                       |               |       |       |            |          |
|  73 |               NESTED LOOPS                |               |     1 |    55 |     2   (0)| 00:00:01 |
|* 74 |                TABLE ACCESS BY INDEX ROWID| TB_YYDP503    |     1 |    25 |     1   (0)| 00:00:01 |
|* 75 |                 INDEX UNIQUE SCAN         | PK_YYDP503    |     1 |       |     1   (0)| 00:00:01 |
|  76 |                TABLE ACCESS BY INDEX ROWID| TB_YYPD003    |     1 |    30 |     1   (0)| 00:00:01 |
|* 77 |                 INDEX RANGE SCAN          | PK_YYPD003    |     1 |       |     1   (0)| 00:00:01 |
|* 78 |           TABLE ACCESS BY INDEX ROWID     | TB_YYDP503    |     1 |    25 |     1   (0)| 00:00:01 |
|* 79 |            INDEX UNIQUE SCAN              | PK_YYDP503    |     1 |       |     1   (0)| 00:00:01 |
|  80 |          TABLE ACCESS BY INDEX ROWID      | TB_YYFB009    |     1 |    55 |     1   (0)| 00:00:01 |
|* 81 |           INDEX UNIQUE SCAN               | PK_YYFB009    |     1 |       |     1   (0)| 00:00:01 |
|* 82 |         VIEW PUSHED PREDICATE             | VW_NSO_1      |     1 |    20 |     3   (0)| 00:00:01 |
|  83 |          SORT GROUP BY                    |               |     1 |   122 |     3   (0)| 00:00:01 |
|* 84 |           FILTER                          |               |       |       |            |          |
|  85 |            NESTED LOOPS                   |               |       |       |            |          |
|  86 |             NESTED LOOPS                  |               |     1 |   122 |     3   (0)| 00:00:01 |
|  87 |              NESTED LOOPS                 |               |     1 |    67 |     2   (0)| 00:00:01 |
|* 88 |               TABLE ACCESS BY INDEX ROWID | TB_YYDP503    |     1 |    25 |     1   (0)| 00:00:01 |
|* 89 |                INDEX UNIQUE SCAN          | PK_YYDP503    |     1 |       |     1   (0)| 00:00:01 |
|* 90 |               TABLE ACCESS BY INDEX ROWID | TB_YYFD011    |     1 |    42 |     1   (0)| 00:00:01 |
|* 91 |                INDEX RANGE SCAN           | IX_YYFD011_01 |     1 |       |     1   (0)| 00:00:01 |
|* 92 |              INDEX UNIQUE SCAN            | PK_YYFB009    |     1 |       |     1   (0)| 00:00:01 |
|* 93 |             TABLE ACCESS BY INDEX ROWID   | TB_YYFB009    |     1 |    55 |     1   (0)| 00:00:01 |
|* 94 |        INDEX RANGE SCAN                   | PK_YYBB004    |     1 |    20 |     1   (0)| 00:00:01 |
|* 95 |       TABLE ACCESS BY INDEX ROWID         | TB_YYDK302    |     1 |    27 |     1   (0)| 00:00:01 |
|* 96 |        INDEX RANGE SCAN                   | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|* 97 |      TABLE ACCESS BY INDEX ROWID          | TB_YYDK302    |     1 |    27 |     1   (0)| 00:00:01 |
|* 98 |       INDEX RANGE SCAN                    | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|  99 |     VIEW PUSHED PREDICATE                 |               |     1 |    39 |    12   (0)| 00:00:01 |
|*100 |      FILTER                               |               |       |       |            |          |
| 101 |       SORT AGGREGATE                      |               |     1 |   149 |            |          |
|*102 |        FILTER                             |               |       |       |            |          |
| 103 |         NESTED LOOPS                      |               |       |       |            |          |
| 104 |          NESTED LOOPS                     |               |     1 |   149 |    12   (0)| 00:00:01 |
| 105 |           NESTED LOOPS                    |               |     1 |   127 |    11   (0)| 00:00:01 |
| 106 |            NESTED LOOPS                   |               |     1 |   105 |    10   (0)| 00:00:01 |
| 107 |             NESTED LOOPS                  |               |     1 |    41 |     2   (0)| 00:00:01 |
| 108 |              TABLE ACCESS BY INDEX ROWID  | TB_YYDK301    |     1 |    17 |     1   (0)| 00:00:01 |
|*109 |               INDEX UNIQUE SCAN           | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
| 110 |              TABLE ACCESS BY INDEX ROWID  | TB_YYDK308    |     1 |    24 |     1   (0)| 00:00:01 |
|*111 |               INDEX RANGE SCAN            | PK_YYDK308    |     1 |       |     1   (0)| 00:00:01 |
|*112 |             TABLE ACCESS BY INDEX ROWID   | TB_YYFD410    |     1 |    64 |     8   (0)| 00:00:01 |
|*113 |              INDEX RANGE SCAN             | PK_YYFD410    |     1 |       |     8   (0)| 00:00:01 |
|*114 |            TABLE ACCESS BY INDEX ROWID    | TB_YYDK302    |     1 |    22 |     1   (0)| 00:00:01 |
|*115 |             INDEX UNIQUE SCAN             | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*116 |           INDEX UNIQUE SCAN               | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*117 |          TABLE ACCESS BY INDEX ROWID      | TB_YYDK302    |     1 |    22 |     1   (0)| 00:00:01 |
| 118 |    SORT AGGREGATE                         |               |     1 |    42 |            |          |
| 119 |     NESTED LOOPS                          |               |       |       |            |          |
| 120 |      NESTED LOOPS                         |               |     1 |    42 |     2   (0)| 00:00:01 |
|*121 |       INDEX RANGE SCAN                    | PK_YYBB004    |     1 |    20 |     1   (0)| 00:00:01 |
|*122 |       INDEX UNIQUE SCAN                   | PK_YYDK309    |     1 |       |     1   (0)| 00:00:01 |
|*123 |      TABLE ACCESS BY INDEX ROWID          | TB_YYDK309    |     1 |    22 |     1   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------------------


