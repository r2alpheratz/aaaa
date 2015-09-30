  SELECT /*+ com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnJobDt */
        D.YMGT_JOB_ID AS YMGT_JOB_ID /* ���Ͱ����۾�ID   */
        ,A.RUN_DT AS RUN_DT /* �������� */
        ,TO_NUMBER (A.TRN_NO) AS TRN_NO /* ������ȣ(��0����)*/
        ,A.RUN_DV_CD AS RUN_DV_CD /* ���౸���ڵ� */
        ,DECODE
         (
             (SELECT 'Y'
                FROM TB_YYPD006 /* YMS�Ҵ�������TBL */
               WHERE RUN_DT = A.RUN_DT
                 AND TRN_NO = A.TRN_NO
                 AND ROWNUM = 1)
            ,NULL, A.YMS_APL_FLG
            ,'Y'
         )
             AS YMS_APL_FLG /* YMS���뿩��   */
        ,A.RUN_INFO AS RUN_INFO /* ���౸��  */
        ,D.FCST_PRS_STT_CD AS FCST_PRS_STT_CD /* ����ó�������ڵ�(NULL�̸� '�̽���')   */
        ,D.OTMZ_PRS_STT_CD AS OTMZ_PRS_STT_CD /* ����ȭó�������ڵ�(NULL�̸� '�̽���') */
        ,D.RSV_SALE_TNSM_STT_CD AS RSV_SALE_TNSM_STT_CD /* �������ۻ����ڵ�(NULL�̸� '������')   */
        ,A.ALC_PRS_STT_CD AS ALC_PRS_STT_CD /* ���Ͱ����Ҵ�ó�������ڵ�  */
        ,NVL (D.RSV_SALE_REFL_STT_CD, 'N1') AS RSV_SALE_REFL_STT_CD /* ���߹ݿ������ڵ�  */
        ,A.STLB_TRN_CLSF_CD AS STLB_TRN_CLSF_CD /* ���������ڵ�  */
        ,A.ROUT_CD AS ROUT_CD /* �뼱�ڵ�  */
        ,A.UP_DN_DV_CD AS UP_DN_DV_CD /* �����౸���ڵ�*/
        ,A.DPT_TM AS DPT_TM /* ��߽ð�  */
        ,SUBSTR (D.JOB_DTTM, 3, 12) AS JOB_DTTM /* �۾��Ͻ�  */
        ,SUBSTR (D.JOB_CLS_DTTM, 3, 12) AS JOB_CLS_DTTM /* �۾������Ͻ�  */
        ,A.TRN_NO AS TRN_NO_VAL /* ������ȣ �������� */
        ,DPT_TM_VAL AS DPT_TM_VAL /* ��߽ð� �������� */
    FROM (SELECT A.RUN_DT AS RUN_DT /* �������� */
                ,A.TRN_NO AS TRN_NO /* ������ȣ */
                ,A.ROUT_CD AS ROUT_CD /* �뼱�ڵ� */
                ,A.UP_DN_DV_CD AS UP_DN_DV_CD /* �����౸���ڵ� */
                ,A.STLB_TRN_CLSF_CD AS STLB_TRN_CLSF_CD /* ���������ڵ� */
                ,A.RUN_DV_CD AS RUN_DV_CD /* ���౸���ڵ� */
                ,A.YMS_APL_FLG AS YMS_APL_FLG /* YMS���뿩�� */
                ,A.ORG_RS_STN_CD AS ORG_RS_STN_CD /* �ù߿��߿��ڵ� */
                ,A.TMN_RS_STN_CD AS TMN_RS_STN_CD /* �������߿��ڵ� */
                ,SUBSTR (B.DPT_TM, 1, 2) AS DPT_TM /* ��߽ð� */
                ,B.DPT_TM AS DPT_TM_VAL /* ��߽ð��� */
                ,   (SELECT Y.KOR_STN_NM /* �ѱۿ���  */
                       FROM TB_YYDK001 X, TB_YYDK102 Y /* ���ڵ��̷�TBL */
                      WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
                        AND X.STN_CD = Y.STN_CD
                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                 || '-'
                 || (SELECT Y.KOR_STN_NM /* �ѱۿ��� */
                       FROM TB_YYDK001 X, TB_YYDK102 Y /* ���ڵ��̷�TBL */
                      WHERE X.RS_STN_CD = A.TMN_RS_STN_CD
                        AND X.STN_CD = Y.STN_CD
                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                 || '('
                 || TO_CHAR (TO_DATE (B.DPT_TM, 'HH24MISS'), 'HH24:MI')
                 || '-'
                 || TO_CHAR (TO_DATE (C.ARV_TM, 'HH24MISS'), 'HH24:MI')
                 || ')'
                     AS RUN_INFO /* ��ߵ������ð� */
                ,NVL (E.ALC_PRS_STT_CD, 1) AS ALC_PRS_STT_CD /* �Ҵ�ó�������ڵ� */
                ,NVL (E.EXCS_RSV_ALC_PRS_STT_CD, 1) AS EXCS_RSV_ALC_PRS_STT_CD /* �ʰ������Ҵ�ó�������ڵ� */
            FROM TB_YYDK301 A /* �����⺻TBL */
                ,TB_YYDK302 B /* �������೻��TBL */
                ,TB_YYDK302 C /* �������೻��TBL */
                ,TB_YYDK201 D /* �뼱�ڵ�TBL */
                ,(SELECT RUN_DT /* �������� */
                        ,TRN_NO /* ������ȣ */
                        ,ALC_PRS_STT_CD /* �Ҵ�ó�������ڵ� */
                        ,EXCS_RSV_ALC_PRS_STT_CD /* �ʰ������Ҵ�ó�������ڵ� */
                    FROM TB_YYBB004 BB /* �������Ҵ�⺻TBL */
                   WHERE ( (DECODE (PSRM_CL_CD || BKCL_CD,  '1F1', 1,  '1C1', 2,  '1R1', 3,  '1R2', 4,  '1R3', 5,  '2F1', 6,  '2C1', 7,  '2R1', 8,  '2R2', 9,  '2R3', 10,  0) =
                                (SELECT MIN (DECODE (X.PSRM_CL_CD || X.BKCL_CD,  '1F1', 1,  '1C1', 2,  '1R1', 3,  '1R2', 4,  '1R3', 5,  '2F1', 6,  '2C1', 7,  '2R1', 8,  '2R2', 9,  '2R3', 10,  0))
                                   FROM TB_YYBB004 X, TB_YYDK309 Y /* ��ŷŬ�������볻��TBL */
                                  WHERE X.RUN_DT = BB.RUN_DT
                                    AND X.TRN_NO = BB.TRN_NO
                                    AND X.RUN_DT = Y.RUN_DT
                                    AND X.TRN_NO = Y.TRN_NO
                                    AND X.PSRM_CL_CD = Y.PSRM_CL_CD
                                    AND X.BKCL_CD = Y.BKCL_CD
                                    AND Y.BKCL_USE_FLG = 'Y')
                        AND PSRM_CL_CD IS NOT NULL) /* END DECODE */
                       OR PSRM_CL_CD IS NULL)
                  UNION ALL
                  SELECT DISTINCT A.RUN_DT /* ������ȣ */
                                 ,A.TRN_NO /* �������� */
                                 ,B.YMGT_ALC_PRS_STT_CD /* �Ҵ�ó�������ڵ� */
                                 ,B.EXCS_RSV_ALC_PRS_STT_CD /* �ʰ������Ҵ�ó�������ڵ� */
                    FROM TB_YYDK301 A, TB_YYBB005 B, TB_YYDK003 C /* ����������ī���ٳ��� TBL */
                   WHERE A.ROUT_CD = B.ROUT_CD /* �뼱�ڵ� */
                     AND A.UP_DN_DV_CD = B.UP_DN_DV_CD /* �������౸���ڵ� */
                     AND B.TRN_CLSF_CD = NVL ('00', B.TRN_CLSF_CD)
                     AND B.BIZ_DD_STG_CD = C.BIZ_DD_STG_CD /* �����ϴܰ��ڵ� */
                     AND A.RUN_DT = C.RUN_DT
                     AND A.RUN_DT BETWEEN B.APL_ST_DT AND B.APL_CLS_DT
                     AND NOT EXISTS
                                 (SELECT '1'
                                    FROM TB_YYBB004 BB /* �������Ҵ�⺻TBL */
                                   WHERE RUN_DT = A.RUN_DT
                                     AND TRN_NO = A.TRN_NO
                                     AND ( (DECODE (PSRM_CL_CD || BKCL_CD,  '1F1', 1,  '1C1', 2,  '1R1', 3,  '1R2', 4,  '1R3', 5,  '2F1', 6,  '2C1', 7,  '2R1', 8,  '2R2', 9,  '2R3', 10,  0) =
                                                (SELECT MIN
                                                        (
                                                            DECODE
                                                            (
                                                                X.PSRM_CL_CD || X.BKCL_CD
                                                               ,'1F1', 1
                                                               ,'1C1', 2
                                                               ,'1R1', 3
                                                               ,'1R2', 4
                                                               ,'1R3', 5
                                                               ,'2F1', 6
                                                               ,'2C1', 7
                                                               ,'2R1', 8
                                                               ,'2R2', 9
                                                               ,'2R3', 10
                                                               ,0
                                                            )
                                                        )
                                                   FROM TB_YYBB004 X, TB_YYDK309 Y /* ��ŷŬ�������볻��TBL */
                                                  WHERE X.RUN_DT = BB.RUN_DT
                                                    AND X.TRN_NO = BB.TRN_NO
                                                    AND X.RUN_DT = Y.RUN_DT
                                                    AND X.TRN_NO = Y.TRN_NO
                                                    AND X.PSRM_CL_CD = Y.PSRM_CL_CD
                                                    AND X.BKCL_CD = Y.BKCL_CD
                                                    AND Y.BKCL_USE_FLG = 'Y')
                                        AND PSRM_CL_CD IS NOT NULL)
                                       OR PSRM_CL_CD IS NULL))) E
           WHERE A.RUN_DT = B.RUN_DT
             AND A.TRN_NO = B.TRN_NO
             AND A.STLB_TRN_CLSF_CD = NVL ('00', A.STLB_TRN_CLSF_CD)
             AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD
             AND A.RUN_DT = C.RUN_DT
             AND A.TRN_NO = C.TRN_NO
             AND A.TMN_RS_STN_CD = C.STOP_RS_STN_CD
             AND A.ROUT_CD = D.ROUT_CD
             AND A.RUN_DT = E.RUN_DT(+)
             AND A.TRN_NO = E.TRN_NO(+)
             AND A.RUN_DT BETWEEN '20140101' AND '20140131'
             AND D.MRNT_CD = NVL ('', D.MRNT_CD)
             AND D.ROUT_DV_CD IN ('10', '30') /* ���⿩��, �ӽÿ��� */
             AND D.MRNT_CD IN ('01', '03', '04')
             AND ( (D.EFC_ST_DT <= '20140101'
                AND D.EFC_CLS_DT >= '20140131')
               OR (D.EFC_ST_DT >= '20140101'
               AND D.EFC_CLS_DT <= '20140131')) /* �����������/�������� */
             AND A.ROUT_CD = NVL ('', A.ROUT_CD)
             AND A.UP_DN_DV_CD = DECODE ('A', 'A', A.UP_DN_DV_CD, 'A')) A
        ,(SELECT A.YMGT_JOB_ID
                ,A.RUN_DT
                ,A.TRN_NO
                ,A.FCST_PRS_STT_CD /* ����ó�������ڵ� */
                ,A.OTMZ_PRS_STT_CD /* ����ȭó�������ڵ� */
                ,A.EXCS_RSV_APL_STT_CD /* �ʰ�������������ڵ� */
                ,A.NON_NML_TRN_FLG /* ������������ */
                ,A.RSV_SALE_TNSM_STT_CD /* ����߸����ۻ����ڵ� */
                ,A.RSV_SALE_TNSM_DTTM /* ����߸������Ͻ� */
                ,A.RSV_SALE_REFL_STT_CD /* ����߸Źݿ������ڵ� */
                ,D.JOB_DTTM /* �۾��Ͻ� */
                ,D.JOB_CLS_DTTM /* �۾������Ͻ� */
            FROM TB_YYFD011 A, TB_YYFB009 D /* ���Ͱ����۾�����⺻TBL */
           WHERE (D.JOB_DTTM, A.RUN_DT, A.TRN_NO) IN (  SELECT MAX (B.JOB_DTTM), A.RUN_DT, A.TRN_NO
                                                          FROM (SELECT A.YMGT_JOB_ID, A.RUN_DT, A.TRN_NO
                                                                  FROM TB_YYFD011 A /* ���Ͱ������������TBL */
                                                                 WHERE A.RUN_DT BETWEEN '20140101' AND '20140131'
                                                                   AND (A.NON_NML_TRN_FLG = 'Y'
                                                                     OR A.NON_NML_TRN_FLG = 'N')
                                                                   AND (A.EXCS_RSV_APL_STT_CD IS NULL
                                                                     OR A.EXCS_RSV_APL_STT_CD = 'A'
                                                                     OR A.EXCS_RSV_APL_STT_CD = 'Y') /* �ʰ����ุ �������� ���� */
                                                                                                    ) A
                                                              ,(SELECT B.YMGT_JOB_ID, B.JOB_DTTM
                                                                  FROM TB_YYFB009 B /* ���Ͱ����۾�����⺻TBL */
                                                                 WHERE B.REG_DTTM LIKE '20140101' || '%'
                                                                   AND B.ONLN_ARNG_DV_CD = NVL ('', B.ONLN_ARNG_DV_CD) /* �¶��ι�ġ�����ڵ� */
                                                                                                                                     ) B
                                                         WHERE B.YMGT_JOB_ID = A.YMGT_JOB_ID
                                                      GROUP BY A.RUN_DT, A.TRN_NO)
             AND A.YMGT_JOB_ID = D.YMGT_JOB_ID
             AND A.REG_DTTM LIKE '20140101' || '%') D
   WHERE A.RUN_DT = D.RUN_DT
     AND A.TRN_NO = D.TRN_NO
     AND (A.STLB_TRN_CLSF_CD, A.ROUT_CD, A.UP_DN_DV_CD, A.DPT_TM) IN (SELECT TRN_CLSF_CD  /* ���������ڵ�   */
                                                                            ,ROUT_CD      /* �뼱�ڵ�   */
                                                                            ,UP_DN_DV_CD  /* �����౸���ڵ� */
                                                                            ,TMWD_DV_CD   /* �ð��뱸���ڵ� */
                                                                        FROM TB_YYFD008   /* ���׷캰��������TBL */
                                                                       WHERE USR_GP_ID IN (SELECT DISTINCT USR_GP_ID /* ����ڱ׷�ID */
                                                                                             FROM TB_YYFD007 /* ���׷캰����ڳ���TBL */
                                                                                            WHERE USR_ID = NVL ('', USR_ID))
                                                                         AND TRN_CLSF_CD = NVL ('00', TRN_CLSF_CD)
                                                                         AND ROUT_CD = NVL ('', ROUT_CD)
                                                                         AND UP_DN_DV_CD = DECODE ('A', 'A', UP_DN_DV_CD, 'A'))
ORDER BY RUN_DT, TRN_NO, YMS_APL_FLG DESC





Ʃ�� ���� 
   1. ���� ����ӵ� ��ȣ ��. 
   2. �ε��� ���� ���� ( ���� �Ǽ� : 2������) 
       TB_YYFB009 ( REG_DTTM ) 








----------------------------------------------------------------------------------------------------------
| Id  | Operation                                   | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                            |            |     1 |   295 |   255   (3)| 00:00:04 |
|*  1 |  COUNT STOPKEY                              |            |       |       |            |          |
|*  2 |   INDEX RANGE SCAN                          | PK_YYPD006 |     1 |    14 |     1   (0)| 00:00:01 |
|   3 |  NESTED LOOPS                               |            |     1 |    59 |     3   (0)| 00:00:01 |
|   4 |   TABLE ACCESS BY INDEX ROWID               | TB_YYDK001 |     1 |    13 |     2   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN                        | PK_YYDK001 |     1 |       |     1   (0)| 00:00:01 |
|*  6 |   TABLE ACCESS BY INDEX ROWID               | TB_YYDK102 |     1 |    46 |     1   (0)| 00:00:01 |
|*  7 |    INDEX RANGE SCAN                         | PK_YYDK102 |     1 |       |     1   (0)| 00:00:01 |
|   8 |    NESTED LOOPS                             |            |     1 |    59 |     3   (0)| 00:00:01 |
|   9 |     TABLE ACCESS BY INDEX ROWID             | TB_YYDK001 |     1 |    13 |     2   (0)| 00:00:01 |
|* 10 |      INDEX UNIQUE SCAN                      | PK_YYDK001 |     1 |       |     1   (0)| 00:00:01 |
|* 11 |     TABLE ACCESS BY INDEX ROWID             | TB_YYDK102 |     1 |    46 |     1   (0)| 00:00:01 |
|* 12 |      INDEX RANGE SCAN                       | PK_YYDK102 |     1 |       |     1   (0)| 00:00:01 |
|  13 |  SORT ORDER BY                              |            |     1 |   295 |   255   (3)| 00:00:04 |
|  14 |   NESTED LOOPS SEMI                         |            |     1 |   295 |   254   (2)| 00:00:04 |
|  15 |    NESTED LOOPS OUTER                       |            |     1 |   287 |   251   (2)| 00:00:04 |
|  16 |     NESTED LOOPS                            |            |     1 |   271 |   227   (2)| 00:00:03 |
|  17 |      NESTED LOOPS                           |            |     1 |   244 |   224   (2)| 00:00:03 |
|  18 |       NESTED LOOPS                          |            |     1 |   217 |   221   (2)| 00:00:03 |
|  19 |        NESTED LOOPS                         |            |     1 |   188 |   220   (2)| 00:00:03 |
|  20 |         NESTED LOOPS                        |            |     1 |   149 |   219   (2)| 00:00:03 |
|* 21 |          HASH JOIN                          |            |    95 |  8170 |   122   (4)| 00:00:02 |
|  22 |           VIEW                              | VW_NSO_3   |    92 |  2852 |    78   (3)| 00:00:01 |
|  23 |            HASH GROUP BY                    |            |    92 |  9200 |    78   (3)| 00:00:01 |
|  24 |             NESTED LOOPS                    |            |       |       |            |          |
|  25 |              NESTED LOOPS                   |            |    92 |  9200 |    77   (2)| 00:00:01 |
|* 26 |               TABLE ACCESS FULL             | TB_YYFB009 |     1 |    57 |    43   (3)| 00:00:01 |
|* 27 |               INDEX RANGE SCAN              | PK_YYFD011 |   134 |       |     2   (0)| 00:00:01 |
|* 28 |              TABLE ACCESS BY INDEX ROWID    | TB_YYFD011 |    89 |  3827 |    34   (0)| 00:00:01 |
|  29 |           TABLE ACCESS FULL                 | TB_YYFB009 | 18782 |  1008K|    43   (3)| 00:00:01 |
|* 30 |          TABLE ACCESS BY INDEX ROWID        | TB_YYFD011 |     1 |    63 |     2   (0)| 00:00:01 |
|* 31 |           INDEX UNIQUE SCAN                 | PK_YYFD011 |     1 |       |     1   (0)| 00:00:01 |
|* 32 |         TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |     1 |    39 |     1   (0)| 00:00:01 |
|* 33 |          INDEX UNIQUE SCAN                  | PK_YYDK301 |     1 |       |     0   (0)| 00:00:01 |
|* 34 |        TABLE ACCESS BY INDEX ROWID          | TB_YYDK201 |     1 |    29 |     1   (0)| 00:00:01 |
|* 35 |         INDEX UNIQUE SCAN                   | PK_YYDK201 |     1 |       |     0   (0)| 00:00:01 |
|* 36 |       TABLE ACCESS BY INDEX ROWID           | TB_YYDK302 |     1 |    27 |     3   (0)| 00:00:01 |
|* 37 |        INDEX RANGE SCAN                     | PK_YYDK302 |     1 |       |     2   (0)| 00:00:01 |
|* 38 |      TABLE ACCESS BY INDEX ROWID            | TB_YYDK302 |     1 |    27 |     3   (0)| 00:00:01 |
|* 39 |       INDEX RANGE SCAN                      | PK_YYDK302 |     1 |       |     2   (0)| 00:00:01 |
|  40 |     VIEW                                    |            |     1 |    16 |    24   (5)| 00:00:01 |
|  41 |      UNION ALL PUSHED PREDICATE             |            |       |       |            |          |
|* 42 |       FILTER                                |            |       |       |            |          |
|  43 |        TABLE ACCESS BY INDEX ROWID          | TB_YYBB004 |     1 |    24 |     4   (0)| 00:00:01 |
|* 44 |         INDEX RANGE SCAN                    | PK_YYBB004 |     1 |       |     3   (0)| 00:00:01 |
|  45 |          SORT AGGREGATE                     |            |     1 |    42 |            |          |
|  46 |           NESTED LOOPS                      |            |       |       |            |          |
|  47 |            NESTED LOOPS                     |            |     1 |    42 |     5   (0)| 00:00:01 |
|* 48 |             INDEX RANGE SCAN                | PK_YYBB004 |     1 |    20 |     3   (0)| 00:00:01 |
|* 49 |             INDEX UNIQUE SCAN               | PK_YYDK309 |     1 |       |     1   (0)| 00:00:01 |
|* 50 |            TABLE ACCESS BY INDEX ROWID      | TB_YYDK309 |     1 |    22 |     2   (0)| 00:00:01 |
|  51 |       SORT UNIQUE                           |            |     1 |    82 |    15   (7)| 00:00:01 |
|* 52 |        FILTER                               |            |       |       |            |          |
|  53 |         NESTED LOOPS                        |            |       |       |            |          |
|  54 |          NESTED LOOPS                       |            |     1 |    82 |    14   (0)| 00:00:01 |
|  55 |           NESTED LOOPS                      |            |     1 |    48 |    12   (0)| 00:00:01 |
|  56 |            NESTED LOOPS ANTI                |            |     1 |    37 |    10   (0)| 00:00:01 |
|  57 |             TABLE ACCESS BY INDEX ROWID     | TB_YYDK301 |     1 |    22 |     2   (0)| 00:00:01 |
|* 58 |              INDEX UNIQUE SCAN              | PK_YYDK301 |     1 |       |     1   (0)| 00:00:01 |
|* 59 |             VIEW                            | VW_SQ_1    |     1 |    15 |     8   (0)| 00:00:01 |
|* 60 |              FILTER                         |            |       |       |            |          |
|* 61 |               INDEX RANGE SCAN              | PK_YYBB004 |     1 |    20 |     3   (0)| 00:00:01 |
|  62 |                SORT AGGREGATE               |            |     1 |    42 |            |          |
|  63 |                 NESTED LOOPS                |            |       |       |            |          |
|  64 |                  NESTED LOOPS               |            |     1 |    42 |     5   (0)| 00:00:01 |
|* 65 |                   INDEX RANGE SCAN          | PK_YYBB004 |     1 |    20 |     3   (0)| 00:00:01 |
|* 66 |                   INDEX UNIQUE SCAN         | PK_YYDK309 |     1 |       |     1   (0)| 00:00:01 |
|* 67 |                  TABLE ACCESS BY INDEX ROWID| TB_YYDK309 |     1 |    22 |     2   (0)| 00:00:01 |
|  68 |            TABLE ACCESS BY INDEX ROWID      | TB_YYDK003 |     1 |    11 |     2   (0)| 00:00:01 |
|* 69 |             INDEX RANGE SCAN                | PK_YYDK003 |     1 |       |     1   (0)| 00:00:01 |
|* 70 |           INDEX RANGE SCAN                  | PK_YYBB005 |     1 |       |     1   (0)| 00:00:01 |
|* 71 |          TABLE ACCESS BY INDEX ROWID        | TB_YYBB005 |     1 |    34 |     2   (0)| 00:00:01 |
|  72 |    VIEW PUSHED PREDICATE                    | VW_NSO_2   |     1 |     8 |     3   (0)| 00:00:01 |
|* 73 |     FILTER                                  |            |       |       |            |          |
|  74 |      NESTED LOOPS                           |            |     1 |    34 |     3   (0)| 00:00:01 |
|  75 |       TABLE ACCESS BY INDEX ROWID           | TB_YYFD008 |     1 |    20 |     2   (0)| 00:00:01 |
|* 76 |        INDEX UNIQUE SCAN                    | PK_YYFD008 |     1 |       |     1   (0)| 00:00:01 |
|* 77 |       INDEX RANGE SCAN                      | PK_YYFD007 |     1 |    14 |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   1 - filter(ROWNUM=1)
   2 - access("RUN_DT"=:B1 AND "TRN_NO"=:B2)
   5 - access("X"."RS_STN_CD"=:B1)
   6 - filter("Y"."APL_ST_DT"<=TO_CHAR(SYSDATE@!,'YYYYMMDD'))
   7 - access("X"."STN_CD"="Y"."STN_CD" AND "Y"."APL_CLS_DT">=TO_CHAR(SYSDATE@!,'YYYYMMDD'))
  10 - access("X"."RS_STN_CD"=:B1)
  11 - filter("Y"."APL_ST_DT"<=TO_CHAR(SYSDATE@!,'YYYYMMDD'))
  12 - access("X"."STN_CD"="Y"."STN_CD" AND "Y"."APL_CLS_DT">=TO_CHAR(SYSDATE@!,'YYYYMMDD'))
  21 - access("D"."JOB_DTTM"="MAX(B.JOB_DTTM)")
  26 - filter("B"."REG_DTTM" LIKE '20140101%')
  27 - access("B"."YMGT_JOB_ID"="A"."YMGT_JOB_ID" AND "A"."RUN_DT">='20140101' AND
              "A"."RUN_DT"<='20140131')
  28 - filter(("A"."NON_NML_TRN_FLG"='N' OR "A"."NON_NML_TRN_FLG"='Y') AND
              ("A"."EXCS_RSV_APL_STT_CD" IS NULL OR ("A"."EXCS_RSV_APL_STT_CD"='A' OR
              "A"."EXCS_RSV_APL_STT_CD"='Y')))
  30 - filter("A"."REG_DTTM" LIKE '20140101%')
  31 - access("A"."YMGT_JOB_ID"="D"."YMGT_JOB_ID" AND "A"."RUN_DT"="RUN_DT" AND
              "A"."TRN_NO"="TRN_NO")
       filter("A"."RUN_DT"<='20140131' AND "A"."RUN_DT">='20140101')
  32 - filter("A"."STLB_TRN_CLSF_CD"='00')
  33 - access("A"."RUN_DT"="A"."RUN_DT" AND "A"."TRN_NO"="A"."TRN_NO")
       filter("A"."RUN_DT">='20140101' AND "A"."RUN_DT"<='20140131')
  34 - filter(("D"."MRNT_CD"='01' OR "D"."MRNT_CD"='03' OR "D"."MRNT_CD"='04') AND
              ("D"."MRNT_CD"='01' OR "D"."MRNT_CD"='03' OR "D"."MRNT_CD"='04') AND ("D"."ROUT_DV_CD"='10' OR
              "D"."ROUT_DV_CD"='30') AND ("D"."EFC_ST_DT"<='20140101' AND "D"."EFC_CLS_DT">='20140131' OR
              "D"."EFC_ST_DT">='20140101' AND "D"."EFC_CLS_DT"<='20140131'))
  35 - access("A"."ROUT_CD"="D"."ROUT_CD")
  36 - filter("A"."TMN_RS_STN_CD"="C"."STOP_RS_STN_CD")
  37 - access("A"."RUN_DT"="C"."RUN_DT" AND "A"."TRN_NO"="C"."TRN_NO")
       filter("C"."RUN_DT">='20140101' AND "C"."RUN_DT"<='20140131')
  38 - filter("A"."ORG_RS_STN_CD"="B"."STOP_RS_STN_CD")
  39 - access("A"."RUN_DT"="B"."RUN_DT" AND "A"."TRN_NO"="B"."TRN_NO")
       filter("B"."RUN_DT">='20140101' AND "B"."RUN_DT"<='20140131')
  42 - filter('20140131'>="A"."RUN_DT" AND '20140101'<="A"."RUN_DT")
  44 - access("RUN_DT"="A"."RUN_DT" AND "TRN_NO"="A"."TRN_NO")
       filter("RUN_DT">='20140101' AND "RUN_DT"<='20140131' AND
              DECODE("PSRM_CL_CD"||"BKCL_CD",'1F1',1,'1C1',2,'1R1',3,'1R2',4,'1R3',5,'2F1',6,'2C1',7,'2R1',8,'2R
              2',9,'2R3',10,0)= (SELECT MIN(DECODE("X"."PSRM_CL_CD"||"X"."BKCL_CD",'1F1',1,'1C1',2,'1R1',3,'1R2'
              ,4,'1R3',5,'2F1',6,'2C1',7,'2R1',8,'2R2',9,'2R3',10,0)) FROM "YZDBA"."TB_YYDK309"
              "Y","YZDBA"."TB_YYBB004" "X" WHERE "X"."TRN_NO"=:B1 AND "X"."RUN_DT"=:B2 AND
              "X"."BKCL_CD"="Y"."BKCL_CD" AND "X"."PSRM_CL_CD"="Y"."PSRM_CL_CD" AND "Y"."TRN_NO"=:B3 AND
              "Y"."RUN_DT"=:B4 AND "Y"."BKCL_USE_FLG"='Y' AND "X"."RUN_DT"="Y"."RUN_DT" AND
              "X"."TRN_NO"="Y"."TRN_NO"))
  48 - access("X"."RUN_DT"=:B1 AND "X"."TRN_NO"=:B2)
  49 - access("Y"."RUN_DT"=:B1 AND "Y"."TRN_NO"=:B2 AND "X"."PSRM_CL_CD"="Y"."PSRM_CL_CD" AND
              "X"."BKCL_CD"="Y"."BKCL_CD")
       filter("X"."RUN_DT"="Y"."RUN_DT" AND "X"."TRN_NO"="Y"."TRN_NO")
  50 - filter("Y"."BKCL_USE_FLG"='Y')
  52 - filter('20140131'>="A"."RUN_DT" AND '20140101'<="A"."RUN_DT")
  58 - access("A"."RUN_DT"="A"."RUN_DT" AND "A"."TRN_NO"="A"."TRN_NO")
       filter("A"."RUN_DT">='20140101' AND "A"."RUN_DT"<='20140131')
  59 - filter("ITEM_1"="A"."RUN_DT" AND "ITEM_2"="A"."TRN_NO")
  60 - filter('20140131'>="A"."RUN_DT" AND '20140101'<="A"."RUN_DT")
  61 - access("RUN_DT"="A"."RUN_DT" AND "TRN_NO"="A"."TRN_NO")
       filter("RUN_DT">='20140101' AND "RUN_DT"<='20140131' AND
              DECODE("PSRM_CL_CD"||"BKCL_CD",'1F1',1,'1C1',2,'1R1',3,'1R2',4,'1R3',5,'2F1',6,'2C1',7,'2R1',8,'2R
              2',9,'2R3',10,0)= (SELECT MIN(DECODE("X"."PSRM_CL_CD"||"X"."BKCL_CD",'1F1',1,'1C1',2,'1R1',3,'1R2'
              ,4,'1R3',5,'2F1',6,'2C1',7,'2R1',8,'2R2',9,'2R3',10,0)) FROM "YZDBA"."TB_YYDK309"
              "Y","YZDBA"."TB_YYBB004" "X" WHERE "X"."TRN_NO"=:B1 AND "X"."RUN_DT"=:B2 AND
              "X"."BKCL_CD"="Y"."BKCL_CD" AND "X"."PSRM_CL_CD"="Y"."PSRM_CL_CD" AND "Y"."TRN_NO"=:B3 AND
              "Y"."RUN_DT"=:B4 AND "Y"."BKCL_USE_FLG"='Y' AND "X"."RUN_DT"="Y"."RUN_DT" AND
              "X"."TRN_NO"="Y"."TRN_NO"))
  65 - access("X"."RUN_DT"=:B1 AND "X"."TRN_NO"=:B2)
  66 - access("Y"."RUN_DT"=:B1 AND "Y"."TRN_NO"=:B2 AND "X"."PSRM_CL_CD"="Y"."PSRM_CL_CD" AND
              "X"."BKCL_CD"="Y"."BKCL_CD")
       filter("X"."RUN_DT"="Y"."RUN_DT" AND "X"."TRN_NO"="Y"."TRN_NO")
  67 - filter("Y"."BKCL_USE_FLG"='Y')
  69 - access("C"."RUN_DT"="A"."RUN_DT")
       filter("C"."RUN_DT">='20140101' AND "C"."RUN_DT"<='20140131' AND "A"."RUN_DT"="C"."RUN_DT")
  70 - access("A"."ROUT_CD"="B"."ROUT_CD" AND "A"."UP_DN_DV_CD"="B"."UP_DN_DV_CD" AND
              "B"."TRN_CLSF_CD"='00' AND "B"."BIZ_DD_STG_CD"="C"."BIZ_DD_STG_CD" AND
              "B"."APL_CLS_DT">='20140101')
       filter("B"."APL_CLS_DT">="A"."RUN_DT" AND "A"."RUN_DT"<="B"."APL_CLS_DT")
  71 - filter("B"."APL_ST_DT"<="A"."RUN_DT" AND "B"."APL_ST_DT"<='20140131' AND
              "A"."RUN_DT">="B"."APL_ST_DT")
  73 - filter('00'="A"."STLB_TRN_CLSF_CD")
  76 - access("TRN_CLSF_CD"="A"."STLB_TRN_CLSF_CD" AND "ROUT_CD"="A"."ROUT_CD" AND
              "UP_DN_DV_CD"="A"."UP_DN_DV_CD" AND "TMWD_DV_CD"=SUBSTR("B"."DPT_TM",1,2))
       filter("ROUT_CD"="A"."ROUT_CD" AND "UP_DN_DV_CD"="A"."UP_DN_DV_CD")
  77 - access("USR_GP_ID"="USR_GP_ID")

