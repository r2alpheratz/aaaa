SELECT /*+com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspPssr*/
 *
FROM
(
SELECT  T1.TRN_NO, T1.DAY_DV_CD,T1.DAY_DV_NM,T1.DPT_STGP_CD,T1.DPT_STGP_NM,T1.ARV_STGP_CD,T1.ARV_STGP_NM,T1.YYYYMM,T1.CRG_PLN_NO,T1.CRG_PLN_CHG_DEGR,
T1.CHG_PLN_DEGR, T1.FLAG,
                ( SELECT DPT_STN_CONS_ORDR
                    FROM TB_YYDD505
                   WHERE RUN_DT BETWEEN RPAD('201310', 8,'01') AND RPAD('201410', 8, '31')
                     AND TRN_NO = LPAD(TRIM(T1.TRN_NO),5,'0')
                     AND DPT_STGP_CD = T1.DPT_STGP_CD
                     AND ARV_STGP_CD = T1.ARV_STGP_CD
                     AND ROWNUM = 1 ) AS DPT_STN_CONS_ORDR,
                ( SELECT ARV_STN_CONS_ORDR
                    FROM TB_YYDD505
                   WHERE RUN_DT BETWEEN RPAD('201310', 8,'01') AND RPAD('201410', 8, '31')
                     AND TRN_NO = LPAD(TRIM(T1.TRN_NO),5,'0')
                     AND DPT_STGP_CD = T1.DPT_STGP_CD
                     AND ARV_STGP_CD = T1.ARV_STGP_CD
                     AND ROWNUM = 1 ) AS ARV_STN_CONS_ORDR,
  SUM(DSP_01) DSP_01,
  SUM(DSP_02) DSP_02 ,
  SUM(DSP_03) DSP_03,
  SUM(DSP_04) DSP_04,
  SUM(DSP_05) DSP_05,
  SUM(DSP_06) DSP_06,
  SUM(DSP_07) DSP_07,
  SUM(DSP_08) DSP_08,
  SUM(DSP_09) DSP_09,
  SUM(DSP_10) DSP_10,SUM(DSP_11) DSP_11,
  SUM(DSP_12) DSP_12,SUM(DSP_13) DSP_13,SUM(DSP_14) DSP_14,SUM(DSP_15) DSP_15,SUM(DSP_16) DSP_16,SUM(DSP_17) DSP_17,SUM(DSP_18) DSP_18,SUM(DSP_19) DSP_19,SUM(DSP_20) DSP_20
  FROM
(
SELECT
     DISTINCT
     LPAD(LTRIM(A.TRN_NO,0), 5 , ' ')  AS TRN_NO,                      /* 열차번호           */
       A.DAY_DV_CD AS DAY_DV_CD,                                         /* 요일        CD     */
       ( SELECT VLID_VAL_KOR_AVVR_NM
            FROM TB_YYDK007
               WHERE XROIS_OLD_SRT_CD = 'I909'
             AND VLID_VAL = A.DAY_DV_CD ) DAY_DV_NM,                     /* 요일               */
       A.DPT_STGP_CD,                                                    /* 출발역 그룹 CD     */
      ( SELECT VLID_VAL_KOR_AVVR_NM
          FROM TB_YYDK007
         WHERE XROIS_OLD_SRT_CD = 'Y019'
           AND VLID_VAL = A.DPT_STGP_CD ) DPT_STGP_NM,                   /* 출발역 그룹        */
       A.ARV_STGP_CD,                                                    /* 도착역 그룹 CD     */
       ( SELECT VLID_VAL_KOR_AVVR_NM
           FROM TB_YYDK007
          WHERE XROIS_OLD_SRT_CD = 'Y019'
            AND VLID_VAL = A.ARV_STGP_CD ) ARV_STGP_NM,                                       /* 도착역 그룹        */
       A.FCST_YM AS YYYYMM,                                      /* 예측 년월          */
     A.CRG_PLN_NO,
       A.CRG_PLN_CHG_DEGR,
       A.CRG_PLN_NO || '(' || A.CRG_PLN_CHG_DEGR || ')' AS CHG_PLN_DEGR, /* 수송계획변경차수   */
       '예약' AS FLAG,                                                   /* 예약/취소 구분     */
       (DECODE(A.DASP_DV_NO, 1, A.RSV_SALE_FCST_PRNB, 0)) DSP_01,
       (DECODE(A.DASP_DV_NO, 2, A.RSV_SALE_FCST_PRNB, 0)) DSP_02,
       (DECODE(A.DASP_DV_NO, 3, A.RSV_SALE_FCST_PRNB, 0)) DSP_03,
       (DECODE(A.DASP_DV_NO, 4, A.RSV_SALE_FCST_PRNB, 0)) DSP_04,
       (DECODE(A.DASP_DV_NO, 5, A.RSV_SALE_FCST_PRNB, 0)) DSP_05,
       (DECODE(A.DASP_DV_NO, 6, A.RSV_SALE_FCST_PRNB, 0)) DSP_06,
       (DECODE(A.DASP_DV_NO, 7, A.RSV_SALE_FCST_PRNB, 0)) DSP_07,
       (DECODE(A.DASP_DV_NO, 8, A.RSV_SALE_FCST_PRNB, 0)) DSP_08,
       (DECODE(A.DASP_DV_NO, 9, A.RSV_SALE_FCST_PRNB, 0)) DSP_09,
       (DECODE(A.DASP_DV_NO, 10, A.RSV_SALE_FCST_PRNB, 0)) DSP_10,
       (DECODE(A.DASP_DV_NO, 11, A.RSV_SALE_FCST_PRNB, 0)) DSP_11,
       (DECODE(A.DASP_DV_NO, 12, A.RSV_SALE_FCST_PRNB, 0)) DSP_12,
       (DECODE(A.DASP_DV_NO, 13, A.RSV_SALE_FCST_PRNB, 0)) DSP_13,
       (DECODE(A.DASP_DV_NO, 14, A.RSV_SALE_FCST_PRNB, 0)) DSP_14,
       (DECODE(A.DASP_DV_NO, 15, A.RSV_SALE_FCST_PRNB, 0)) DSP_15,
       (DECODE(A.DASP_DV_NO, 16, A.RSV_SALE_FCST_PRNB, 0)) DSP_16,
       (DECODE(A.DASP_DV_NO, 17, A.RSV_SALE_FCST_PRNB, 0)) DSP_17,
       (DECODE(A.DASP_DV_NO, 18, A.RSV_SALE_FCST_PRNB, 0)) DSP_18,
       (DECODE(A.DASP_DV_NO, 19, A.RSV_SALE_FCST_PRNB, 0)) DSP_19,
       (DECODE(A.DASP_DV_NO, 20, A.RSV_SALE_FCST_PRNB, 0)) DSP_20
  FROM TB_YYFD211 A, /* DSP별예약/취소예측 TBL */
       TB_YYFD203 B, /* 예측 오차율 TBL        */
       TB_YYFD002 C,  /* 역그룹핑내역TBL */
       TB_YYFD002 D   /* 역그룹핑내역TBL */
 WHERE B.FCST_ACHV_DT = (SELECT MAX(FCST_ACHV_DT)
                          FROM TB_YYFD211 AA,
                               TB_YYFB001 BB
                         WHERE AA.FCST_YM BETWEEN '201310' AND '201410'
                           AND AA.TRN_NO = LPAD(TRIM('101'),5,'0')
                           AND AA.STGP_DEGR = BB.STGP_DEGR
                           AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN BB.APL_ST_DT AND BB.APL_CLS_DT
                           AND ('0' IN ('0','8','9') OR AA.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
                           AND (AA.DPT_STGP_CD || '-' || AA.ARV_STGP_CD) IN (  '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020'  )
                       )
   AND B.FCST_MDL_SEL_FLG = 'Y'                                        /* 모형선택여부 = 'Y' */
   AND ('0' IN ('0','8','9') OR B.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
   AND (B.DPT_STGP_CD || '-' || B.ARV_STGP_CD) IN (  '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020'  )  /* 출도착(GOD) 리스트 */
   AND A.FCST_ACHV_DT = B.FCST_ACHV_DT                              /* 예측 수행 일자     */
   AND A.FCST_MDL_DV_CD = B.FCST_MDL_DV_CD                           /* 예측모형구분코드   */
   AND A.STGP_DEGR = (SELECT STGP_DEGR
                        FROM TB_YYFB001
                       WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                         AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)                              /* 역그룹 차수        */
   AND A.STGP_DEGR = B.STGP_DEGR                                /* 역그룹차수         */
   AND ('0' IN ('0','8','9') OR A.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
   AND A.DAY_DV_CD = B.DAY_DV_CD                                /* 요일 구분 코드     */
   AND A.DPT_STGP_CD = B.DPT_STGP_CD                              /* 출발역 그룹 코드   */
   AND A.ARV_STGP_CD = B.ARV_STGP_CD                              /* 도착역 그룹 코드   */
   AND (A.DPT_STGP_CD || '-' || A.ARV_STGP_CD) IN (  '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020'  ) /* 출도착(GOD) 리스트 */
   AND A.TRN_NO = LPAD(TRIM('101'),5,'0')          /* 열차번호           */
   AND A.FCST_YM BETWEEN '201310' AND '201410'          /* 조회기간(예측년월  */
   AND A.DPT_STGP_CD = C.STGP_CD
   AND A.ARV_STGP_CD = D.STGP_CD
   AND A.STGP_DEGR = C.STGP_DEGR
   AND A.STGP_DEGR = D.STGP_DEGR) T1
   GROUP BY T1.TRN_NO
     , T1.DAY_DV_CD
     , T1.DAY_DV_NM
     , T1.DPT_STGP_CD
     , T1.DPT_STGP_NM
     , T1.ARV_STGP_CD
     , T1.ARV_STGP_NM
     , T1.YYYYMM
     , T1.CRG_PLN_NO
     , T1.CRG_PLN_CHG_DEGR
     , T1.CHG_PLN_DEGR
     , T1.FLAG
 UNION ALL
SELECT  T2.TRN_NO, T2.DAY_DV_CD,T2.DAY_DV_NM,T2.DPT_STGP_CD,T2.DPT_STGP_NM,T2.ARV_STGP_CD,T2.ARV_STGP_NM,T2.YYYYMM,T2.CRG_PLN_NO,T2.CRG_PLN_CHG_DEGR,
T2.CHG_PLN_DEGR, T2.FLAG,
                ( SELECT DPT_STN_CONS_ORDR
                    FROM TB_YYDD505
                   WHERE RUN_DT BETWEEN RPAD('201310', 8,'01') AND RPAD('201410', 8, '31')
                     AND TRN_NO = LPAD(TRIM(T2.TRN_NO),5,'0')
                     AND DPT_STGP_CD = T2.DPT_STGP_CD
                     AND ARV_STGP_CD = T2.ARV_STGP_CD
                     AND ROWNUM = 1 ) AS DPT_STN_CONS_ORDR,
                ( SELECT ARV_STN_CONS_ORDR
                    FROM TB_YYDD505
                   WHERE RUN_DT BETWEEN RPAD('201310', 8,'01') AND RPAD('201410', 8, '31')
                     AND TRN_NO = LPAD(TRIM(T2.TRN_NO),5,'0')
                     AND DPT_STGP_CD = T2.DPT_STGP_CD
                     AND ARV_STGP_CD = T2.ARV_STGP_CD
                     AND ROWNUM = 1 ) AS ARV_STN_CONS_ORDR,
  SUM(DSP_01) DSP_01,
  SUM(DSP_02) DSP_02 ,
  SUM(DSP_03) DSP_03,
  SUM(DSP_04) DSP_04,
  SUM(DSP_05) DSP_05,
  SUM(DSP_06) DSP_06,
  SUM(DSP_07) DSP_07,
  SUM(DSP_08) DSP_08,
  SUM(DSP_09) DSP_09,
  SUM(DSP_10) DSP_10,SUM(DSP_11) DSP_11,
  SUM(DSP_12) DSP_12,SUM(DSP_13) DSP_13,SUM(DSP_14) DSP_14,SUM(DSP_15) DSP_15,SUM(DSP_16) DSP_16,SUM(DSP_17) DSP_17,SUM(DSP_18) DSP_18,SUM(DSP_19) DSP_19,SUM(DSP_20) DSP_20
  FROM
(
SELECT DISTINCT
     LPAD(LTRIM(A.TRN_NO,0), 5 , ' ')  AS TRN_NO,                      /* 열차번호           */
       A.DAY_DV_CD AS DAY_DV_CD,                                         /* 요일        CD     */
       ( SELECT VLID_VAL_KOR_AVVR_NM
            FROM TB_YYDK007
               WHERE XROIS_OLD_SRT_CD = 'I909'
             AND VLID_VAL = A.DAY_DV_CD ) DAY_DV_NM,              /* 요일               */
       A.DPT_STGP_CD,                                                    /* 출발역 그룹 CD     */
      ( SELECT VLID_VAL_KOR_AVVR_NM
          FROM TB_YYDK007
         WHERE XROIS_OLD_SRT_CD = 'Y019'
           AND VLID_VAL = A.DPT_STGP_CD ) DPT_STGP_NM,                   /* 출발역 그룹        */
       A.ARV_STGP_CD,                                                    /* 도착역 그룹 CD     */
       ( SELECT VLID_VAL_KOR_AVVR_NM
           FROM TB_YYDK007
          WHERE XROIS_OLD_SRT_CD = 'Y019'
            AND VLID_VAL = A.ARV_STGP_CD ) ARV_STGP_NM,                                       /* 도착역 그룹        */
       A.FCST_YM AS YYYYMM,                                              /* 예측 년월          */
       A.CRG_PLN_NO,
     A.CRG_PLN_CHG_DEGR,
       A.CRG_PLN_NO || '(' || A.CRG_PLN_CHG_DEGR || ')' AS CHG_PLN_DEGR, /* 수송계획변경차수   */
       '취소' AS FLAG,                                                   /* 예약/취소 구분     */
       (DECODE(A.DASP_DV_NO, 1, A.CNC_RET_FCST_PRNB, 0)) DSP_01,
       (DECODE(A.DASP_DV_NO, 2, A.CNC_RET_FCST_PRNB, 0)) DSP_02,
       (DECODE(A.DASP_DV_NO, 3, A.CNC_RET_FCST_PRNB, 0)) DSP_03,
       (DECODE(A.DASP_DV_NO, 4, A.CNC_RET_FCST_PRNB, 0)) DSP_04,
       (DECODE(A.DASP_DV_NO, 5, A.CNC_RET_FCST_PRNB, 0)) DSP_05,
       (DECODE(A.DASP_DV_NO, 6, A.CNC_RET_FCST_PRNB, 0)) DSP_06,
       (DECODE(A.DASP_DV_NO, 7, A.CNC_RET_FCST_PRNB, 0)) DSP_07,
       (DECODE(A.DASP_DV_NO, 8, A.CNC_RET_FCST_PRNB, 0)) DSP_08,
       (DECODE(A.DASP_DV_NO, 9, A.CNC_RET_FCST_PRNB, 0)) DSP_09,
       (DECODE(A.DASP_DV_NO, 10, A.CNC_RET_FCST_PRNB, 0)) DSP_10,
       (DECODE(A.DASP_DV_NO, 11, A.CNC_RET_FCST_PRNB, 0)) DSP_11,
       (DECODE(A.DASP_DV_NO, 12, A.CNC_RET_FCST_PRNB, 0)) DSP_12,
       (DECODE(A.DASP_DV_NO, 13, A.CNC_RET_FCST_PRNB, 0)) DSP_13,
       (DECODE(A.DASP_DV_NO, 14, A.CNC_RET_FCST_PRNB, 0)) DSP_14,
       (DECODE(A.DASP_DV_NO, 15, A.CNC_RET_FCST_PRNB, 0)) DSP_15,
       (DECODE(A.DASP_DV_NO, 16, A.CNC_RET_FCST_PRNB, 0)) DSP_16,
       (DECODE(A.DASP_DV_NO, 17, A.CNC_RET_FCST_PRNB, 0)) DSP_17,
       (DECODE(A.DASP_DV_NO, 18, A.CNC_RET_FCST_PRNB, 0)) DSP_18,
       (DECODE(A.DASP_DV_NO, 19, A.CNC_RET_FCST_PRNB, 0)) DSP_19,
       (DECODE(A.DASP_DV_NO, 20, A.CNC_RET_FCST_PRNB, 0)) DSP_20
  FROM TB_YYFD211 A, /* DSP별예약/취소예측 TBL */
       TB_YYFD203 B, /* 예측 오차율 TBL        */
       TB_YYFD002 C,
       TB_YYFD002 D
 WHERE B.FCST_ACHV_DT = (SELECT MAX(FCST_ACHV_DT)
                          FROM TB_YYFD211 AA,
                               TB_YYFB001 BB
                         WHERE AA.FCST_YM BETWEEN '201310' AND '201410'
                           AND AA.TRN_NO = LPAD(TRIM('101'),5,'0')
                           AND AA.STGP_DEGR = BB.STGP_DEGR
                           AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN BB.APL_ST_DT AND BB.APL_CLS_DT
                           AND ('0' IN ('0','8','9') OR AA.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
                           AND (AA.DPT_STGP_CD || '-' || AA.ARV_STGP_CD) IN (  '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020'  )
                       )
   AND B.FCST_MDL_SEL_FLG = 'Y'                                     /* 모형선택여부 = 'Y' */
   AND ('0' IN ('0','8','9') OR B.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
   AND (B.DPT_STGP_CD || '-' || B.ARV_STGP_CD) IN (  '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020'  )   /* 출도착(GOD) 리스트 */
   AND A.FCST_ACHV_DT = B.FCST_ACHV_DT                              /* 예측 수행 일자     */
   AND A.FCST_MDL_DV_CD = B.FCST_MDL_DV_CD                           /* 예측모형구분코드   */
   AND A.STGP_DEGR = (SELECT STGP_DEGR
                        FROM TB_YYFB001
                       WHERE TO_CHAR (SYSDATE, 'YYYYMMDD') >= APL_ST_DT
                         AND TO_CHAR (SYSDATE, 'YYYYMMDD') <= APL_CLS_DT)                              /* 역그룹 차수        */
   AND A.STGP_DEGR = B.STGP_DEGR                                /* 역그룹차수         */
   AND ('0' IN ('0','8','9') OR A.DAY_DV_CD = '0') /* 전요일, 통합요일, 평요일(일단조회해온뒤 다이나믹처리) */
   AND A.DAY_DV_CD = B.DAY_DV_CD                                /* 요일 구분 코드     */
   AND A.DPT_STGP_CD = B.DPT_STGP_CD                              /* 출발역 그룹 코드   */
   AND A.ARV_STGP_CD = B.ARV_STGP_CD                              /* 도착역 그룹 코드   */
   AND (A.DPT_STGP_CD || '-' || A.ARV_STGP_CD) IN (  '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
                                                       '01003-01016','01001-75004','01001-75003','01001-01020','01003-75004','01003-75003',
                                                       '01003-01020','01008-01010','01008-01016','01008-75004','01008-75003','01008-01020',
                                                       '01010-01016','01010-75004','01010-75003','01010-01020','01016-75004','01016-75003',
                                                       '01016-01020','75004-75003','75004-01020','75003-01020'  )  /* 출도착(GOD) 리스트 */
   AND A.TRN_NO = LPAD(TRIM('101'),5,'0')          /* 열차번호           */
   AND A.FCST_YM BETWEEN '201310' AND '201410'          /* 조회기간(예측년월)  */
   AND A.DPT_STGP_CD = C.STGP_CD
   AND A.ARV_STGP_CD = D.STGP_CD
   AND A.STGP_DEGR = C.STGP_DEGR
   AND A.STGP_DEGR = D.STGP_DEGR) T2
   GROUP BY T2.TRN_NO
     , T2.DAY_DV_CD
     , T2.DAY_DV_NM
     , T2.DPT_STGP_CD
     , T2.DPT_STGP_NM
     , T2.ARV_STGP_CD
     , T2.ARV_STGP_NM
     , T2.YYYYMM
     , T2.CRG_PLN_NO
     , T2.CRG_PLN_CHG_DEGR
     , T2.CHG_PLN_DEGR
     , T2.FLAG)
  ORDER BY TRN_NO DESC, DPT_STN_CONS_ORDR ASC, ARV_STN_CONS_ORDR ASC, YYYYMM, DAY_DV_CD, FLAG
  
  
  
현재 인덱스 
YZDBA                TB_YYFD211                     PK_YYFD211                      227881840  => FCST_ACHV_DT,STGP_DEGR,DPT_STGP_CD,ARV_STGP_CD,FCST_YM,DAY_DV_CD,FCST_MDL_DV_CD,TRN_NO,DASP_DV_NO,CRG_PLN_CHG_DEGR
  
튜닝 내용
   SQL 수정 및 인덱스 생성 
       현재 : AND  A.DPT_STGP_CD||'-'||A.ARV_STGP_CD IN ( '01001-01003','01001-01008','01003-01008','01001-01010','01003-01010','01001-01016',
       수정 : AND (A.DPT_STGP_CD,A.ARV_STGP_CD ) IN     ( ( '01001','01003') ,('01001','01008'),('01003','01008') ,('01001','01010') ,('01003','01010'),('01001','01016'),
       
       필요 인덱스 : TB_YYFD211 ( TRN_NO,DPT_STGP_CD,ARV_STGP_CD,STGP_DEGR,FCST_YM,FCST_ACHV_DT  ) FCST_ACHV_DT 컬럼은 옵션임
       
       

  

---------------------------------------------------------------------------------------------------------------
| Id  | Operation                             | Name          | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |
---------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                      |               | 98058 |    51M|       |   415K  (8)| 01:23:01 |
|   1 |  SORT ORDER BY                        |               | 98058 |    51M|    58M|   415K  (8)| 01:23:01 |
|   2 |   VIEW                                |               | 98058 |    51M|       |   403K  (9)| 01:20:45 |
|   3 |    UNION-ALL                          |               |       |       |       |            |          |
|   4 |     TABLE ACCESS BY INDEX ROWID       | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|*  5 |      INDEX RANGE SCAN                 | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|   6 |     TABLE ACCESS BY INDEX ROWID       | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|*  7 |      INDEX RANGE SCAN                 | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|   8 |     TABLE ACCESS BY INDEX ROWID       | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|*  9 |      INDEX RANGE SCAN                 | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|* 10 |     COUNT STOPKEY                     |               |       |       |       |            |          |
|* 11 |      TABLE ACCESS BY INDEX ROWID      | TB_YYDD505    |     3 |    90 |       |   724   (1)| 00:00:09 |
|* 12 |       INDEX RANGE SCAN                | IX_YYDD505_02 |  7965 |       |       |    38   (0)| 00:00:01 |
|* 13 |     COUNT STOPKEY                     |               |       |       |       |            |          |
|* 14 |      TABLE ACCESS BY INDEX ROWID      | TB_YYDD505    |     3 |    90 |       |   724   (1)| 00:00:09 |
|* 15 |       INDEX RANGE SCAN                | IX_YYDD505_02 |  7965 |       |       |    38   (0)| 00:00:01 |
|  16 |     HASH GROUP BY                     |               | 49029 |    23M|    27M|   201K  (9)| 00:40:23 |
|  17 |      VIEW                             |               | 49029 |    23M|       |   196K  (9)| 00:39:20 |
|  18 |       HASH UNIQUE                     |               | 49029 |  5218K|  5784K|   196K  (9)| 00:39:20 |
|* 19 |        HASH JOIN                      |               | 49029 |  5218K|       |   105K (16)| 00:21:12 |
|  20 |         INDEX FAST FULL SCAN          | IX_YYFD002_01 |   650 |  5850 |       |     2   (0)| 00:00:01 |
|* 21 |         HASH JOIN                     |               |  6868 |   670K|       |   105K (16)| 00:21:12 |
|  22 |          INDEX FAST FULL SCAN         | IX_YYFD002_01 |   650 |  5850 |       |     2   (0)| 00:00:01 |
|  23 |          NESTED LOOPS                 |               |       |       |       |            |          |
|  24 |           NESTED LOOPS                |               |  1001 | 91091 |       |   105K (16)| 00:21:12 |
|* 25 |            TABLE ACCESS BY INDEX ROWID| TB_YYFD203    |   872 | 27904 |       |  1637   (1)| 00:00:20 |
|* 26 |             INDEX SKIP SCAN           | PK_YYFD203    |  1297 |       |       |  1238   (1)| 00:00:15 |
|  27 |              SORT AGGREGATE           |               |     1 |    58 |       |            |          |
|* 28 |               HASH JOIN               |               |   205K|    11M|       | 89448   (1)| 00:17:54 |
|* 29 |                INDEX RANGE SCAN       | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|* 30 |                INDEX SKIP SCAN        | PK_YYFD211    |   205K|  7419K|       | 89443   (1)| 00:17:54 |
|* 31 |            INDEX RANGE SCAN           | PK_YYFD211    |     1 |       |       |   120  (16)| 00:00:02 |
|* 32 |             INDEX RANGE SCAN          | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|  33 |           TABLE ACCESS BY INDEX ROWID | TB_YYFD211    |     1 |    59 |       |   121  (16)| 00:00:02 |
|  34 |     TABLE ACCESS BY INDEX ROWID       | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|* 35 |      INDEX RANGE SCAN                 | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|  36 |     TABLE ACCESS BY INDEX ROWID       | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|* 37 |      INDEX RANGE SCAN                 | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|  38 |     TABLE ACCESS BY INDEX ROWID       | TB_YYDK007    |     1 |    70 |       |     0   (0)| 00:00:01 |
|* 39 |      INDEX RANGE SCAN                 | PK_YYDK007    |     1 |       |       |     0   (0)| 00:00:01 |
|* 40 |     COUNT STOPKEY                     |               |       |       |       |            |          |
|* 41 |      TABLE ACCESS BY INDEX ROWID      | TB_YYDD505    |     1 |    30 |       |   288   (1)| 00:00:04 |
|* 42 |       INDEX RANGE SCAN                | IX_YYDD505_02 |  7965 |       |       |    17   (0)| 00:00:01 |
|* 43 |     COUNT STOPKEY                     |               |       |       |       |            |          |
|* 44 |      TABLE ACCESS BY INDEX ROWID      | TB_YYDD505    |     1 |    30 |       |   288   (1)| 00:00:04 |
|* 45 |       INDEX RANGE SCAN                | IX_YYDD505_02 |  7965 |       |       |    17   (0)| 00:00:01 |
|  46 |     HASH GROUP BY                     |               | 49029 |    23M|    27M|   201K  (9)| 00:40:23 |
|  47 |      VIEW                             |               | 49029 |    23M|       |   196K  (9)| 00:39:20 |
|  48 |       HASH UNIQUE                     |               | 49029 |  5218K|  5784K|   196K  (9)| 00:39:20 |
|* 49 |        HASH JOIN                      |               | 49029 |  5218K|       |   105K (16)| 00:21:12 |
|  50 |         INDEX FAST FULL SCAN          | IX_YYFD002_01 |   650 |  5850 |       |     2   (0)| 00:00:01 |
|* 51 |         HASH JOIN                     |               |  6868 |   670K|       |   105K (16)| 00:21:12 |
|  52 |          INDEX FAST FULL SCAN         | IX_YYFD002_01 |   650 |  5850 |       |     2   (0)| 00:00:01 |
|  53 |          NESTED LOOPS                 |               |       |       |       |            |          |
|  54 |           NESTED LOOPS                |               |  1001 | 91091 |       |   105K (16)| 00:21:12 |
|* 55 |            TABLE ACCESS BY INDEX ROWID| TB_YYFD203    |   872 | 27904 |       |  1637   (1)| 00:00:20 |
|* 56 |             INDEX SKIP SCAN           | PK_YYFD203    |  1297 |       |       |  1238   (1)| 00:00:15 |
|  57 |              SORT AGGREGATE           |               |     1 |    58 |       |            |          |
|* 58 |               HASH JOIN               |               |   205K|    11M|       | 89448   (1)| 00:17:54 |
|* 59 |                INDEX RANGE SCAN       | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|* 60 |                INDEX SKIP SCAN        | PK_YYFD211    |   205K|  7419K|       | 89443   (1)| 00:17:54 |
|* 61 |            INDEX RANGE SCAN           | PK_YYFD211    |     1 |       |       |   120  (16)| 00:00:02 |
|* 62 |             INDEX RANGE SCAN          | IX_YYFB001_01 |     1 |    21 |       |     1   (0)| 00:00:01 |
|  63 |           TABLE ACCESS BY INDEX ROWID | TB_YYFD211    |     1 |    59 |       |   121  (16)| 00:00:02 |
---------------------------------------------------------------------------------------------------------------
  
