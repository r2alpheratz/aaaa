  SELECT /*+ com.korail.yz.yr.cb.YRCB001QMDAO.selectListDayPrAcvmCompQry */
        '(' || A.DAY_DV_CD || ')' || A.DAY_DV_NM AS STANDARD
        ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
        ,ROUND (AVG (A.UTL_RT) * 100, 3) AS UTL_RT
        ,ROUND (AVG (A.ABRD_RT) * 100, 3) AS ABRD_RT
        ,SUM (A.BIZ_RVN_AMT) AS BIZ_RVN_AMT
        ,ROUND (SUM (A.BIZ_RVN_AMT) / SUM (A.BS_SEAT_NUM), 0) AS BIZ_RVN_AMT_PER_SEAT_CNT
    FROM (  SELECT A.RUN_DT
                  ,A.TRN_NO
                  , (SELECT SUBSTR (VLID_VAL_NM, 1, 1)
                       FROM TB_YYDK007
                      WHERE XROIS_OLD_SRT_CD = 'I909'
                        AND VLID_VAL = C.DAY_DV_CD)
                       AS DAY_DV_NM
                  ,C.DAY_DV_CD
                  ,SUM (A.ABRD_PRNB) AS ABRD_PRNB
                  ,SUM (A.UTL_RT) AS UTL_RT
                  ,SUM (A.ABRD_RT) AS ABRD_RT
                  ,SUM (B.BIZ_RVN_AMT) AS BIZ_RVN_AMT
                  ,D.BS_SEAT_NUM AS BS_SEAT_NUM
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
                       AND C.UP_DN_DV_CD = DECODE ('A', 'A', C.UP_DN_DV_CD, 'A')
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
                  ,TB_YYDK002 C
                  ,(  SELECT RUN_DT
                            ,TRN_NO
                            ,PSRM_CL_CD
                            ,SUM (BS_SEAT_NUM) AS BS_SEAT_NUM
                        FROM TB_YYDK305
                       WHERE RUN_DT BETWEEN '20140101' AND '20140131'
                         AND PSRM_CL_CD = NVL ('', PSRM_CL_CD)
                         AND GEN_SEAT_DUP_FLG = 'N'
                    GROUP BY RUN_DT, TRN_NO, PSRM_CL_CD) D
             WHERE A.RUN_DT = B.RUN_DT
               AND A.TRN_NO = B.TRN_NO
               AND A.PSRM_CL_CD = B.PSRM_CL_CD
               AND A.BKCL_CD = B.BKCL_CD
               AND A.RUN_DT = D.RUN_DT
               AND A.TRN_NO = D.TRN_NO
               AND A.PSRM_CL_CD = D.PSRM_CL_CD
               AND A.RUN_DT = C.RUN_DT
               AND C.DAY_DV_CD = DECODE ('0', '0', C.DAY_DV_CD, '0')
          GROUP BY A.RUN_DT
                  ,A.TRN_NO
                  ,C.DAY_DV_CD
                  ,D.BS_SEAT_NUM) A
GROUP BY A.DAY_DV_NM, A.DAY_DV_CD
ORDER BY A.DAY_DV_CD




튜닝 내용
    1달치 데이터의 정보 조회
    
    인덱스 수정 검토 및 function(40만번 이상 호출)  사용시에 scalar subquery 사용
        수정 인덱스 : ROUT_CD,STN_CONS_ORDR,APL_CLS_DT,APL_ST_DT
        
        
        sql :            A.ABRD_PRNB  * (select FN_YB_GETROUTDSTCAL(....)  from dual )   
        
        
        sql 현재 :   SUM (A.ABRD_PRNB + A.SMG_ABRD_PRNB
            수정 :   SUM (A.ABRD_PRNB)  + SUM (A.SMG_ABRD_PRNB ) 
