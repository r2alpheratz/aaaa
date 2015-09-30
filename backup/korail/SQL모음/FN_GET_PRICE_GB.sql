CREATE OR REPLACE FUNCTION YZDBA.FN_GET_PRICE_GB( p_run_dt VARCHAR2,
                                                  p_trn_no VARCHAR2,
                                                  p_psrm_cl_cd VARCHAR2,
                                                  p_rout_cd VARCHAR2,
                                                  p_stlb_trn_clsf_cd VARCHAR2,
                                                  p_dpt_stn_cons_ordr NUMBER,
                                                  p_arv_stn_cons_ordr NUMBER,
                                                  p_bkcl_cd VARCHAR2)
 RETURN NUMBER IS
  v_price          TB_YYDK326.STDR_ADUL_PRC%TYPE;
  v_stdr_adul_prc  TB_YYDK326.STDR_ADUL_PRC%TYPE;
  v_chil_prc       TB_YYDK326.CHIL_PRC%TYPE;
  v_psrm_fare      TB_YYDK326.PSRM_FARE%TYPE;
  v_day_gb         VARCHAR2(1);
  v_rep_dcnt_rt    TB_YYBB003.REP_DCNT_RT%TYPE;
  v_arv_ordr       NUMBER;
  v_dpt_ordr       NUMBER;

BEGIN

   /*
   * p_run_dt             : 운영일자
   * p_trn_no             : 운행열차번호
   * p_psrm_cl_cd         : 객실등급코드
   * p_rout_cd            : 노선코드            (TB_YYDK301)
   * p_stlb_trn_clsf_cd        : 열차종별코드        (TB_YYDK301)
   * p_dpt_stop_rs_stn_cd : 출발 정차예발역코드 (TB_YYDK302)
   * p_arv_stop_rs_stn_cd : 도착 정차예발역코드 (TB_YYDK302)
   * p_dpt_stn_cons_ordr  : 출발 역구성순서     (TB_YYDK302)
   * p_arv_stn_cons_ordr  : 도착 역구성순서     (TB_YYDK302)
   * p_bkcl_cd           : 할인등급코드
                          -> NULL 경우 할인율 적용을 안함
   */

   v_price := 0;

   /* 할인 , 할증 구분
    * 할인 : 월~ 목 => 0.5%
    * 할증 : 금~일, 공휴일 => 6.5% */

   SELECT CASE WHEN A.DAY_DV_CD IN('2', '3', '4', '5') AND B.HLDY_DV_CD IS NULL THEN '1' ELSE '2' END DAY_GB
   INTO   v_day_gb
   FROM   TB_YYDK002 A,
          TB_YYDK003 B
   WHERE  A.RUN_DT = B.RUN_DT
   AND    RUN_DT =  p_run_dt
   AND    B.TRN_OPR_BZ_DV_CD = '001';


   v_dpt_ordr := LEAST(p_dpt_stn_cons_ordr, p_arv_stn_cons_ordr);
   v_arv_ordr := GREATEST(p_dpt_stn_cons_ordr, p_arv_stn_cons_ordr);


   SELECT NVL(SUM(DECODE(v_day_gb,'1',(STDR_ADUL_PRC  - FLOOR( (STDR_ADUL_PRC * 0.005 + 50) / 100) * 100)
                             ,(STDR_ADUL_PRC  + FLOOR( (STDR_ADUL_PRC * 0.065 + 50) / 100) * 100))),0) STDR_ADUL_PRC,
          NVL(SUM(DECODE(v_day_gb,'1',(PSRM_FARE - FLOOR( (PSRM_FARE * 0.005 + 50) / 100) * 100)
                             ,(PSRM_FARE + FLOOR( (PSRM_FARE * 0.065 + 50) / 100) * 100))),0) PSRM_FARE
   INTO  v_stdr_adul_prc,
         v_psrm_fare
   FROM
   (
          SELECT GREATEST(A.STDR_ADUL_PRC,A.LWST_PRC) STDR_ADUL_PRC,
                 GREATEST(A.STDR_ADUL_PRC,A.LWST_PRC) + GREATEST(A.PSRM_FARE,A.PSRM_LWST_FARE) PSRM_FARE
          FROM   TB_YYDK326 A
          WHERE  A.TRN_OPR_BZ_DV_CD = '001'
          AND    A.PRC_CL_CD = P_STLB_TRN_CLSF_CD || '1'
          AND    A.DPT_DT = p_run_dt
          AND    A.ROUT_CD = p_rout_cd
          AND    A.SSTN_CONS_ORDR = v_dpt_ordr
          AND    A.ESTN_CONS_ORDR = v_arv_ordr
          AND    A.PRC_DCNT_SUR_DV_CD = '1' /* 운임할증구분코드 */
          AND    A.EXS_LN_DST = (SELECT YZDBA.FN_YZYB_GETROUTDSTCAL(p_rout_cd, v_dpt_ordr, v_arv_ordr, p_run_dt, 2) FROM DUAL)
          
   );

   /*
     단축거리인해  FN_YB_GETROUTDSTCAL 거리와 TB_RE590 의 DST 거리가 차이가 발생한다
     FN_YB_GETROUTDSTCAL를 사용안하고 운임을 구한다
     예) 414열차 서울(1/0001) - 안강(73/0192)
   */
   IF v_stdr_adul_prc = 0 OR  v_psrm_fare = 0 THEN

       SELECT NVL(DECODE(V_DAY_GB,'1',(ADLT_PRC  - FLOOR( (ADLT_PRC * 0.005 + 50) / 100) * 100)
                                 ,(ADLT_PRC  + FLOOR( (ADLT_PRC * 0.065 + 50) / 100) * 100)),0) ADLT_PRC,
              NVL(DECODE(V_DAY_GB,'1',(PSRM_FARE - FLOOR( (PSRM_FARE * 0.005 + 50) / 100) * 100)
                                 ,(PSRM_FARE + FLOOR( (PSRM_FARE * 0.065 + 50) / 100) * 100)),0) PSRM_FARE
       INTO  v_stdr_adul_prc,
             v_psrm_fare
       FROM
       (
              SELECT MIN(GREATEST(A.ADLT_PRC,A.ADLT_LWST_PRC)) ADLT_PRC,
                     MIN(GREATEST(A.ADLT_PRC,A.ADLT_LWST_PRC) + GREATEST(A.PSRM_FARE,A.LWST_PSRM_FARE)) PSRM_FARE
              FROM   TB_YYDK326 A
              WHERE  A.TRN_OPR_BZ_DV_CD = '001' /* 열차운영사업자구분코드 : 001 한국철도공사 */
              AND    A.PRC_CL_CD = P_STLB_TRN_CLSF_CD || '1'
              and    A.DPT_DT = p_run_dt
              AND    A.ROUT_CD = p_rout_cd
              AND    A.SSTN_CONS_ORDR = v_dpt_ordr
              AND    A.ESTN_CONS_ORDR = v_arv_ordr
              AND    A.PRC_DCNT_SUR_DV_CD = '1' /* 운임할증구분코드 */
       );

   END IF;

   IF p_bkcl_cd IS NOT NULL THEN /* 할인등급이 있을경우*/
         /* 할인율 */
     SELECT REP_DCNT_RT
     INTO   v_rep_dcnt_rt
     FROM   TB_YYBB003
     WHERE  BKCL_CD = p_bkcl_cd
     AND    TRN_OPR_BZ_DV_CD = '001'
     AND    p_run_dt BETWEEN APL_ST_DT AND APL_CLS_DT
     AND    BKCL_USE_FLG = 'Y';

     IF p_psrm_cl_cd = '1' THEN     /* 일반석 */
        v_price := v_stdr_adul_prc  - FLOOR( (v_stdr_adul_prc  * v_rep_dcnt_rt + 50) / 100) * 100;
     ELSIF p_psrm_cl_cd = '2' THEN  /* 특실 */
        v_price := v_psrm_fare - FLOOR( (v_psrm_fare * v_rep_dcnt_rt + 50) / 100) * 100;
     END IF;

   ELSE                          /* 할인등급이 없을경우*/

     IF p_psrm_cl_cd = '1' THEN    /* 일반석 */
        v_price := v_stdr_adul_prc;
     ELSIF p_psrm_cl_cd = '2' THEN /* 특실 */
        v_price := v_psrm_fare;
     END IF;

   END IF;

 RETURN v_price;

END FN_GET_PRICE_GB;