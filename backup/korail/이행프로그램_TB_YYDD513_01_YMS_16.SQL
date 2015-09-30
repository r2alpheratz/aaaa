SELECT 
       RUN_DT,
       TRN_NO,
       REST_SEAT_MG_ID,  --잔여좌석관리ID   
       BKCLS_CD,
       DEAL_DT,
       a1_1 ||
       a2_1 ||
       a3_1 ||
       a4_1 ||
       a5_1 ||
       a6_1 ||
       a7_1 ||
       a8_1 ||
       a9_1 ||
       a10_1||
       a11_1||
       a12_1 as FST_ALC_SEAT_NUM_CONT,
       b1_1 ||
       b2_1 ||
       b3_1 ||
       b4_1 ||
       b5_1 ||
       b6_1 ||
       b7_1 ||
       b8_1 ||
       b9_1 ||
       b10_1||
       b11_1||
       b12_1 as MRK_SEAT_NUM_CONT,
       c1_1 ||
       c2_1 ||
       c3_1 ||
       c4_1 ||
       c5_1 ||
       c6_1 ||
       c7_1 ||
       c8_1 ||
       c9_1 ||
       c10_1||
       c11_1||
       c12_1 as ACT_MRK_SEAT_NUM_CONT,
       'Y'   NST_FLG,
       TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') ,
       'MIG',
       TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') ,
       'MIG'
 FROM (
SELECT 
       RUN_DT,
       TRN_NO,
       REST_SEAT_MG_ID,  --잔여좌석관리ID   
       BKCLS_CD,
       DEAL_DT,
       max(CASE WHEN zone_seg_grup_no = 1 THEN t1 ELSE '' END ) AS a1_1   ,
       max(CASE WHEN zone_seg_grup_no = 2 THEN t1 ELSE '' END ) AS a2_1   ,
       max(CASE WHEN zone_seg_grup_no = 3 THEN t1 ELSE '' END ) AS a3_1   ,
       max(CASE WHEN zone_seg_grup_no = 4 THEN t1 ELSE '' END ) AS a4_1   ,
       max(CASE WHEN zone_seg_grup_no = 5 THEN t1 ELSE '' END ) AS a5_1   ,
       max(CASE WHEN zone_seg_grup_no = 6 THEN t1 ELSE '' END ) AS a6_1   ,
       max(CASE WHEN zone_seg_grup_no = 7 THEN t1 ELSE '' END ) AS a7_1   ,
       max(CASE WHEN zone_seg_grup_no = 8 THEN t1 ELSE '' END ) AS a8_1   ,
       max(CASE WHEN zone_seg_grup_no = 9 THEN t1 ELSE '' END ) AS a9_1   ,
       max(CASE WHEN zone_seg_grup_no = 10 THEN t1 ELSE '' END ) AS a10_1 ,
       max(CASE WHEN zone_seg_grup_no = 11 THEN t1 ELSE '' END ) AS a11_1 ,
       max(CASE WHEN zone_seg_grup_no = 12 THEN t1 ELSE '' END ) AS a12_1 ,
       max(CASE WHEN zone_seg_grup_no = 1 THEN t2 ELSE '' END ) AS b1_1   ,
       max(CASE WHEN zone_seg_grup_no = 2 THEN t2 ELSE '' END ) AS b2_1   ,
       max(CASE WHEN zone_seg_grup_no = 3 THEN t2 ELSE '' END ) AS b3_1   ,
       max(CASE WHEN zone_seg_grup_no = 4 THEN t2 ELSE '' END ) AS b4_1   ,
       max(CASE WHEN zone_seg_grup_no = 5 THEN t2 ELSE '' END ) AS b5_1   ,
       max(CASE WHEN zone_seg_grup_no = 6 THEN t2 ELSE '' END ) AS b6_1   ,
       max(CASE WHEN zone_seg_grup_no = 7 THEN t2 ELSE '' END ) AS b7_1   ,
       max(CASE WHEN zone_seg_grup_no = 8 THEN t2 ELSE '' END ) AS b8_1   ,
       max(CASE WHEN zone_seg_grup_no = 9 THEN t2 ELSE '' END ) AS b9_1   ,
       max(CASE WHEN zone_seg_grup_no = 10 THEN t2 ELSE '' END ) AS b10_1 ,
       max(CASE WHEN zone_seg_grup_no = 11 THEN t2 ELSE '' END ) AS b11_1 ,
       max(CASE WHEN zone_seg_grup_no = 12 THEN t2 ELSE '' END ) AS b12_1 ,
       max(CASE WHEN zone_seg_grup_no = 1 THEN t3 ELSE '' END ) AS c1_1   ,
       max(CASE WHEN zone_seg_grup_no = 2 THEN t3 ELSE '' END ) AS c2_1   ,
       max(CASE WHEN zone_seg_grup_no = 3 THEN t3 ELSE '' END ) AS c3_1   ,
       max(CASE WHEN zone_seg_grup_no = 4 THEN t3 ELSE '' END ) AS c4_1   ,
       max(CASE WHEN zone_seg_grup_no = 5 THEN t3 ELSE '' END ) AS c5_1   ,
       max(CASE WHEN zone_seg_grup_no = 6 THEN t3 ELSE '' END ) AS c6_1   ,
       max(CASE WHEN zone_seg_grup_no = 7 THEN t3 ELSE '' END ) AS c7_1   ,
       max(CASE WHEN zone_seg_grup_no = 8 THEN t3 ELSE '' END ) AS c8_1   ,
       max(CASE WHEN zone_seg_grup_no = 9 THEN t3 ELSE '' END ) AS c9_1   ,
       max(CASE WHEN zone_seg_grup_no = 10 THEN t3 ELSE '' END ) AS c10_1 ,
       max(CASE WHEN zone_seg_grup_no = 11 THEN t3 ELSE '' END ) AS c11_1 ,
       max(CASE WHEN zone_seg_grup_no = 12 THEN t3 ELSE '' END ) AS c12_1 
 FROM (
select 
       RUN_DT,
       TRN_NO,
       RUN_DT||TRN_NO||PSRM_CL_CD||'0' ||SEAT_ATT_CD||'ZZZ' as REST_SEAT_MG_ID,  --잔여좌석관리ID   
       BKCLS_CD,
       DEAL_DT,
       zone_seg_grup_no, 
       case when grup_bkcls_fst_alc_cnt >= 0 then '+'||lpad(to_char(grup_bkcls_fst_alc_cnt),4,'0') else '-'||lpad(to_char(abs(grup_bkcls_fst_alc_cnt)),4,'0') end as t1,
       case when grup_bkcls_mrk_cnt     >= 0 then '+'||lpad(to_char(grup_bkcls_mrk_cnt),4,'0') else '-'||lpad(to_char(abs(grup_bkcls_mrk_cnt)),4,'0') end as t2,
       case when grup_bkcls_abrd_psno   >= 0 then '+'||lpad(to_char(grup_bkcls_abrd_psno),4,'0') else '-'||lpad(to_char(abs(grup_bkcls_abrd_psno)),4,'0') end as t3
from tb_yd410 partition (tb_yd410_p01)
WHERE RUN_DT >= $$[V_ST_1Y_DT_YZ]
AND     RUN_DT <= $$[V_ED_1Y_DT_YZ]
and bkcls_cd <> 'F1'
      )
group by 
       RUN_DT,
       TRN_NO,
       REST_SEAT_MG_ID,
       BKCLS_CD,
       DEAL_DT
       )


튜닝 내용
   - ok 
   - CASE 문장 대신
       TO_CHAR(grup_bkcls_fst_alc_cnt,'0000') 로 하여도 되는지 확인 바람.   
