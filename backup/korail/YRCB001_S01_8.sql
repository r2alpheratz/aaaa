  SELECT /*+ com.korail.yz.yr.cb.YRCB001QMDAO.selectListTrnNoPrAcvmCompQry */
        TO_NUMBER (A.TRN_NO) AS STANDARD
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
                                    ,DECODE (:SMG, 'N', SUM (A.ABRD_PRNB), SUM (A.ABRD_PRNB + A.SMG_ABRD_PRNB)) ABRD_PRNB
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
                               WHERE A.RUN_DT BETWEEN :RUN_TRM_ST_DT AND :RUN_TRM_CLS_DT
                                 AND B.RUN_DT = A.RUN_DT
                                 AND B.TRN_NO = A.TRN_NO
                                 AND B.TRN_ATT_CD IN ('1', '6')
                                 AND A.RUN_DT = C.RUN_DT
                                 AND A.TRN_NO = C.TRN_NO
                                 AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                                 AND C.STOP_RS_STN_CD = NVL (:DPT_STN_CD, C.STOP_RS_STN_CD)
                                 AND A.RUN_DT = D.RUN_DT
                                 AND A.TRN_NO = D.TRN_NO
                                 AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                                 AND D.STOP_RS_STN_CD = NVL (:ARV_STN_CD, D.STOP_RS_STN_CD)
                            GROUP BY A.RUN_DT
                                    ,A.TRN_NO
                                    ,A.PSRM_CL_CD
                                    ,A.BKCL_CD) A
                          ,(  SELECT A.RUN_DT
                                    ,A.TRN_NO
                                    ,A.PSRM_CL_CD
                                    ,SUM (A.BS_SEAT_NUM) SEAT_CNT
                                FROM TB_YYDK305 A, TB_YYDK301 B
                               WHERE B.RUN_DT BETWEEN :RUN_TRM_ST_DT AND :RUN_TRM_CLS_DT
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
                       AND C.STLB_TRN_CLSF_CD = NVL (:STLB_TRN_CLSF_CD, C.STLB_TRN_CLSF_CD)
                       AND C.UP_DN_DV_CD = DECODE (:UP_DN_DV_CD, 'A', C.UP_DN_DV_CD, :UP_DN_DV_CD)
                       AND D.RUN_DT = C.RUN_DT
                       AND D.TRN_NO = C.TRN_NO
                       AND D.STOP_RS_STN_CD = C.ORG_RS_STN_CD
                       AND E.RUN_DT = C.RUN_DT
                       AND E.TRN_NO = C.TRN_NO
                       AND E.STOP_RS_STN_CD = C.TMN_RS_STN_CD
                       AND A.RUN_DT = F.RUN_DT
                       AND F.DAY_DV_CD = DECODE (:DAY_DV_CD, '0', F.DAY_DV_CD, :DAY_DV_CD)
                       AND C.ROUT_CD = G.ROUT_CD
                       AND G.MRNT_CD = NVL (:MRNT_CD, G.MRNT_CD)
                       AND G.MRNT_CD IN ('01', '03', '04')
                       AND A.PSRM_CL_CD = NVL (:PSRM_CL_CD, A.PSRM_CL_CD)
                       AND A.BKCL_CD = NVL (:BKCL_CD, A.BKCL_CD)) A
                  ,(  SELECT A.RUN_DT
                            ,A.TRN_NO
                            ,A.PSRM_CL_CD
                            ,DECODE (:BKCL_CD, 'F2', 'F1', A.BKCL_CD) AS BKCL_CD
                            ,DECODE (:SMG, 'N', SUM (A.BIZ_RVN_AMT - A.SMG_BIZ_RVN_AMT), SUM (A.BIZ_RVN_AMT)) AS BIZ_RVN_AMT
                        FROM TB_YYDS512 A
                            ,TB_YYDK301 B
                            ,TB_YYDK302 C
                            ,TB_YYDK302 D
                       WHERE A.RUN_DT BETWEEN :RUN_TRM_ST_DT AND :RUN_TRM_CLS_DT
                         AND A.PSRM_CL_CD = NVL (:PSRM_CL_CD, A.PSRM_CL_CD)
                         AND A.BKCL_CD = NVL (:BKCL_CD, A.BKCL_CD)
                         AND B.RUN_DT = A.RUN_DT
                         AND B.TRN_NO = A.TRN_NO
                         AND B.TRN_ATT_CD IN ('1', '6')
                         AND A.RUN_DT = C.RUN_DT
                         AND A.TRN_NO = C.TRN_NO
                         AND A.DPT_STN_CONS_ORDR = C.STN_CONS_ORDR
                         AND C.STOP_RS_STN_CD = NVL (:DPT_STN_CD, C.STOP_RS_STN_CD)
                         AND A.RUN_DT = D.RUN_DT
                         AND A.TRN_NO = D.TRN_NO
                         AND A.ARV_STN_CONS_ORDR = D.STN_CONS_ORDR
                         AND D.STOP_RS_STN_CD = NVL (:ARV_STN_CD, D.STOP_RS_STN_CD)
                    GROUP BY A.RUN_DT
                            ,A.TRN_NO
                            ,A.PSRM_CL_CD
                            ,A.BKCL_CD) B
                  ,(  SELECT RUN_DT
                            ,TRN_NO
                            ,PSRM_CL_CD
                            ,SUM (BS_SEAT_NUM) AS BS_SEAT_NUM
                        FROM TB_YYDK305
                       WHERE RUN_DT BETWEEN :RUN_TRM_ST_DT AND :RUN_TRM_CLS_DT
                         AND PSRM_CL_CD = NVL (:PSRM_CL_CD, PSRM_CL_CD)
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
GROUP BY A.TRN_NO
ORDER BY A.TRN_NO




튜닝 내용
    1달치 데이터의 정보 조회
    
    인덱스 수정 검토 및 function(40만번 이상 호출)  사용시에 scalar subquery 사용
        수정 인덱스 : ROUT_CD,STN_CONS_ORDR,APL_CLS_DT,APL_ST_DT
        
        sql :            A.ABRD_PRNB  * (select FN_YB_GETROUTDSTCAL(....)  from dual )   
         ( scalar subquery 로 변경을 위함)
