SELECT   D.YMGT_JOB_ID  /*���Ͱ����۾�ID*/
         ,A.RUN_DT                                                                                /* ��������         */
         ,LPAD(TO_NUMBER(A.TRN_NO), 5, ' ') TRN_NO                                                /* ������ȣ(��0����)         */
         ,A.SHTM_EXCS_RSV_ALLW_FLG /* �ܱ��ʰ�������뿩�� */
         ,A.RUN_DV_CD AS RUN_DV_CD                                     /* ���౸���ڵ�     */
         ,DECODE( (SELECT 'Y'
                  FROM   TB_YYPD006 /* YMS�Ҵ�������TBL */
                  WHERE  RUN_DT = A.RUN_DT
                  AND    TRN_NO = A.TRN_NO
                  AND    ROWNUM = 1), NULL, A.YMS_APL_FLG, 'Y') YMS_APL_FLG                        /* YMS���뿩��        */
         ,A.RUN_INFO   /* ���౸��       */
         ,D.FCST_PRS_STT_CD AS FCST_PRS_STT_CD /* ����ó�������ڵ�(NULL�̸� '�̽���') */
         ,D.OTMZ_PRS_STT_CD AS  OTMZ_PRS_STT_CD /* ����ȭó�������ڵ�(NULL�̸� '�̽���') */
         , D.RSV_SALE_TNSM_STT_CD AS RSV_SALE_TNSM_STT_CD             /* �������ۻ����ڵ�(NULL�̸� '������')*/
         ,A.ALC_PRS_STT_CD AS ALC_PRS_STT_CD                                         /* ���Ͱ����Ҵ�ó�������ڵ� */
         ,NVL(D.RSV_SALE_REFL_STT_CD, 'N1') AS RSV_SALE_REFL_STT_CD                 /* ���߹ݿ������ڵ� */
         ,A.STLB_TRN_CLSF_CD AS TRN_CLSF_CD /*���������ڵ�*/
         ,A.ROUT_CD /* �뼱�ڵ� */
         ,A.UP_DN_DV_CD /* �����౸���ڵ� */
         ,A.DPT_TM /* ��߽ð� */
         ,SUBSTR(D.JOB_DTTM, 3, 12) JOB_DTTM /*�۾��Ͻ�*/
         ,SUBSTR(D.JOB_CLS_DTTM, 3, 12) JOB_CLS_DTTM /* �۾������Ͻ� */
         ,A.TRN_NO TRN_NO_VAL /* ������ȣ �������� */
         ,DPT_TM_VAL  /* ��߽ð� �������� */
FROM     (SELECT A.RUN_DT                                                                      /* �������� */
                 ,A.TRN_NO                                                                        /* ������ȣ         */
                 ,A.ROUT_CD                                                                       /* �뼱�ڵ�         */
                 ,A.UP_DN_DV_CD                                                                     /* �����౸���ڵ�   */
                 ,A.STLB_TRN_CLSF_CD                                                                   /* ���������ڵ�     */
                 ,A.SHTM_EXCS_RSV_ALLW_FLG                                                         /* �ܱ��ʰ�������뿩�� */
                 ,A.RUN_DV_CD                                                                     /* ���౸���ڵ�     */
                 ,A.YMS_APL_FLG                                                                   /* YMS���뿩��      */
                 ,A.ORG_RS_STN_CD                                                                 /* �ù߿��߿��ڵ� */
                 ,A.TMN_RS_STN_CD                                                                 /* �������߿��ڵ� */
                 ,SUBSTR(B.DPT_TM, 1, 2) DPT_TM                                                          /* ��߽ð� */
                 ,B.DPT_TM DPT_TM_VAL
                 ,(SELECT Y.KOR_STN_NM /* �ѱۿ��� */
                      FROM  TB_YYDK001 X /* ���߿��ڵ� */
                                 ,TB_YYDK102 Y /* ���ڵ��̷� */
                    WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
                       AND X.STN_CD = Y.STN_CD
                       AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT) ||
                 '-' || (SELECT Y.KOR_STN_NM /* �ѱۿ��� */
                      FROM  TB_YYDK001 X /* ���߿��ڵ� */
                                 ,TB_YYDK102 Y /* ���ڵ��̷� */
                    WHERE X.RS_STN_CD = A.TMN_RS_STN_CD
                       AND X.STN_CD = Y.STN_CD
                       AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT) ||
                 '(' ||
                 TO_CHAR(TO_DATE(B.DPT_TM, 'HH24MISS'), 'HH24:MI') ||
                 '-' ||
                 TO_CHAR(TO_DATE(C.ARV_TM, 'HH24MISS'), 'HH24:MI') ||
                 ')' RUN_INFO                                                                      /* ��ߵ������ð� */
                ,NVL(E.ALC_PRS_STT_CD, 1) AS ALC_PRS_STT_CD /* �Ҵ�ó�������ڵ� */
                ,NVL(E.EXCS_RSV_ALC_PRS_STT_CD, 1) AS EXCS_RSV_ALC_PRS_STT_CD /* �ʰ������Ҵ�ó�������ڵ� */
          FROM   TB_YYDK301 A                                                                    /* �����⺻TBL */
                 ,TB_YYDK302 B                                                                    /* �������೻��TBL */
                 ,TB_YYDK302 C                                                                   /* �������೻��TBL */
                 ,TB_YYDK201 D /* �뼱�ڵ�TBL */
                 ,(SELECT RUN_DT, /* �������� */
                         TRN_NO, /* ������ȣ */
                         ALC_PRS_STT_CD, /* �Ҵ�ó�������ڵ� */
                         EXCS_RSV_ALC_PRS_STT_CD /* �ʰ������Ҵ�ó�������ڵ� */
                  FROM   TB_YYBB004 BB /* �������Ҵ�⺻TBL */
                  WHERE  ( (DECODE(PSRM_CL_CD || BKCL_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) 
                           = (SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCL_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) )
                              FROM   TB_YYBB004 X , /* �������Ҵ�⺻TBL */
                                     TB_YYDK309 Y /* ��ŷŬ�������볻��TBL */
                              WHERE  X.RUN_DT = BB.RUN_DT
                              AND    X.TRN_NO = BB.TRN_NO
                              AND    X.RUN_DT = Y.RUN_DT
                              AND    X.TRN_NO = Y.TRN_NO
                              AND    X.PSRM_CL_CD = Y.PSRM_CL_CD
                              AND    X.BKCL_CD = Y.BKCL_CD
                              AND    Y.BKCL_USE_FLG ='Y')
                            AND PSRM_CL_CD IS NOT NULL)
                          OR PSRM_CL_CD IS NULL)
                  UNION ALL
                  SELECT DISTINCT A.RUN_DT, /* ������ȣ */
                                  A.TRN_NO, /* �������� */
                                  B.ALC_PRS_STT_CD, /* �Ҵ�ó�������ڵ� */
                                  B.EXCS_RSV_ALC_PRS_STT_CD /* �ʰ������Ҵ�ó�������ڵ� */
                  FROM       TB_YYDK301 A /* �����⺻TBL */
                                  ,TB_YYBB005 B /* �뼱���Ҵ�⺻TBL */
                                  ,TB_YYDK003 C /**����������ī���ٳ��� TBL**/
                  WHERE           A.ROUT_CD = B.ROUT_CD /* �뼱�ڵ� */
                  AND             A.UP_DN_DV_CD = B.UP_DN_DV_CD /* �������౸���ڵ� */
                  AND             B.TRN_CLSF_CD LIKE :TRN_CLSF_CD /* ���������ڵ� */
                  AND             B.BIZ_DD_STG_CD = C.BIZ_DD_STG_CD /* �����ϴܰ��ڵ� */
                  AND             A.RUN_DT = C.RUN_DT
                  AND             A.RUN_DT BETWEEN B.APL_ST_DT AND B.APL_CLS_DT
                  AND             NOT EXISTS(SELECT '1'
                                             FROM   TB_YYBB004 BB /* �������Ҵ�⺻TBL */
                                             WHERE  RUN_DT = A.RUN_DT
                                             AND    TRN_NO = A.TRN_NO
                                             AND    ( (DECODE(PSRM_CL_CD || BKCL_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) 
                                                      = (SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCL_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) )
                                                           FROM   TB_YYBB004  X /* �������Ҵ�⺻TBL */
                                                                       , TB_YYDK309 Y /* ��ŷŬ�������볻��TBL */
                                                           WHERE  X.RUN_DT = BB.RUN_DT
                                                           AND    X.TRN_NO = BB.TRN_NO
                                                           AND    X.RUN_DT = Y.RUN_DT
                                                           AND    X.TRN_NO = Y.TRN_NO
                                                           AND    X.PSRM_CL_CD = Y.PSRM_CL_CD
                                                           AND    X.BKCL_CD = Y.BKCL_CD
                                                           AND    Y.BKCL_USE_FLG = 'Y')
                                                       AND PSRM_CL_CD IS NOT NULL)
                                                     OR PSRM_CL_CD IS NULL) ) ) E
          WHERE  A.RUN_DT = B.RUN_DT
          AND    A.TRN_NO = B.TRN_NO
          AND    A.STLB_TRN_CLSF_CD LIKE :TRN_CLSF_CD  /* ���������ڵ� */
          AND    A.ORG_RS_STN_CD = B.STOP_RS_STN_CD /* �ù߿��߿��ڵ� */
          AND    A.RUN_DT = C.RUN_DT
          AND    A.TRN_NO = C.TRN_NO
          AND    A.TMN_RS_STN_CD = C.STOP_RS_STN_CD
          AND    A.ROUT_CD = D.ROUT_CD
          AND    A.RUN_DT = E.RUN_DT(+)
          AND    A.TRN_NO = E.TRN_NO(+)
          AND    A.RUN_DT BETWEEN :RUN_TRM_ST_DT AND :RUN_TRM_CLS_DT /* ����Ⱓ */
          AND    D.MRNT_CD LIKE :MRNT_CD  /* �ֿ��༱�ڵ� */
          AND    D.MRNT_CD IN ('01','03','04')
          AND    ( (D.EFC_ST_DT <= :RUN_TRM_ST_DT
                    AND D.EFC_CLS_DT >= :RUN_TRM_CLS_DT)
                  OR(D.EFC_ST_DT >= :RUN_TRM_ST_DT
                     AND D.EFC_CLS_DT <= :RUN_TRM_CLS_DT) ) /* �����������/�������� */
          AND    A.ROUT_CD LIKE :ROUT_CD  /* �뼱�ڵ� */
          AND    A.UP_DN_DV_CD LIKE :UP_DN_DV_CD   /*�����౸���ڵ�*/) A, 
         (SELECT A.YMGT_JOB_ID /* ���Ͱ����۾�ID */
                 ,A.RUN_DT /* �������� */
                 ,A.TRN_NO /* ������ȣ */
                 ,A.FCST_PRS_STT_CD /* ����ó�������ڵ� */
                 ,A.OTMZ_PRS_STT_CD /* ����ȭó�������ڵ� */
                 ,A.ITDC_SUPT_STT_CD /* �ǻ�������������ڵ� */
                 ,A.NON_NML_TRN_FLG /* ������������ */
                 ,A.RSV_SALE_TNSM_STT_CD /* ����߸����ۻ����ڵ� */
                 ,A.RSV_SALE_TNSM_DTTM /* ����߸������Ͻ� */
                 ,A.RSV_SALE_REFL_STT_CD /* ����߸Źݿ������ڵ� */
                 ,D.JOB_DTTM /* �۾��Ͻ� */
                 ,D.JOB_CLS_DTTM /* �۾������Ͻ� */
          FROM   TB_YYFD011 A,          /* ���Ͱ������������TBL */
                 TB_YYFB009 D                 /* ���Ͱ����۾�����⺻TBL */
          WHERE  (D.JOB_DTTM, A.RUN_DT, A.TRN_NO) IN(
                    SELECT   MAX(B.JOB_DTTM),
                             A.RUN_DT,
                             A.TRN_NO
                    FROM     (SELECT A.YMGT_JOB_ID /* ���Ͱ����۾�ID */
                                     ,A.RUN_DT /* �������� */
                                     ,A.TRN_NO /* ������ȣ */
                              FROM   TB_YYFD011 A /* ���Ͱ������������TBL */
                              WHERE  A.RUN_DT BETWEEN :RUN_TRM_ST_DT AND :RUN_TRM_CLS_DT
                              AND    (A.NON_NML_TRN_FLG = 'Y'
                                      OR A.NON_NML_TRN_FLG = 'N')
                              AND    (A.ITDC_SUPT_STT_CD IS NULL
                                      OR A.ITDC_SUPT_STT_CD = 'A'
                                      OR A.ITDC_SUPT_STT_CD = 'Y')                               /* �ʰ����ุ �������� ���� */
                                                           ) A,
                             (SELECT B.YMGT_JOB_ID /* ���Ͱ����۾�ID */
                                     ,B.JOB_DTTM /* �۾��Ͻ� */
                              FROM   TB_YYFB009 B    /* ���Ͱ����۾�����⺻TBL */
                              WHERE  B.REG_DTTM LIKE :JOB_DT || '%'
                              AND    B.ONLN_ARNG_DV_CD LIKE :ONLN_ARNG_DV_CD /* �¶��ι�ġ�����ڵ� */ ) B
                    WHERE    B.YMGT_JOB_ID = A.YMGT_JOB_ID
                    GROUP BY A.RUN_DT,
                             A.TRN_NO)
          AND    A.YMGT_JOB_ID = D.YMGT_JOB_ID
          AND    SUBSTR(A.REG_DTTM, 1, 8) = :JOB_DT) D
WHERE    A.RUN_DT = D.RUN_DT
AND      A.TRN_NO = D.TRN_NO
AND      (A.STLB_TRN_CLSF_CD, A.ROUT_CD, A.UP_DN_DV_CD, A.DPT_TM) IN(
            SELECT TRN_CLSF_CD        /* ���������ڵ�   */
                   ,ROUT_CD                                                                         /* �뼱�ڵ�       */
                   ,UP_DN_DV_CD                                                                       /* �����౸���ڵ� */
                   ,TMWD_DV_CD                                                                       /* �ð��뱸���ڵ� */
            FROM   TB_YYFD008 /* ���׷캰��������TBL */
            WHERE  USR_GP_ID IN(SELECT DISTINCT USR_GP_ID /* ����ڱ׷�ID */
                                 FROM            TB_YYFD007 /* ���׷캰����ڳ���TBL */
                                 WHERE           USR_ID LIKE :USR_ID)
            AND    STLB_TRN_CLSF_CD LIKE  :TRN_CLSF_CD
            AND    ROUT_CD LIKE :ROUT_CD
            AND    UP_DN_DV_CD LIKE :UP_DN_DV_CD)
ORDER BY RUN_DT,
         TRN_NO,
         YMS_APL_FLG DESC