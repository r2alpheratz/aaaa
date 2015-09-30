SELECT *    /*+com.korail.yz.yf.ba.YFBA003QMDAO.selectListTrnPssr*/
FROM (SELECT
        NVL2 (A.TRN_NO, A.TRN_NO, B.TRN_NO) TRN_NO /*열차번호*/
        ,NVL2 (A.DPT_STGP_CD ,A.DPT_STGP_CD , B.DPT_STGP_CD ) DPT_STGP_CD  /*출발역그룹코드*/
        ,NVL2 (A.DPT_STGP_NM ,A.DPT_STGP_NM , B.DPT_STGP_NM ) DPT_STGP_NM  /*출발역그룹이름*/
        ,NVL2 (A.ARV_STGP_CD ,A.ARV_STGP_CD , B.ARV_STGP_CD ) ARV_STGP_CD  /*도착역그룹코드*/
        ,NVL2 (A.ARV_STGP_NM ,A.ARV_STGP_NM , B.ARV_STGP_NM ) ARV_STGP_NM  /*도착역그룹이름*/ 
        ,NVL2 (A.DAY_DV_CD ,A.DAY_DV_CD , B.DAY_DV_CD ) DAY_DV_CD  /*요일구분코드*/
        ,NVL2 (A.DAY_DV_NM ,A.DAY_DV_NM , B.DAY_DV_NM ) DAY_DV_NM  /*요일구분코드*/
        ,NVL2 (A.CHG_PLN_DEGR ,A.CHG_PLN_DEGR , B.CHG_PLN_DEGR ) CHG_PLN_DEGR
        ,NVL2 (A.YYYYMM ,A.YYYYMM , B.YYYYMM ) YYYYMM
        ,B.PRNB AS EXP_PRNB
        ,A.PRNB AS RST_PRNB
        ,( SELECT DPT_STN_CONS_ORDR
             FROM TB_YYDD505
            WHERE RUN_DT BETWEEN RPAD('201301', 8,'01') AND RPAD('201405', 8, '31') 
              AND TRN_NO = LPAD(TRIM(NVL2 (A.TRN_NO, A.TRN_NO, B.TRN_NO)),5,'0')
              AND DPT_STGP_CD = NVL2 (A.DPT_STGP_CD ,A.DPT_STGP_CD , B.DPT_STGP_CD )
              AND ARV_STGP_CD = NVL2 (A.ARV_STGP_CD ,A.ARV_STGP_CD , B.ARV_STGP_CD )
              AND ROWNUM = 1 ) AS DPT_STN_CONS_ORDR
        ,( SELECT ARV_STN_CONS_ORDR
             FROM TB_YYDD505
            WHERE RUN_DT BETWEEN RPAD('201301', 8,'01') AND RPAD('201405', 8, '31') 
              AND TRN_NO = LPAD(TRIM(NVL2 (A.TRN_NO, A.TRN_NO, B.TRN_NO)),5,'0')
              AND DPT_STGP_CD = NVL2 (A.DPT_STGP_CD ,A.DPT_STGP_CD , B.DPT_STGP_CD )
              AND ARV_STGP_CD = NVL2 (A.ARV_STGP_CD ,A.ARV_STGP_CD , B.ARV_STGP_CD )
              AND ROWNUM = 1 ) AS ARV_STN_CONS_ORDR
   FROM (SELECT DISTINCT
                LPAD(LTRIM(A.TRN_NO, 0 ), 5,' ') AS TRN_NO,                    
                A.DAY_DV_CD,
                ( SELECT VLID_VAL_KOR_AVVR_NM
                       FROM TB_YYDK007
                      WHERE XROIS_OLD_SRT_CD = 'I909'
                       AND VLID_VAL = A.DAY_DV_CD ) DAY_DV_NM,                                      
                A.DPT_STGP_CD,    /* 출발역그룹코드 */
                ( SELECT VLID_VAL_KOR_AVVR_NM
                       FROM TB_YYDK007
                      WHERE XROIS_OLD_SRT_CD = 'Y019'
                       AND VLID_VAL = A.DPT_STGP_CD ) DPT_STGP_NM,              
                A.ARV_STGP_CD,        /* 도착역그룹코드 */            
                ( SELECT VLID_VAL_KOR_AVVR_NM
                       FROM TB_YYDK007
                      WHERE XROIS_OLD_SRT_CD = 'Y019'
                       AND VLID_VAL = A.ARV_STGP_CD ) ARV_STGP_NM,                
                A.RUN_YM  AS YYYYMM,                    
                A.CRG_PLN_NO || '(' || A.CRG_PLN_CHG_DEGR || ')' AS CHG_PLN_DEGR,                 
                A.WEIT_AVG_ABRD_PRNB PRNB
           FROM TB_YYFD207 A, /*열차별실적승차인원 TBL*/
                TB_YYFD002 B, /*역그룹핑 VIEW*/
                TB_YYFD002 C /*역그룹핑 VIEW*/
          WHERE A.TRN_NO       = LPAD(LTRIM('101'), 5,'0')                   
            AND A.STGP_DEGR   = (SELECT STGP_DEGR
                   FROM TB_YYFB001
                  WHERE     TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)                                 
            AND A.DPT_STGP_CD||'-'||A.ARV_STGP_CD IN ( '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020' )                    
            AND A.RUN_YM      BETWEEN '201301' AND '201405'
            AND ('0' IN ('0','8','9') OR A.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
            AND B.STGP_CD     = A.DPT_STGP_CD                    
            AND B.STGP_DEGR   = (SELECT STGP_DEGR
                   FROM TB_YYFB001
                  WHERE     TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)               
            AND C.STGP_CD     = A.ARV_STGP_CD                    
            AND C.STGP_DEGR   = (SELECT STGP_DEGR
                   FROM TB_YYFB001
                  WHERE     TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                        AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)                               
        ) A FULL OUTER JOIN                    
        (SELECT DISTINCT
                LPAD(LTRIM(A.TRN_NO, 0 ), 5,' ') AS TRN_NO,                    
                A.DAY_DV_CD AS DAY_DV_CD,
                ( SELECT VLID_VAL_KOR_AVVR_NM
                       FROM TB_YYDK007
                      WHERE XROIS_OLD_SRT_CD = 'I909'
                       AND VLID_VAL = A.DAY_DV_CD ) DAY_DV_NM,                              
                A.DPT_STGP_CD,    /* 출발역그룹코드 */
                ( SELECT VLID_VAL_KOR_AVVR_NM
                       FROM TB_YYDK007
                      WHERE XROIS_OLD_SRT_CD = 'Y019'
                       AND VLID_VAL = A.DPT_STGP_CD ) DPT_STGP_NM,              
                A.ARV_STGP_CD,        /* 도착역그룹코드 */            
                ( SELECT VLID_VAL_KOR_AVVR_NM
                       FROM TB_YYDK007
                      WHERE XROIS_OLD_SRT_CD = 'Y019'
                       AND VLID_VAL = A.ARV_STGP_CD ) ARV_STGP_NM, 
                A.FCST_YM AS YYYYMM,                    
                A.CRG_PLN_NO || '(' || A.CRG_PLN_CHG_DEGR || ')' AS CHG_PLN_DEGR,                    
                A.FCST_ABRD_PRNB PRNB                    
           FROM TB_YYFD208 A,                    
                TB_YYFD203 B, 
                TB_YYFD002 C, 
                TB_YYFD002 D
          WHERE B.FCST_MDL_SEL_FLG = 'Y'
            AND ('0' IN ('0','8','9') OR B.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
            AND B.DPT_STGP_CD||'-'||B.ARV_STGP_CD IN (  '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020'  )                  
            AND B.FCST_ACHV_DT = (SELECT MAX(FCST_ACHV_DT)
                                   FROM TB_YYFD208
                                  WHERE TRN_NO      = LPAD(TRIM('101'),5,'0')
                                    AND STGP_DEGR   =  ( SELECT STGP_DEGR
                                         FROM TB_YYFB001
                                      WHERE     TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                                          AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT) 
                                    AND DPT_STGP_CD||'-'||ARV_STGP_CD IN (  '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020'  )
                                                AND ('0' IN ('0','8','9') OR DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
                                    AND FCST_YM     BETWEEN '201301' AND '201405'
                                )
            AND A.FCST_ACHV_DT    = B.FCST_ACHV_DT                    
            AND A.FCST_MDL_DV_CD = B.FCST_MDL_DV_CD                    
            AND A.STGP_DEGR      = B.STGP_DEGR                    
            AND A.DAY_DV_CD      = B.DAY_DV_CD                    
            AND A.DPT_STGP_CD    = B.DPT_STGP_CD                    
            AND A.ARV_STGP_CD    = B.ARV_STGP_CD                    
            AND A.STGP_DEGR      = (SELECT STGP_DEGR
                                      FROM TB_YYFB001
                                     WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                                       AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)               
            AND A.TRN_NO         = LPAD(LTRIM('101'), 5,'0')                                    
            AND A.DPT_STGP_CD||'-'||A.ARV_STGP_CD IN ( '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020' )                    
            AND ('0' IN ('0','8','9') OR A.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
            AND A.FCST_YM        BETWEEN '201301' AND '201405'
            AND C.STGP_CD        = A.DPT_STGP_CD                    
            AND C.STGP_DEGR      = (SELECT STGP_DEGR
                                      FROM TB_YYFB001
                                     WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                                       AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)                   
            AND D.STGP_CD        = A.ARV_STGP_CD                    
            AND D.STGP_DEGR      = (SELECT STGP_DEGR
                                      FROM TB_YYFB001
                                     WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                                       AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)    
        )B                    
     ON A.TRN_NO       = B.TRN_NO                                      
    AND A.YYYYMM       = B.YYYYMM                    
    AND A.CHG_PLN_DEGR = B.CHG_PLN_DEGR                    
    AND A.DAY_DV_CD    = B.DAY_DV_CD                    
    AND A.DPT_STGP_CD  = B.DPT_STGP_CD                    
    AND A.ARV_STGP_CD  = B.ARV_STGP_CD
) 
    ORDER BY TRN_NO, DPT_STN_CONS_ORDR, ARV_STN_CONS_ORDR, DAY_DV_CD, CHG_PLN_DEGR, YYYYMM


인덱스 정보 
YZDBA        TB_YYFD208        PK_YYFD208       15072291  => TRN_CLSF_CD,FCST_ACHV_DT,STGP_DEGR,DPT_STGP_CD,ARV_STGP_CD,DAY_DV_CD,FCST_MDL_DV_CD,FCST_YM,TRN_NO,CRG_PLN_NO


튜닝 내용
   SQL 수정 및 인덱스 생성 
       현재 : AND  A.DPT_STGP_CD||'-'||A.ARV_STGP_CD IN ( '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
       수정 : AND (A.DPT_STGP_CD,A.ARV_STGP_CD ) IN     ( ( '01001','01003') ,('01001','01008'),('01003','01008') ,('01001','01010') ,('01003','01010'),('01001','01016'),
       
       필요 인덱스 : TB_YYFD208 ( TRN_NO,DPT_STGP_CD,ARV_STGP_CD,STGP_DEGR,FCST_YM,FCST_ACHV_DT  ) FCST_ACHV_DT 컬럼은 옵션임
       
       
   조인 조건 추가 검토 바람. 
      and a.TRN_CLSF_CD=b.TRN_CLSF_CD




-------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name          | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |               | 43980 |    19M|       | 21994   (1)| 00:04:24 |
|   1 |  TABLE ACCESS BY INDEX ROWID        | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|   3 |   TABLE ACCESS BY INDEX ROWID       | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|*  4 |    INDEX RANGE SCAN                 | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|   5 |  TABLE ACCESS BY INDEX ROWID        | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|*  6 |   INDEX RANGE SCAN                  | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|   7 |   TABLE ACCESS BY INDEX ROWID       | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|*  8 |    INDEX RANGE SCAN                 | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|   9 |  TABLE ACCESS BY INDEX ROWID        | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|* 10 |   INDEX RANGE SCAN                  | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|  11 |   TABLE ACCESS BY INDEX ROWID       | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|* 12 |    INDEX RANGE SCAN                 | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|* 13 |  COUNT STOPKEY                      |               |       |       |       |            |          |
|* 14 |   TABLE ACCESS BY INDEX ROWID       | TB_YYDD505    |     1 |    30 |       |   288   (1)| 00:00:04 |
|* 15 |    INDEX RANGE SCAN                 | IX_YYDD505_02 |  8724 |       |       |    17   (0)| 00:00:01 |
|* 16 |  COUNT STOPKEY                      |               |       |       |       |            |          |
|* 17 |   TABLE ACCESS BY INDEX ROWID       | TB_YYDD505    |     1 |    30 |       |   288   (1)| 00:00:04 |
|* 18 |    INDEX RANGE SCAN                 | IX_YYDD505_02 |  8724 |       |       |    17   (0)| 00:00:01 |
|  19 |  SORT ORDER BY                      |               | 43980 |    19M|    21M| 21994   (1)| 00:04:24 |
|  20 |   VIEW                              | VW_FOJ_0      | 43980 |    19M|       | 17649   (1)| 00:03:32 |
|* 21 |    HASH JOIN FULL OUTER             |               | 43980 |    19M|       | 17649   (1)| 00:03:32 |
|  22 |     VIEW                            |               |     1 |   228 |       |   130   (4)| 00:00:02 |
|  23 |      HASH UNIQUE                    |               |     1 |    62 |       |   130   (4)| 00:00:02 |
|* 24 |       HASH JOIN                     |               | 10812 |   654K|       |   125   (2)| 00:00:02 |
|* 25 |        INDEX FAST FULL SCAN         | IX_YYFD002_01 |   650 |  5850 |       |     2   (0)| 00:00:01 |
|* 26 |         INDEX RANGE SCAN            | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|* 27 |        HASH JOIN                    |               |  1607 | 85171 |       |   122   (1)| 00:00:02 |
|  28 |         TABLE ACCESS BY INDEX ROWID | TB_YYFD207    |   239 | 10516 |       |   119   (0)| 00:00:02 |
|* 29 |          INDEX SKIP SCAN            | PK_YYFD207    |   104 |       |       |   111   (0)| 00:00:02 |
|* 30 |           INDEX RANGE SCAN          | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|* 31 |         INDEX FAST FULL SCAN        | IX_YYFD002_01 |   650 |  5850 |       |     2   (0)| 00:00:01 |
|* 32 |          INDEX RANGE SCAN           | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|  33 |     VIEW                            |               | 43979 |  9792K|       | 17518   (1)| 00:03:31 |
|  34 |      HASH UNIQUE                    |               | 43979 |  4552K|  5040K| 17518   (1)| 00:03:31 |
|* 35 |       HASH JOIN                     |               | 43979 |  4552K|       | 11068   (1)| 00:02:13 |
|* 36 |        INDEX FAST FULL SCAN         | IX_YYFD002_01 |   650 |  5850 |       |     2   (0)| 00:00:01 |
|* 37 |         INDEX RANGE SCAN            | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|* 38 |        HASH JOIN                    |               |  6176 |   585K|       | 11065   (1)| 00:02:13 |
|* 39 |         INDEX FAST FULL SCAN        | IX_YYFD002_01 |   650 |  5850 |       |     2   (0)| 00:00:01 |
|* 40 |          INDEX RANGE SCAN           | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|* 41 |         HASH JOIN                   |               |   874 | 76912 |       | 11062   (1)| 00:02:13 |
|* 42 |          TABLE ACCESS BY INDEX ROWID| TB_YYFD203    |   872 | 27904 |       |  1637   (1)| 00:00:20 |
|* 43 |           INDEX SKIP SCAN           | PK_YYFD203    |  1297 |       |       |  1238   (1)| 00:00:15 |
|  44 |            SORT AGGREGATE           |               |     1 |    37 |       |            |          |
|* 45 |             INDEX SKIP SCAN         | PK_YYFD208    | 12161 |   439K|       |  5382   (1)| 00:01:05 |
|* 46 |              INDEX RANGE SCAN       | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|  47 |          TABLE ACCESS BY INDEX ROWID| TB_YYFD208    | 12161 |   665K|       |  9425   (1)| 00:01:54 |
|* 48 |           INDEX SKIP SCAN           | PK_YYFD208    |  5263 |       |       |  5382   (1)| 00:01:05 |
|* 49 |            INDEX RANGE SCAN         | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------------------------

