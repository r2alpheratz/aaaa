  SELECT /*+com.korail.yz.yf.da.YFDA001QMDAO.selectListAllTrnInfo*/
         A4.DAY_DV_CD
        ,MIN(B4.VLID_VAL_KOR_AVVR_NM)  DAY_DV_NM
        ,SUM (A4.LAST_ABRD_EXPCT_DMD) LAST_ABRD_EXPCT_DMD_SUM
        ,ROUND (SUM (A4.LAST_ABRD_EXPCT_DMD) / DECODE (COUNT (DISTINCT A4.DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.DAY_DV_NUM)), 1) LAST_ABRD_EXPCT_DMD_AVG
        ,SUM (A4.EXPN_POTT_DMD_NUM) EXPN_POTT_DMD_NUM_SUM
        ,ROUND (SUM (A4.EXPN_POTT_DMD_NUM) / DECODE (COUNT (DISTINCT A4.DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.DAY_DV_NUM)), 1) EXPN_POTT_DMD_NUM_AVG
        ,ROUND ((SUM (A4.FCST_ABRD_RT) / DECODE (COUNT (DISTINCT A4.DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.DAY_DV_NUM))) * 100, 1) FCST_ABRD_RT
        ,SUM (A4.SALE_NUM) SALE_NUM_SUM
        ,ROUND (SUM (A4.SALE_NUM) / DECODE (COUNT (DISTINCT A4.DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.DAY_DV_NUM)), 1) SALE_NUM_AVG
        ,ROUND (SUM (A4.CANCEL_NUM) / DECODE (COUNT (DISTINCT A4.DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.DAY_DV_NUM)), 1) CANCEL_NUM_AVG
        ,SUM (A4.CANCEL_NUM) CANCEL_NUM_SUM
        ,SUM (A4.PAST_NUM) PAST_NUM_SUM
        ,ROUND (SUM (A4.PAST_NUM) / DECODE (COUNT (DISTINCT A4.PAST_DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.PAST_DAY_DV_NUM)), 1) PAST_NUM_AVG
        ,SUM (A4.PAST_SALE_NUM) PAST_SALE_NUM_SUM
        ,ROUND (SUM (A4.PAST_SALE_NUM) / DECODE (COUNT (DISTINCT A4.PAST_DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.PAST_DAY_DV_NUM)), 1) PAST_SALE_NUM_AVG
        ,SUM (A4.PAST_CANCEL_NUM) PAST_CANCEL_NUM_SUM
        ,ROUND (SUM (A4.PAST_CANCEL_NUM) / DECODE (COUNT (DISTINCT A4.PAST_DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.PAST_DAY_DV_NUM)), 1) PAST_CANCEL_NUM_AVG
        ,SUM (A4.PRICE) PRICE_SUM
        ,ROUND (SUM (A4.PRICE) / DECODE (COUNT (DISTINCT A4.DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.DAY_DV_NUM)), 1) PRICE_AVG
        ,SUM (A4.TOT_NUM) TOT_NUM_SUM
        ,ROUND (SUM (A4.TOT_NUM) / DECODE (COUNT (DISTINCT A4.DAY_DV_NUM), 0, 1, COUNT (DISTINCT A4.DAY_DV_NUM)), 1) TOT_NUM_AVG
    FROM (SELECT /*+RULE*/
                 C3.DAY_DV_CD
                ,A3.TRN_NO
                ,A3.FCST_PSN_RT FCST_ABRD_RT
                ,B3.SALE_NUM
                ,B3.CANCEL_NUM
                ,A3.PRICE
                ,A3.LAST_ABRD_EXPCT_DMD
                ,A3.EXPN_POTT_DMD_NUM
                ,B3.TOT_NUM
                ,C3.DAY_DV_CD || A3.RUN_DT DAY_DV_NUM
                ,0 PAST_NUM
                ,0 PAST_SALE_NUM
                ,0 PAST_CANCEL_NUM
                ,NULL PAST_DAY_DV_NUM
            FROM (SELECT A1.TRN_NO
                        ,A1.RUN_DT RUN_DT
                        ,A1.EXPN_RVN_AMT PRICE
                        ,A1.FCST_ABRD_PRNB LAST_ABRD_EXPCT_DMD
                        ,ROUND
                         (
                             CASE
                                 WHEN '' = '1'
                                 THEN
                                     A1.ABRD_RT1
                                 WHEN '' = '2'
                                 THEN
                                     A1.ABRD_RT2
                                 WHEN '' IS NULL
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
                        , SUM (Z.EXPN_POTT_DMD_NUM) AS EXPN_POTT_DMD_NUM
                    FROM (  SELECT A.RUN_DT
                                  ,A.TRN_NO
                                  ,SUM (A.EXPN_RVN_AMT) EXPN_RVN_AMT
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.FCST_ABRD_RT)), 0) ABRD_RT1
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.FCST_ABRD_RT)), 0) ABRD_RT2
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '1', A.FCST_ABRD_PRNB)), 0) ABRD_PRNB1
                                  ,NVL (SUM (DECODE (A.PSRM_CL_CD, '2', A.FCST_ABRD_PRNB)), 0) ABRD_PRNB2
                                  ,SUM (A.FCST_ABRD_PRNB) FCST_ABRD_PRNB
                              FROM TB_YYPD003 A, /*열차별BookingClass통제정보 TBL*/
                                   TB_YYDK301 C, /*일일열차정보 TBL*/
                                   TB_YYDK201 D /*노선 TBL*/
                             WHERE  A.RUN_DT IN(SELECT RUN_DT
                                                 FROM TB_YYDK002
                                                WHERE DAY_DV_CD = DECODE('0', '0', DAY_DV_CD, '0')
                                                  AND RUN_DT BETWEEN '20130401' AND '20140401')
                               AND A.TRN_NO = DECODE( '', '', A.TRN_NO, LPAD ('', 5, '0'))
                               AND A.PSRM_CL_CD = DECODE('', '', A.PSRM_CL_CD, '')
                               AND A.RUN_DT = C.RUN_DT
                               AND A.TRN_NO = C.TRN_NO
                               AND C.UP_DN_DV_CD = DECODE ('A', 'A', C.UP_DN_DV_CD, 'A')
                               AND C.STLB_TRN_CLSF_CD = DECODE ('' , '', C.STLB_TRN_CLSF_CD, '' )
                               AND C.ROUT_CD = D.ROUT_CD
                               AND D.MRNT_CD = DECODE ('', '', D.MRNT_CD, '')
                               AND D.ROUT_DV_CD IN ('10', '30')
                               AND D.MRNT_CD IN ('01', '03', '04')
                               AND A.BKCL_CD = 'F1'
                          GROUP BY A.RUN_DT, A.TRN_NO) A1
                          ,TB_YYFD410 Z
                    WHERE Z.RUN_DT = A1.RUN_DT
                              AND Z.TRN_NO = A1.TRN_NO
                              AND Z.PSRM_CL_CD = DECODE('', '', Z.PSRM_CL_CD, '')
                              AND (Z.FCST_ACHV_DT, Z.YMGT_JOB_ID) = (SELECT SUBSTR (MAX (Y.FCST_ACHV_DT || Y.YMGT_JOB_ID), 1, 8), SUBSTR (MAX (Y.FCST_ACHV_DT || Y.YMGT_JOB_ID), 9)
                                                                       FROM TB_YYFD410 Y /*최종탑승예측수요 TBL*/
                                                                      WHERE Z.RUN_DT = Y.RUN_DT
                                                                        AND Z.TRN_NO = Y.TRN_NO
                                                                        AND Z.PSRM_CL_CD = Y.PSRM_CL_CD
                                                                        AND Z.BKCL_CD = Y.BKCL_CD
                                                                        AND Z.DPT_STN_CONS_ORDR = Y.DPT_STN_CONS_ORDR
                                                                        AND Z.ARV_STN_CONS_ORDR = Y.ARV_STN_CONS_ORDR)
                   GROUP BY  A1.TRN_NO
                            ,A1.RUN_DT
                            ,A1.EXPN_RVN_AMT 
                            ,A1.FCST_ABRD_PRNB 
                            ,A1.ABRD_RT1
                            ,A1.ABRD_RT2
                            ,A1.ABRD_PRNB1
                            ,A1.ABRD_PRNB2) A3
                ,(  SELECT A.RUN_DT
                          ,A.TRN_NO
                          ,SUM (A.RSV_SEAT_NUM + A.SALE_SEAT_NUM) SALE_NUM
                          ,SUM (A.CNC_SEAT_NUM + A.RET_SEAT_NUM) CANCEL_NUM
                          ,SUM (A.RSV_SEAT_NUM + A.SALE_SEAT_NUM - A.CNC_SEAT_NUM - A.RET_SEAT_NUM) TOT_NUM
                      FROM TB_YYDS501 A, /*예약발매실적 TBL*/
                                        TB_YYDK301 B, /*일일열차정보 TBL*/
                                                     TB_YYDK201 C /*노선 TBL*/
                     WHERE                   A.RUN_DT IN(SELECT RUN_DT
                                                           FROM TB_YYDK002
                                                          WHERE DAY_DV_CD = DECODE('0', '0', DAY_DV_CD, '0')
                                                            AND RUN_DT BETWEEN '20130401' AND '20140401')
                                             AND
                           A.TRN_NO = DECODE( '', '', A.TRN_NO, LPAD ('', 5, '0'))
                       AND A.PSRM_CL_CD = DECODE('', '', A.PSRM_CL_CD, '')
                       AND B.UP_DN_DV_CD = DECODE ('A', 'A', B.UP_DN_DV_CD, 'A')
                       AND B.STLB_TRN_CLSF_CD = DECODE ('' , '', B.STLB_TRN_CLSF_CD, '' )
                       AND A.RUN_DT = B.RUN_DT
                       AND A.TRN_NO = B.TRN_NO
                       AND B.ROUT_CD = C.ROUT_CD
                       AND C.MRNT_CD = DECODE ('', '', C.MRNT_CD, '')
                       AND C.MRNT_CD IN ('01', '03', '04')
                  GROUP BY A.RUN_DT, A.TRN_NO) B3
                ,TB_YYDK002 C3 /*Calendar TBL*/
           WHERE A3.RUN_DT = B3.RUN_DT(+)
             AND A3.TRN_NO = B3.TRN_NO(+)
             AND A3.RUN_DT = C3.RUN_DT
          UNION ALL
            SELECT MAX (D.DAY_DV_CD)
                  ,A.TRN_NO
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,NULL
                  ,SUM (A.RSV_SEAT_NUM + A.SALE_SEAT_NUM - A.CNC_SEAT_NUM - A.RET_SEAT_NUM) PAST_NUM
                  ,SUM (A.RSV_SEAT_NUM + A.SALE_SEAT_NUM) PAST_SALE_NUM
                  ,SUM (A.CNC_SEAT_NUM + A.RET_SEAT_NUM) PAST_CANCEL_NUM
                  ,MAX (DISTINCT D.DAY_DV_CD || A.RUN_DT) PAST_DAY_DV_NUM
              FROM TB_YYDS501 A
                  , /*예약발매실적 TBL*/
                   TB_YYDK301 B
                  , /*일일열차정보 TBL*/
                   TB_YYDK201 C
                  , /*노선 TBL*/
                   TB_YYDK002 D /*Calendar TBL*/
             WHERE A.RUN_DT IN('20130325','20130326','20130327','20130328','20130329','20130330','20130324','20130318','20130319',
                               '20130320','20130321','20130322','20130323','20130317','20130311','20130312','20130313','20130314',
                               '20130315','20130316','20130310','20130304','20130305','20130306','20130307','20130308','20130309',
                               '20130303','20120402','20120403','20120404','20120329','20120330','20120331','20120401','20120409',
                               '20120402','20120326','20120410','20120403','20120327','20120411','20120404','20120328','20120405',
                               '20120329','20120322','20120406','20120330','20120323','20120407','20120331','20120324','20120408',
                               '20120401','20120325')
               AND A.TRN_NO = DECODE( '', '', A.TRN_NO, LPAD ('', 5, '0'))
               AND A.PSRM_CL_CD = DECODE('', '', A.PSRM_CL_CD, '')
               AND B.UP_DN_DV_CD = DECODE ('A', 'A', B.UP_DN_DV_CD, 'A')
               AND B.STLB_TRN_CLSF_CD = DECODE ('' , '', B.STLB_TRN_CLSF_CD, '' )
               AND B.trn_att_cd IN ('1', '6') /* 열차속성(일반, 일반/관광혼용) */
               AND B.trn_opn_flg = 'Y' /* 열차공개여부                  */
               AND B.TRN_SPS_FLG = 'N' /* 운휴여부                      */
               AND A.RUN_DT = B.RUN_DT
               AND A.TRN_NO = B.TRN_NO
               AND B.ROUT_CD = C.ROUT_CD
               AND C.MRNT_CD = DECODE ('', '', C.MRNT_CD, '')
               AND C.MRNT_CD IN ('01', '03', '04')
               AND A.RUN_DT = D.RUN_DT
          GROUP BY A.TRN_NO, A.RUN_DT) A4
          ,TB_YYDK007 B4
WHERE    A4.DAY_DV_CD = B4.VLID_VAL
AND      B4.XROIS_OLD_SRT_CD = 'I909'
GROUP BY A4.DAY_DV_CD, B4.VLID_VAL_KOR_AVVR_NM
ORDER BY A4.DAY_DV_CD






튜닝 내용
   - rule 힌트 제거 
   - hash 조인 힌트 추가 (대량 데이터를 코드성 테이블과 조인하기 위함임)
       /*+ LEADING(B) USE_HASH(C D) */  : union 두번재 sql시작점.
   
   - run_dt 변수는 대량 테이블이 아닌 작은 테이블에 사용 할 것.
     예)
                              FROM TB_YYPD003 A, /*열차별BookingClass통제정보 TBL*/
                                   TB_YYDK301 C, /*일일열차정보 TBL*/
                                   TB_YYDK201 D /*노선 TBL*/
                             WHERE  A.RUN_DT IN(SELECT RUN_DT
                                                 FROM TB_YYDK002
                                                WHERE DAY_DV_CD = DECODE('0', '0', DAY_DV_CD, '0')
                                                  AND RUN_DT BETWEEN '20130401' AND '20140401')
                               AND A.RUN_DT = C.RUN_DT
                               AND A.TRN_NO = C.TRN_NO

       수정 
                              FROM TB_YYPD003 A, /*열차별BookingClass통제정보 TBL*/
                                   TB_YYDK301 C, /*일일열차정보 TBL*/
                                   TB_YYDK201 D /*노선 TBL*/
                             WHERE  c.RUN_DT IN(SELECT RUN_DT                           --> 수정 부분 alias a 를 alias c 로 변경 
                                                 FROM TB_YYDK002
                                                WHERE DAY_DV_CD = DECODE('0', '0', DAY_DV_CD, '0')
                                                  AND RUN_DT BETWEEN '20130401' AND '20140401')
                               AND A.RUN_DT = C.RUN_DT
                               AND A.TRN_NO = C.TRN_NO             

   - sql 수정 
        현재 : SUM (A.RSV_SEAT_NUM + A.SALE_SEAT_NUM) 
        수정 : SUM (A.RSV_SEAT_NUM )  + SUM(A.SALE_SEAT_NUM)
        
        

---------------------------------------------------------------------
| Id  | Operation                                      | Name       |
---------------------------------------------------------------------
|   0 | SELECT STATEMENT                               |            |
|   1 |  SORT GROUP BY                                 |            |
|   2 |   NESTED LOOPS                                 |            |
|   3 |    NESTED LOOPS                                |            |
|   4 |     VIEW                                       |            |
|   5 |      UNION-ALL                                 |            |
|   6 |       MERGE JOIN OUTER                         |            |
|   7 |        NESTED LOOPS                            |            |
|   8 |         NESTED LOOPS                           |            |
|   9 |          VIEW                                  |            |
|  10 |           SORT GROUP BY                        |            |
|* 11 |            FILTER                              |            |
|  12 |             NESTED LOOPS                       |            |
|  13 |              NESTED LOOPS                      |            |
|  14 |               VIEW                             |            |
|  15 |                SORT GROUP BY                   |            |
|  16 |                 NESTED LOOPS                   |            |
|  17 |                  NESTED LOOPS                  |            |
|  18 |                   NESTED LOOPS                 |            |
|  19 |                    NESTED LOOPS                |            |
|* 20 |                     TABLE ACCESS BY INDEX ROWID| TB_YYDK002 |
|* 21 |                      INDEX RANGE SCAN          | PK_YYDK002 |
|  22 |                     TABLE ACCESS BY INDEX ROWID| TB_YYPD003 |
|* 23 |                      INDEX RANGE SCAN          | PK_YYPD003 |
|* 24 |                    TABLE ACCESS BY INDEX ROWID | TB_YYDK301 |
|* 25 |                     INDEX UNIQUE SCAN          | PK_YYDK301 |
|* 26 |                   INDEX UNIQUE SCAN            | PK_YYDK201 |
|* 27 |                  TABLE ACCESS BY INDEX ROWID   | TB_YYDK201 |
|* 28 |               INDEX RANGE SCAN                 | PK_YYFD410 |
|  29 |              TABLE ACCESS BY INDEX ROWID       | TB_YYFD410 |
|  30 |             SORT AGGREGATE                     |            |
|* 31 |              INDEX RANGE SCAN                  | PK_YYFD410 |
|* 32 |          INDEX UNIQUE SCAN                     | PK_YYDK002 |
|  33 |         TABLE ACCESS BY INDEX ROWID            | TB_YYDK002 |
|* 34 |        SORT JOIN                               |            |
|  35 |         VIEW                                   |            |
|  36 |          SORT GROUP BY                         |            |
|  37 |           NESTED LOOPS                         |            |
|  38 |            NESTED LOOPS                        |            |
|  39 |             NESTED LOOPS                       |            |
|  40 |              NESTED LOOPS                      |            |
|* 41 |               TABLE ACCESS BY INDEX ROWID      | TB_YYDK002 |
|* 42 |                INDEX RANGE SCAN                | PK_YYDK002 |
|  43 |               TABLE ACCESS BY INDEX ROWID      | TB_YYDS501 |
|* 44 |                INDEX RANGE SCAN                | PK_YYDS501 |
|* 45 |              TABLE ACCESS BY INDEX ROWID       | TB_YYDK301 |
|* 46 |               INDEX UNIQUE SCAN                | PK_YYDK301 |
|* 47 |             INDEX UNIQUE SCAN                  | PK_YYDK201 |
|* 48 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK201 |
|  49 |       SORT GROUP BY                            |            |
|  50 |        CONCATENATION                           |            |
|  51 |         NESTED LOOPS                           |            |
|  52 |          NESTED LOOPS                          |            |
|  53 |           NESTED LOOPS                         |            |
|  54 |            NESTED LOOPS                        |            |
|  55 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|* 56 |              INDEX RANGE SCAN                  | PK_YYDS501 |
|  57 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|* 58 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|* 59 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|* 60 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|* 61 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|* 62 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
|  63 |         NESTED LOOPS                           |            |
|  64 |          NESTED LOOPS                          |            |
|  65 |           NESTED LOOPS                         |            |
|  66 |            NESTED LOOPS                        |            |
|  67 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|* 68 |              INDEX RANGE SCAN                  | PK_YYDS501 |
|  69 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|* 70 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|* 71 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|* 72 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|* 73 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|* 74 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
|  75 |         NESTED LOOPS                           |            |
|  76 |          NESTED LOOPS                          |            |
|  77 |           NESTED LOOPS                         |            |
|  78 |            NESTED LOOPS                        |            |
|  79 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|* 80 |              INDEX RANGE SCAN                  | PK_YYDS501 |
|  81 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|* 82 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|* 83 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|* 84 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|* 85 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|* 86 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
|  87 |         NESTED LOOPS                           |            |
|  88 |          NESTED LOOPS                          |            |
|  89 |           NESTED LOOPS                         |            |
|  90 |            NESTED LOOPS                        |            |
|  91 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|* 92 |              INDEX RANGE SCAN                  | PK_YYDS501 |
|  93 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|* 94 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|* 95 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|* 96 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|* 97 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|* 98 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
|  99 |         NESTED LOOPS                           |            |
| 100 |          NESTED LOOPS                          |            |
| 101 |           NESTED LOOPS                         |            |
| 102 |            NESTED LOOPS                        |            |
| 103 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*104 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 105 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*106 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*107 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*108 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*109 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*110 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 111 |         NESTED LOOPS                           |            |
| 112 |          NESTED LOOPS                          |            |
| 113 |           NESTED LOOPS                         |            |
| 114 |            NESTED LOOPS                        |            |
| 115 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*116 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 117 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*118 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*119 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*120 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*121 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*122 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 123 |         NESTED LOOPS                           |            |
| 124 |          NESTED LOOPS                          |            |
| 125 |           NESTED LOOPS                         |            |
| 126 |            NESTED LOOPS                        |            |
| 127 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*128 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 129 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*130 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*131 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*132 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*133 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*134 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 135 |         NESTED LOOPS                           |            |
| 136 |          NESTED LOOPS                          |            |
| 137 |           NESTED LOOPS                         |            |
| 138 |            NESTED LOOPS                        |            |
| 139 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*140 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 141 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*142 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*143 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*144 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*145 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*146 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 147 |         NESTED LOOPS                           |            |
| 148 |          NESTED LOOPS                          |            |
| 149 |           NESTED LOOPS                         |            |
| 150 |            NESTED LOOPS                        |            |
| 151 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*152 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 153 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*154 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*155 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*156 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*157 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*158 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 159 |         NESTED LOOPS                           |            |
| 160 |          NESTED LOOPS                          |            |
| 161 |           NESTED LOOPS                         |            |
| 162 |            NESTED LOOPS                        |            |
| 163 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*164 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 165 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*166 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*167 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*168 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*169 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*170 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 171 |         NESTED LOOPS                           |            |
| 172 |          NESTED LOOPS                          |            |
| 173 |           NESTED LOOPS                         |            |
| 174 |            NESTED LOOPS                        |            |
| 175 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*176 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 177 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*178 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*179 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*180 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*181 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*182 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 183 |         NESTED LOOPS                           |            |
| 184 |          NESTED LOOPS                          |            |
| 185 |           NESTED LOOPS                         |            |
| 186 |            NESTED LOOPS                        |            |
| 187 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*188 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 189 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*190 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*191 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*192 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*193 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*194 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 195 |         NESTED LOOPS                           |            |
| 196 |          NESTED LOOPS                          |            |
| 197 |           NESTED LOOPS                         |            |
| 198 |            NESTED LOOPS                        |            |
| 199 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*200 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 201 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*202 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*203 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*204 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*205 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*206 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 207 |         NESTED LOOPS                           |            |
| 208 |          NESTED LOOPS                          |            |
| 209 |           NESTED LOOPS                         |            |
| 210 |            NESTED LOOPS                        |            |
| 211 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*212 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 213 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*214 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*215 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*216 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*217 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*218 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 219 |         NESTED LOOPS                           |            |
| 220 |          NESTED LOOPS                          |            |
| 221 |           NESTED LOOPS                         |            |
| 222 |            NESTED LOOPS                        |            |
| 223 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*224 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 225 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*226 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*227 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*228 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*229 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*230 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 231 |         NESTED LOOPS                           |            |
| 232 |          NESTED LOOPS                          |            |
| 233 |           NESTED LOOPS                         |            |
| 234 |            NESTED LOOPS                        |            |
| 235 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*236 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 237 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*238 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*239 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*240 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*241 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*242 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 243 |         NESTED LOOPS                           |            |
| 244 |          NESTED LOOPS                          |            |
| 245 |           NESTED LOOPS                         |            |
| 246 |            NESTED LOOPS                        |            |
| 247 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*248 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 249 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*250 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*251 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*252 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*253 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*254 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 255 |         NESTED LOOPS                           |            |
| 256 |          NESTED LOOPS                          |            |
| 257 |           NESTED LOOPS                         |            |
| 258 |            NESTED LOOPS                        |            |
| 259 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*260 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 261 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*262 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*263 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*264 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*265 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*266 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 267 |         NESTED LOOPS                           |            |
| 268 |          NESTED LOOPS                          |            |
| 269 |           NESTED LOOPS                         |            |
| 270 |            NESTED LOOPS                        |            |
| 271 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*272 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 273 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*274 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*275 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*276 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*277 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*278 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 279 |         NESTED LOOPS                           |            |
| 280 |          NESTED LOOPS                          |            |
| 281 |           NESTED LOOPS                         |            |
| 282 |            NESTED LOOPS                        |            |
| 283 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*284 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 285 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*286 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*287 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*288 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*289 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*290 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 291 |         NESTED LOOPS                           |            |
| 292 |          NESTED LOOPS                          |            |
| 293 |           NESTED LOOPS                         |            |
| 294 |            NESTED LOOPS                        |            |
| 295 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*296 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 297 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*298 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*299 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*300 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*301 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*302 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 303 |         NESTED LOOPS                           |            |
| 304 |          NESTED LOOPS                          |            |
| 305 |           NESTED LOOPS                         |            |
| 306 |            NESTED LOOPS                        |            |
| 307 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*308 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 309 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*310 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*311 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*312 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*313 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*314 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 315 |         NESTED LOOPS                           |            |
| 316 |          NESTED LOOPS                          |            |
| 317 |           NESTED LOOPS                         |            |
| 318 |            NESTED LOOPS                        |            |
| 319 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*320 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 321 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*322 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*323 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*324 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*325 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*326 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 327 |         NESTED LOOPS                           |            |
| 328 |          NESTED LOOPS                          |            |
| 329 |           NESTED LOOPS                         |            |
| 330 |            NESTED LOOPS                        |            |
| 331 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*332 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 333 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*334 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*335 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*336 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*337 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*338 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 339 |         NESTED LOOPS                           |            |
| 340 |          NESTED LOOPS                          |            |
| 341 |           NESTED LOOPS                         |            |
| 342 |            NESTED LOOPS                        |            |
| 343 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*344 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 345 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*346 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*347 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*348 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*349 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*350 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 351 |         NESTED LOOPS                           |            |
| 352 |          NESTED LOOPS                          |            |
| 353 |           NESTED LOOPS                         |            |
| 354 |            NESTED LOOPS                        |            |
| 355 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*356 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 357 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*358 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*359 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*360 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*361 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*362 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 363 |         NESTED LOOPS                           |            |
| 364 |          NESTED LOOPS                          |            |
| 365 |           NESTED LOOPS                         |            |
| 366 |            NESTED LOOPS                        |            |
| 367 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*368 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 369 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*370 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*371 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*372 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*373 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*374 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 375 |         NESTED LOOPS                           |            |
| 376 |          NESTED LOOPS                          |            |
| 377 |           NESTED LOOPS                         |            |
| 378 |            NESTED LOOPS                        |            |
| 379 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*380 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 381 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*382 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*383 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*384 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*385 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*386 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 387 |         NESTED LOOPS                           |            |
| 388 |          NESTED LOOPS                          |            |
| 389 |           NESTED LOOPS                         |            |
| 390 |            NESTED LOOPS                        |            |
| 391 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*392 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 393 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*394 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*395 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*396 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*397 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*398 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 399 |         NESTED LOOPS                           |            |
| 400 |          NESTED LOOPS                          |            |
| 401 |           NESTED LOOPS                         |            |
| 402 |            NESTED LOOPS                        |            |
| 403 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*404 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 405 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*406 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*407 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*408 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*409 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*410 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 411 |         NESTED LOOPS                           |            |
| 412 |          NESTED LOOPS                          |            |
| 413 |           NESTED LOOPS                         |            |
| 414 |            NESTED LOOPS                        |            |
| 415 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*416 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 417 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*418 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*419 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*420 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*421 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*422 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 423 |         NESTED LOOPS                           |            |
| 424 |          NESTED LOOPS                          |            |
| 425 |           NESTED LOOPS                         |            |
| 426 |            NESTED LOOPS                        |            |
| 427 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*428 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 429 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*430 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*431 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*432 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*433 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*434 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 435 |         NESTED LOOPS                           |            |
| 436 |          NESTED LOOPS                          |            |
| 437 |           NESTED LOOPS                         |            |
| 438 |            NESTED LOOPS                        |            |
| 439 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*440 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 441 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*442 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*443 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*444 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*445 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*446 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 447 |         NESTED LOOPS                           |            |
| 448 |          NESTED LOOPS                          |            |
| 449 |           NESTED LOOPS                         |            |
| 450 |            NESTED LOOPS                        |            |
| 451 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*452 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 453 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*454 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*455 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*456 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*457 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*458 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 459 |         NESTED LOOPS                           |            |
| 460 |          NESTED LOOPS                          |            |
| 461 |           NESTED LOOPS                         |            |
| 462 |            NESTED LOOPS                        |            |
| 463 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*464 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 465 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*466 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*467 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*468 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*469 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*470 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 471 |         NESTED LOOPS                           |            |
| 472 |          NESTED LOOPS                          |            |
| 473 |           NESTED LOOPS                         |            |
| 474 |            NESTED LOOPS                        |            |
| 475 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*476 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 477 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*478 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*479 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*480 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*481 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*482 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 483 |         NESTED LOOPS                           |            |
| 484 |          NESTED LOOPS                          |            |
| 485 |           NESTED LOOPS                         |            |
| 486 |            NESTED LOOPS                        |            |
| 487 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*488 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 489 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*490 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*491 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*492 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*493 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*494 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 495 |         NESTED LOOPS                           |            |
| 496 |          NESTED LOOPS                          |            |
| 497 |           NESTED LOOPS                         |            |
| 498 |            NESTED LOOPS                        |            |
| 499 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*500 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 501 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*502 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*503 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*504 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*505 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*506 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 507 |         NESTED LOOPS                           |            |
| 508 |          NESTED LOOPS                          |            |
| 509 |           NESTED LOOPS                         |            |
| 510 |            NESTED LOOPS                        |            |
| 511 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*512 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 513 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*514 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*515 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*516 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*517 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*518 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 519 |         NESTED LOOPS                           |            |
| 520 |          NESTED LOOPS                          |            |
| 521 |           NESTED LOOPS                         |            |
| 522 |            NESTED LOOPS                        |            |
| 523 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*524 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 525 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*526 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*527 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*528 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*529 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*530 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 531 |         NESTED LOOPS                           |            |
| 532 |          NESTED LOOPS                          |            |
| 533 |           NESTED LOOPS                         |            |
| 534 |            NESTED LOOPS                        |            |
| 535 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*536 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 537 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*538 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*539 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*540 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*541 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*542 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 543 |         NESTED LOOPS                           |            |
| 544 |          NESTED LOOPS                          |            |
| 545 |           NESTED LOOPS                         |            |
| 546 |            NESTED LOOPS                        |            |
| 547 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*548 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 549 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*550 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*551 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*552 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*553 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*554 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 555 |         NESTED LOOPS                           |            |
| 556 |          NESTED LOOPS                          |            |
| 557 |           NESTED LOOPS                         |            |
| 558 |            NESTED LOOPS                        |            |
| 559 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*560 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 561 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*562 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*563 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*564 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*565 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*566 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 567 |         NESTED LOOPS                           |            |
| 568 |          NESTED LOOPS                          |            |
| 569 |           NESTED LOOPS                         |            |
| 570 |            NESTED LOOPS                        |            |
| 571 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*572 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 573 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*574 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*575 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*576 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*577 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*578 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 579 |         NESTED LOOPS                           |            |
| 580 |          NESTED LOOPS                          |            |
| 581 |           NESTED LOOPS                         |            |
| 582 |            NESTED LOOPS                        |            |
| 583 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*584 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 585 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*586 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*587 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*588 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*589 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*590 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 591 |         NESTED LOOPS                           |            |
| 592 |          NESTED LOOPS                          |            |
| 593 |           NESTED LOOPS                         |            |
| 594 |            NESTED LOOPS                        |            |
| 595 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*596 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 597 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*598 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*599 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*600 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*601 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*602 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 603 |         NESTED LOOPS                           |            |
| 604 |          NESTED LOOPS                          |            |
| 605 |           NESTED LOOPS                         |            |
| 606 |            NESTED LOOPS                        |            |
| 607 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*608 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 609 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*610 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*611 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*612 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*613 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*614 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 615 |         NESTED LOOPS                           |            |
| 616 |          NESTED LOOPS                          |            |
| 617 |           NESTED LOOPS                         |            |
| 618 |            NESTED LOOPS                        |            |
| 619 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*620 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 621 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*622 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*623 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*624 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*625 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*626 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
| 627 |         NESTED LOOPS                           |            |
| 628 |          NESTED LOOPS                          |            |
| 629 |           NESTED LOOPS                         |            |
| 630 |            NESTED LOOPS                        |            |
| 631 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDS501 |
|*632 |              INDEX RANGE SCAN                  | PK_YYDS501 |
| 633 |             TABLE ACCESS BY INDEX ROWID        | TB_YYDK002 |
|*634 |              INDEX UNIQUE SCAN                 | PK_YYDK002 |
|*635 |            TABLE ACCESS BY INDEX ROWID         | TB_YYDK301 |
|*636 |             INDEX UNIQUE SCAN                  | PK_YYDK301 |
|*637 |           INDEX UNIQUE SCAN                    | PK_YYDK201 |
|*638 |          TABLE ACCESS BY INDEX ROWID           | TB_YYDK201 |
|*639 |     INDEX RANGE SCAN                           | PK_YYDK007 |
| 640 |    TABLE ACCESS BY INDEX ROWID                 | TB_YYDK007 |
---------------------------------------------------------------------

