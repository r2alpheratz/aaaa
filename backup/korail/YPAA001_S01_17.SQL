select
      TRN_NO
      ,PSRM_CL_CD
      ,PSRM_CL_NM
      ,ZONE_SEG_GP_NO
      ,DPT_ARV
      ,GP_BKCL_FST_ALC_NUM
      ,ALC_CNT
      ,ALL_CNT
      ,EXPCT_DMD
      ,DECODE ('F1', 'F1', BS_SEAT_NUM, '') BS_SEAT_NUM
      ,DECODE ('F1', 'F1', NOTY_SALE_SEAT_NUM, '') NOTY_SALE_SEAT_NUM
      ,DECODE ('F1', 'F1', MAX_ALL_CNT - PSRM_CL_CD_SUM_ALC_CNT, '') REMAIN
      ,FCST_ACHV_DT
      ,DECODE ('F1', 'F1', DECODE(ALL_CNT,  0, '0%',  NULL, '-',  TO_CHAR(ROUND (ALL_CNT / MAX_ALL_CNT, 4) * 100 , '999.99')), '') PER
      ,DPT_TM
      ,RUN_INFO
  FROM (SELECT T1.RUN_DT
              ,TO_NUMBER (T1.TRN_NO) TRN_NO
              , (SELECT VLID_VAL_NM
                   FROM TB_YYDK007
                  WHERE XROIS_OLD_SRT_CD = 'R408'
                    AND VLID_VAL = T1.PSRM_CL_CD)
                   PSRM_CL_NM
              ,T1.ZONE_SEG_GP_NO
              ,T1.DPT_ARV
              , (SELECT B.DPT_TM
                   FROM TB_YYDK301 A, TB_YYDK302 B
                  WHERE A.RUN_DT = T1.RUN_DT
                    AND A.TRN_NO = T1.TRN_NO
                    AND A.RUN_DT = B.RUN_DT
                    AND A.TRN_NO = B.TRN_NO
                    AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD)
                   DPT_TM
              , (SELECT    (SELECT T2.KOR_STN_NM
                              FROM TB_YYDK001 T1, TB_YYDK102 T2
                             WHERE T1.RS_STN_CD = A.ORG_RS_STN_CD
                               AND T1.STN_CD = T2.STN_CD
                               AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
                        || '-'
                        || (SELECT T2.KOR_STN_NM
                              FROM TB_YYDK001 T1, TB_YYDK102 T2
                             WHERE T1.RS_STN_CD = A.TMN_RS_STN_CD
                               AND T1.STN_CD = T2.STN_CD
                               AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
                        || '('
                        || TO_CHAR (TO_DATE (B.DPT_TM, 'HH24MISS'), 'HH24:MI')
                        || '-'
                        || TO_CHAR (TO_DATE (C.ARV_TM, 'HH24MISS'), 'HH24:MI')
                        || ')'
                   FROM TB_YYDK301 A, TB_YYDK302 B, TB_YYDK302 C
                  WHERE A.RUN_DT = T1.RUN_DT
                    AND A.TRN_NO = T1.TRN_NO
                    AND A.RUN_DT = B.RUN_DT
                    AND A.TRN_NO = B.TRN_NO
                    AND A.ORG_RS_STN_CD = B.STOP_RS_STN_CD
                    AND A.RUN_DT = C.RUN_DT
                    AND A.TRN_NO = C.TRN_NO
                    AND A.TMN_RS_STN_CD = C.STOP_RS_STN_CD)
                   RUN_INFO
              ,DECODE (T1.GP_BKCL_FST_ALC_NUM, 999, 0, T1.GP_BKCL_FST_ALC_NUM) GP_BKCL_FST_ALC_NUM
              ,T1.ALC_CNT
              ,T1.ALL_CNT
              , (SELECT SUM (A.USR_CTL_EXPN_DMD_NUM)
                   FROM TB_YYFD410 A
                       ,TB_YYDK302 B
                       ,TB_YYDK302 C
                       ,TB_YYDK308 D
                       ,TB_YYDK301 E
                       ,TB_YYDK201 Z
                       ,TB_YYDK002 I
                  WHERE E.RUN_DT BETWEEN '20140318' AND '20140320'
                    AND E.TRN_NO = DECODE (LPAD (TRIM (''), 5, '0'), NULL, E.TRN_NO, LPAD (TRIM (''), 5, '0'))
                    AND E.STLB_TRN_CLSF_CD = '00'
                    AND Z.MRNT_CD = DECODE ('', NULL, Z.MRNT_CD, '')
                    AND E.ROUT_CD = DECODE ('', NULL, E.ROUT_CD, '')
                    AND E.ROUT_CD = Z.ROUT_CD
                    AND E.UP_DN_DV_CD = DECODE ('A', 'A', E.UP_DN_DV_CD, 'A')
                    AND A.YMGT_JOB_ID = (SELECT SUBSTR (MAX (SUBSTR (AA.REG_DTTM, 1, 8) || AA.YMGT_JOB_ID), 9, 24)
                                           FROM TB_YYFD011 AA, TB_YYFD010 BB
                                          WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
                                            AND BB.YMGT_PROC_DV_ID IN ('YP625', 'YP620')
                                            AND AA.OTMZ_PRS_STT_CD = '11'
                                            AND AA.RUN_DT = A.RUN_DT
                                            AND AA.TRN_NO = A.TRN_NO)
                    AND E.RUN_DT = A.RUN_DT
                    AND E.TRN_NO = A.TRN_NO
                    AND A.BKCL_CD = 'F1'
                    AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
                    AND A.RUN_DT = B.RUN_DT
                    AND A.TRN_NO = B.TRN_NO
                    AND A.DPT_STN_CONS_ORDR = B.STN_CONS_ORDR
                    AND A.RUN_DT = C.RUN_DT
                    AND A.TRN_NO = C.TRN_NO
                    AND A.ARV_STN_CONS_ORDR = C.STN_CONS_ORDR
                    AND A.RUN_DT = D.RUN_DT
                    AND A.TRN_NO = D.TRN_NO
                    AND B.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', D.DPT_ZONE_NO, D.ARV_ZONE_NO)
                    AND C.TRVL_ZONE_NO = DECODE (E.UP_DN_DV_CD, 'D', D.ARV_ZONE_NO, D.DPT_ZONE_NO)
                    AND A.RUN_DT = T1.RUN_DT
                    AND A.TRN_NO = T1.TRN_NO
                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD
                    AND D.SEG_GP_NO = T1.ZONE_SEG_GP_NO
                    AND A.RUN_DT = I.RUN_DT
                    AND I.DAY_DV_CD = DECODE ('0',  '0', I.DAY_DV_CD,  '9', I.DAY_DV_CD,  '0') )  
                   EXPCT_DMD
              , (SELECT MAX (DECODE ('F1', 'F1', A.GP_MRK_ALLW_NUM, A.BKCL_MRK_ALLW_NUM))
                   FROM TB_YYPD006 A
                       ,TB_YYDK301 B
                       ,TB_YYDK201 C
                       ,TB_YYDK002 I
                  WHERE B.RUN_DT BETWEEN '20140318' AND '20140320'
                    AND B.TRN_NO = DECODE (LPAD(TRIM(''), 5,'0'), NULL, B.TRN_NO, LPAD(TRIM(''), 5,'0'))
                    AND B.STLB_TRN_CLSF_CD = '00'
                    AND C.MRNT_CD = DECODE ('', NULL, C.MRNT_CD, '')
                    AND B.ROUT_CD = DECODE ('', NULL, B.ROUT_CD, '')
                    AND B.ROUT_CD = C.ROUT_CD
                    AND B.UP_DN_DV_CD = DECODE ('A', 'A', B.UP_DN_DV_CD, 'A')
                    AND A.YMGT_JOB_ID = (SELECT SUBSTR (MAX (SUBSTR (AA.REG_DTTM, 1, 8) || AA.YMGT_JOB_ID), 9, 24)
                                           FROM TB_YYFD011 AA, TB_YYFD010 BB
                                          WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
                                            AND BB.YMGT_PROC_DV_ID IN ('YP625', 'YP620')
                                            AND AA.OTMZ_PRS_STT_CD = '11'
                                            AND AA.RUN_DT = A.RUN_DT
                                            AND AA.TRN_NO = A.TRN_NO)
                    AND B.RUN_DT = A.RUN_DT
                    AND B.TRN_NO = A.TRN_NO
                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15
                    AND A.BKCL_CD = 'F1'
                    AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
                    AND A.RUN_DT = T1.RUN_DT
                    AND A.TRN_NO = T1.TRN_NO
                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD
                    AND A.RUN_DT = I.RUN_DT
                    AND I.DAY_DV_CD = DECODE ('0',  '0', I.DAY_DV_CD,  '9', I.DAY_DV_CD,  '0')    )  MAX_ALL_CNT
              , (SELECT SUM (DECODE ('F1', 'F1', A.GP_ALC_NUM, A.BKCL_ALC_NUM))
                   FROM TB_YYPD006 A
                       ,TB_YYDK301 B
                       ,TB_YYDK201 C
                       ,TB_YYDK002 I
                  WHERE B.RUN_DT BETWEEN '20140318' AND '20140320'
                    AND B.TRN_NO = DECODE (LPAD(TRIM(''), 5,'0'), NULL, B.TRN_NO, LPAD(TRIM(''), 5,'0'))
                    AND B.STLB_TRN_CLSF_CD = '00'
                    AND C.MRNT_CD = DECODE ('', NULL, C.MRNT_CD, '')
                    AND B.ROUT_CD = DECODE ('', NULL, B.ROUT_CD, '')
                    AND B.ROUT_CD = C.ROUT_CD
                    AND B.UP_DN_DV_CD = DECODE ('A', 'A', B.UP_DN_DV_CD, 'A')
                    AND A.YMGT_JOB_ID = (SELECT SUBSTR (MAX (SUBSTR (AA.REG_DTTM, 1, 8) || AA.YMGT_JOB_ID), 9, 24)
                                           FROM TB_YYFD011 AA, TB_YYFD010 BB
                                          WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
                                            AND BB.YMGT_PROC_DV_ID IN ('YP625', 'YP620')
                                            AND AA.OTMZ_PRS_STT_CD = '11'
                                            AND AA.RUN_DT = A.RUN_DT
                                            AND AA.TRN_NO = A.TRN_NO)
                    AND B.RUN_DT = A.RUN_DT
                    AND B.TRN_NO = A.TRN_NO
                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15
                    AND A.BKCL_CD = 'F1'
                    AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
                    AND A.RUN_DT = T1.RUN_DT
                    AND A.TRN_NO = T1.TRN_NO
                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD
                    AND A.RUN_DT = I.RUN_DT
                                           AND I.DAY_DV_CD = DECODE('0', '0', I.DAY_DV_CD, '9', I.DAY_DV_CD, '0') )  FCST_ACHV_DT
              , (SELECT DISTINCT SUBSTR (B.YMGT_JOB_ID, 14, 8)
                   FROM TB_YYPD006 A
                       ,TB_YYFD010 B
                       ,TB_YYDK301 C
                       ,TB_YYDK201 D
                       ,TB_YYDK002 I
                  WHERE C.RUN_DT BETWEEN '20140318' AND '20140320'
                    AND C.TRN_NO = DECODE (LPAD(TRIM(''), 5,'0'), NULL, C.TRN_NO, LPAD(TRIM(''), 5,'0'))
                    AND C.STLB_TRN_CLSF_CD = '00'
                    AND D.MRNT_CD = DECODE ('', NULL, D.MRNT_CD, '')
                    AND C.ROUT_CD = DECODE ('', NULL, C.ROUT_CD, '')
                    AND C.ROUT_CD = D.ROUT_CD
                    AND C.UP_DN_DV_CD = DECODE ('A', 'A', C.UP_DN_DV_CD, 'A')
                    AND A.YMGT_JOB_ID = (SELECT SUBSTR (MAX (SUBSTR (AA.REG_DTTM, 1, 8) || AA.YMGT_JOB_ID), 9, 24)
                                           FROM TB_YYFD011 AA, TB_YYFD010 BB
                                          WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
                                            AND BB.YMGT_PROC_DV_ID IN ('YP625', 'YP620')
                                            AND AA.OTMZ_PRS_STT_CD = '11'
                                            AND AA.RUN_DT = A.RUN_DT
                                            AND AA.TRN_NO = A.TRN_NO)
                    AND C.RUN_DT = A.RUN_DT
                    AND C.TRN_NO = A.TRN_NO
                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15
                    AND A.BKCL_CD = 'F1'
                    AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
                    AND A.YMGT_JOB_ID = B.YMGT_JOB_ID
                    AND B.YMGT_PROC_DV_ID IN ('YP625', 'YP620')
                    AND A.RUN_DT = T1.RUN_DT
                    AND A.TRN_NO = T1.TRN_NO
                    AND A.RUN_DT = I.RUN_DT
                    AND I.DAY_DV_CD = DECODE ('0',  '0', I.DAY_DV_CD,  '9', I.DAY_DV_CD,  '0') ) PSRM_CL_CD_SUM_ALC_CNT
              , (SELECT A.BS_SEAT_NUM
                   FROM TB_YYDK305 A
                  WHERE A.RUN_DT = T1.RUN_DT
                    AND A.TRN_NO = T1.TRN_NO
                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD
                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15)
                   BS_SEAT_NUM
              , (SELECT A.NOTY_SALE_SEAT_NUM
                   FROM TB_YYDK305 A
                  WHERE A.RUN_DT = T1.RUN_DT
                    AND A.TRN_NO = T1.TRN_NO
                    AND A.PSRM_CL_CD = T1.PSRM_CL_CD
                    AND TO_NUMBER(A.SEAT_ATT_CD) = 15)
                   NOTY_SALE_SEAT_NUM
              ,T1.PSRM_CL_CD PSRM_CL_CD
          FROM (  SELECT A.RUN_DT
                        ,A.TRN_NO
                        ,A.PSRM_CL_CD
                        ,A.ZONE_SEG_GP_NO
                        ,E.UP_DN_DV_CD
                        ,C.STOP_RS_STN_CD STOP_1
                        ,D.STOP_RS_STN_CD STOP_2
                        ,C.RUN_ORDR
                        ,D.RUN_ORDR
                        ,DECODE
                         (
                             E.UP_DN_DV_CD
                            ,'D',    (SELECT T2.KOR_STN_NM
                                        FROM TB_YYDK001 T1, TB_YYDK102 T2
                                       WHERE T1.RS_STN_CD = C.STOP_RS_STN_CD
                                         AND T1.STN_CD = T2.STN_CD
                                         AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
                                  || '-'
                                  || (SELECT T2.KOR_STN_NM
                                        FROM TB_YYDK001 T1, TB_YYDK102 T2
                                       WHERE T1.RS_STN_CD = D.STOP_RS_STN_CD
                                         AND T1.STN_CD = T2.STN_CD
                                         AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
                            ,   (SELECT T2.KOR_STN_NM
                                   FROM TB_YYDK001 T1, TB_YYDK102 T2
                                  WHERE T1.RS_STN_CD = D.STOP_RS_STN_CD
                                    AND T1.STN_CD = T2.STN_CD
                                    AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
                             || '-'
                             || (SELECT T2.KOR_STN_NM
                                   FROM TB_YYDK001 T1, TB_YYDK102 T2
                                  WHERE T1.RS_STN_CD = C.STOP_RS_STN_CD
                                    AND T1.STN_CD = T2.STN_CD
                                    AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN T2.APL_ST_DT AND T2.APL_CLS_DT)
                         )
                             DPT_ARV
                        ,SUM (DECODE ('F1', 'F1', A.GP_ALC_NUM, A.BKCL_ALC_NUM)) ALC_CNT
                        ,CASE
                             WHEN ( (G.VLID_ST_DNO IS NULL)
                                OR (TO_DATE (A.RUN_DT, 'YYYYMMDD') - TO_DATE (TO_CHAR (SYSDATE, 'YYYYMMDD'), 'YYYYMMDD') > G.VLID_CLS_DNO))
                             THEN
                                 NVL (F.GP_FST_ALC_SEAT_NUM, 0)
                             ELSE
                                 NVL (A.GP_BKCL_FST_ALC_NUM, 0)
                         END
                             AS GP_BKCL_FST_ALC_NUM
                        ,SUM (DECODE ('F1', 'F1', A.GP_MRK_ALLW_NUM, A.BKCL_MRK_ALLW_NUM)) ALL_CNT
                    FROM TB_YYPD006 A
                        ,TB_YYDK308 B
                        ,TB_YYDK302 C
                        ,TB_YYDK302 D
                        ,TB_YYDK301 E
                        ,TB_YYDK201 Z
                        ,TB_YYDK328 F
                        ,TB_YYBB003 G
                        ,TB_YYFD010 H
                        ,TB_YYDK002 I
                   WHERE E.RUN_DT BETWEEN '20140318' AND '20140320'
                     AND E.TRN_NO = DECODE (LPAD(TRIM(''), 5,'0'), NULL, E.TRN_NO, LPAD(TRIM(''), 5,'0'))
                     AND E.STLB_TRN_CLSF_CD = '00'
                     AND Z.MRNT_CD = DECODE ('', NULL, Z.MRNT_CD, '')
                     AND E.ROUT_CD = DECODE ('', NULL, E.ROUT_CD, '')
                     AND E.ROUT_CD = Z.ROUT_CD
                     AND E.UP_DN_DV_CD = DECODE ('A', 'A', E.UP_DN_DV_CD, 'A')
                     AND A.YMGT_JOB_ID = (SELECT SUBSTR (MAX (SUBSTR (AA.REG_DTTM, 1, 8) || AA.YMGT_JOB_ID), 9, 24)
                                            FROM TB_YYFD011 AA, TB_YYFD010 BB
                                           WHERE AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
                                             AND BB.YMGT_PROC_DV_ID IN ('YP625', 'YP620')
                                             AND AA.OTMZ_PRS_STT_CD = '11'
                                             AND AA.RUN_DT = A.RUN_DT
                                             AND AA.TRN_NO = A.TRN_NO)
                     AND E.RUN_DT = A.RUN_DT
                     AND E.TRN_NO = A.TRN_NO
                     AND TO_NUMBER(A.SEAT_ATT_CD) = 15
                     AND A.BKCL_CD = 'F1'
                     AND A.PSRM_CL_CD = DECODE ('', NULL, A.PSRM_CL_CD, '')
                     AND (A.GP_MRK_ALLW_NUM IS NOT NULL
                       OR A.BKCL_MRK_ALLW_NUM IS NOT NULL)
                     AND A.RUN_DT = B.RUN_DT
                     AND A.TRN_NO = B.TRN_NO
                     AND A.ZONE_SEG_GP_NO = B.SEG_GP_NO
                     AND A.RUN_DT = C.RUN_DT
                     AND A.TRN_NO = C.TRN_NO
                     AND B.DPT_ZONE_NO = C.TRVL_ZONE_NO
                     AND A.RUN_DT = D.RUN_DT
                     AND A.TRN_NO = D.TRN_NO
                     AND B.ARV_ZONE_NO = D.TRVL_ZONE_NO
                     AND C.STOP_RS_STN_CD <> D.STOP_RS_STN_CD
                     AND C.RUN_ORDR < DECODE (E.UP_DN_DV_CD,  'D', D.RUN_ORDR,  'U', 100)
                     AND D.RUN_ORDR > DECODE (E.UP_DN_DV_CD,  'D', C.RUN_ORDR,  'U', 0)
                     AND C.RUN_ORDR > DECODE (E.UP_DN_DV_CD,  'D', 0,  'U', D.RUN_ORDR)
                     AND F.RUN_DT = A.RUN_DT
                     AND F.TRN_NO = A.TRN_NO
                     AND SUBSTR (F.REST_SEAT_MG_ID, 14, 1) = A.PSRM_CL_CD
                     AND TO_NUMBER(A.SEAT_ATT_CD) = TO_NUMBER(SUBSTR(F.REST_SEAT_MG_ID, 15, 3))
                     AND A.ZONE_SEG_GP_NO = F.SEG_GP_NO
                     AND A.RUN_DT BETWEEN G.APL_ST_DT AND G.APL_CLS_DT
                     AND F.RUN_DT BETWEEN G.APL_ST_DT AND G.APL_CLS_DT
                     AND A.YMGT_JOB_ID = H.YMGT_JOB_ID
                     AND H.YMGT_PROC_DV_ID IN ('YP625', 'YP620')
                     AND F.DEAL_DT = TO_CHAR(TO_DATE(SUBSTR(H.YMGT_JOB_ID,14, 8 ),'YYYYMMDD') - 1, 'YYYYMMDD')
                     AND SUBSTR (TRIM (F.REST_SEAT_MG_ID), 15, 3) = '015'
                     AND G.BKCL_CD = A.BKCL_CD
                     AND A.ZONE_SEG_GP_NO BETWEEN TO_NUMBER (NVL ('1', '0')) AND TO_NUMBER (NVL ('1', '99999'))
                     AND E.RUN_DT = I.RUN_DT
                                            AND I.DAY_DV_CD = DECODE('0', '0', I.DAY_DV_CD, '9', I.DAY_DV_CD, '0')
                 GROUP BY A.RUN_DT
                         ,A.TRN_NO
                         ,A.PSRM_CL_CD
                         ,A.ZONE_SEG_GP_NO
                         ,E.UP_DN_DV_CD
                         ,C.STOP_RS_STN_CD
                         ,D.STOP_RS_STN_CD
                         ,C.RUN_ORDR
                         ,D.RUN_ORDR
                         ,A.GP_BKCL_FST_ALC_NUM
                         ,F.GP_FST_ALC_SEAT_NUM
                         ,G.VLID_ST_DNO
                         ,G.VLID_CLS_DNO
                 ORDER BY A.RUN_DT
                         ,A.TRN_NO
                         ,A.PSRM_CL_CD
                         ,A.ZONE_SEG_GP_NO
                         ,E.UP_DN_DV_CD
                         ,DECODE (E.UP_DN_DV_CD,  'D', C.RUN_ORDR,  'U', D.RUN_ORDR)
                         ,DECODE (E.UP_DN_DV_CD,  'D', D.RUN_ORDR,  'U', C.RUN_ORDR) DESC) T1) TMP
                         


인덱스 정보 
   YZDBA                          TB_YYDK328                     PK_YYDK328                        8780516 => RUN_DT,TRN_NO,REST_SEAT_MG_ID,SEG_GP_NO,DEAL_DT

튜닝 내용 
   - 인덱스(PK) 컬럼 순서 변경 또는 생성  검토 바람
      현재       :  RUN_DT,TRN_NO,REST_SEAT_MG_ID,SEG_GP_NO,DEAL_DT
      수정/생성  :  RUN_DT,TRN_NO,                SEG_GP_NO,DEAL_DT ,REST_SEAT_MG_ID                 

   - SQL 수정 
     힌트 추가 /*+ ORDERED */ 
     FROM 절의 순서 변경  ALIAS F 를 맨 뒤로 이동 



-------------------------------------------------------------------------------------------------------------
| Id  | Operation                                   | Name          | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                            |               |     1 |   101 |    23   (9)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID                | TB_YYDK007    |     1 |    25 |     1   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                          | PK_YYDK007    |     1 |       |     1   (0)| 00:00:01 |
|   3 |  NESTED LOOPS                               |               |     1 |    48 |     2   (0)| 00:00:01 |
|   4 |   TABLE ACCESS BY INDEX ROWID               | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|*  5 |    INDEX UNIQUE SCAN                        | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|*  6 |   TABLE ACCESS BY INDEX ROWID               | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|*  7 |    INDEX RANGE SCAN                         | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
|   8 |    NESTED LOOPS                             |               |     1 |    48 |     2   (0)| 00:00:01 |
|   9 |     TABLE ACCESS BY INDEX ROWID             | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|* 10 |      INDEX UNIQUE SCAN                      | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|* 11 |     TABLE ACCESS BY INDEX ROWID             | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|* 12 |      INDEX RANGE SCAN                       | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
|  13 |      NESTED LOOPS                           |               |     1 |    48 |     2   (0)| 00:00:01 |
|  14 |       TABLE ACCESS BY INDEX ROWID           | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|* 15 |        INDEX UNIQUE SCAN                    | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|* 16 |       TABLE ACCESS BY INDEX ROWID           | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|* 17 |        INDEX RANGE SCAN                     | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
|  18 |        NESTED LOOPS                         |               |     1 |    48 |     2   (0)| 00:00:01 |
|  19 |         TABLE ACCESS BY INDEX ROWID         | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|* 20 |          INDEX UNIQUE SCAN                  | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|* 21 |         TABLE ACCESS BY INDEX ROWID         | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|* 22 |          INDEX RANGE SCAN                   | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
|  23 |  SORT AGGREGATE                             |               |     1 |   252 |            |          |
|  24 |   NESTED LOOPS                              |               |       |       |            |          |
|  25 |    NESTED LOOPS                             |               |     1 |   252 |    10   (0)| 00:00:01 |
|  26 |     NESTED LOOPS                            |               |     1 |   228 |     9   (0)| 00:00:01 |
|  27 |      NESTED LOOPS                           |               |     1 |   206 |     8   (0)| 00:00:01 |
|  28 |       NESTED LOOPS                          |               |     1 |   184 |     7   (0)| 00:00:01 |
|  29 |        NESTED LOOPS                         |               |     1 |   108 |     6   (0)| 00:00:01 |
|  30 |         NESTED LOOPS                        |               |     1 |    44 |     3   (0)| 00:00:01 |
|  31 |          NESTED LOOPS                       |               |     1 |    36 |     2   (0)| 00:00:01 |
|* 32 |           INDEX UNIQUE SCAN                 | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
|* 33 |           TABLE ACCESS BY INDEX ROWID       | TB_YYDK301    |     1 |    25 |     1   (0)| 00:00:01 |
|* 34 |            INDEX UNIQUE SCAN                | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|* 35 |          INDEX UNIQUE SCAN                  | PK_YYDK201    |     1 |       |     1   (0)| 00:00:01 |
|  36 |         VIEW                                | VW_SQ_1       |     1 |    64 |     3   (0)| 00:00:01 |
|  37 |          SORT GROUP BY                      |               |     1 |    88 |     3   (0)| 00:00:01 |
|* 38 |           FILTER                            |               |       |       |            |          |
|  39 |            NESTED LOOPS                     |               |     1 |    88 |     3   (0)| 00:00:01 |
|* 40 |             TABLE ACCESS BY INDEX ROWID     | TB_YYFD011    |     1 |    57 |     2   (0)| 00:00:01 |
|* 41 |              INDEX RANGE SCAN               | IX_YYFD011_01 |     4 |       |     1   (0)| 00:00:01 |
|  42 |             INLIST ITERATOR                 |               |       |       |            |          |
|* 43 |              INDEX UNIQUE SCAN              | PK_YYFD010    |     1 |    31 |     1   (0)| 00:00:01 |
|  44 |        TABLE ACCESS BY INDEX ROWID          | TB_YYFD410    |     1 |    76 |     1   (0)| 00:00:01 |
|* 45 |         INDEX RANGE SCAN                    | PK_YYFD410    |     1 |       |     1   (0)| 00:00:01 |
|  46 |       TABLE ACCESS BY INDEX ROWID           | TB_YYDK302    |     1 |    22 |     1   (0)| 00:00:01 |
|* 47 |        INDEX UNIQUE SCAN                    | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|  48 |      TABLE ACCESS BY INDEX ROWID            | TB_YYDK302    |     1 |    22 |     1   (0)| 00:00:01 |
|* 49 |       INDEX UNIQUE SCAN                     | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|* 50 |     INDEX RANGE SCAN                        | PK_YYDK308    |     1 |       |     1   (0)| 00:00:01 |
|* 51 |    TABLE ACCESS BY INDEX ROWID              | TB_YYDK308    |     1 |    24 |     1   (0)| 00:00:01 |
|* 52 |  TABLE ACCESS BY INDEX ROWID                | TB_YYDK305    |     1 |    25 |     1   (0)| 00:00:01 |
|* 53 |   INDEX RANGE SCAN                          | PK_YYDK305    |     2 |       |     1   (0)| 00:00:01 |
|* 54 |  TABLE ACCESS BY INDEX ROWID                | TB_YYDK305    |     1 |    24 |     1   (0)| 00:00:01 |
|* 55 |   INDEX RANGE SCAN                          | PK_YYDK305    |     2 |       |     1   (0)| 00:00:01 |
|  56 |  SORT AGGREGATE                             |               |     1 |   176 |            |          |
|  57 |   NESTED LOOPS                              |               |       |       |            |          |
|  58 |    NESTED LOOPS                             |               |     1 |   176 |     7   (0)| 00:00:01 |
|  59 |     NESTED LOOPS                            |               |     1 |   108 |     6   (0)| 00:00:01 |
|  60 |      NESTED LOOPS                           |               |     1 |    44 |     3   (0)| 00:00:01 |
|  61 |       NESTED LOOPS                          |               |     1 |    36 |     2   (0)| 00:00:01 |
|* 62 |        INDEX UNIQUE SCAN                    | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
|* 63 |        TABLE ACCESS BY INDEX ROWID          | TB_YYDK301    |     1 |    25 |     1   (0)| 00:00:01 |
|* 64 |         INDEX UNIQUE SCAN                   | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|* 65 |       INDEX UNIQUE SCAN                     | PK_YYDK201    |     1 |       |     1   (0)| 00:00:01 |
|  66 |      VIEW                                   | VW_SQ_2       |     1 |    64 |     3   (0)| 00:00:01 |
|  67 |       SORT GROUP BY                         |               |     1 |    88 |     3   (0)| 00:00:01 |
|* 68 |        FILTER                               |               |       |       |            |          |
|  69 |         NESTED LOOPS                        |               |     1 |    88 |     3   (0)| 00:00:01 |
|* 70 |          TABLE ACCESS BY INDEX ROWID        | TB_YYFD011    |     1 |    57 |     2   (0)| 00:00:01 |
|* 71 |           INDEX RANGE SCAN                  | IX_YYFD011_01 |     4 |       |     1   (0)| 00:00:01 |
|  72 |          INLIST ITERATOR                    |               |       |       |            |          |
|* 73 |           INDEX UNIQUE SCAN                 | PK_YYFD010    |     1 |    31 |     1   (0)| 00:00:01 |
|* 74 |     INDEX RANGE SCAN                        | PK_YYPD006    |     1 |       |     1   (0)| 00:00:01 |
|  75 |    TABLE ACCESS BY INDEX ROWID              | TB_YYPD006    |     1 |    68 |     1   (0)| 00:00:01 |
|  76 |     HASH UNIQUE                             |               |     1 |   265 |    11  (10)| 00:00:01 |
|* 77 |      FILTER                                 |               |       |       |            |          |
|  78 |       SORT GROUP BY                         |               |     1 |   265 |    11  (10)| 00:00:01 |
|* 79 |        FILTER                               |               |       |       |            |          |
|  80 |         NESTED LOOPS                        |               |     1 |   265 |    10   (0)| 00:00:01 |
|  81 |          NESTED LOOPS                       |               |     1 |   222 |     9   (0)| 00:00:01 |
|  82 |           NESTED LOOPS                      |               |     1 |   168 |     6   (0)| 00:00:01 |
|  83 |            NESTED LOOPS                     |               |     1 |   137 |     5   (0)| 00:00:01 |
|  84 |             NESTED LOOPS                    |               |     1 |    80 |     3   (0)| 00:00:01 |
|  85 |              NESTED LOOPS                   |               |     1 |    60 |     2   (0)| 00:00:01 |
|* 86 |               INDEX UNIQUE SCAN             | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
|* 87 |               TABLE ACCESS BY INDEX ROWID   | TB_YYDK301    |     1 |    37 |     1   (0)| 00:00:01 |
|* 88 |                INDEX UNIQUE SCAN            | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|* 89 |              INDEX UNIQUE SCAN              | PK_YYDK201    |     1 |       |     1   (0)| 00:00:01 |
|* 90 |             TABLE ACCESS BY INDEX ROWID     | TB_YYFD011    |     1 |    57 |     2   (0)| 00:00:01 |
|* 91 |              INDEX RANGE SCAN               | IX_YYFD011_01 |     4 |       |     1   (0)| 00:00:01 |
|  92 |            INLIST ITERATOR                  |               |       |       |            |          |
|* 93 |             INDEX UNIQUE SCAN               | PK_YYFD010    |     1 |    31 |     1   (0)| 00:00:01 |
|* 94 |           INDEX RANGE SCAN                  | PK_YYPD006    |     1 |    54 |     3   (0)| 00:00:01 |
|  95 |          INLIST ITERATOR                    |               |       |       |            |          |
|* 96 |           INDEX UNIQUE SCAN                 | PK_YYFD010    |     1 |    43 |     1   (0)| 00:00:01 |
|  97 |  SORT AGGREGATE                             |               |     1 |   176 |            |          |
|  98 |   NESTED LOOPS                              |               |       |       |            |          |
|  99 |    NESTED LOOPS                             |               |     1 |   176 |     7   (0)| 00:00:01 |
| 100 |     NESTED LOOPS                            |               |     1 |   108 |     6   (0)| 00:00:01 |
| 101 |      NESTED LOOPS                           |               |     1 |    44 |     3   (0)| 00:00:01 |
| 102 |       NESTED LOOPS                          |               |     1 |    36 |     2   (0)| 00:00:01 |
|*103 |        INDEX UNIQUE SCAN                    | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
|*104 |        TABLE ACCESS BY INDEX ROWID          | TB_YYDK301    |     1 |    25 |     1   (0)| 00:00:01 |
|*105 |         INDEX UNIQUE SCAN                   | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|*106 |       INDEX UNIQUE SCAN                     | PK_YYDK201    |     1 |       |     1   (0)| 00:00:01 |
| 107 |      VIEW                                   | VW_SQ_3       |     1 |    64 |     3   (0)| 00:00:01 |
| 108 |       SORT GROUP BY                         |               |     1 |    88 |     3   (0)| 00:00:01 |
|*109 |        FILTER                               |               |       |       |            |          |
| 110 |         NESTED LOOPS                        |               |     1 |    88 |     3   (0)| 00:00:01 |
|*111 |          TABLE ACCESS BY INDEX ROWID        | TB_YYFD011    |     1 |    57 |     2   (0)| 00:00:01 |
|*112 |           INDEX RANGE SCAN                  | IX_YYFD011_01 |     4 |       |     1   (0)| 00:00:01 |
| 113 |          INLIST ITERATOR                    |               |       |       |            |          |
|*114 |           INDEX UNIQUE SCAN                 | PK_YYFD010    |     1 |    31 |     1   (0)| 00:00:01 |
|*115 |     INDEX RANGE SCAN                        | PK_YYPD006    |     1 |       |     1   (0)| 00:00:01 |
| 116 |    TABLE ACCESS BY INDEX ROWID              | TB_YYPD006    |     1 |    68 |     1   (0)| 00:00:01 |
| 117 |  NESTED LOOPS                               |               |     1 |    47 |     2   (0)| 00:00:01 |
| 118 |   TABLE ACCESS BY INDEX ROWID               | TB_YYDK301    |     1 |    20 |     1   (0)| 00:00:01 |
|*119 |    INDEX UNIQUE SCAN                        | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|*120 |   TABLE ACCESS BY INDEX ROWID               | TB_YYDK302    |     1 |    27 |     1   (0)| 00:00:01 |
|*121 |    INDEX RANGE SCAN                         | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
| 122 |  NESTED LOOPS                               |               |     1 |    48 |     2   (0)| 00:00:01 |
| 123 |   TABLE ACCESS BY INDEX ROWID               | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|*124 |    INDEX UNIQUE SCAN                        | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|*125 |   TABLE ACCESS BY INDEX ROWID               | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|*126 |    INDEX RANGE SCAN                         | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
| 127 |    NESTED LOOPS                             |               |     1 |    48 |     2   (0)| 00:00:01 |
| 128 |     TABLE ACCESS BY INDEX ROWID             | TB_YYDK001    |     1 |    13 |     1   (0)| 00:00:01 |
|*129 |      INDEX UNIQUE SCAN                      | PK_YYDK001    |     1 |       |     1   (0)| 00:00:01 |
|*130 |     TABLE ACCESS BY INDEX ROWID             | TB_YYDK102    |     1 |    35 |     1   (0)| 00:00:01 |
|*131 |      INDEX RANGE SCAN                       | PK_YYDK102    |     1 |       |     1   (0)| 00:00:01 |
| 132 |  NESTED LOOPS                               |               |       |       |            |          |
| 133 |   NESTED LOOPS                              |               |     1 |    79 |     3   (0)| 00:00:01 |
| 134 |    NESTED LOOPS                             |               |     1 |    52 |     2   (0)| 00:00:01 |
| 135 |     TABLE ACCESS BY INDEX ROWID             | TB_YYDK301    |     1 |    25 |     1   (0)| 00:00:01 |
|*136 |      INDEX UNIQUE SCAN                      | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|*137 |     TABLE ACCESS BY INDEX ROWID             | TB_YYDK302    |     1 |    27 |     1   (0)| 00:00:01 |
|*138 |      INDEX RANGE SCAN                       | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*139 |    INDEX RANGE SCAN                         | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*140 |   TABLE ACCESS BY INDEX ROWID               | TB_YYDK302    |     1 |    27 |     1   (0)| 00:00:01 |
| 141 |  VIEW                                       |               |     1 |   101 |    23   (9)| 00:00:01 |
| 142 |   SORT ORDER BY                             |               |     1 |   351 |    23   (9)| 00:00:01 |
| 143 |    HASH GROUP BY                            |               |     1 |   351 |    23   (9)| 00:00:01 |
| 144 |     NESTED LOOPS                            |               |     1 |   351 |    11   (0)| 00:00:01 |
| 145 |      NESTED LOOPS                           |               |     1 |   320 |    10   (0)| 00:00:01 |
| 146 |       NESTED LOOPS                          |               |     1 |   296 |     9   (0)| 00:00:01 |
| 147 |        NESTED LOOPS                         |               |     1 |   270 |     8   (0)| 00:00:01 |
| 148 |         NESTED LOOPS                        |               |     1 |   244 |     7   (0)| 00:00:01 |
| 149 |          NESTED LOOPS                       |               |     1 |   236 |     6   (0)| 00:00:01 |
| 150 |           NESTED LOOPS                      |               |     1 |   225 |     5   (0)| 00:00:01 |
| 151 |            NESTED LOOPS                     |               |     1 |   200 |     4   (0)| 00:00:01 |
| 152 |             NESTED LOOPS                    |               |     1 |   147 |     2   (0)| 00:00:01 |
|*153 |              TABLE ACCESS BY INDEX ROWID    | TB_YYPD006    |     1 |   120 |     1   (0)| 00:00:01 |
|*154 |               INDEX RANGE SCAN              | PK_YYPD006    |     1 |       |     1   (0)| 00:00:01 |
| 155 |                SORT AGGREGATE               |               |     1 |    88 |            |          |
| 156 |                 NESTED LOOPS                |               |     7 |   616 |    10   (0)| 00:00:01 |
|*157 |                  TABLE ACCESS BY INDEX ROWID| TB_YYFD011    |     5 |   285 |     6   (0)| 00:00:01 |
|*158 |                   INDEX RANGE SCAN          | IX_YYFD011_01 |    16 |       |     1   (0)| 00:00:01 |
| 159 |                  INLIST ITERATOR            |               |       |       |            |          |
|*160 |                   INDEX UNIQUE SCAN         | PK_YYFD010    |     1 |    31 |     1   (0)| 00:00:01 |
|*161 |              TABLE ACCESS BY INDEX ROWID    | TB_YYBB003    |     1 |    27 |     1   (0)| 00:00:01 |
|*162 |               INDEX RANGE SCAN              | PK_YYBB003    |     1 |       |     1   (0)| 00:00:01 |
| 163 |             TABLE ACCESS BY INDEX ROWID     | TB_YYDK328    |     1 |    53 |     2   (0)| 00:00:01 |
|*164 |              INDEX RANGE SCAN               | PK_YYDK328    |     1 |       |     1   (0)| 00:00:01 |
|*165 |            TABLE ACCESS BY INDEX ROWID      | TB_YYDK301    |     1 |    25 |     1   (0)| 00:00:01 |
|*166 |             INDEX UNIQUE SCAN               | PK_YYDK301    |     1 |       |     1   (0)| 00:00:01 |
|*167 |           INDEX UNIQUE SCAN                 | PK_YYDK002    |     1 |       |     1   (0)| 00:00:01 |
|*168 |          INDEX UNIQUE SCAN                  | PK_YYDK201    |     1 |       |     1   (0)| 00:00:01 |
| 169 |         TABLE ACCESS BY INDEX ROWID         | TB_YYDK302    |     1 |    26 |     1   (0)| 00:00:01 |
|*170 |          INDEX RANGE SCAN                   | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*171 |        TABLE ACCESS BY INDEX ROWID          | TB_YYDK302    |     1 |    26 |     1   (0)| 00:00:01 |
|*172 |         INDEX RANGE SCAN                    | PK_YYDK302    |     1 |       |     1   (0)| 00:00:01 |
|*173 |       TABLE ACCESS BY INDEX ROWID           | TB_YYDK308    |     1 |    24 |     1   (0)| 00:00:01 |
|*174 |        INDEX UNIQUE SCAN                    | PK_YYDK308    |     1 |       |     1   (0)| 00:00:01 |
| 175 |      INLIST ITERATOR                        |               |       |       |            |          |
|*176 |       INDEX UNIQUE SCAN                     | PK_YYFD010    |     1 |    31 |     1   (0)| 00:00:01 |
-------------------------------------------------------------------------------------------------------------

