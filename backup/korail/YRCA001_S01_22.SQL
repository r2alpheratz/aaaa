SELECT (SELECT VLID_VAL_NM
            FROM TB_YYDK007
           WHERE XROIS_OLD_SRT_CD = 'I909'
             AND VLID_VAL = DAY_DV_CD)
             DAY_NM
        ,DAY_DV_CD DAY_ORDR
        ,TO_NUMBER (TRN_NO) TRN_NO
        ,DAY_DV_CD
        ,SUM (SEAT_NUM) SEAT_NUM        ,/* 좌석수          */
         SUM (SEAT_CRKM) SEAT_CRKM        ,/* 좌석키로        */
         SUM (ABRD_PKLO) ABRD_PKLO        ,/* 인키로          */
         SUM (ABRD_PRNB) ABRD_PRNB        ,/* 승차인원        */
         SUM (ABRD_PKLO) / SUM (SEAT_CRKM) * 100 ABRD_RT        ,/* 승차율          */
         SUM (ABRD_PRNB) / SUM (SEAT_NUM) * 100 UTL_RT
        ,SUM (BIZ_AMT) AMT
    FROM (  SELECT A.RUN_DT                  ,/* 운행일자        */
                   A.TRN_NO
                  ,SUM (B.SEAT_NUM) SEAT_NUM                  ,/* 좌석수          */
                   SUM (B.SEAT_CRKM) SEAT_CRKM                  ,/* 좌석키로        */
                   SUM (B.ABRD_PKLO) ABRD_PKLO                  ,/* 인키로          */
                   SUM (B.ABRD_PRNB) ABRD_PRNB                  ,/* 승차인원        */
                   SUM (B.ABRD_PKLO) / SUM (B.SEAT_CRKM) ABRD_RT                  ,/* 승차율          */
                   SUM (B.ABRD_PRNB) / SUM (B.SEAT_NUM) UTL_RT
                  , (SELECT SUM (C.BIZ_RVN_AMT - C.SMG_BIZ_RVN_AMT) BIZ_RVN_AMT                       /* 영업수입   */
                       FROM TB_YYDS510 A, /** 구간별 승차수입실적 **/
                            TB_YYDS512 C                      /** 열차별 초과예약한도 **/
                      WHERE C.RUN_DT = A.RUN_DT(+)
                        AND C.TRN_NO = A.TRN_NO(+)
                        AND C.PSRM_CL_CD = A.PSRM_CL_CD(+)
                        AND C.DPT_STN_CONS_ORDR = A.DPT_STN_CONS_ORDR(+)
                        AND C.ARV_STN_CONS_ORDR = A.ARV_STN_CONS_ORDR(+)
                        AND C.BKCL_CD = A.BKCL_CD(+)
                        AND C.SEAT_ATT_CD = A.SEAT_ATT_CD(+)
                        AND C.ARV_STN_CONS_ORDR <> C.DPT_STN_CONS_ORDR
                        AND C.PSRM_CL_CD LIKE DECODE('', '', '%', '')
                        AND C.RUN_DT = B.RUN_DT
                        AND C.TRN_NO = B.TRN_NO)
                       BIZ_AMT
                  ,D.DAY_DV_CD
              FROM TB_YYDK301 A                  ,/** 일일열차정보  **/
                   TB_YYDS511 B                  ,/** 열차별 승차율 **/
                   TB_YYDK201 C                  ,/** 노선          **/
                   TB_YYDK002 D
             WHERE A.RUN_DT BETWEEN '20140101' AND '20140131'
               AND A.STLB_TRN_CLSF_CD LIKE DECODE ('00', '', '%', '00')
               AND C.MRNT_CD LIKE DECODE ('', '', '%', '')
               AND C.MRNT_CD IN ('01', '03', '04')
               AND ( (C.EFC_ST_DT <= '20140101'
                  AND C.EFC_CLS_DT >= '20140131')
                 OR (C.EFC_ST_DT >= '20140101'
                 AND C.EFC_CLS_DT <= '20140131'))
               AND A.ROUT_CD LIKE DECODE ('', '', '%', '')
               AND A.UP_DN_DV_CD LIKE DECODE ('A', 'A', '%', 'A')
               AND A.TRN_NO LIKE DECODE (LPAD (TRIM ('101'), 5, '0'), '', '%', LPAD (TRIM ('101'), 5, '0'))
               AND B.PSRM_CL_CD LIKE DECODE ('', '', '%', '')
               AND A.TRN_DV_CD = 2
               AND A.RUN_DT = B.RUN_DT(+)
               AND A.TRN_NO = B.TRN_NO(+)
               AND A.ROUT_CD = C.ROUT_CD
               AND A.RUN_DT = D.RUN_DT
          GROUP BY A.RUN_DT
                  ,D.DAY_DV_CD
                  ,B.RUN_DT
                  ,B.TRN_NO
                  ,A.TRN_NO)
GROUP BY DAY_DV_CD, TRN_NO
ORDER BY TRN_NO, DAY_ORDR






튜닝 의견 
  - 조회 결과 건수가 많을 경우 scalar subquery 부분이 느려 질 수 있음.
  - 조회 결과가 많을 경우는 조인(hash join)으로 변경 고려 할 것. 
  
  

--------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name       | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |            |     1 |    75 |     8  (38)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID        | TB_YYDK007 |     1 |    25 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PK_YYDK007 |     1 |       |     1   (0)| 00:00:01 |
|   3 |  SORT AGGREGATE                     |            |     1 |    69 |            |          |
|*  4 |   HASH JOIN OUTER                   |            |    41 |  2829 |     3   (0)| 00:00:01 |
|   5 |    TABLE ACCESS BY INDEX ROWID      | TB_YYDS512 |    41 |  1558 |     2   (0)| 00:00:01 |
|*  6 |     INDEX RANGE SCAN                | PK_YYDS512 |    41 |       |     1   (0)| 00:00:01 |
|*  7 |    INDEX RANGE SCAN                 | PK_YYDS510 |    46 |  1426 |     1   (0)| 00:00:01 |
|   8 |  SORT ORDER BY                      |            |     1 |    75 |     8  (38)| 00:00:01 |
|   9 |   HASH GROUP BY                     |            |     1 |    75 |     8  (38)| 00:00:01 |
|  10 |    VIEW                             |            |     1 |    75 |     6  (17)| 00:00:01 |
|  11 |     HASH GROUP BY                   |            |     1 |   101 |     6  (17)| 00:00:01 |
|  12 |      NESTED LOOPS                   |            |       |       |            |          |
|  13 |       NESTED LOOPS                  |            |     1 |   101 |     5   (0)| 00:00:01 |
|  14 |        NESTED LOOPS                 |            |     1 |    64 |     4   (0)| 00:00:01 |
|  15 |         NESTED LOOPS                |            |     3 |   114 |     3   (0)| 00:00:01 |
|  16 |          TABLE ACCESS BY INDEX ROWID| TB_YYDK002 |     3 |    33 |     1   (0)| 00:00:01 |
|* 17 |           INDEX RANGE SCAN          | PK_YYDK002 |     3 |       |     1   (0)| 00:00:01 |
|* 18 |          TABLE ACCESS BY INDEX ROWID| TB_YYDK301 |     1 |    27 |     1   (0)| 00:00:01 |
|* 19 |           INDEX UNIQUE SCAN         | PK_YYDK301 |     1 |       |     1   (0)| 00:00:01 |
|* 20 |         TABLE ACCESS BY INDEX ROWID | TB_YYDK201 |     1 |    26 |     1   (0)| 00:00:01 |
|* 21 |          INDEX UNIQUE SCAN          | PK_YYDK201 |     1 |       |     1   (0)| 00:00:01 |
|* 22 |        INDEX RANGE SCAN             | PK_YYDS511 |     1 |       |     1   (0)| 00:00:01 |
|  23 |       TABLE ACCESS BY INDEX ROWID   | TB_YYDS511 |     1 |    37 |     1   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------------
  
