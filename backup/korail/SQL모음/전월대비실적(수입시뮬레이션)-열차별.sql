        SELECT /*+ com.korail.yz.ys.ec.YSEC001QMDAO.selectListRvnSimlBfmmVsAcvmTrn */
               A2.TRN_NO,
               C2.SEG_GP_NO,
               (SELECT Y.KOR_STN_NM                               /* 한글역명           */
                  FROM TB_YYDK001 X,                                /* 예발역코드TBL     */
                       TB_YYDK102 Y                    /* 역코드이력TBL     */
                 WHERE     X.RS_STN_CD = A2.DPT_STN_CD
                       AND X.STN_CD = Y.STN_CD
                       AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT
                                                             AND Y.APL_CLS_DT)
                  AS DPT_STN_NM,
               (SELECT Y.KOR_STN_NM                               /* 한글역명           */
                  FROM TB_YYDK001 X,                                /* 예발역코드TBL     */
                       TB_YYDK102 Y                    /* 역코드이력TBL     */
                 WHERE     X.RS_STN_CD = A2.ARV_STN_CD
                       AND X.STN_CD = Y.STN_CD
                       AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN Y.APL_ST_DT
                                                             AND Y.APL_CLS_DT)
                  AS ARV_STN_NM,
               A2.ABRD_EXPECT, /* 예측승차인원  */
               A2.ABRD_PRNB,   /* 실적평균      */
               A2.F1_AMT,      /* 열차영업수입  */
               A2.BKCL_AMT,    /* 할인등급실적  */
               A2.EXPECT_AMT,  /* 예측정상수입  */
               A2.NORMAL_AMT,  /* 실적정상수입  */
               DECODE(A2.NORMAL_AMT, 0, 0, NULL, 0, ROUND(((A2.NORMAL_AMT - A2.BKCL_AMT) / A2.NORMAL_AMT ) * 100, 1)) AS DCNT_RT, /* 할인율 */ 
               A2.DPT_ORDR,
               A2.ARV_ORDR
          FROM (  SELECT A1.TRN_NO,
                         A1.DPT_STN_CONS_ORDR,
                         A1.ARV_STN_CONS_ORDR,
                         MAX (B1.RUN_ORDR) DPT_ORDR,
                         MAX (C1.RUN_ORDR) ARV_ORDR,
                         MAX (A1.RUN_DT) RUN_DT,
                         MAX (B1.TRVL_ZONE_NO) DPT_ZONE_NO,
                         MAX (C1.TRVL_ZONE_NO) ARV_ZONE_NO,
                         MAX (B1.STOP_RS_STN_CD) DPT_STN_CD,
                         MAX (C1.STOP_RS_STN_CD) ARV_STN_CD,
                         SUM (A1.LAST_ABRD_EXPN_DMD_NUM) ABRD_EXPECT,
                         SUM (A1.ABRD_PRNB / #DAY_CNT#) ABRD_PRNB,
                         SUM (A1.F1_AMT / #DAY_CNT#) F1_AMT,
                         SUM (A1.BKCL_AMT / #DAY_CNT#) BKCL_AMT,
                         SUM (  YZDBA.FN_YZYB_GETPRICEGB (A1.RUN_DT,
                                                 A1.TRN_NO,
                                                 A1.PSRM_CL_CD,
                                                 D1.ROUT_CD,
                                                 D1.STLB_TRN_CLSF_CD,
                                                 B1.STN_CONS_ORDR,
                                                 C1.STN_CONS_ORDR,
                                                 NULL)
                              * A1.LAST_ABRD_EXPN_DMD_NUM /* 최종승차예측수요수 */
                             )
                            AS EXPECT_AMT, /* 예측정상수입  */
                           SUM (  YZDBA.FN_YZYB_GETPRICEGB (A1.RUN_DT,
                                                   A1.TRN_NO,
                                                   A1.PSRM_CL_CD,
                                                   D1.ROUT_CD,
                                                   D1.STLB_TRN_CLSF_CD,
                                                   B1.STN_CONS_ORDR,
                                                   C1.STN_CONS_ORDR,
                                                   NULL)
                                * A1.ABRD_PRNB 
                               )
                         / #DAY_CNT#
                            AS NORMAL_AMT, /* 실적정상수입  */
                         MAX (D1.UP_DN_DV_CD) UP_DN_DV_CD
                    FROM (  SELECT A.RUN_DT,
                                   A.TRN_NO,
                                   A.PSRM_CL_CD,
                                   A.DPT_STN_CONS_ORDR,
                                   A.ARV_STN_CONS_ORDR,
                                   SUM (A.LAST_ABRD_EXPN_DMD_NUM) LAST_ABRD_EXPN_DMD_NUM,
                                   0 ABRD_PRNB,
                                   0 F1_AMT,
                                   0 BKCL_AMT
                              FROM TB_YYFD410 A
                             WHERE (A.RUN_DT,
                                    A.TRN_NO,
                                    A.PSRM_CL_CD,
                                    A.BKCL_CD,
                                    A.FCST_ACHV_DT,
                                    A.YMGT_JOB_ID) IN
                                      (  SELECT Z.RUN_DT,
                                                Z.TRN_NO,
                                                Z.PSRM_CL_CD,
                                                Z.BKCL_CD,
                                                SUBSTR (MAX (Z.FCST_ACHV_DT || Z.YMGT_JOB_ID), 1, 8),
                                                SUBSTR (MAX (Z.FCST_ACHV_DT || Z.YMGT_JOB_ID), 9)
                                           FROM TB_YYFD410 Z, 
                                                TB_YYDK301 Y, 
                                                TB_YYDK201 X
                                          WHERE     Z.RUN_DT = #RUN_DT#
                                                AND Z.TRN_NO = DECODE(TRIM(#TRN_NO#), NULL, Z.TRN_NO, LPAD(TRIM(#TRN_NO#), 5, '0'))
                                                AND Z.PSRM_CL_CD = NVL(#PSRM_CL_CD#, Z.PSRM_CL_CD)
                                                AND Z.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, Z.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                                AND Z.RUN_DT = Y.RUN_DT
                                                AND Z.TRN_NO = Y.TRN_NO
                                                AND Y.UP_DN_DV_CD = NVL(#UP_DN_DV_CD#, Y.UP_DN_DV_CD)
                                                AND Y.STLB_TRN_CLSF_CD = NVL(#STLB_TRN_CLSF_CD#, Y.STLB_TRN_CLSF_CD)
                                                AND Y.ROUT_CD = X.ROUT_CD
                                                AND X.ROUT_DV_CD IN ('10','30') 
                                                AND X.MRNT_CD = NVL(#MRNT_CD#, X.MRNT_CD)
                                                AND X.MRNT_CD IN ('01', '03', '04')
                                       GROUP BY Z.RUN_DT,
                                                Z.TRN_NO,
                                                Z.PSRM_CL_CD,
                                                Z.BKCL_CD)
                          GROUP BY A.RUN_DT,
                                   A.TRN_NO,
                                   A.PSRM_CL_CD,
                                   A.DPT_STN_CONS_ORDR,
                                   A.ARV_STN_CONS_ORDR
                          UNION ALL
                            SELECT A.RUN_DT,
                                   A.TRN_NO,
                                   A.PSRM_CL_CD,
                                   A.DPT_STN_CONS_ORDR,
                                   A.ARV_STN_CONS_ORDR,
                                   0,
                                   SUM (ABRD_PRNB),
                                   0,
                                   0
                              FROM TB_YYDS510 A, 
                                   TB_YYDK301 B, 
                                   TB_YYDK201 C
                             WHERE     A.RUN_DT IN ($RUN_DT_ARR$)
                                   AND A.TRN_NO = DECODE(TRIM(#TRN_NO#), NULL, A.TRN_NO, LPAD(TRIM(#TRN_NO#), 5, '0'))
                                   AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                   AND A.BKCL_CD LIKE DECODE (#BKCL_CD#, NULL, A.BKCL_CD, 'F1', 'F%', #BKCL_CD#)
                                   AND A.RUN_DT = B.RUN_DT
                                   AND A.TRN_NO = B.TRN_NO
                                   AND B.UP_DN_DV_CD = NVL(#UP_DN_DV_CD#, B.UP_DN_DV_CD)
                                   AND B.STLB_TRN_CLSF_CD = NVL(#STLB_TRN_CLSF_CD#, B.STLB_TRN_CLSF_CD)
                                   AND B.ROUT_CD = C.ROUT_CD
                                   AND C.ROUT_DV_CD IN ('10','30') 
                                   AND C.MRNT_CD = NVL(#MRNT_CD#, C.MRNT_CD)
                                   AND C.MRNT_CD IN ('01', '03', '04')
                          GROUP BY A.RUN_DT,
                                   A.TRN_NO,
                                   A.PSRM_CL_CD,
                                   A.DPT_STN_CONS_ORDR,
                                   A.ARV_STN_CONS_ORDR
                          UNION ALL
                            SELECT A.RUN_DT,
                                   A.TRN_NO,
                                   A.PSRM_CL_CD,
                                   A.DPT_STN_CONS_ORDR,
                                   A.ARV_STN_CONS_ORDR,
                                   0,
                                   0,
                                   SUM (A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT) F1_AMT,
                                   SUM (DECODE (#BKCL_CD#, NULL, A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT,
                                            DECODE (DECODE(A.BKCL_CD, 'F2', 'F1', A.BKCL_CD),
                                            #BKCL_CD#, A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT)))
                                     AS BKCL_AMT
                              FROM TB_YYDS512 A, 
                                   TB_YYDK301 B, 
                                   TB_YYDK201 C
                             WHERE     A.RUN_DT IN ($RUN_DT_ARR$)
                                   AND A.TRN_NO = DECODE(TRIM(#TRN_NO#), NULL, A.TRN_NO, LPAD(TRIM(#TRN_NO#), 5, '0'))
                                   AND A.PSRM_CL_CD = NVL(#PSRM_CL_CD#, A.PSRM_CL_CD)
                                   AND A.RUN_DT = B.RUN_DT
                                   AND A.TRN_NO = B.TRN_NO
                                   AND B.UP_DN_DV_CD = NVL(#UP_DN_DV_CD#, B.UP_DN_DV_CD)
                                   AND B.STLB_TRN_CLSF_CD = NVL(#STLB_TRN_CLSF_CD#, B.STLB_TRN_CLSF_CD)
                                   AND B.ROUT_CD = C.ROUT_CD
                                   AND C.ROUT_DV_CD IN ('10','30') 
                                   AND C.MRNT_CD = NVL(#MRNT_CD#, C.MRNT_CD)
                                   AND C.MRNT_CD IN ('01', '03', '04')
                          GROUP BY A.RUN_DT,
                                   A.TRN_NO,
                                   A.PSRM_CL_CD,
                                   A.DPT_STN_CONS_ORDR,
                                   A.ARV_STN_CONS_ORDR) A1,
                         TB_YYDK302 B1,
                         TB_YYDK302 C1,
                         TB_YYDK301 D1
                   WHERE     A1.RUN_DT            = D1.RUN_DT
                         AND A1.TRN_NO            = D1.TRN_NO
                         AND A1.RUN_DT            = B1.RUN_DT
                         AND A1.TRN_NO            = B1.TRN_NO
                         AND A1.DPT_STN_CONS_ORDR = B1.STN_CONS_ORDR
                         AND A1.RUN_DT            = C1.RUN_DT
                         AND A1.TRN_NO            = C1.TRN_NO
                         AND A1.ARV_STN_CONS_ORDR = C1.STN_CONS_ORDR
                GROUP BY A1.TRN_NO, A1.DPT_STN_CONS_ORDR, A1.ARV_STN_CONS_ORDR) A2,
               TB_YYDK308 C2
         WHERE     A2.RUN_DT = C2.RUN_DT
               AND A2.TRN_NO = C2.TRN_NO
               AND A2.DPT_ZONE_NO =
                      DECODE (A2.UP_DN_DV_CD, 'D', C2.DPT_ZONE_NO, C2.ARV_ZONE_NO)
               AND A2.ARV_ZONE_NO =
                      DECODE (A2.UP_DN_DV_CD, 'D', C2.ARV_ZONE_NO, C2.DPT_ZONE_NO)
      ORDER BY SEG_GP_NO, DPT_ORDR, ARV_ORDR