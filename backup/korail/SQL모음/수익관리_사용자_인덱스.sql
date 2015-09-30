-- 테이블 사용자 인덱스 

-- TB_YYBB007 사용자기본 
DROP INDEX YZDBA.IX_YYBB007_1;

CREATE INDEX YZDBA.IX_YYBB007_1 ON YZDBA.TB_YYBB007
(BLG_CD, TRVL_USR_NM)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYBB007_2;

CREATE INDEX YZDBA.IX_YYBB007_2 ON YZDBA.TB_YYBB007
(TRVL_USR_NM)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


-- TB_YYDK001 예발역코드

DROP INDEX YZDBA.IX_YYDK001_1;

CREATE INDEX YZDBA.IX_YYDK001_2 ON YZDBA.TB_YYDK001
(STN_CD, RS_STN_CD)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYDK001_2;

CREATE INDEX YZDBA.IX_YYDK001_2 ON YZDBA.TB_YYDK001
(CHG_DTTM)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           

-- TB_YYDK005 창구기본 
DROP INDEX YZDBA.IX_YYDK005_1;

CREATE INDEX YZDBA.IX_YYDK005_1 ON YZDBA.TB_YYDK005
(BLG_CD, WCT_NO)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYDK005_2;

CREATE INDEX YZDBA.IX_YYDK005_2 ON YZDBA.TB_YYDK005
(WCT_KND_CD, STN_CD)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYDK005_3;

CREATE INDEX YZDBA.IX_YYDK005_3 ON YZDBA.YYDK005
(WCT_KND_CD, WCT_OP_ST_DT, WCT_OP_CLS_DT)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
           
-- TB_YYDK101 소속코드  


DROP INDEX YZDBA.IX_YYDK101_1;

CREATE INDEX YZDBA.IX_YYDK101_1 ON YZDBA.TB_YYDK101
(HRNK_BLG_CD, BLG_CD)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYDK101_2;

CREATE INDEX YZDBA.IX_YYDK101_2 ON YZDBA.TB_YYDK101
(STN_CD, BCH_CD)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYDK101_3;

CREATE INDEX YZDBA.IX_YYDK101_3 ON YZDBA.TB_YYDK101
(BCH_CD)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
DROP INDEX YZDBA.IX_YYDK101_4;

CREATE INDEX YZDBA.IX_YYDK101_4 ON YZDBA.TB_YYDK101
(BLG_KOR_NM)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
  
-- TB_YYDK102 역코드 이력 
DROP INDEX YZDBA.IX_YYDK102_1;

CREATE INDEX YZDBA.IX_YYDK102_1 ON YZDBA.TB_YYDK102
(BLG_BRCF_CD, AR_MG_STN_CD)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYDK102_2;

CREATE UNIQUE INDEX YZDBA.IX_YYDK102_2 ON YZDBA.TB_YYDK102
(STN_CD, APL_CLS_DT, APL_ST_DT)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYDK102_3;

CREATE INDEX YZDBA.IX_YYDK102_3 ON YZDBA.TB_YYDK102
(STNM_VAL)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
           
-- TB_YYDK201 노선코드  
DROP INDEX YZDBA.IX_YYDK201_1;

CREATE INDEX YZDBA.IX_YYDK201_1 ON YZDBA.TB_YYDK201
(CHG_DTTM)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
-- TB_YYDK203 노선구성역내역  
DROP INDEX YZDBA.IX_YYDK203_1;

CREATE INDEX YZDBA.IX_YYDK203_1 ON YZDBA.TB_YYDK203
(STN_CD, ROUT_CD)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYDK203_2;

CREATE INDEX YZDBA.IX_YYDK203_2 ON YZDBA.TB_YYDK203
(CHG_DTTM)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
           
-- TB_YYDK301 열차기본   
DROP INDEX YZDBA.IX_YYDK301_01;

CREATE INDEX YZDBA.IX_YYDK301_01 ON YZDBA.TB_YYDK301
(ROUT_CD, RUN_DT)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
DROP INDEX YZDBA.IX_YYDK301_02;

CREATE INDEX YZDBA.IX_YYDK301_02 ON YZDBA.TB_YYDK301
(ROUT_CD, RUN_DT, TRN_OPR_BZ_DV_CD)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


           
-- TB_YYDK309 부킹클래스적용내역   
DROP INDEX YZDBA.IX_YYDK309_01;

CREATE INDEX YZDBA.IX_YYDK309_01 ON YZDBA.TB_YYDK309
(TRN_NO, RUN_DT, PSRM_CL_CD, BKCL_CD)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
-- TB_YYDK310 승차권 발매기본    
DROP INDEX YZDBA.IX_YYDK310_01;

CREATE INDEX YZDBA.IX_YYDK310_01 ON YZDBA.TB_YYDK310
(SALE_DT, TK_KND_CD)
TABLESPACE TSI_YZ01
PCTFREE    0
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          5M
            NEXT             5M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
DROP INDEX YZDBA.IX_YYDK310_02;

CREATE INDEX YZDBA.IX_YYDK310_02 ON YZDBA.TB_YYDK310
(PNR_NO)
TABLESPACE TSI_YZ01
PCTFREE    0
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          5M
            NEXT             5M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
                     
-- TB_YYDK312 승차권 반환내역
                   
DROP INDEX YZDBA.PK_YYDK312_01;

CREATE UNIQUE INDEX YZDBA.PK_YYDK312_01 ON YZDBA.TB_YYDK312
(RET_DT)
TABLESPACE TSI_YZ01
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           );



-- TB_YYDK313 여정기본 
DROP INDEX YZDBA.IX_YYDK313_01;

CREATE INDEX YZDBA.IX_YYDK313_01 ON YZDBA.TB_YYDK313
(RSV_CNC_DT)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          5M
            NEXT             5M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
           
 -- TB_YYDK315 여정열차내역
DROP INDEX YZDBA.IX_YYDK315_01;

CREATE INDEX YZDBA.IX_YYDK315_01 ON YZDBA.TB_YYDK315
(RUN_DT, TRN_NO)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          5M
            NEXT             5M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           );
           

 -- TB_YYDK322 특단예약접수기본          
DROP INDEX YZDBA.IX_YYDK322_01;

CREATE INDEX YZDBA.IX_YYDK322_01 ON YZDBA.TB_YYDK322
(REP_PNR_NO, SMG_RSV_RCP_PRG_STT_CD)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           

 -- TB_YYDK323 특단여정열차내역           
DROP INDEX YZDBA.IX_YYDK323_01;

CREATE INDEX YZDBA.IX_YYDK323_01 ON YZDBA.TB_YYDK323
(PNR_NO, JRNY_SQNO)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           

 -- TB_YYDP503 열차특성상세     
DROP INDEX YZDBA.IX_YYDP503_01;

CREATE INDEX YZDBA.IX_YYDP503_01 ON YZDBA.TB_YYDP503
(TRN_NO, DAY_DV_CD, BIZ_DD_STG_CD, RUN_DT)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
 -- TB_YYDD505 열차구간내역    
DROP INDEX YZDBA.IX_YYDD505_01;

CREATE INDEX YZDBA.IX_YYDD505_01 ON YZDBA.TB_YYDD505
(RUN_DT, STGP_DEGR, DPT_STGP_CD, ARV_STGP_CD, TRN_NO)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYDD505_02;

CREATE INDEX YZDBA.IX_YYDD505_02 ON YZDBA.TB_YYDD505
(TRN_NO, RUN_DT, DPT_STN_CONS_ORDR, ARV_STN_CONS_ORDR)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
 -- TB_YYFB001 역그룹차수 기본             
DROP INDEX YZDBA.IX_YYFB001_01;

CREATE INDEX YZDBA.IX_YYFB001_01 ON YZDBA.TB_YYFB001
(APL_ST_DT, APL_CLS_DT, STGP_DEGR)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
 -- TB_YYFD002 역그룹핑내역  
DROP INDEX YZDBA.IX_YYFD002_01;

CREATE INDEX YZDBA.IX_YYFD002_01 ON YZDBA.TB_YYFD002
(STGP_CD, STGP_DEGR, RS_STN_CD)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
 
 -- TB_YYFB003 시간대그룹차수기본   
DROP INDEX YZDBA.IX_YYFB003_01;

CREATE INDEX YZDBA.IX_YYFB003_01 ON YZDBA.TB_YYFB003
(APL_ST_DT, APL_CLS_DT, TMWD_GP_DEGR)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );          
           
  -- TB_YYFD004 시간대그룹핑내역            
DROP INDEX YZDBA.IX_YF140_01;

CREATE INDEX YZDBA.IX_YF140_01 ON YZDBA.TB_YF140
(STGP_DEGR, DPT_STGP_CD, ARV_STGP_CD, DAY_DV_CD, TMWD_DV_CD)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
           
    -- TB_YYFD007 담당그룹별사용자내역      
DROP INDEX YZDBA.IX_YYFD007_01;

CREATE INDEX YZDBA.IX_YYFD007_01 ON YZDBA.TB_YYFD007
(USR_ID, USR_GP_ID)
TABLESPACE TSI_YZ01
PCTFREE    5
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
 -- TB_YYFD008 담당그룹별열차내역            
DROP INDEX YZDBA.IX_YYFD008_01;

CREATE INDEX YZDBA.IX_YYFD008_01 ON YZDBA.TB_YYFD008
(USR_GP_ID)
TABLESPACE TSI_YZ01
PCTFREE    5
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
 -- TB_YYFB009 수익관리작업결과기본                
DROP INDEX YZDBA.IX_YYFB009_01;

CREATE INDEX YZDBA.IX_YYFB009_01 ON YZDBA.TB_YYFB009
(JOB_DTTM, YMGT_JOB_ID)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
 -- TB_YYFD011 수익관리대상열차내역            
DROP INDEX YZDBA.IX_YYFD011_01;

CREATE INDEX YZDBA.IX_YYFD011_01 ON YZDBA.TB_YYFD011
(RUN_DT, TRN_NO, YMGT_JOB_ID)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );


DROP INDEX YZDBA.IX_YYFD011_02;

CREATE INDEX YZDBA.IX_YYFD011_02 ON YZDBA.TB_YYFD011
(YMGT_JOB_ID, FCST_PRS_STT_CD, RUN_DT, TRN_NO)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
 -- TB_YYFD015 이상열차내역            
DROP INDEX YZDBA.IX_YYFD015_01;

CREATE INDEX YZDBA.IX_YYFD015_01 ON YZDBA.TB_YYFD015
(ABV_TRN_SRT_CD)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
           
           
  -- TB_YYFS106 하계연말연시DSP별예약취소실적집계             
DROP INDEX YZDBA.IX_YYFS106_01;

CREATE INDEX YZDBA.IX_YYFS106_01 ON YZDBA.TB_YYFS106
(LRG_CRG_DV_CD, RUN_DT)
TABLESPACE TSI_YZ01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );
           
-- TB_YYFD108 하계연말연시DSP별예약취소예측내역          
DROP INDEX YZDBA.IX_YF440_01;

CREATE INDEX YZDBA.IX_YF440_01 ON YZDBA.TB_YF440
(LRG_CRG_DV_CD, FCST_EXC_DT)
TABLESPACE TS_YFINDX01
PCTFREE    3
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          1M
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );