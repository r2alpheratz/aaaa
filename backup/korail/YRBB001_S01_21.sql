		SELECT   MRNT_CD,
		         MN_RUN_LN_NM,
		         UP_DN_DV_CD,
		         RUN_DT,
		         RUN_DT_TXT,
		         TRN_NO,
		         PRNB1,
		         PRNB2,
		         PRNB3,
		         ERR_RATE1,
		         ERR_RATE2,
		         RMRK,
		         GP_MRK_SEAT_NUM
		FROM     (SELECT /*+ RULE */
		                   A3.MRNT_CD,
		                 A3.MN_RUN_LN_NM,
		                 A3.UP_DN_DV_CD,
		                    TO_CHAR(TO_DATE(A3.RUN_DT, 'YYYYMMDD'), 'YYYY.MM.DD')
		                    || '('
		                    || (SELECT SUBSTR(VLID_VAL_NM,1,1)
		                    FROM TB_YYDK007
		                    WHERE     XROIS_OLD_SRT_CD = 'I909'
		                    AND VLID_VAL = (SELECT DAY_DV_CD
		                               FROM TB_YYDK002
		                              WHERE RUN_DT = A3.RUN_DT))
		                    || ')' RUN_DT_TXT,
		                 A3.RUN_DT,
		                 TO_NUMBER(A3.TRN_NO) TRN_NO,
		                 A3.PRNB1,
		                 A3.PRNB2,
		                 A3.PRNB3,
		                 DECODE(A3.PRNB1, 0, 0, ROUND(ABS(100 - (A3.PRNB2 / A3.PRNB1) * 100), 0) ) ERR_RATE1,
		                 DECODE(A3.PRNB3, 0, 0, ROUND(ABS(100 - (B3.GP_MRK_SEAT_NUM / A3.PRNB3) * 100), 0) ) ERR_RATE2,
		                 '' RMRK,
		                 NVL(B3.GP_MRK_SEAT_NUM, 0) GP_MRK_SEAT_NUM,
		                 A3.SUM_FLAG
		          FROM   (SELECT   C.MRNT_CD,
		                           (SELECT LN_NM		  
		                            FROM   TB_YYDK103			
		                            WHERE  LN_CD IN ( SELECT DISTINCT MRNT_CD		
		                                            FROM            TB_YYDK201	
		                                            WHERE           ROUT_DV_CD IN('10', '30')		 
		                                            AND             MRNT_CD IN ('01','03','04')	
		                                            AND             ( (EFC_ST_DT <= '20140101'	
		                                                               AND EFC_CLS_DT >= '20140131')	
		                                                             OR(EFC_ST_DT >= '20140101'			 
		                                                                AND EFC_CLS_DT <= '20140131') ) )
		                            AND    APL_ST_DT <= TO_CHAR(SYSDATE, 'YYYYMMDD')
		                            AND    APL_CLS_DT >= TO_CHAR(SYSDATE, 'YYYYMMDD')
		                            AND    LN_CD = C.MRNT_CD) MN_RUN_LN_NM,
		                           C.UP_DN_DV_CD,
		                           T2.RUN_DT,
		                           T2.TRN_NO,
		                           NVL(SUM(T2.PRNB1), 0) PRNB1,
		                           NVL(SUM(T2.PRNB2), 0) PRNB2,
		                           NVL(SUM(T2.PRNB3), 0) PRNB3,
		                           '1' SUM_FLAG
		                  FROM     TB_YYDK302 A,
		                           TB_YYDK302 B,
		                           TB_YYDP503 C,
		                           (SELECT   T1.RUN_DT,
		                                     T1.TRN_NO,
		                                     T1.DPT_STN_CONS_ORDR,
		                                     T1.ARV_STN_CONS_ORDR,
		                                     SUM(DECODE(T1.FLAG, '1', PRNB, 0) ) PRNB1,
		                                     SUM(DECODE(T1.FLAG, '2', PRNB, 0) ) PRNB2,
		                                     SUM(DECODE(T1.FLAG, '3', PRNB, 0) ) PRNB3
		                            FROM     (SELECT G.RUN_DT,
		                                             G.TRN_NO,
		                                             G.DPT_STN_CONS_ORDR,
		                                             G.ARV_STN_CONS_ORDR,
		                                             NVL(A.ABRD_PRNB, 0) PRNB,
		                                             '1' FLAG
		                                      FROM   (SELECT   RUN_DT,
		                                                       TRN_NO,
		                                                       PSRM_CL_CD,
		                                                       DECODE(BKCL_CD, 'F2', 'F1', BKCL_CD) BKCL_CD,
		                                                       DPT_STN_CONS_ORDR,
		                                                       ARV_STN_CONS_ORDR,
		                                                       SUM(ABRD_POSN_RT) AS ABRD_POSN_RT,
		                                                       SUM(ABRD_PRNB) AS ABRD_PRNB,
		                                                       SUM(SMG_ABRD_PRNB) AS SMG_ABRD_PRNB,
		                                                       SUM(CMTR_ABRD_PRNB) AS CMTR_ABRD_PRNB
		                                              FROM     TB_YYDS510
		                                              WHERE    RUN_DT BETWEEN '20140101' AND '20140131'
		                                              AND      TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                                              AND      PSRM_CL_CD LIKE DECODE('', '', '%', '')
		                                              GROUP BY RUN_DT,
		                                                       TRN_NO,
		                                                       PSRM_CL_CD,
		                                                       DECODE(BKCL_CD, 'F2', 'F1', BKCL_CD),
		                                                       DPT_STN_CONS_ORDR,
		                                                       ARV_STN_CONS_ORDR) A,
		                                             TB_YYDK002 X,
		                                             (SELECT BB.RUN_DT,
		                                                     BB.TRN_NO,
		                                                     BB.DPT_STN_CONS_ORDR,
		                                                     BB.ARV_STN_CONS_ORDR,
		                                                     AA.BKCL_CD,
		                                                     AA.PSRM_CL_CD
		                                              FROM   (SELECT DISTINCT RUN_DT,
		                                                                      TRN_NO,
		                                                                      BKCL_CD,
		                                                                      PSRM_CL_CD
		                                                      FROM            TB_YYDD504
		                                                      WHERE           RUN_DT BETWEEN '20140101' AND '20140131'
		                                                      AND             PSRM_CL_CD LIKE DECODE('', '', '%', '')
		                                                      AND             TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )) AA,
		                                                     (SELECT X.RUN_DT,
		                                                             X.TRN_NO,
		                                                             DPT_STN_CONS_ORDR,
		                                                             ARV_STN_CONS_ORDR
		                                                      FROM   TB_YYDD505 X,
		                                                             TB_YYDK002 Y,
		                                                             TB_YYDK301 Z
		                                                      WHERE  Y.RUN_DT BETWEEN '20140101' AND '20140131'
		                                                      AND    Y.DAY_DV_CD LIKE DECODE('0', '0', '%', '')
		                                                      AND    Y.RUN_DT = Z.RUN_DT
		                                                      AND    Z.STLB_TRN_CLSF_CD = DECODE('00', '', '%', '00')
		                                                      AND    Z.TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                                                      AND    Z.RUN_DT = X.RUN_DT
		                                                      AND    Z.TRN_NO = X.TRN_NO) BB
		                                              WHERE  AA.RUN_DT = BB.RUN_DT
		                                              AND    AA.TRN_NO = BB.TRN_NO) G
		                                      WHERE  X.DAY_DV_CD LIKE DECODE('0', '0', '%', '')
		                                      AND    X.RUN_DT = A.RUN_DT
		                                      AND    A.RUN_DT(+) = G.RUN_DT
		                                      AND    A.TRN_NO(+) = G.TRN_NO
		                                      AND    A.DPT_STN_CONS_ORDR(+) = G.DPT_STN_CONS_ORDR
		                                      AND    A.ARV_STN_CONS_ORDR(+) = G.ARV_STN_CONS_ORDR
		                                      AND    A.PSRM_CL_CD(+) = G.PSRM_CL_CD
		                                      AND    A.BKCL_CD(+) = G.BKCL_CD
		                                      AND    A.RUN_DT BETWEEN '20140101' AND '20140131'
		                                      AND    A.TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                                      UNION ALL
		                                      SELECT G.RUN_DT,
		                                             G.TRN_NO,
		                                             G.DPT_STN_CONS_ORDR,
		                                             G.ARV_STN_CONS_ORDR,
		                                             NVL(A.USR_CTL_EXPN_DMD_NUM, 0),
		                                             '2' FLAG
		                                      FROM   TB_YYFD410 A,
		                                             TB_YYDK002 X,
		                                             (SELECT BB.RUN_DT,
		                                                     BB.TRN_NO,
		                                                     BB.DPT_STN_CONS_ORDR,
		                                                     BB.ARV_STN_CONS_ORDR,
		                                                     AA.BKCL_CD,
		                                                     AA.PSRM_CL_CD
		                                              FROM   (SELECT DISTINCT RUN_DT,
		                                                                      TRN_NO,
		                                                                      BKCL_CD,
		                                                                      PSRM_CL_CD
		                                                      FROM            TB_YYDD504
		                                                      WHERE           RUN_DT BETWEEN '20140101' AND '20140131'
		                                                      AND             PSRM_CL_CD LIKE DECODE('', '', '%', '')
		                                                      AND             TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )) AA,
		                                                     (SELECT X.RUN_DT,
		                                                             X.TRN_NO,
		                                                             DPT_STN_CONS_ORDR,
		                                                             ARV_STN_CONS_ORDR
		                                                      FROM   TB_YYDD505 X,
		                                                             TB_YYDK002 Y,
		                                                             TB_YYDK301 Z
		                                                      WHERE  Y.RUN_DT BETWEEN '20140101' AND '20140131'
		                                                      AND    Y.DAY_DV_CD LIKE DECODE('0', '0', '%', '')
		                                                      AND    Y.RUN_DT = Z.RUN_DT
		                                                      AND    Z.STLB_TRN_CLSF_CD LIKE DECODE('00', '', '%', '00')
		                                                      AND    Z.TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                                                      AND    Z.RUN_DT = X.RUN_DT
		                                                      AND    Z.TRN_NO = X.TRN_NO) BB
		                                              WHERE  AA.RUN_DT = BB.RUN_DT
		                                              AND    AA.TRN_NO = BB.TRN_NO) G
		                                      WHERE  X.DAY_DV_CD LIKE DECODE('0', '0', '%', '')
		                                      AND    X.RUN_DT = A.RUN_DT
		                                      AND    A.RUN_DT(+) = G.RUN_DT
		                                      AND    A.TRN_NO(+) = G.TRN_NO
		                                      AND    A.DPT_STN_CONS_ORDR(+) = G.DPT_STN_CONS_ORDR
		                                      AND    A.ARV_STN_CONS_ORDR(+) = G.ARV_STN_CONS_ORDR
		                                      AND    A.PSRM_CL_CD(+) = G.PSRM_CL_CD
		                                      AND    A.BKCL_CD(+) = G.BKCL_CD
		                                      AND    A.YMGT_JOB_ID = (SELECT SUBSTR(MAX(SUBSTR(AA.REG_USR_ID, 1, 8)
		                                                                               || AA.YMGT_JOB_ID),
		                                                                           7,
		                                                                           24)
		                                                             FROM   TB_YYFD011 AA,
		                                                                    TB_YYFD010 BB
		                                                             WHERE  AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                                                             AND    BB.YMGT_PROC_DV_ID IN('YF540', 'YF940', 'YF950')
		                                                             AND    AA.FCST_PRS_STT_CD IN('11', '21')
		                                                             AND    AA.RUN_DT = A.RUN_DT
		                                                             AND    AA.TRN_NO = A.TRN_NO)
		                                      AND    A.RUN_DT BETWEEN '20140101' AND '20140131'
		                                      AND    A.TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                                      UNION ALL
		                                      SELECT G.RUN_DT,
		                                             G.TRN_NO,
		                                             G.DPT_STN_CONS_ORDR,
		                                             G.ARV_STN_CONS_ORDR,
		                                             NVL(A.ALC_NUM, 0),
		                                             '3' FLAG
		                                      FROM   TB_YYPD005 A,
		                                             TB_YYDK002 X,
		                                             (SELECT BB.RUN_DT,
		                                                     BB.TRN_NO,
		                                                     BB.DPT_STN_CONS_ORDR,
		                                                     BB.ARV_STN_CONS_ORDR,
		                                                     AA.BKCL_CD,
		                                                     AA.PSRM_CL_CD
		                                              FROM   (SELECT DISTINCT RUN_DT,
		                                                                      TRN_NO,
		                                                                      BKCL_CD,
		                                                                      PSRM_CL_CD
		                                                      FROM            TB_YYDD504
		                                                      WHERE           RUN_DT BETWEEN '20140101' AND '20140131'
		                                                      AND             TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                                                      AND             PSRM_CL_CD LIKE DECODE('', '', '%', '')) AA,
		                                                     (SELECT X.RUN_DT,
		                                                             X.TRN_NO,
		                                                             DPT_STN_CONS_ORDR,
		                                                             ARV_STN_CONS_ORDR
		                                                      FROM   TB_YYDD505 X,
		                                                             TB_YYDK002 Y,
		                                                             TB_YYDK301 Z
		                                                      WHERE  Y.RUN_DT BETWEEN '20140101' AND '20140131'
		                                                      AND    Y.DAY_DV_CD LIKE DECODE('0', '0', '%', '')
		                                                      AND    Y.RUN_DT = Z.RUN_DT
		                                                      AND    Z.STLB_TRN_CLSF_CD = DECODE('00', '', '%', '00')
		                                                      AND    Z.TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                                                      AND    Z.RUN_DT = X.RUN_DT
		                                                      AND    Z.TRN_NO = X.TRN_NO) BB
		                                              WHERE  AA.RUN_DT = BB.RUN_DT
		                                              AND    AA.TRN_NO = BB.TRN_NO) G
		                                      WHERE  X.DAY_DV_CD LIKE DECODE('0', '0', '%', '')
		                                      AND    X.RUN_DT = A.RUN_DT
		                                      AND    A.RUN_DT(+) = G.RUN_DT
		                                      AND    A.TRN_NO(+) = G.TRN_NO
		                                      AND    A.DPT_STN_CONS_ORDR(+) = G.DPT_STN_CONS_ORDR
		                                      AND    A.ARV_STN_CONS_ORDR(+) = G.ARV_STN_CONS_ORDR
		                                      AND    A.PSRM_CL_CD(+) = G.PSRM_CL_CD
		                                      AND    A.BKCL_CD(+) = G.BKCL_CD
		                                      AND    A.YMGT_JOB_ID = (SELECT SUBSTR(MAX(SUBSTR(AA.REG_USR_ID, 1, 8)
		                                                                               || AA.YMGT_JOB_ID),
		                                                                           7,
		                                                                           24)
		                                                             FROM   TB_YYFD011 AA,
		                                                                    TB_YYFD010 BB
		                                                             WHERE  AA.YMGT_JOB_ID = BB.YMGT_JOB_ID
		                                                             AND    BB.YMGT_PROC_DV_ID IN('YF540', 'YF940', 'YF950')
		                                                             AND    AA.FCST_PRS_STT_CD IN('11', '21')
		                                                             AND    AA.RUN_DT = A.RUN_DT
		                                                             AND    AA.TRN_NO = A.TRN_NO)
		                                      AND    A.RUN_DT BETWEEN '20140101' AND '20140131'
		                                      AND    A.TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )) T1
		                            GROUP BY T1.RUN_DT,
		                                     T1.TRN_NO,
		                                     T1.DPT_STN_CONS_ORDR,
		                                     T1.ARV_STN_CONS_ORDR) T2
		                  WHERE    T2.RUN_DT = A.RUN_DT
		                  AND      T2.TRN_NO = A.TRN_NO
		                  AND      T2.DPT_STN_CONS_ORDR = A.STN_CONS_ORDR
		                  AND      T2.RUN_DT = B.RUN_DT
		                  AND      T2.TRN_NO = B.TRN_NO
		                  AND      T2.ARV_STN_CONS_ORDR = B.STN_CONS_ORDR
		                   AND      T2.RUN_DT = C.RUN_DT
		                  AND      T2.TRN_NO = C.TRN_NO
		                  AND      C.DAY_DV_CD LIKE DECODE('0', '0', '%', '')
		                  AND      C.MRNT_CD LIKE DECODE('', '', '%', '')
		                  AND      C.MRNT_CD IN ('01','03','04')
		                  AND      C.UP_DN_DV_CD LIKE DECODE('A', 'A', '%', 'A')
		                  GROUP BY C.MRNT_CD,
		                           C.UP_DN_DV_CD,
		                           T2.RUN_DT,
		                           T2.TRN_NO) A3,
		                 (SELECT   A.RUN_DT,
		                           A.TRN_NO,
		                           SUM(A.GP_MRK_SEAT_NUM) GP_MRK_SEAT_NUM
		                  FROM     TB_YYDK328 A
		                  WHERE    A.RUN_DT BETWEEN '20140101' AND '20140131'
		                  AND      SUBSTR(A.REST_SEAT_MG_ID,14,1) LIKE DECODE('', '', '%', '')
		                  AND      A.TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                  AND      (A.RUN_DT, A.TRN_NO, A.DEAL_DT) IN
		                                                          (SELECT RUN_DT, TRN_NO, MAX(DEAL_DT) FROM TB_YYDK328
		                                                    WHERE RUN_DT BETWEEN '20140101' AND '20140131'
		                                                      AND SUBSTR(REST_SEAT_MG_ID,14,1) LIKE DECODE('', '', '%', '')
		                                                      AND TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                                                    GROUP BY RUN_DT, TRN_NO)
		                  GROUP BY A.RUN_DT,
		                           A.TRN_NO) B3
		          WHERE  A3.RUN_DT = B3.RUN_DT(+)
		          AND    A3.TRN_NO = B3.TRN_NO(+)) A
		ORDER BY MRNT_CD,
		         RUN_DT,
		         TRN_NO,
		         SUM_FLAG
		         


현재 인덱스 
  YZDBA                TB_YYDD504                     PK_YYDD504                        1171201  => RUN_DT,TRN_NO,PSRM_CL_CD,SEAT_ATT_CD,BKCL_CD

  YZDBA                TB_YYDK328                     PK_YYDK328                       12647639  => RUN_DT,TRN_NO,REST_SEAT_MG_ID,SEG_GP_NO,DEAL_DT

튜닝 내용
  - rule 힌트 제거 
  
  - TRN_NO 조건이 있을 경우는 TB_YYDD504,TB_YYDS510 테이블에 (TRN_NO,RUN_DT,PSRM_CL_CD) 가 베스트 임. 
  
  - TB_YYDK201 테이블이 있는 이유는 ?
     (AND    LN_CD = C.MRNT_CD 조건도 있고, AND    MRNT_CD IN ('01','03','04') 조건도 있음 ) 

  - outer join error 
     	  AND    A.BKCL_CD(+) = G.BKCL_CD
		    AND    A.RUN_DT BETWEEN '20140101' AND '20140131'


        AND    X.RUN_DT = A.RUN_DT
		    AND    A.RUN_DT(+) = G.RUN_DT

   - 현재 인덱스 수준에서 아래와 같이 수정 검토 할 것....
       힌트 추가 ( RULE 힌트가 있는 곳) 
            FROM     (SELECT /*+ USE_HASH(A3 B3)  */


            (  
             SELECT   A.RUN_DT,
		                   A.TRN_NO,
		                   SUM(A.GP_MRK_SEAT_NUM) GP_MRK_SEAT_NUM
		          FROM     TB_YYDK002 kk, TB_YYDK328 A                                                        --> RUN_DT 컬럼에 대해 = 문장을 수행하기 위함임. 
		          WHERE    kk.RUN_DT BETWEEN '20140101' AND '20140131'  and kk.run_dt = a.run_dt
		          AND      SUBSTR(A.REST_SEAT_MG_ID,14,1) LIKE DECODE('', '', '%', '')
		          AND      A.TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		          AND      (A.RUN_DT, A.TRN_NO, A.DEAL_DT) IN
		                                                  (SELECT b.RUN_DT, b.TRN_NO, MAX(b.DEAL_DT) FROM TB_YYDK002 kk,  TB_YYDK328 b
		                                            WHERE kk.RUN_DT BETWEEN '20140101' AND '20140131'  and kk.run_dt = b.run_dt
		                                              AND SUBSTR(b.REST_SEAT_MG_ID,14,1) LIKE DECODE('', '', '%', '')
		                                              AND b.TRN_NO LIKE DECODE(LPAD(TRIM('101'), 5, '0'), '', '%', LPAD(TRIM('101'), 5, '0') )
		                                            GROUP BY b.RUN_DT, b.TRN_NO)
		          GROUP BY A.RUN_DT,
		                   A.TRN_NO
		          ) B3         
		                           
		                           
--------------------------------------------------------------------------
| Id  | Operation                                        | Name          |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT                                 |               |
|   1 |  NESTED LOOPS                                    |               |
|   2 |   NESTED LOOPS                                   |               |
|   3 |    VIEW                                          | VW_NSO_2      |
|   4 |     SORT UNIQUE                                  |               |
|*  5 |      TABLE ACCESS FULL                           | TB_YYDK201    |
|*  6 |    INDEX RANGE SCAN                              | PK_YYDK103    |
|*  7 |   TABLE ACCESS BY INDEX ROWID                    | TB_YYDK103    |
|   8 |  TABLE ACCESS BY INDEX ROWID                     | TB_YYDK007    |
|*  9 |   INDEX RANGE SCAN                               | PK_YYDK007    |
|  10 |    TABLE ACCESS BY INDEX ROWID                   | TB_YYDK002    |
|* 11 |     INDEX UNIQUE SCAN                            | PK_YYDK002    |
|  12 |  SORT ORDER BY                                   |               |
|  13 |   MERGE JOIN OUTER                               |               |
|  14 |    VIEW                                          |               |
|  15 |     SORT GROUP BY                                |               |
|  16 |      NESTED LOOPS                                |               |
|  17 |       NESTED LOOPS                               |               |
|  18 |        NESTED LOOPS                              |               |
|  19 |         VIEW                                     |               |
|  20 |          SORT GROUP BY                           |               |
|  21 |           VIEW                                   |               |
|  22 |            UNION-ALL                             |               |
|  23 |             NESTED LOOPS                         |               |
|  24 |              NESTED LOOPS                        |               |
|* 25 |               FILTER                             |               |
|  26 |                MERGE JOIN OUTER                  |               |
|  27 |                 SORT JOIN                        |               |
|  28 |                  VIEW                            | VM_NWVW_0     |
|  29 |                   SORT UNIQUE                    |               |
|  30 |                    NESTED LOOPS                  |               |
|  31 |                     NESTED LOOPS                 |               |
|  32 |                      NESTED LOOPS                |               |
|* 33 |                       TABLE ACCESS BY INDEX ROWID| TB_YYDK301    |
|* 34 |                        INDEX RANGE SCAN          | PK_YYDK301    |
|* 35 |                       TABLE ACCESS BY INDEX ROWID| TB_YYDK002    |
|* 36 |                        INDEX UNIQUE SCAN         | PK_YYDK002    |
|* 37 |                      INDEX RANGE SCAN            | IX_YYDD505_02 |
|* 38 |                     INDEX RANGE SCAN             | PK_YYDD504    |
|* 39 |                 SORT JOIN                        |               |
|  40 |                  VIEW                            |               |
|  41 |                   SORT GROUP BY                  |               |
|  42 |                    TABLE ACCESS BY INDEX ROWID   | TB_YYDS510    |
|* 43 |                     INDEX RANGE SCAN             | PK_YYDS510    |
|* 44 |               INDEX UNIQUE SCAN                  | PK_YYDK002    |
|* 45 |              TABLE ACCESS BY INDEX ROWID         | TB_YYDK002    |
|* 46 |             FILTER                               |               |
|  47 |              NESTED LOOPS                        |               |
|  48 |               NESTED LOOPS                       |               |
|* 49 |                FILTER                            |               |
|  50 |                 NESTED LOOPS OUTER               |               |
|  51 |                  VIEW                            | VM_NWVW_1     |
|  52 |                   SORT UNIQUE                    |               |
|  53 |                    NESTED LOOPS                  |               |
|  54 |                     NESTED LOOPS                 |               |
|  55 |                      NESTED LOOPS                |               |
|* 56 |                       TABLE ACCESS BY INDEX ROWID| TB_YYDK301    |
|* 57 |                        INDEX RANGE SCAN          | PK_YYDK301    |
|* 58 |                       TABLE ACCESS BY INDEX ROWID| TB_YYDK002    |
|* 59 |                        INDEX UNIQUE SCAN         | PK_YYDK002    |
|* 60 |                      INDEX RANGE SCAN            | IX_YYDD505_02 |
|* 61 |                     INDEX RANGE SCAN             | PK_YYDD504    |
|  62 |                  TABLE ACCESS BY INDEX ROWID     | TB_YYFD410    |
|* 63 |                   INDEX RANGE SCAN               | PK_YYFD410    |
|* 64 |                INDEX UNIQUE SCAN                 | PK_YYDK002    |
|* 65 |               TABLE ACCESS BY INDEX ROWID        | TB_YYDK002    |
|  66 |              SORT AGGREGATE                      |               |
|  67 |               NESTED LOOPS                       |               |
|* 68 |                TABLE ACCESS BY INDEX ROWID       | TB_YYFD011    |
|* 69 |                 INDEX RANGE SCAN                 | IX_YYFD011_01 |
|* 70 |                INDEX RANGE SCAN                  | PK_YYFD010    |
|* 71 |             FILTER                               |               |
|  72 |              NESTED LOOPS                        |               |
|  73 |               NESTED LOOPS                       |               |
|* 74 |                FILTER                            |               |
|  75 |                 NESTED LOOPS OUTER               |               |
|  76 |                  VIEW                            | VM_NWVW_2     |
|  77 |                   SORT UNIQUE                    |               |
|  78 |                    NESTED LOOPS                  |               |
|  79 |                     NESTED LOOPS                 |               |
|  80 |                      NESTED LOOPS                |               |
|* 81 |                       TABLE ACCESS BY INDEX ROWID| TB_YYDK301    |
|* 82 |                        INDEX RANGE SCAN          | PK_YYDK301    |
|* 83 |                       TABLE ACCESS BY INDEX ROWID| TB_YYDK002    |
|* 84 |                        INDEX UNIQUE SCAN         | PK_YYDK002    |
|* 85 |                      INDEX RANGE SCAN            | IX_YYDD505_02 |
|* 86 |                     INDEX RANGE SCAN             | PK_YYDD504    |
|  87 |                  TABLE ACCESS BY INDEX ROWID     | TB_YYPD005    |
|* 88 |                   INDEX RANGE SCAN               | PK_YYPD005    |
|* 89 |                INDEX UNIQUE SCAN                 | PK_YYDK002    |
|* 90 |               TABLE ACCESS BY INDEX ROWID        | TB_YYDK002    |
|  91 |              SORT AGGREGATE                      |               |
|  92 |               NESTED LOOPS                       |               |
|* 93 |                TABLE ACCESS BY INDEX ROWID       | TB_YYFD011    |
|* 94 |                 INDEX RANGE SCAN                 | IX_YYFD011_01 |
|* 95 |                INDEX RANGE SCAN                  | PK_YYFD010    |
|* 96 |         TABLE ACCESS BY INDEX ROWID              | TB_YYDP503    |
|* 97 |          INDEX UNIQUE SCAN                       | PK_YYDP503    |
|* 98 |        INDEX UNIQUE SCAN                         | PK_YYDK302    |
|* 99 |       INDEX UNIQUE SCAN                          | PK_YYDK302    |
|*100 |    SORT JOIN                                     |               |
| 101 |     VIEW                                         |               |
| 102 |      SORT GROUP BY                               |               |
| 103 |       VIEW                                       | VM_NWVW_3     |
|*104 |        FILTER                                    |               |
| 105 |         SORT GROUP BY                            |               |
| 106 |          NESTED LOOPS                            |               |
| 107 |           TABLE ACCESS BY INDEX ROWID            | TB_YYDK328    |
|*108 |            INDEX RANGE SCAN                      | PK_YYDK328    |
|*109 |           INDEX RANGE SCAN                       | PK_YYDK328    |
--------------------------------------------------------------------------

