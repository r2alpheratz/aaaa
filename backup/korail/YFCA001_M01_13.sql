  SELECT /*+com.korail.yz.yf.ca.YFCA001QMDAO.selectListPeriExpPssr*/
        DISTINCT A.RUN_DT AS RUN_DT
                ,LPAD (LTRIM(A.TRN_NO, '0'), 5, ' ') AS TRN_NO
                ,A.PSRM_CL_CD
                ,A.DPT_STGP_CD
                ,A.ARV_STGP_CD
                , (SELECT VLID_VAL_KOR_AVVR_NM
                     FROM TB_YYDK007
                    WHERE XROIS_OLD_SRT_CD = 'Y019'
                      AND VLID_VAL = A.DPT_STGP_CD)
                     DPT_STGP_NM
                , (SELECT VLID_VAL_KOR_AVVR_NM
                     FROM TB_YYDK007
                    WHERE XROIS_OLD_SRT_CD = 'Y019'
                      AND VLID_VAL = A.ARV_STGP_CD)
                     ARV_STGP_NM
                ,B.SUM_ABRD_PRNB
                , (SELECT KOR_STN_NM
                     FROM TB_YYDK001
                    WHERE RS_STN_CD = A.DPT_RS_STN_CD)
                     AS DPT_RS_STN_NM
                ,A.DPT_TM AS DPT_TM
                , /* 출발시각 */
                  (SELECT KOR_STN_NM
                     FROM TB_YYDK001
                    WHERE RS_STN_CD = A.ARV_RS_STN_CD)
                     AS ARV_RS_STN_NM
                ,A.ABRD_PRNB
                ,A.DPT_STN_CONS_ORDR
                ,A.ARV_STN_CONS_ORDR
                ,A.YMGT_JOB_ID
                ,A.DPT_ORDR
                ,A.ARV_ORDR
                ,A.FCST_ACHV_DT
                /*,A.REG_USR_ID*/
                /*,A.CHG_USR_ID*/
                ,A.TRN_NO
    FROM (  SELECT /*+ RULE */
           A.RUN_DT
                  ,A.TRN_NO
                  ,A.PSRM_CL_CD
                  , /* 객실등급코드 */
                   A.DPT_STN_CONS_ORDR
                  ,C.DPT_TM
                  , /* 출발시각      */
                   A.ARV_STN_CONS_ORDR
                  ,B.DPT_RS_STN_CD
                  ,B.ARV_RS_STN_CD
                  ,SUM (A.USR_CTL_EXPN_DMD_NUM) ABRD_PRNB
                  , /* 사용자조정예상수요수 */
                   A.YMGT_JOB_ID
                  , /* 수익관리작업ID */
                   A.FCST_ACHV_DT
                  ,C.RUN_ORDR DPT_ORDR
                  ,D.RUN_ORDR ARV_ORDR
                  ,B.DPT_STGP_CD
                  ,B.ARV_STGP_CD
                 /* ,A.REG_USR_ID */
                 /* ,A.CHG_USR_ID */
              FROM TB_YYFD410 A                  , /* 최종탑승예측수요내역TBL */
                   TB_YYDD505 B                  , /* 열차구간내역TBL */
                   TB_YYDK302 C                  , /* 열차운행내역TBL */
                   TB_YYDK302 D                  , /* 열차운행내역TBL */
                   TB_YYDK002 E                  , /* 카렌다내역TBL */
                   TB_YYDK301 F /* 열차기본TBL */
             WHERE B.RUN_DT BETWEEN '20130401' AND '201400401'
               AND B.TRN_NO = LPAD (TRIM ('101'), 5, '0')
               AND A.YMGT_JOB_ID = (SELECT /*+ RULE */
                       SUBSTR (MAX (SUBSTR (AA.REG_DTTM, 1, 8) || AA.YMGT_JOB_ID), 9, 24)
                                      FROM TB_YYFD011 AA, TB_YYFD010 BB
                                     WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
                                       AND BB.YMGT_PROC_DV_ID IN ('YF540', 'YF940', 'YF950')
                                       AND AA.FCST_PRS_STT_CD IN ('11', '21')
                                       AND AA.RUN_DT = A.RUN_DT
                                       AND AA.TRN_NO = LPAD (TRIM ('101'), 5, '0'))
               AND A.RUN_DT = B.RUN_DT
               AND A.TRN_NO = B.TRN_NO
               AND B.STGP_DEGR = (SELECT STGP_DEGR
                                    FROM TB_YYFB001
                                   WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                                     AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)
               AND B.TMWD_GP_DEGR = (SELECT TMWD_GP_DEGR
                                       FROM TB_YYFB003
                                      WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT) /* 시간대그룹차수  */
               AND B.DPT_STN_CONS_ORDR = A.DPT_STN_CONS_ORDR
               AND B.ARV_STN_CONS_ORDR = A.ARV_STN_CONS_ORDR
               AND      B.DPT_STGP_CD IN('01001','01001','01003','01001','01003','01001','01003','01001','01001','01001','01003','01003',
                                         '01003','01008','01008','01008','01008','01008','01010','01010','01010','01010','01016','01016','01016','75004','75004','75003')
               AND      B.ARV_STGP_CD IN('01003','01008','01008','01010','01010','01016','01016','75004','75003','01020','75004','75003','01020',
                                         '01010','01016','75004','75003','01020','01016','75004','75003','01020','75004','75003','01020','75003','01020','01020')
               AND      (B.DPT_STGP_CD || '-' || B.ARV_STGP_CD) IN('01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                                   '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                                   '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                                   '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                                   '01016-01020','75004-75003','75004-01020','75003-01020')
               AND C.RUN_DT = A.RUN_DT
               AND C.TRN_NO = A.TRN_NO
               AND C.STN_CONS_ORDR = A.DPT_STN_CONS_ORDR
               AND D.RUN_DT = A.RUN_DT
               AND D.TRN_NO = A.TRN_NO
               AND D.STN_CONS_ORDR = A.ARV_STN_CONS_ORDR
               AND B.RUN_DT = E.RUN_DT
               AND ('0' IN ('0','8','9') OR E.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
               AND A.RUN_DT = F.RUN_DT
               AND A.TRN_NO = F.TRN_NO
               AND F.STLB_TRN_CLSF_CD = DECODE ('', '', F.STLB_TRN_CLSF_CD, '')
          GROUP BY A.RUN_DT
                  ,A.TRN_NO
                  ,A.PSRM_CL_CD
                  ,A.DPT_STN_CONS_ORDR
                  ,A.ARV_STN_CONS_ORDR
                  ,A.YMGT_JOB_ID
                  ,A.FCST_ACHV_DT
                  ,C.RUN_ORDR
                  , /* 운행순서 */
                   D.RUN_ORDR
                  , /* 운행순서 */
                   C.DPT_TM
               /*    ,A.REG_USR_ID */
               /*   ,A.CHG_USR_ID   */
                  ,B.DPT_STGP_CD
                  ,B.ARV_STGP_CD
                  ,B.DPT_RS_STN_CD
                  , /* 출발예발역코드 */
                   B.ARV_RS_STN_CD /* 도착예발역코드 */
                                  ) A
        ,(  SELECT
           A.RUN_DT
                  ,A.TRN_NO
                  ,A.PSRM_CL_CD
                  ,B.DPT_STGP_CD
                  ,B.ARV_STGP_CD
                  ,SUM (A.USR_CTL_EXPN_DMD_NUM) SUM_ABRD_PRNB
                  ,A.YMGT_JOB_ID
                  ,A.FCST_ACHV_DT
              FROM TB_YYFD410 A                  , /* 최종탑승예측수요내역TBL  */
                   TB_YYDD505 B                  , /* 열차구간내역TBL          */
                   TB_YYDK002 C                  , /* 카렌다내역TBL            */
                   TB_YYDK301 D /* 열차기본TBL              */
             WHERE B.RUN_DT BETWEEN '20130401' AND '201400401'
               AND B.TRN_NO = LPAD (TRIM ('101'), 5, '0')
               AND A.YMGT_JOB_ID = (SELECT /*+ RULE */
                       SUBSTR (MAX (SUBSTR (AA.REG_DTTM, 1, 8) || AA.YMGT_JOB_ID), 9, 24)
                                      FROM TB_YYFD011 AA, /* 수익관리대상열차내역TBL */
                                                         TB_YYFD010 BB /* 수익관리작업결과내역TBL */
                                     WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
                                       AND BB.YMGT_PROC_DV_ID IN ('YF540', 'YF940', 'YF950') /* 수익관리프로세스구분ID */
                                       AND AA.FCST_PRS_STT_CD IN ('11', '21') /* 예측처리상태코드 */
                                       AND AA.RUN_DT = A.RUN_DT
                                       AND AA.TRN_NO = LPAD (TRIM ('101'), 5, '0'))
               AND A.RUN_DT = B.RUN_DT
               AND A.TRN_NO = B.TRN_NO
               AND B.STGP_DEGR = (SELECT STGP_DEGR
                                    FROM TB_YYFB001
                                   WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                                     AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)
               AND B.TMWD_GP_DEGR = (SELECT TMWD_GP_DEGR
                                       FROM TB_YYFB003
                                      WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT) /* 시간대그룹차수  */
               AND B.DPT_STN_CONS_ORDR = A.DPT_STN_CONS_ORDR
               AND B.ARV_STN_CONS_ORDR = A.ARV_STN_CONS_ORDR
               AND      B.DPT_STGP_CD IN('01001','01001','01003','01001','01003','01001','01003','01001','01001','01001','01003','01003','01003','01008',
                                         '01008','01008','01008','01008','01010','01010','01010','01010','01016','01016','01016','75004','75004','75003')
               AND      B.ARV_STGP_CD IN('01003','01008','01008','01010','01010','01016','01016','75004','75003','01020','75004','75003','01020','01010',
                                         '01016','75004','75003','01020','01016','75004','75003','01020','75004','75003','01020','75003','01020','01020')
               AND      (B.DPT_STGP_CD || '-' || B.ARV_STGP_CD) IN('01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                                   '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                                   '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                                   '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                                   '01016-01020','75004-75003','75004-01020','75003-01020')
               AND      B.RUN_DT = C.RUN_DT
               AND ('0' IN ('0','8','9') OR C.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
               AND A.RUN_DT = D.RUN_DT
               AND A.TRN_NO = D.TRN_NO
               AND D.STLB_TRN_CLSF_CD = DECODE ('', '', D.STLB_TRN_CLSF_CD, '')
          GROUP BY A.RUN_DT
                  ,A.TRN_NO
                  ,A.PSRM_CL_CD
                  ,B.DPT_STGP_CD
                  ,B.ARV_STGP_CD
                  ,A.YMGT_JOB_ID
                  ,A.FCST_ACHV_DT) B
        ,TB_YYFD002 C
        ,TB_YYFD002 D
   WHERE A.RUN_DT = B.RUN_DT
     AND A.TRN_NO = B.TRN_NO
     AND A.DPT_STGP_CD = B.DPT_STGP_CD
     AND A.ARV_STGP_CD = B.ARV_STGP_CD
     AND A.YMGT_JOB_ID = B.YMGT_JOB_ID
     AND A.PSRM_CL_CD = B.PSRM_CL_CD /* 객실등급코드 */
     AND C.STGP_CD = A.DPT_STGP_CD
     AND C.STGP_DEGR = (SELECT STGP_DEGR
                          FROM TB_YYFB001
                         WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                           AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)
     AND D.STGP_CD = A.ARV_STGP_CD
     AND D.STGP_DEGR = C.STGP_DEGR
ORDER BY A.RUN_DT
        ,A.TRN_NO
        ,A.PSRM_CL_CD
        ,A.DPT_STGP_CD
        ,A.ARV_STGP_CD






YZDBA                TB_YYDD505                     IX_YYDD505_01                    12301639  => RUN_DT,STGP_DEGR,DPT_RS_STN_CD,ARV_RS_STN_CD,TRN_NO
YZDBA                                               IX_YYDD505_02                    12301639  => TRN_NO,RUN_DT,DPT_STN_CONS_ORDR,ARV_STN_CONS_ORDR
YZDBA                                               PK_YYDD505                       12301639  => RUN_DT,TRN_NO,DPT_STN_CONS_ORDR,ARV_STN_CONS_ORDR




튜닝 내용 
   1. rule 힌트 제거 검토 바람.
   2. AND (A.DPT_STGP_CD,A.ARV_STGP_CD ) IN     ( ( '01001','01003') ,('01001','01008') 형태로 sql 수정
   3. 인덱스 생성 검토 
        TB_YYDD505( TRN_NO, STGP_DEGR, TMWD_GP_DEGR, DPT_STGP_CD, ARV_STGP_CD,RUN_DT)  
   4. STGP_DEGR , TMWD_GP_DEGR 부분의 변수값은 다른 sql에서 수행해서 변수로 처리 하는 방법 권고.




-------------------------------------------------------------------
| Id  | Operation                                 | Name          |
-------------------------------------------------------------------
|   0 | SELECT STATEMENT                          |               |
|   1 |  TABLE ACCESS BY INDEX ROWID              | TB_YYDK007    |
|*  2 |   INDEX RANGE SCAN                        | PK_YYDK007    |
|   3 |  TABLE ACCESS BY INDEX ROWID              | TB_YYDK007    |
|*  4 |   INDEX RANGE SCAN                        | PK_YYDK007    |
|   5 |  TABLE ACCESS BY INDEX ROWID              | TB_YYDK001    |
|*  6 |   INDEX UNIQUE SCAN                       | PK_YYDK001    |
|   7 |  TABLE ACCESS BY INDEX ROWID              | TB_YYDK001    |
|*  8 |   INDEX UNIQUE SCAN                       | PK_YYDK001    |
|   9 |  SORT UNIQUE                              |               |
|  10 |   NESTED LOOPS                            |               |
|  11 |    NESTED LOOPS                           |               |
|  12 |     MERGE JOIN                            |               |
|  13 |      VIEW                                 |               |
|  14 |       SORT GROUP BY                       |               |
|* 15 |        FILTER                             |               |
|  16 |         NESTED LOOPS                      |               |
|  17 |          NESTED LOOPS                     |               |
|  18 |           NESTED LOOPS                    |               |
|  19 |            NESTED LOOPS                   |               |
|* 20 |             TABLE ACCESS BY INDEX ROWID   | TB_YYDD505    |
|* 21 |              INDEX RANGE SCAN             | IX_YYDD505_02 |
|* 22 |             INDEX UNIQUE SCAN             | PK_YYDK002    |
|  23 |            TABLE ACCESS BY INDEX ROWID    | TB_YYFD410    |
|* 24 |             INDEX RANGE SCAN              | PK_YYFD410    |
|* 25 |           INDEX UNIQUE SCAN               | PK_YYDK301    |
|* 26 |          TABLE ACCESS BY INDEX ROWID      | TB_YYDK301    |
|  27 |         SORT AGGREGATE                    |               |
|  28 |          NESTED LOOPS                     |               |
|* 29 |           TABLE ACCESS BY INDEX ROWID     | TB_YYFD011    |
|* 30 |            INDEX RANGE SCAN               | IX_YYFD011_01 |
|* 31 |           INDEX RANGE SCAN                | PK_YYFD010    |
|* 32 |         INDEX RANGE SCAN                  | IX_YYFB001_01 |
|* 33 |         INDEX RANGE SCAN                  | IX_YYFB003_01 |
|* 34 |      SORT JOIN                            |               |
|  35 |       VIEW                                |               |
|  36 |        SORT GROUP BY                      |               |
|* 37 |         FILTER                            |               |
|  38 |          NESTED LOOPS                     |               |
|  39 |           NESTED LOOPS                    |               |
|  40 |            NESTED LOOPS                   |               |
|  41 |             NESTED LOOPS                  |               |
|  42 |              NESTED LOOPS                 |               |
|  43 |               NESTED LOOPS                |               |
|* 44 |                TABLE ACCESS BY INDEX ROWID| TB_YYDD505    |
|* 45 |                 INDEX RANGE SCAN          | IX_YYDD505_02 |
|* 46 |                INDEX UNIQUE SCAN          | PK_YYDK002    |
|  47 |               TABLE ACCESS BY INDEX ROWID | TB_YYFD410    |
|* 48 |                INDEX RANGE SCAN           | PK_YYFD410    |
|* 49 |              TABLE ACCESS BY INDEX ROWID  | TB_YYDK301    |
|* 50 |               INDEX UNIQUE SCAN           | PK_YYDK301    |
|  51 |             TABLE ACCESS BY INDEX ROWID   | TB_YYDK302    |
|* 52 |              INDEX UNIQUE SCAN            | PK_YYDK302    |
|* 53 |            INDEX UNIQUE SCAN              | PK_YYDK302    |
|  54 |           TABLE ACCESS BY INDEX ROWID     | TB_YYDK302    |
|  55 |          SORT AGGREGATE                   |               |
|  56 |           NESTED LOOPS                    |               |
|* 57 |            TABLE ACCESS BY INDEX ROWID    | TB_YYFD011    |
|* 58 |             INDEX RANGE SCAN              | IX_YYFD011_01 |
|* 59 |            INDEX RANGE SCAN               | PK_YYFD010    |
|* 60 |          INDEX RANGE SCAN                 | IX_YYFB001_01 |
|* 61 |          INDEX RANGE SCAN                 | IX_YYFB003_01 |
|* 62 |     INDEX RANGE SCAN                      | IX_YYFD002_01 |
|* 63 |      INDEX RANGE SCAN                     | IX_YYFB001_01 |
|* 64 |    INDEX RANGE SCAN                       | IX_YYFD002_01 |
-------------------------------------------------------------------
        
