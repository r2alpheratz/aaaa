SELECT /*+ com.korail.yz.yr.cb.YRCB001QMDAO.selectListAmountPrAcvmCompQry */
      '전체' AS STANDARD
      ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
      ,ROUND (AVG (A.UTL_RT) * 100, 3) AS UTL_RT
      ,ROUND (AVG (A.ABRD_RT) * 100, 3) AS ABRD_RT
      ,SUM (A.BIZ_RVN_AMT) AS BIZ_RVN_AMT
      ,ROUND (SUM (A.BIZ_RVN_AMT) / SUM (A.BS_SEAT_NUM), 0) AS BIZ_RVN_AMT_PER_SEAT_CNT
  FROM (  SELECT A.RUN_DT
                ,A.TRN_NO
                ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                ,SUM (A.UTL_RT) AS UTL_RT
                ,SUM (A.ABRD_RT) AS ABRD_RT
                ,SUM (B.BIZ_RVN_AMT) AS BIZ_RVN_AMT
                ,C.BS_SEAT_NUM AS BS_SEAT_NUM
            FROM (SELECT B.RUN_DT
                        ,B.TRN_NO
                        ,B.PSRM_CL_CD
                        ,A.BKCL_CD
                        ,NVL (A.ABRD_PRNB, 0) ABRD_PRNB
                        ,B.SEAT_CNT SEAT_CNT
                        ,  B.SEAT_CNT
                         * FN_YB_GETROUTDSTCAL
                           (
                               C.ROUT_CD
                              ,D.STN_CONS_ORDR
                              ,E.STN_CONS_ORDR
                              ,B.RUN_DT
                           )
                             SEAT_KM
                        ,NVL (A.PKILO, 0) PKILO
                        ,NVL (A.ABRD_PRNB, 0) / B.SEAT_CNT UTL_RT
                        ,  NVL (A.PKILO, 0)
                         / (  B.SEAT_CNT
                            * FN_YB_GETROUTDSTCAL
                              (
                                  C.ROUT_CD
                                 ,D.STN_CONS_ORDR
                                 ,E.STN_CONS_ORDR
                                 ,B.RUN_DT
                              ))
                             ABRD_RT
                    FROM (  SELECT A.RUN_DT
                                  ,A.TRN_NO
                                  ,A.PSRM_CL_CD
                                  ,A.BKCL_CD
                                  ,DECODE ('N', 'N', SUM (A.ABRD_PRNB), SUM (A.ABRD_PRNB + A.SMG_ABRD_PRNB)) ABRD_PRNB
                                  ,SUM (  A.ABRD_PRNB
                                        * FN_YB_GETROUTDSTCAL
                                          (
                                              B.ROUT_CD
                                             ,A.DPT_STN_CONS_ORDR
                                             ,A.ARV_STN_CONS_ORDR
                                             ,A.RUN_DT
                                          ))
                                       PKILO
                              FROM TB_YYDS510 A
                                  ,TB_YYDK301 B
                                  ,TB_YYDK302 C
                                  ,TB_YYDK302 D
                             WHERE A.RUN_DT BETWEEN '20140101' AND '20140131'
                               AND B.RUN_DT = A.RUN_DT
                               AND B.TRN_NO = A.TRN_NO
                               AND B.TRN_ATT_CD IN ('1', '6')
                               AND A.RUN_DT = C.RUN_DT
                               AND A.TRN_NO = C.TRN_NO
                               AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                               AND C.STOP_RS_STN_CD = NVL ('', C.STOP_RS_STN_CD)
                               AND A.RUN_DT = D.RUN_DT
                               AND A.TRN_NO = D.TRN_NO
                               AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                               AND D.STOP_RS_STN_CD = NVL ('', D.STOP_RS_STN_CD)
                          GROUP BY A.RUN_DT
                                  ,A.TRN_NO
                                  ,A.PSRM_CL_CD
                                  ,A.BKCL_CD) A
                        ,(  SELECT A.RUN_DT
                                  ,A.TRN_NO
                                  ,A.PSRM_CL_CD
                                  ,SUM (A.BS_SEAT_NUM) SEAT_CNT
                              FROM TB_YYDK305 A, TB_YYDK301 B
                             WHERE B.RUN_DT BETWEEN '20140101' AND '20140131'
                               AND B.TRN_ATT_CD IN ('1', '6')
                               AND A.RUN_DT = B.RUN_DT
                               AND A.TRN_NO = B.TRN_NO
                               AND A.GEN_SEAT_DUP_FLG = 'N'
                               AND A.SEAT_ATT_CD IN ('003', '015', '016', '017', '018', '019', '020', '021', '022', '023', '024', '027', '028')
                          GROUP BY A.RUN_DT, A.TRN_NO, A.PSRM_CL_CD) B
                        ,TB_YYDK301 C
                        ,TB_YYDK302 D
                        ,TB_YYDK302 E
                        ,TB_YYDK002 F
                        ,TB_YYDK201 G
                   WHERE B.RUN_DT = A.RUN_DT
                     AND B.TRN_NO = A.TRN_NO
                     AND B.PSRM_CL_CD = A.PSRM_CL_CD
                     AND C.RUN_DT = B.RUN_DT
                     AND C.TRN_NO = B.TRN_NO
                     AND C.STLB_TRN_CLSF_CD = NVL ('00', C.STLB_TRN_CLSF_CD)
                     AND C.UP_DN_DV_CD = DECODE (00, 00, C.UP_DN_DV_CD, 00)
                     AND D.RUN_DT = C.RUN_DT
                     AND D.TRN_NO = C.TRN_NO
                     AND D.STOP_RS_STN_CD = C.ORG_RS_STN_CD
                     AND E.RUN_DT = C.RUN_DT
                     AND E.TRN_NO = C.TRN_NO
                     AND E.STOP_RS_STN_CD = C.TMN_RS_STN_CD
                     AND A.RUN_DT = F.RUN_DT
                     AND F.DAY_DV_CD LIKE DECODE ('0', '0', '%', '0')
                     AND C.ROUT_CD = G.ROUT_CD
                     AND G.MRNT_CD = NVL ('01', G.MRNT_CD)
                     AND G.MRNT_CD IN ('01', '03', '04')
                     AND A.PSRM_CL_CD = NVL ('', A.PSRM_CL_CD)
                     AND A.BKCL_CD = NVL ('', A.BKCL_CD)) A
                ,(  SELECT A.RUN_DT
                          ,A.TRN_NO
                          ,A.PSRM_CL_CD
                          ,DECODE ('', 'F2', 'F1', A.BKCL_CD) AS BKCL_CD
                          ,DECODE ('N', 'N', SUM (A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT), SUM (A.BIZ_RVN_AMT)) AS BIZ_RVN_AMT
                      FROM TB_YYDS512 A
                          ,TB_YYDK301 B
                          ,TB_YYDK302 C
                          ,TB_YYDK302 D
                     WHERE A.RUN_DT BETWEEN '20140101' AND '20140131'
                       AND A.PSRM_CL_CD = NVL ('', A.PSRM_CL_CD)
                       AND A.BKCL_CD = NVL ('', A.BKCL_CD)
                       AND B.RUN_DT = A.RUN_DT
                       AND B.TRN_NO = A.TRN_NO
                       AND B.TRN_ATT_CD IN ('1', '6')
                       AND A.RUN_DT = C.RUN_DT
                       AND A.TRN_NO = C.TRN_NO
                       AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                       AND C.STOP_RS_STN_CD = NVL ('', C.STOP_RS_STN_CD)
                       AND A.RUN_DT = D.RUN_DT
                       AND A.TRN_NO = D.TRN_NO
                       AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                       AND D.STOP_RS_STN_CD = NVL ('', D.STOP_RS_STN_CD)
                  GROUP BY A.RUN_DT
                          ,A.TRN_NO
                          ,A.PSRM_CL_CD
                          ,A.BKCL_CD) B
                ,(  SELECT RUN_DT
                          ,TRN_NO
                          ,PSRM_CL_CD
                          ,SUM (BS_SEAT_NUM) AS BS_SEAT_NUM
                      FROM TB_YYDK305
                     WHERE RUN_DT BETWEEN '20140101' AND '20140131'
                       AND PSRM_CL_CD = NVL ('', PSRM_CL_CD)
                       AND GEN_SEAT_DUP_FLG = 'N'
                  GROUP BY RUN_DT, TRN_NO, PSRM_CL_CD) C
           WHERE A.RUN_DT = B.RUN_DT
             AND A.TRN_NO = B.TRN_NO
             AND A.PSRM_CL_CD = B.PSRM_CL_CD
             AND A.BKCL_CD = B.BKCL_CD
             AND A.RUN_DT = C.RUN_DT
             AND A.TRN_NO = C.TRN_NO
             AND A.PSRM_CL_CD = C.PSRM_CL_CD
        GROUP BY A.RUN_DT, A.TRN_NO, C.BS_SEAT_NUM) A



YZDBA                          TB_YYDK205                     PK_YYDK205                         589577 => STN_CONS_ORDR,ROUT_CD,APL_CLS_DT
YZDBA                          TB_YYDK205                     UK_YYDK205_01                      589577 => ROUT_CD,STN_CONS_ORDR,APL_ST_DT

튜닝 내용
    1달치 데이터의 정보 조회
    
    인덱스 수정 검토 및 function(40만번 이상 호출)  사용시에 scalar subquery 사용
        수정  인덱스  : TB_YYDK205( ROUT_CD,STN_CONS_ORDR,APL_CLS_DT,APL_ST_DT)
        
        수정 sql :            A.ABRD_PRNB  * (select FN_YB_GETROUTDSTCAL(....)  from dual )   
           ( scalar subquery 로 변경을 위함)





------------------------------------------------------------------------------------------------------------
| Id  | Operation                                  | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                           |               |     1 |    67 | 20028   (1)| 00:04:01 |
|   1 |  FAST DUAL                                 |               |     1 |       |     2   (0)| 00:00:01 |
|   2 |   FAST DUAL                                |               |     1 |       |     2   (0)| 00:00:01 |
|   3 |  SORT AGGREGATE                            |               |     1 |    67 |            |          |
|   4 |   VIEW                                     |               |     1 |    67 | 20028   (1)| 00:04:01 |
|   5 |    HASH GROUP BY                           |               |     1 |   217 | 20028   (1)| 00:04:01 |
|   6 |     NESTED LOOPS                           |               |       |       |            |          |
|   7 |      NESTED LOOPS                          |               |     1 |   217 | 20027   (1)| 00:04:01 |
|   8 |       NESTED LOOPS                         |               |     1 |   194 | 20024   (1)| 00:04:01 |
|   9 |        NESTED LOOPS                        |               |     1 |   171 | 20021   (1)| 00:04:01 |
|  10 |         NESTED LOOPS                       |               |     1 |   160 | 20020   (1)| 00:04:01 |
|* 11 |          HASH JOIN                         |               |    17 |  2363 | 19850   (1)| 00:03:59 |
|  12 |           NESTED LOOPS                     |               |     4 |   372 |  1693   (2)| 00:00:21 |
|* 13 |            HASH JOIN                       |               |    10 |   730 |  1643   (1)| 00:00:20 |
|  14 |             VIEW                           |               |   246 |  7380 |  1092   (1)| 00:00:14 |
|  15 |              HASH GROUP BY                 |               |   246 | 10824 |  1092   (1)| 00:00:14 |
|* 16 |               HASH JOIN                    |               |  3074 |   132K|  1091   (1)| 00:00:14 |
|* 17 |                TABLE ACCESS BY INDEX ROWID | TB_YYDK305    |  3074 | 82998 |  1065   (1)| 00:00:13 |
|* 18 |                 INDEX RANGE SCAN           | PK_YYDK305    |  6746 |       |    56   (0)| 00:00:01 |
|* 19 |                TABLE ACCESS BY INDEX ROWID | TB_YYDK301    |  8467 |   140K|    25   (0)| 00:00:01 |
|* 20 |                 INDEX RANGE SCAN           | PK_YYDK301    |  8489 |       |     2   (0)| 00:00:01 |
|  21 |             NESTED LOOPS                   |               |       |       |            |          |
|  22 |              NESTED LOOPS                  |               |  3983 |   167K|   550   (1)| 00:00:07 |
|* 23 |               TABLE ACCESS FULL            | TB_YYDK201    |     2 |    16 |    24   (0)| 00:00:01 |
|* 24 |               INDEX RANGE SCAN             | IX_YYDK301_01 |  3540 |       |    14   (0)| 00:00:01 |
|* 25 |              TABLE ACCESS BY INDEX ROWID   | TB_YYDK301    |  1981 | 69335 |   512   (1)| 00:00:07 |
|* 26 |            VIEW PUSHED PREDICATE           |               |     1 |    20 |     5  (20)| 00:00:01 |
|  27 |             SORT GROUP BY                  |               |     1 |    23 |     5  (20)| 00:00:01 |
|* 28 |              FILTER                        |               |       |       |            |          |
|* 29 |               TABLE ACCESS BY INDEX ROWID  | TB_YYDK305    |     1 |    23 |     4   (0)| 00:00:01 |
|* 30 |                INDEX RANGE SCAN            | PK_YYDK305    |     1 |       |     3   (0)| 00:00:01 |
|  31 |           VIEW                             |               |  5391 |   242K| 18156   (1)| 00:03:38 |
|  32 |            HASH GROUP BY                   |               |  5391 |   526K| 18156   (1)| 00:03:38 |
|* 33 |             HASH JOIN                      |               |  8709 |   850K| 18154   (1)| 00:03:38 |
|* 34 |              HASH JOIN                     |               |  8709 |   654K| 10170   (1)| 00:02:03 |
|* 35 |               HASH JOIN                    |               |  8709 |   459K|  2187   (1)| 00:00:27 |
|* 36 |                TABLE ACCESS BY INDEX ROWID | TB_YYDK301    |  8467 |   181K|    25   (0)| 00:00:01 |
|* 37 |                 INDEX RANGE SCAN           | PK_YYDK301    |  8489 |       |     2   (0)| 00:00:01 |
|  38 |                TABLE ACCESS BY INDEX ROWID | TB_YYDS510    | 59103 |  1846K|  2160   (1)| 00:00:26 |
|* 39 |                 INDEX RANGE SCAN           | PK_YYDS510    | 59103 |       |   345   (1)| 00:00:05 |
|* 40 |               INDEX RANGE SCAN             | PK_YYDK302    | 63451 |       |   252   (1)| 00:00:04 |
|* 41 |              INDEX RANGE SCAN              | PK_YYDK302    | 63451 |       |   252   (1)| 00:00:04 |
|  42 |          VIEW PUSHED PREDICATE             |               |     1 |    21 |    10   (0)| 00:00:01 |
|  43 |           SORT GROUP BY                    |               |     1 |    98 |    10   (0)| 00:00:01 |
|* 44 |            FILTER                          |               |       |       |            |          |
|  45 |             NESTED LOOPS                   |               |       |       |            |          |
|  46 |              NESTED LOOPS                  |               |     1 |    98 |    10   (0)| 00:00:01 |
|  47 |               NESTED LOOPS                 |               |     1 |    75 |     8   (0)| 00:00:01 |
|  48 |                NESTED LOOPS                |               |     1 |    52 |     6   (0)| 00:00:01 |
|* 49 |                 TABLE ACCESS BY INDEX ROWID| TB_YYDK301    |     1 |    17 |     2   (0)| 00:00:01 |
|* 50 |                  INDEX UNIQUE SCAN         | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|  51 |                 TABLE ACCESS BY INDEX ROWID| TB_YYDS512    |     1 |    35 |     4   (0)| 00:00:01 |
|* 52 |                  INDEX RANGE SCAN          | PK_YYDS512    |     1 |       |     3   (0)| 00:00:01 |
|* 53 |                INDEX UNIQUE SCAN           | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|* 54 |               INDEX UNIQUE SCAN            | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|  55 |              TABLE ACCESS BY INDEX ROWID   | TB_YYDK302    |     1 |    23 |     2   (0)| 00:00:01 |
|* 56 |         TABLE ACCESS BY INDEX ROWID        | TB_YYDK002    |     1 |    11 |     1   (0)| 00:00:01 |
|* 57 |          INDEX UNIQUE SCAN                 | PK_YYDK002    |     1 |       |     0   (0)| 00:00:01 |
|* 58 |        TABLE ACCESS BY INDEX ROWID         | TB_YYDK302    |     1 |    23 |     3   (0)| 00:00:01 |
|* 59 |         INDEX RANGE SCAN                   | PK_YYDK302    |     5 |       |     2   (0)| 00:00:01 |
|* 60 |       INDEX RANGE SCAN                     | PK_YYDK302    |     5 |       |     2   (0)| 00:00:01 |
|* 61 |      TABLE ACCESS BY INDEX ROWID           | TB_YYDK302    |     1 |    23 |     3   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

  11 - access("B"."RUN_DT"="A"."RUN_DT" AND "B"."TRN_NO"="A"."TRN_NO" AND
              "B"."PSRM_CL_CD"="A"."PSRM_CL_CD")
  13 - access("C"."RUN_DT"="B"."RUN_DT" AND "C"."TRN_NO"="B"."TRN_NO")
  16 - access("A"."RUN_DT"="B"."RUN_DT" AND "A"."TRN_NO"="B"."TRN_NO")
  17 - filter("A"."GEN_SEAT_DUP_FLG"='N' AND ("A"."SEAT_ATT_CD"='003' OR "A"."SEAT_ATT_CD"='015' OR
              "A"."SEAT_ATT_CD"='016' OR "A"."SEAT_ATT_CD"='017' OR "A"."SEAT_ATT_CD"='018' OR
              "A"."SEAT_ATT_CD"='019' OR "A"."SEAT_ATT_CD"='020' OR "A"."SEAT_ATT_CD"='021' OR
              "A"."SEAT_ATT_CD"='022' OR "A"."SEAT_ATT_CD"='023' OR "A"."SEAT_ATT_CD"='024' OR
              "A"."SEAT_ATT_CD"='027' OR "A"."SEAT_ATT_CD"='028'))
  18 - access("A"."RUN_DT">='20140101' AND "A"."RUN_DT"<='20140131')
  19 - filter("B"."TRN_ATT_CD"='1' OR "B"."TRN_ATT_CD"='6')
  20 - access("B"."RUN_DT">='20140101' AND "B"."RUN_DT"<='20140131')
  23 - filter("G"."MRNT_CD"='01' AND ("G"."MRNT_CD"='01' OR "G"."MRNT_CD"='03' OR
              "G"."MRNT_CD"='04'))
  24 - access("C"."ROUT_CD"="G"."ROUT_CD")
  25 - filter("C"."STLB_TRN_CLSF_CD"='00')
  26 - filter("B"."PSRM_CL_CD"="C"."PSRM_CL_CD")
  28 - filter('20140131'>="B"."RUN_DT" AND '20140101'<="B"."RUN_DT")
  29 - filter("GEN_SEAT_DUP_FLG"='N')
  30 - access("RUN_DT"="B"."RUN_DT" AND "TRN_NO"="B"."TRN_NO")
       filter("RUN_DT">='20140101' AND "RUN_DT"<='20140131')
  33 - access("A"."RUN_DT"="D"."RUN_DT" AND "A"."TRN_NO"="D"."TRN_NO" AND
              "A"."ARV_STN_CONS_ORDR"="D"."STN_CONS_ORDR")
  34 - access("A"."RUN_DT"="C"."RUN_DT" AND "A"."TRN_NO"="C"."TRN_NO" AND
              "A"."DPT_STN_CONS_ORDR"="C"."STN_CONS_ORDR")
  35 - access("B"."RUN_DT"="A"."RUN_DT" AND "B"."TRN_NO"="A"."TRN_NO")
  36 - filter("B"."TRN_ATT_CD"='1' OR "B"."TRN_ATT_CD"='6')
  37 - access("B"."RUN_DT">='20140101' AND "B"."RUN_DT"<='20140131')
  39 - access("A"."RUN_DT">='20140101' AND "A"."RUN_DT"<='20140131')
  40 - access("C"."RUN_DT">='20140101' AND "C"."RUN_DT"<='20140131')
  41 - access("D"."RUN_DT">='20140101' AND "D"."RUN_DT"<='20140131')
  44 - filter('20140131'>="B"."RUN_DT" AND '20140101'<="B"."RUN_DT")
  49 - filter("B"."TRN_ATT_CD"='1' OR "B"."TRN_ATT_CD"='6')
  50 - access("B"."RUN_DT"="B"."RUN_DT" AND "B"."TRN_NO"="B"."TRN_NO")
       filter("B"."RUN_DT">='20140101' AND "B"."RUN_DT"<='20140131')
  52 - access("A"."RUN_DT"="B"."RUN_DT" AND "A"."TRN_NO"="B"."TRN_NO" AND
              "A"."PSRM_CL_CD"="B"."PSRM_CL_CD" AND "A"."BKCL_CD"="A"."BKCL_CD")
       filter("A"."BKCL_CD"="A"."BKCL_CD" AND "A"."PSRM_CL_CD"="B"."PSRM_CL_CD" AND
              "A"."RUN_DT">='20140101' AND "A"."RUN_DT"<='20140131' AND "B"."RUN_DT"="A"."RUN_DT" AND
              "B"."TRN_NO"="A"."TRN_NO")
  53 - access("C"."RUN_DT"="B"."RUN_DT" AND "C"."TRN_NO"="B"."TRN_NO" AND
              "A"."DPT_STN_CONS_ORDR"="C"."STN_CONS_ORDR")
       filter("C"."RUN_DT">='20140101' AND "C"."RUN_DT"<='20140131' AND "A"."RUN_DT"="C"."RUN_DT"
              AND "A"."TRN_NO"="C"."TRN_NO")
  54 - access("D"."RUN_DT"="B"."RUN_DT" AND "D"."TRN_NO"="B"."TRN_NO" AND
              "A"."ARV_STN_CONS_ORDR"="D"."STN_CONS_ORDR")
       filter("D"."RUN_DT">='20140101' AND "D"."RUN_DT"<='20140131' AND "A"."RUN_DT"="D"."RUN_DT"
              AND "A"."TRN_NO"="D"."TRN_NO")
  56 - filter("F"."DAY_DV_CD" LIKE '%')
  57 - access("A"."RUN_DT"="F"."RUN_DT")
  58 - filter("E"."STOP_RS_STN_CD"="C"."TMN_RS_STN_CD")
  59 - access("E"."RUN_DT"="C"."RUN_DT" AND "E"."TRN_NO"="C"."TRN_NO")
  60 - access("D"."RUN_DT"="C"."RUN_DT" AND "D"."TRN_NO"="C"."TRN_NO")
  61 - filter("D"."STOP_RS_STN_CD"="C"."ORG_RS_STN_CD")
        
