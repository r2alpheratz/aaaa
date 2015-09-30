열차별 예측실적승차인원조회 차트 분석

01.장기예측인원
02.최종예측인원
03.예약발매실적
=======================







02.최종예측인원 


SELECT SUM(A.USE_PS_CTL_EXPCT_DMD) 
  FROM TB_YF540 A,
       TB_YD330 B
 WHERE A.RUN_DT = B.RUN_DT
   AND A.TRN_NO = B.TRN_NO
   AND A.DPT_STN_CONS_ORDR = B.DPT_STN_CONS_ORDR
   AND A.ARV_STN_CONS_ORDR = B.ARV_STN_CONS_ORDR
   
   AND A.RUN_DT = '20140411'
   AND A.TRN_NO = '00104'
   AND B.DPT_STGP_CD = DECODE(:LS_STGP_CD1, '%', B.DPT_STGP_CD, :LS_STGP_CD1)
   AND B.ARV_STGP_CD = DECODE(:LS_STGP_CD2, '%', B.ARV_STGP_CD, :LS_STGP_CD2)
   
   AND A.YMS_JOB_ID = ( 
                        SELECT MAX(AA.YMS_JOB_ID)
                                 FROM TB_YF540 AA,
                                      TB_YD330 BB
                                WHERE AA.RUN_DT = BB.RUN_DT
                                  AND AA.TRN_NO = BB.TRN_NO
                                  AND AA.DPT_STN_CONS_ORDR = BB.DPT_STN_CONS_ORDR
                           AND AA.ARV_STN_CONS_ORDR = BB.ARV_STN_CONS_ORDR
                                  AND AA.RUN_DT = '20140411'
                                  AND AA.TRN_NO = '00104'
                                  AND BB.DPT_STGP_CD = DECODE(:LS_STGP_CD1, '%', BB.DPT_STGP_CD, :LS_STGP_CD1)
                           AND BB.ARV_STGP_CD = DECODE(:LS_STGP_CD2, '%', BB.ARV_STGP_CD, :LS_STGP_CD2) 
                                  AND BB.DPT_STGP_CD = DECODE(:LS_STGP_CD1, '%', BB.DPT_STGP_CD, :LS_STGP_CD1)
                           AND BB.ARV_STGP_CD = DECODE(:LS_STGP_CD2, '%', BB.ARV_STGP_CD, :LS_STGP_CD2) 
                       );

===============================================================================

03.예약발매실적

--03 예약발매 실적

SELECT RUN_DT,
        TRN_NO,
        DPT_BF_DNO,
        SUM( ACM_RSV_SEAT_CNT + ACM_SALE_SEAT_CNT - ACM_CNC_SEAT_CNT - ACM_RET_SEAT_CNT ) SUM_CNT 
  FROM TB_YD340
 WHERE RUN_DT = :AS_RUN_DT
   AND TRN_NO = :AS_TRN_NO
   AND DPT_BF_DNO >= 0 
   AND DPT_BF_DNO <= 60
   AND DPT_STGP_CD = DECODE(:AS_DPT_STGP_CD, '%', DPT_STGP_CD, :AS_DPT_STGP_CD)
   AND ARV_STGP_CD = DECODE(:AS_ARV_STGP_CD, '%', ARV_STGP_CD, :AS_ARV_STGP_CD)
 GROUP BY RUN_DT, TRN_NO, DPT_BF_DNO
 ORDER BY DPT_BF_DNO