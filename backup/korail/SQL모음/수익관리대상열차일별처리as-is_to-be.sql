<작업일자별 조회>
SELECT   D.YMS_JOB_ID,                                                                            /* 작업일시         */
         A.RUN_DT,                                                                                /* 운행일자         */
         LPAD(TO_NUMBER(A.TRN_NO), 5, ' ') TRN_NO,                                                /* 열차번호         */
         A.STTRM_OVRBK_ALLW_FLG,                                                                  /* 초과예약적용여부 */
         FN_YB_GETCOMMCDNM('T305', A.RUN_DV_CD, 1) RUN_DV_CD,                                     /* 운행구분코드     */
         DECODE( (SELECT 'Y'
                  FROM   TB_YP620
                  WHERE  RUN_DT = A.RUN_DT
                  AND    TRN_NO = A.TRN_NO
                  AND    ROWNUM = 1), NULL, A.YMS_APL_FLG, 'Y') YMS_APL_FLG,                        /* YMS상태        */
         A.RUN_INFO,                                                                              /* 운행역시각       */
         NVL(FN_YB_GETCOMMCDNM('Y003', D.FCST_PRS_STT_CD, 1), '미실행') FCST_PRS_STT,             /* 에측진행상태코드 */
         NVL(FN_YB_GETCOMMCDNM('Y004', D.OPTMZ_PRS_STT_CD, 1), '미실행') OPTMZ_PRS_STT,         /* 최적화진행상태코드 */
         NVL(FN_YB_GETCOMMCDNM('Y006', D.RS_TRNSM_STT_CD, 1), '미전송') RS_TRNSM_STT,             /* 예발전송상태코드 */
         A.YMS_ALC_PRS_STT_CD YMS_ALC_PRS_STT_CD,                                         /* 수익관리할당처리상태코드 */
         NVL(FN_YB_GETCOMMCDNM('Y007', D.RS_APL_STT_CD, 1), '미반영') RS_APL_STT,                 /* 예발반영상태코드 */
         A.TRN_CLSF_CD,
         A.ROUT_CD,
         A.UND_DV_CD,
         A.DPT_TM,
         SUBSTR(D.JOB_DTTM, 3, 12) JOB_DTTM,
         SUBSTR(D.JOB_CLS_DTTM, 3, 12) JOB_CLS_DTTM,
         A.TRN_NO TRN_NO_VAL,
         DPT_TM_VAL
FROM     (SELECT A.RUN_DT,                                                                        /* 운행일자         */
                 A.TRN_NO,                                                                        /* 열차번호         */
                 A.ROUT_CD,                                                                       /* 노선코드         */
                 A.UND_DV_CD,                                                                     /* 상하행구분코드   */
                 A.TRN_CLSF_CD,                                                                   /* 열차종별코드     */
                 A.STTRM_OVRBK_ALLW_FLG,                                                          /* 초과예약적용여부 */
                 A.RUN_DV_CD,                                                                     /* 운행구분코드     */
                 A.YMS_APL_FLG,                                                                   /* YMS적용여부      */
                 A.ORG_RS_STN_CD,                                                                 /* 출발예발역코드   */
                 A.TMN_RS_STN_CD,                                                                 /* 도착예발역코드   */
                 SUBSTR(B.DPT_TM, 1, 2) DPT_TM,                                                          /* 출발시각  */
                 B.DPT_TM DPT_TM_VAL,
                 FN_YB_GETRSVSALESTNNM(A.ORG_RS_STN_CD) ||
                 '-' ||
                 FN_YB_GETRSVSALESTNNM(A.TMN_RS_STN_CD) ||
                 '(' ||
                 TO_CHAR(TO_DATE(B.DPT_TM, 'HH24MISS'), 'HH24:MI') ||
                 '-' ||
                 TO_CHAR(TO_DATE(C.ARV_TM, 'HH24MISS'), 'HH24:MI') ||
                 ')' RUN_INFO,                                                                      /* 출발도착역시각 */
                 FN_YB_GETCOMMCDNM('Y010', NVL(E.YMS_ALC_PRS_STT_CD, 1), 1) YMS_ALC_PRS_STT_CD,
                 /* 수익관리할당처리상태코드 */
                 FN_YB_GETCOMMCDNM('Y010', NVL(E.EXCS_RSV_ALC_PRS_STT_CD, 1), 1) EXCS_RSV_ALC_PRS_STT_CD
          /* 초과예약할당처리상태코드 */
          FROM   TB_RD215 A,                                                                    /** 일일열차정보     **/
                 TB_RD225 B,                                                                    /** 일일열차운행시각 **/
                 TB_RD225 C,                                                                    /** 일일열차운행시각 **/
                 TB_SZ001 D,                                                                    /** 노선             **/
                 (SELECT RUN_DT,
                         TRN_NO,
                         YMS_ALC_PRS_STT_CD,
                         EXCS_RSV_ALC_PRS_STT_CD
                  FROM   TB_YB200 BB /**열차별할당처리**/
                  WHERE  ( (DECODE(PSRM_CL_CD || BKCLS_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) 
                           = (SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCLS_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) )
                              FROM   TB_YB200 X ,
                                     TB_RI630 Y /**BookingClass관리**/
                              WHERE  X.RUN_DT = BB.RUN_DT
                              AND    X.TRN_NO = BB.TRN_NO
                              AND    X.RUN_DT = Y.RUN_DT
                              AND    X.TRN_NO = Y.TRN_NO
                              AND    X.PSRM_CL_CD = Y.PSRM_CL_CD
                              AND    X.BKCLS_CD = Y.BKCLS_CD
                              AND    Y.BKCLS_USE_FLG ='Y')
                            AND PSRM_CL_CD IS NOT NULL)
                          OR PSRM_CL_CD IS NULL)
                  UNION ALL
                  SELECT DISTINCT A.RUN_DT,
                                  A.TRN_NO,
                                  B.YMS_ALC_PRS_STT_CD,
                                  B.EXCS_RSV_ALC_PRS_STT_CD
                  FROM            TB_RD215 A, /**일일열차정보 TBL**/
                                  TB_YB210 B, /**노선별할당처리 TBL**/
                                  TB_RB715 C /**Calendar TBL**/
                  WHERE           A.ROUT_CD = B.ROUT_CD
                  AND             A.UND_DV_CD = B.UND_DV_CD
                  AND             B.TRN_CLSF_CD LIKE :AS_TRN_CLSF
                  AND             B.BIZ_DD_STG_CD = C.BIZ_DD_STG_CD
                  AND             A.RUN_DT = C.RUN_DT
                  AND             A.RUN_DT BETWEEN B.APL_RUN_ST_DT AND B.APL_RUN_CLS_DT
                  AND             NOT EXISTS(SELECT '1'
                                             FROM   TB_YB200 BB /**열차별할당처리 TBL**/
                                             WHERE  RUN_DT = A.RUN_DT
                                             AND    TRN_NO = A.TRN_NO
                                             AND    ( (DECODE(PSRM_CL_CD || BKCLS_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) 
                                                      = (SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCLS_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) )
                                                           FROM   TB_YB200 X, TB_RI630 Y
                                                           WHERE  X.RUN_DT = BB.RUN_DT
                                                           AND    X.TRN_NO = BB.TRN_NO
                                                           AND    X.RUN_DT = Y.RUN_DT
                                                           AND    X.TRN_NO = Y.TRN_NO
                                                           AND    X.PSRM_CL_CD = Y.PSRM_CL_CD
                                                           AND    X.BKCLS_CD = Y.BKCLS_CD
                                                           AND    Y.BKCLS_USE_FLG = 'Y')
                                                       AND PSRM_CL_CD IS NOT NULL)
                                                     OR PSRM_CL_CD IS NULL) ) ) E
          WHERE  A.RUN_DT = B.RUN_DT
          AND    A.TRN_NO = B.TRN_NO
          AND    A.TRN_CLSF_CD LIKE :AS_TRN_CLSF  /* 열차종별코드 */
          AND    A.ORG_RS_STN_CD = B.STOP_RS_STN_CD
          AND    A.RUN_DT = C.RUN_DT
          AND    A.TRN_NO = C.TRN_NO
          AND    A.TMN_RS_STN_CD = C.STOP_RS_STN_CD
          AND    A.ROUT_CD = D.ROUT_CD
          AND    A.RUN_DT = E.RUN_DT(+)
          AND    A.TRN_NO = E.TRN_NO(+)
          AND    A.RUN_DT BETWEEN :AS_RUN_DT_FROM AND :AS_RUN_DT_TO /* 운행기간 */
          AND    D.MN_RUN_LN_CD LIKE :AS_LN_CD  /* 주운행선코드 */
          AND    D.MN_RUN_LN_CD IN ('01','03','04')
          AND    ( (D.EFC_ST_DT <= :AS_RUN_DT_FROM
                    AND D.EFC_CLS_DT >= :AS_RUN_DT_TO)
                  OR(D.EFC_ST_DT >= :AS_RUN_DT_FROM
                     AND D.EFC_CLS_DT <= :AS_RUN_DT_TO) )
          AND    A.ROUT_CD LIKE :AS_ROUT_CD  /* 노선코드 */
          AND    A.UND_DV_CD LIKE :AS_UND_DV_CD   /*상하행구분코드*/) A, 
         (SELECT A.YMS_JOB_ID YMS_JOB_ID,                                                     /* 수익관리작업ID       */
                 A.RUN_DT,                                                                    /* 운행일자             */
                 A.TRN_NO,                                                                    /* 열차번호             */
                 A.FCST_PRS_STT_CD,                                                           /* 에측진행상태코드     */
                 A.OPTMZ_PRS_STT_CD,                                                          /* 최적화진행상태코드   */
                 A.DS_STT_CD,                                           /* 초과예약적용상태코드(의사결정지원상태코드) */
                 A.ABNRM_TRN_FLG,                                                             /* 비정상열차여부       */
                 A.RS_TRNSM_STT_CD,                                                           /* 예발전송상태코드     */
                 A.RSV_SALE_TRNSM_DTTM,                                                       /* 예약발매전송일시     */
                 A.RS_APL_STT_CD,                                                             /* 예발반영상태코드     */
                 D.JOB_DTTM,
                 D.JOB_CLS_DTTM
          FROM   TB_YZ930 A,                                                                    /** 수익관리대상열차 **/
                 TB_YZ910 D                 /**수익관리작업결과**/
          WHERE  (D.JOB_DTTM, A.RUN_DT, A.TRN_NO) IN(
                    SELECT   MAX(B.JOB_DTTM),
                             A.RUN_DT,
                             A.TRN_NO
                    FROM     (SELECT A.YMS_JOB_ID,
                                     A.RUN_DT,
                                     A.TRN_NO
                              FROM   TB_YZ930 A                                                 /** 수익관리대상열차 **/
                              WHERE  A.RUN_DT BETWEEN :AS_RUN_DT_FROM AND :AS_RUN_DT_TO
                              AND    (A.ABNRM_TRN_FLG = 'Y'
                                      OR A.ABNRM_TRN_FLG = 'N')
                              AND    (A.DS_STT_CD IS NULL
                                      OR A.DS_STT_CD = 'A'
                                      OR A.DS_STT_CD = 'Y')                               /* 초과예약만 돌린열차 제외 */
                                                           ) A,
                             (SELECT B.YMS_JOB_ID,
                                     B.JOB_DTTM
                              FROM   TB_YZ910 B                                                 /** 수익관리작업결과 **/
                              WHERE  B.REG_DTTM LIKE :AS_WRK_DT || '%'
                              AND    B.ONLN_LUMP_DV LIKE :AS_ONLN_LUMP_DV /*온라인 배치구분*/ ) B
                    WHERE    B.YMS_JOB_ID = A.YMS_JOB_ID
                    GROUP BY A.RUN_DT,
                             A.TRN_NO)
          AND    A.YMS_JOB_ID = D.YMS_JOB_ID
          AND    SUBSTR(A.REG_DTTM, 1, 8) = :AS_WRK_DT) D
WHERE    A.RUN_DT = D.RUN_DT
AND      A.TRN_NO = D.TRN_NO
AND      (A.TRN_CLSF_CD, A.ROUT_CD, A.UND_DV_CD, A.DPT_TM) IN(
            SELECT TRN_CLSF_CD,                                                                     /* 열차종별코드   */
                   ROUT_CD,                                                                         /* 노선코드       */
                   UND_DV_CD,                                                                       /* 상하행구분코드 */
                   TMWD_DV_CD                                                                       /* 시간대구분코드 */
            FROM   TB_YZ950                                                                       /** 담당그룹별열차 **/
            WHERE  CG_GRUP_ID IN(SELECT DISTINCT CG_GRUP_ID                                             /* 담당그룹ID */
                                 FROM            TB_YZ970                                         /** 담당그룹사용자 **/
                                 WHERE           USE_PS_ID LIKE :AS_CHG)
            AND    TRN_CLSF_CD LIKE :AS_TRN_CLSF
            AND    ROUT_CD LIKE :AS_ROUT_CD
            AND    UND_DV_CD LIKE :AS_UND_DV_CD)
ORDER BY RUN_DT,
         TRN_NO,
         YMS_APL_FLG DESC

===============================================================================================================
<운행일자별 조회>
SELECT   D.YMS_JOB_ID YMS_JOB_ID,
         SUBSTR(D.YMS_JOB_ID, 10, 8) WRK_DT,
         A.RUN_DT,
         LPAD(TO_NUMBER(A.TRN_NO), 5, ' ') TRN_NO,
         A.STTRM_OVRBK_ALLW_FLG,
         FN_YB_GETCOMMCDNM('T305', A.RUN_DV_CD, 1) RUN_DV_CD,
         DECODE( (SELECT 'Y'
                  FROM   TB_YP620
                  WHERE  RUN_DT = A.RUN_DT
                  AND    TRN_NO = A.TRN_NO
                  AND    ROWNUM = 1), NULL, A.YMS_APL_FLG, 'Y') YMS_APL_FLG,                        /* YMS상태        */
         A.RUN_INFO,
         NVL(FN_YB_GETCOMMCDNM('Y003', D.FCST_PRS_STT_CD, 1), '미실행') FCST_PRS_STT,             /* 에측진행상태코드 */
         NVL(FN_YB_GETCOMMCDNM('Y004', D.OPTMZ_PRS_STT_CD, 1), '미실행') OPTMZ_PRS_STT,         /* 최적화진행상태코드 */
         NVL(FN_YB_GETCOMMCDNM('Y006', D.RS_TRNSM_STT_CD, 1), '미전송') RS_TRNSM_STT,             /* 예발전송상태코드 */
         A.YMS_ALC_PRS_STT_CD YMS_ALC_PRS_STT_CD,                                         /* 수익관리할당처리상태코드 */
         NVL(FN_YB_GETCOMMCDNM('Y007', D.RS_APL_STT_CD, 1), '미반영') RS_APL_STT,                 /* 예발반영상태코드 */
         SUBSTR(D.JOB_DTTM, 3, 12) JOB_DTTM,
         SUBSTR(D.JOB_CLS_DTTM, 3, 12) JOB_CLS_DTTM,
         A.TRN_NO TRN_NO_VAL,
         A.DPT_TM_VAL,
         /*아래 4개 변수는 열차재작업에 필요한 것임 d_ys11110_1 참조*/
         A.TRN_CLSF_CD,
         A.ROUT_CD,
         A.UND_DV_CD,
         A.DPT_TM
FROM     (SELECT   A.RUN_DT,
                   A.TRN_NO,
                   A.ROUT_CD,
                   A.UND_DV_CD,
                   A.TRN_CLSF_CD,
                   A.STTRM_OVRBK_ALLW_FLG,
                   A.RUN_DV_CD,
                   A.YMS_APL_FLG,
                   A.ORG_RS_STN_CD,
                   A.TMN_RS_STN_CD,
                   SUBSTR(B.DPT_TM, 1, 2) DPT_TM,
                   B.DPT_TM DPT_TM_VAL,
                   FN_YB_GETRSVSALESTNNM(A.ORG_RS_STN_CD) ||
                   '-' ||
                   FN_YB_GETRSVSALESTNNM(A.TMN_RS_STN_CD) ||
                   '(' ||
                   TO_CHAR(TO_DATE(B.DPT_TM, 'hh24miss'), 'hh24:mi') ||
                   '-' ||
                   TO_CHAR(TO_DATE(C.ARV_TM, 'hh24miss'), 'hh24:mi') ||
                   ')' RUN_INFO,
                   FN_YB_GETCOMMCDNM('Y010', NVL(E.YMS_ALC_PRS_STT_CD, 1), 1) YMS_ALC_PRS_STT_CD
                                                                                          /* 수익관리할당처리상태코드 */
          FROM     TB_RD215 A,
                   TB_RD225 B,
                   TB_RD225 C,
                   TB_SZ001 D,
                   (SELECT BB.RUN_DT,
                           BB.TRN_NO,
                           BB.YMS_ALC_PRS_STT_CD,
                           BB.EXCS_RSV_ALC_PRS_STT_CD
                    FROM   TB_YB200 BB
                    WHERE  ( (DECODE(PSRM_CL_CD || BKCLS_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0)
                             = (SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCLS_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) )
                                           FROM   TB_YB200 X,
                                                  TB_RI630 Y
                                           WHERE  X.RUN_DT = BB.RUN_DT
                                           AND    X.TRN_NO = BB.TRN_NO
                                           AND    X.RUN_DT = Y.RUN_DT
                                           AND    X.TRN_NO = Y.TRN_NO 
                                           AND    X.PSRM_CL_CD = Y.PSRM_CL_CD
                                           AND    X.BKCLS_CD = Y.BKCLS_CD
                                           AND    Y.BKCLS_USE_FLG = 'Y')
                              AND PSRM_CL_CD IS NOT NULL)
                            OR PSRM_CL_CD IS NULL)
                    UNION ALL
                    SELECT DISTINCT A.RUN_DT,
                                    A.TRN_NO,
                                    B.YMS_ALC_PRS_STT_CD,
                                    B.EXCS_RSV_ALC_PRS_STT_CD
                    FROM            TB_RD215 A,
                                    TB_YB210 B,
                                    TB_RB715 C
                    WHERE           A.ROUT_CD = B.ROUT_CD
                    AND             A.UND_DV_CD = B.UND_DV_CD
                    AND             A.TRN_CLSF_CD LIKE :AS_TRN_CLSF
                    AND             B.BIZ_DD_STG_CD = C.BIZ_DD_STG_CD
                    AND             A.RUN_DT = C.RUN_DT
                    AND             A.RUN_DT BETWEEN B.APL_RUN_ST_DT AND B.APL_RUN_CLS_DT
                    AND             NOT EXISTS(SELECT '1'
                                               FROM   TB_YB200 BB
                                               WHERE  RUN_DT = A.RUN_DT
                                               AND    TRN_NO = A.TRN_NO
                                               AND    ( (DECODE(PSRM_CL_CD || BKCLS_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) 
                                                        = (SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCLS_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) )
                                                             FROM   TB_YB200 X , TB_RI630 Y
                                                             WHERE  X.RUN_DT = BB.RUN_DT
                                                             AND    X.TRN_NO = BB.TRN_NO
                                                             AND    X.RUN_DT = Y.RUN_DT
                                                             AND    X.TRN_NO = Y.TRN_NO 
                                                             AND    X.PSRM_CL_CD = Y.PSRM_CL_CD
                                                             AND    X.BKCLS_CD = Y.BKCLS_CD
                                                             AND    Y.BKCLS_USE_FLG = 'Y')
                                                         AND PSRM_CL_CD IS NOT NULL)
                                                       OR PSRM_CL_CD IS NULL) ) ) E
          WHERE    A.RUN_DT = B.RUN_DT
          AND      A.TRN_NO = B.TRN_NO
          AND      A.TRN_CLSF_CD LIKE :AS_TRN_CLSF
          AND      A.ORG_RS_STN_CD = B.STOP_RS_STN_CD
          AND      A.RUN_DT = C.RUN_DT
          AND      A.TRN_NO = C.TRN_NO
          AND      A.TMN_RS_STN_CD = C.STOP_RS_STN_CD
          AND      A.ROUT_CD = D.ROUT_CD
          AND      D.EFC_ST_DT <= :AS_RUN_DT
          AND      D.EFC_ST_DT <= :AS_RUN_DT
          AND      A.RUN_DT = E.RUN_DT(+)
          AND      A.TRN_NO = E.TRN_NO(+)
          AND      A.RUN_DT = :AS_RUN_DT
          AND      D.MN_RUN_LN_CD LIKE :AS_LN_CD
          AND      D.MN_RUN_LN_CD IN ('01','03','04')
          AND      A.ROUT_CD LIKE :AS_ROUT_CD
          AND      A.UND_DV_CD LIKE :AS_UND_DV_CD
          AND      A.TRN_NO LIKE :AS_TRN_NO
          ORDER BY A.RUN_DT,
                   A.TRN_NO) A,
         (SELECT   A.YMS_JOB_ID,
                   A.RUN_DT,
                   A.TRN_NO,
                   A.FCST_PRS_STT_CD,
                   A.OPTMZ_PRS_STT_CD,
                   A.DS_STT_CD,
                   A.ABNRM_TRN_FLG,
                   A.RS_TRNSM_STT_CD,
                   A.RSV_SALE_TRNSM_DTTM,
                   A.RS_APL_STT_CD,
                   D.JOB_DTTM,
                   D.JOB_CLS_DTTM
          FROM     TB_YZ930 A,
                   TB_YZ910 D
          WHERE    (D.JOB_DTTM, A.RUN_DT, A.TRN_NO) IN(SELECT   MAX(B.JOB_DTTM),
                                                                A.RUN_DT,
                                                                A.TRN_NO
                                                       FROM     (SELECT A.YMS_JOB_ID,
                                                                        A.RUN_DT,
                                                                        A.TRN_NO
                                                                 FROM   TB_YZ930 A              /** 수익관리대상열차 **/
                                                                 WHERE  A.RUN_DT = :AS_RUN_DT
                                                                 AND    (A.ABNRM_TRN_FLG = 'Y'
                                                                         OR A.ABNRM_TRN_FLG = 'N')
                                                                 AND    (A.DS_STT_CD IS NULL
                                                                         OR A.DS_STT_CD = 'A'
                                                                         OR A.DS_STT_CD = 'Y')
                                                                 AND    A.TRN_NO LIKE :AS_TRN_NO) A,
                                                                (SELECT B.YMS_JOB_ID,
                                                                        B.JOB_DTTM
                                                                 FROM   TB_YZ910 B              /** 수익관리작업결과 **/
                                                                                  ) B
                                                       WHERE    B.YMS_JOB_ID = A.YMS_JOB_ID
                                                       GROUP BY A.RUN_DT,
                                                                A.TRN_NO)
          AND      A.YMS_JOB_ID = D.YMS_JOB_ID
          ORDER BY A.RUN_DT,
                   A.TRN_NO) D
WHERE    A.RUN_DT = D.RUN_DT
AND      A.TRN_NO = D.TRN_NO
AND      (A.TRN_CLSF_CD, A.ROUT_CD, A.UND_DV_CD, A.DPT_TM) IN(
            SELECT TRN_CLSF_CD,
                   ROUT_CD,
                   UND_DV_CD,
                   TMWD_DV_CD
            FROM   TB_YZ950
            WHERE  CG_GRUP_ID IN(SELECT DISTINCT CG_GRUP_ID
                                 FROM            TB_YZ970
                                 WHERE           USE_PS_ID LIKE :AS_CHG)
            AND    TRN_CLSF_CD LIKE :AS_TRN_CLSF
            AND    ROUT_CD LIKE :AS_ROUT_CD
            AND    UND_DV_CD LIKE :AS_UND_DV_CD)
ORDER BY A.RUN_DT,
         A.TRN_NO
================================================================================================

TO_BE
<작업일자별 조회>
<![CDATA[
        SELECT /*+ com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnJobDt */
               D.YMGT_JOB_ID                                            AS YMGT_JOB_ID              /* 수익관리작업ID                         */
              ,A.RUN_DT                                                 AS RUN_DT                   /* 운행일자                         */
              ,LPAD(TO_NUMBER(A.TRN_NO), 5, ' ')                        AS TRN_NO                   /* 열차번호(앞0뺀거)                   */
              ,A.SHTM_EXCS_RSV_ALLW_FLG                                 AS SHTM_EXCS_RSV_ALLW_FLG   /* 단기초과예약허용여부                   */
              ,A.RUN_DV_CD                                              AS RUN_DV_CD                /* 운행구분코드                       */
              ,DECODE(( SELECT 'Y'
                          FROM  TB_YYPD006 /* YMS할당결과내역TBL */
                         WHERE  RUN_DT = A.RUN_DT
                           AND  TRN_NO = A.TRN_NO
                           AND  ROWNUM = 1), NULL, A.YMS_APL_FLG, 'Y')  AS YMS_APL_FLG              /* YMS적용여부                      */
              ,A.RUN_INFO                                               AS RUN_INFO                 /* 운행구간                         */
              ,D.FCST_PRS_STT_CD                                        AS FCST_PRS_STT_CD          /* 예측처리상태코드(NULL이면 '미실행')   */
              ,D.OTMZ_PRS_STT_CD                                        AS OTMZ_PRS_STT_CD          /* 최적화처리상태코드(NULL이면 '미실행')  */
              ,D.RSV_SALE_TNSM_STT_CD                                   AS RSV_SALE_TNSM_STT_CD     /* 예발전송상태코드(NULL이면 '미전송')   */
              ,A.ALC_PRS_STT_CD                                         AS ALC_PRS_STT_CD           /* 수익관리할당처리상태코드                 */
              ,NVL(D.RSV_SALE_REFL_STT_CD, 'N1')                        AS RSV_SALE_REFL_STT_CD     /* 예발반영상태코드                     */
              ,A.STLB_TRN_CLSF_CD                                       AS TRN_CLSF_CD              /* 열차종별코드                       */
              ,A.ROUT_CD                                                AS ROUT_CD                  /* 노선코드                             */
              ,A.UP_DN_DV_CD                                            AS UP_DN_DV_CD              /* 상하행구분코드                      */
              ,A.DPT_TM                                                 AS DPT_TM                   /* 출발시각                             */
              ,SUBSTR(D.JOB_DTTM, 3, 12)                                AS JOB_DTTM                 /* 작업일시                         */
              ,SUBSTR(D.JOB_CLS_DTTM, 3, 12)                            AS JOB_CLS_DTTM             /* 작업종료일시                       */
              ,A.TRN_NO                                                 AS TRN_NO_VAL               /* 열차번호 원데이터                    */
              ,DPT_TM_VAL                                               AS DPT_TM_VAL               /* 출발시각 원데이터                    */
          FROM ( SELECT A.RUN_DT                        AS RUN_DT                   /* 운행일자             */
                       ,A.TRN_NO                        AS TRN_NO                   /* 열차번호             */
                       ,A.ROUT_CD                       AS ROUT_CD                  /* 노선코드             */
                       ,A.UP_DN_DV_CD                   AS UP_DN_DV_CD              /* 상하행구분코드      */
                       ,A.STLB_TRN_CLSF_CD              AS STLB_TRN_CLSF_CD         /* 열차종별코드           */
                       ,A.SHTM_EXCS_RSV_ALLW_FLG        AS SHTM_EXCS_RSV_ALLW_FLG   /* 단기초과예약허용여부   */
                       ,A.RUN_DV_CD                     AS RUN_DV_CD                /* 운행구분코드       */
                       ,A.YMS_APL_FLG                   AS YMS_APL_FLG              /* YMS적용여부      */
                       ,A.ORG_RS_STN_CD                 AS ORG_RS_STN_CD            /* 시발예발역코드      */
                       ,A.TMN_RS_STN_CD                 AS TMN_RS_STN_CD            /* 종착예발역코드      */
                       ,SUBSTR(B.DPT_TM, 1, 2)          AS DPT_TM                   /* 출발시각             */
                       ,B.DPT_TM                        AS DPT_TM_VAL               /* 출발시각값            */
                       ,( SELECT Y.KOR_STN_NM /* 한글역명    */
                            FROM TB_YYDK001 X /* 예발역코드TBL */
                                ,TB_YYDK102 Y /* 역코드이력TBL */
                           WHERE X.RS_STN_CD = A.ORG_RS_STN_CD
                             AND X.STN_CD = Y.STN_CD
                             AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                      || '-' 
                      || ( SELECT Y.KOR_STN_NM /* 한글역명 */
                             FROM TB_YYDK001 X /* 예발역코드TBL */
                                 ,TB_YYDK102 Y /* 역코드이력TBL */
                            WHERE X.RS_STN_CD = A.TMN_RS_STN_CD
                              AND X.STN_CD = Y.STN_CD
                              AND TO_CHAR(SYSDATE,'YYYYMMDD') BETWEEN Y.APL_ST_DT AND Y.APL_CLS_DT)
                      || '('
                      || TO_CHAR(TO_DATE(B.DPT_TM, 'HH24MISS'), 'HH24:MI')
                      || '-'
                      || TO_CHAR(TO_DATE(C.ARV_TM, 'HH24MISS'), 'HH24:MI')
                      || ')'                                AS RUN_INFO                 /* 출발도착역시각          */
                       ,NVL(E.ALC_PRS_STT_CD, 1)            AS ALC_PRS_STT_CD           /* 할당처리상태코드         */
                       ,NVL(E.EXCS_RSV_ALC_PRS_STT_CD, 1)   AS EXCS_RSV_ALC_PRS_STT_CD  /* 초과예약할당처리상태코드     */
                  FROM TB_YYDK301 A /* 열차기본TBL */
                      ,TB_YYDK302 B /* 열차운행내역TBL */
                      ,TB_YYDK302 C /* 열차운행내역TBL */
                      ,TB_YYDK201 D /* 노선코드TBL */
                      ,( SELECT RUN_DT                  /* 운행일자                 */
                               ,TRN_NO                  /* 열차번호                 */
                               ,ALC_PRS_STT_CD          /* 할당처리상태코드         */
                               ,EXCS_RSV_ALC_PRS_STT_CD /* 초과예약할당처리상태코드     */
                           FROM TB_YYBB004 BB           /* 열차별할당기본TBL       */
                          WHERE ((DECODE(PSRM_CL_CD || BKCL_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) 
                                   = ( SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCL_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) )
                                         FROM TB_YYBB004 X /* 열차별할당기본TBL        */
                                             ,TB_YYDK309 Y /* 부킹클래스적용내역TBL  */
                                        WHERE X.RUN_DT          = BB.RUN_DT
                                          AND X.TRN_NO          = BB.TRN_NO
                                          AND X.RUN_DT          = Y.RUN_DT
                                          AND X.TRN_NO          = Y.TRN_NO
                                          AND X.PSRM_CL_CD      = Y.PSRM_CL_CD
                                          AND X.BKCL_CD         = Y.BKCL_CD
                                          AND Y.BKCL_USE_FLG    ='Y')
                                    AND PSRM_CL_CD      IS NOT NULL) /* END DECODE */
                             OR PSRM_CL_CD IS NULL)
                          UNION ALL
                         SELECT DISTINCT A.RUN_DT                   /* 열차번호                     */
                                        ,A.TRN_NO                   /* 운행일자                     */
                                        ,B.YMGT_ALC_PRS_STT_CD      /* 할당처리상태코드             */
                                        ,B.EXCS_RSV_ALC_PRS_STT_CD  /* 초과예약할당처리상태코드         */
                          FROM TB_YYDK301 A                         /* 열차기본TBL              */
                              ,TB_YYBB005 B                         /* 노선별할당기본TBL           */
                              ,TB_YYDK003 C                         /* 열차운영사업자카렌다내역 TBL     */
                         WHERE A.ROUT_CD = B.ROUT_CD                /* 노선코드                     */
                           AND A.UP_DN_DV_CD = B.UP_DN_DV_CD        /* 상행하행구분코드             */
                           AND B.TRN_CLSF_CD LIKE #TRN_CLSF_CD#     /* 열차종별코드               */
                           AND B.BIZ_DD_STG_CD = C.BIZ_DD_STG_CD    /* 영업일단계코드              */
                           AND A.RUN_DT = C.RUN_DT
                           AND A.RUN_DT BETWEEN B.APL_ST_DT AND B.APL_CLS_DT
                           AND NOT EXISTS( SELECT '1'
                                             FROM TB_YYBB004 BB /* 열차별할당기본TBL */
                                            WHERE RUN_DT = A.RUN_DT
                                              AND TRN_NO = A.TRN_NO
                                              AND ( (DECODE(PSRM_CL_CD || BKCL_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) 
                                                   = ( SELECT MIN(DECODE(X.PSRM_CL_CD || X.BKCL_CD,'1F1', 1,'1C1', 2,'1R1', 3,'1R2', 4,'1R3', 5,'2F1', 6,'2C1', 7,'2R1', 8,'2R2', 9,'2R3', 10,0) )
                                                         FROM TB_YYBB004 X /* 열차별할당기본TBL */
                                                             ,TB_YYDK309 Y /* 부킹클래스적용내역TBL */
                                                        WHERE X.RUN_DT          = BB.RUN_DT
                                                          AND X.TRN_NO          = BB.TRN_NO
                                                          AND X.RUN_DT          = Y.RUN_DT
                                                          AND X.TRN_NO          = Y.TRN_NO
                                                          AND X.PSRM_CL_CD      = Y.PSRM_CL_CD
                                                          AND X.BKCL_CD         = Y.BKCL_CD
                                                          AND Y.BKCL_USE_FLG    = 'Y')
                                                     AND PSRM_CL_CD IS NOT NULL)
                                               OR PSRM_CL_CD IS NULL) ) ) E
         WHERE A.RUN_DT             = B.RUN_DT
           AND A.TRN_NO             = B.TRN_NO
           AND A.STLB_TRN_CLSF_CD   LIKE #TRN_CLSF_CD#  /* 열차종별코드 */
           AND A.ORG_RS_STN_CD      = B.STOP_RS_STN_CD  /* 시발예발역코드 */
           AND A.RUN_DT             = C.RUN_DT
           AND A.TRN_NO             = C.TRN_NO
           AND A.TMN_RS_STN_CD      = C.STOP_RS_STN_CD
           AND A.ROUT_CD            = D.ROUT_CD
           AND A.RUN_DT             = E.RUN_DT(+)
           AND A.TRN_NO             = E.TRN_NO(+)
           AND A.RUN_DT             BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT# /* 운행기간 */
           AND (#MRNT_CD# IS NULL   OR D.MRNT_CD = #MRNT_CD#)  /* 주운행선코드 */
           AND D.MRNT_CD            IN ('01','03','04')
           AND ( (D.EFC_ST_DT <= #RUN_TRM_ST_DT#
                  AND D.EFC_CLS_DT >= #RUN_TRM_CLS_DT#)
               OR(D.EFC_ST_DT >= #RUN_TRM_ST_DT#
                  AND D.EFC_CLS_DT <= #RUN_TRM_CLS_DT#) ) /* 시행시작일자/종료일자 */
           AND (#ROUT_CD# IS NULL   OR A.ROUT_CD = #ROUT_CD#)  /* 노선코드 */
           AND (#UP_DN_DV_CD# = 'A' OR A.UP_DN_DV_CD = #UP_DN_DV_CD#)   /*상하행구분코드*/
           ) A, 
         ( SELECT A.YMGT_JOB_ID             /* 수익관리작업ID             */
                 ,A.RUN_DT                  /* 운행일자                 */
                 ,A.TRN_NO                  /* 열차번호                 */
                 ,A.FCST_PRS_STT_CD         /* 예측처리상태코드         */
                 ,A.OTMZ_PRS_STT_CD         /* 최적화처리상태코드        */
                 ,A.ITDC_SUPT_STT_CD        /* 의사결정지원상태코드       */
                 ,A.NON_NML_TRN_FLG         /* 비정상열차여부          */
                 ,A.RSV_SALE_TNSM_STT_CD    /* 예약발매전송상태코드       */
                 ,A.RSV_SALE_TNSM_DTTM      /* 예약발매전송일시         */
                 ,A.RSV_SALE_REFL_STT_CD    /* 예약발매반영상태코드       */
                 ,D.JOB_DTTM                /* 작업일시                 */
                 ,D.JOB_CLS_DTTM            /* 작업종료일시           */
            FROM  TB_YYFD011 A              /* 수익관리대상열차내역TBL    */
                 ,TB_YYFB009 D              /* 수익관리작업결과기본TBL    */
          WHERE  (D.JOB_DTTM, A.RUN_DT, A.TRN_NO) IN(
                    SELECT MAX(B.JOB_DTTM)
                          ,A.RUN_DT
                          ,A.TRN_NO
                      FROM ( SELECT A.YMGT_JOB_ID   /* 수익관리작업ID */
                                   ,A.RUN_DT        /* 운행일자         */
                                   ,A.TRN_NO        /* 열차번호         */
                               FROM TB_YYFD011 A    /* 수익관리대상열차내역TBL */
                              WHERE A.RUN_DT BETWEEN #RUN_TRM_ST_DT# AND #RUN_TRM_CLS_DT#
                                AND (A.NON_NML_TRN_FLG = 'Y' OR A.NON_NML_TRN_FLG = 'N')
                                AND (A.ITDC_SUPT_STT_CD IS NULL
                                      OR A.ITDC_SUPT_STT_CD = 'A'
                                      OR A.ITDC_SUPT_STT_CD = 'Y')                               /* 초과예약만 돌린열차 제외 */
                                                           ) A,
                           ( SELECT B.YMGT_JOB_ID /* 수익관리작업ID */
                                   ,B.JOB_DTTM /* 작업일시 */
                               FROM TB_YYFB009 B    /* 수익관리작업결과기본TBL */
                              WHERE B.REG_DTTM LIKE #JOB_DT# || '%'
                                AND (#ONLN_ARNG_DV_CD# IS NULL OR B.ONLN_ARNG_DV_CD = #ONLN_ARNG_DV_CD#) /* 온라인배치구분코드 */ 
                              ) B
                     WHERE B.YMGT_JOB_ID = A.YMGT_JOB_ID
                     GROUP BY A.RUN_DT,
                             A.TRN_NO)
            AND A.YMGT_JOB_ID = D.YMGT_JOB_ID
            AND A.REG_DTTM LIKE #JOB_DT# || '%'
                ) D
        WHERE A.RUN_DT = D.RUN_DT
          AND A.TRN_NO = D.TRN_NO
          AND (A.STLB_TRN_CLSF_CD, A.ROUT_CD, A.UP_DN_DV_CD, A.DPT_TM) IN(
                SELECT TRN_CLSF_CD  /* 열차종별코드       */
                      ,ROUT_CD      /* 노선코드         */
                      ,UP_DN_DV_CD  /* 상하행구분코드  */
                      ,TMWD_DV_CD   /* 시간대구분코드  */
                  FROM TB_YYFD008   /* 담당그룹별열차내역TBL */
            WHERE USR_GP_ID IN( SELECT DISTINCT USR_GP_ID /* 사용자그룹ID */
                                  FROM TB_YYFD007 /* 담당그룹별사용자내역TBL */
                                 WHERE (#USR_ID# IS NULL OR USR_ID = #USR_ID#)
                               )
              AND STLB_TRN_CLSF_CD =  #TRN_CLSF_CD#
              AND (#ROUT_CD# IS NULL OR ROUT_CD = #ROUT_CD#)
              AND (#UP_DN_DV_CD# = 'A' OR UP_DN_DV_CD = #UP_DN_DV_CD#)
            )
        ORDER BY RUN_DT,
                 TRN_NO,
                 YMS_APL_FLG DESC

]]>
