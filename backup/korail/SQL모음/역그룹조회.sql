/* Formatted on 2014-03-13 오전 10:15:17 (QP5 v5.185.11230.41888) */
  SELECT /*+ com.korail.yz.yf.aa.YFAA001QMDAO.selectListStgpInfo*/
        A.KOR_STN_NM AS KOR_GRUP_STN_NM,            /* 역그룹명(한글)             */
         B.KOR_STN_NM AS KOR_STN_NM,                /* 소속역명(한글)             */
         DECODE (B.REP_STN_FLG, 'Y', 'Y', '') REP_STN_FLG, /* 대표역여부                 */
         A.STGP_CD,                                /* 역그룹코드                 */
         CASE WHEN B.DEAL_TRN_CLSF_CD = '00' THEN 'KTX' ELSE '새마을' END
            DEAL_TRN_CLSF_CD,                           /* 취급열차종별코드         */
         A.RS_STN_CD AS RS_STN_CD_1,                    /* 예발역코드(역그룹코드)     */
         B.RS_STN_CD AS RS_STN_CD_2                     /* 예발역코드(소속역코드)     */
    FROM (SELECT A.RS_STN_CD,                          /* 예발역코드             */
                             B.KOR_STN_NM,           /* 한글역명                */
                                          A.STGP_CD    /* 역그룹코드             */
            FROM TB_YYFD002 A,                            /* 역그룹핑내역 TBL     */
                              TB_YYDK001 B              /* 예발역코드 TBL        */
           WHERE     A.STGP_DEGR =
                        (SELECT STGP_DEGR
                           FROM TB_YYFB001                       /* 역그룹차수기본 */
                          WHERE     APL_ST_DT <= TO_CHAR (SYSDATE, 'YYYYMMDD')
                                AND APL_CLS_DT >= TO_CHAR (SYSDATE, 'YYYYMMDD'))
                 AND A.REP_STN_FLG = 'Y'
                 AND A.RS_STN_CD = B.RS_STN_CD
                 AND B.DEAL_TRN_CLSF_CD IN ('00', '01')
                 AND A.STGP_CD IN
                        (SELECT DISTINCT A.STGP_CD             /* 역그룹코드     */
                           FROM TB_YYFD002 A                  /* 역그룹핑내역 TBL */
                          WHERE EXISTS
                                   (SELECT 'X'
                                      FROM TB_YYDK001           /* 예발역코드 TBL*/
                                     WHERE     RS_STN_CD = A.RS_STN_CD
                                           AND DEAL_TRN_CLSF_CD IN ('00', '01')
                                           AND CHTN_STN_FLG IN ('Y', 'N')))
                 AND (null IS NULL OR A.STGP_CD = '')) A,
         (SELECT A.RS_STN_CD,                          /* 예발역코드             */
                 B.KOR_STN_NM,                       /* 한글역명                */
                 A.STGP_CD,                            /* 역그룹코드             */
                 A.STGP_DEGR,                           /* 역그룹차수            */
                 A.REP_STN_FLG,                         /* 대표역여부            */
                 B.DEAL_TRN_CLSF_CD                             /* 취급열차종별코드 */
            FROM TB_YYFD002 A,                                /* 역그룹핑내역 TBL */
                              TB_YYDK001 B                  /* 예발역코드 TBL    */
           WHERE     A.RS_STN_CD = B.RS_STN_CD
                 AND A.STGP_DEGR =
                        (SELECT STGP_DEGR
                           FROM TB_YYFB001                       /* 역그룹차수기본 */
                          WHERE     APL_ST_DT <= TO_CHAR (SYSDATE, 'YYYYMMDD')
                                AND APL_CLS_DT >= TO_CHAR (SYSDATE, 'YYYYMMDD'))
                 AND B.DEAL_TRN_CLSF_CD IN ('00', '01')
                 AND B.CHTN_STN_FLG IN ('Y', 'N')
                 AND B.DEL_FLG = 'N'
                 AND (null IS NULL OR A.STGP_CD = null)) B
   WHERE     A.STGP_CD = B.STGP_CD
         AND ('00' IS NULL OR B.DEAL_TRN_CLSF_CD LIKE '00')
ORDER BY A.RS_STN_CD, B.RS_STN_CD