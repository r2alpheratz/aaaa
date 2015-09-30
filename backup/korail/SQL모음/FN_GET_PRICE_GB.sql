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
   * p_run_dt             : �����
   * p_trn_no             : ���࿭����ȣ
   * p_psrm_cl_cd         : ���ǵ���ڵ�
   * p_rout_cd            : �뼱�ڵ�            (TB_YYDK301)
   * p_stlb_trn_clsf_cd        : ���������ڵ�        (TB_YYDK301)
   * p_dpt_stop_rs_stn_cd : ��� �������߿��ڵ� (TB_YYDK302)
   * p_arv_stop_rs_stn_cd : ���� �������߿��ڵ� (TB_YYDK302)
   * p_dpt_stn_cons_ordr  : ��� ����������     (TB_YYDK302)
   * p_arv_stn_cons_ordr  : ���� ����������     (TB_YYDK302)
   * p_bkcl_cd           : ���ε���ڵ�
                          -> NULL ��� ������ ������ ����
   */

   v_price := 0;

   /* ���� , ���� ����
    * ���� : ��~ �� => 0.5%
    * ���� : ��~��, ������ => 6.5% */

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
          AND    A.PRC_DCNT_SUR_DV_CD = '1' /* �������������ڵ� */
          AND    A.EXS_LN_DST = (SELECT YZDBA.FN_YZYB_GETROUTDSTCAL(p_rout_cd, v_dpt_ordr, v_arv_ordr, p_run_dt, 2) FROM DUAL)
          
   );

   /*
     ����Ÿ�����  FN_YB_GETROUTDSTCAL �Ÿ��� TB_RE590 �� DST �Ÿ��� ���̰� �߻��Ѵ�
     FN_YB_GETROUTDSTCAL�� �����ϰ� ������ ���Ѵ�
     ��) 414���� ����(1/0001) - �Ȱ�(73/0192)
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
              WHERE  A.TRN_OPR_BZ_DV_CD = '001' /* ���������ڱ����ڵ� : 001 �ѱ�ö������ */
              AND    A.PRC_CL_CD = P_STLB_TRN_CLSF_CD || '1'
              and    A.DPT_DT = p_run_dt
              AND    A.ROUT_CD = p_rout_cd
              AND    A.SSTN_CONS_ORDR = v_dpt_ordr
              AND    A.ESTN_CONS_ORDR = v_arv_ordr
              AND    A.PRC_DCNT_SUR_DV_CD = '1' /* �������������ڵ� */
       );

   END IF;

   IF p_bkcl_cd IS NOT NULL THEN /* ���ε���� �������*/
         /* ������ */
     SELECT REP_DCNT_RT
     INTO   v_rep_dcnt_rt
     FROM   TB_YYBB003
     WHERE  BKCL_CD = p_bkcl_cd
     AND    TRN_OPR_BZ_DV_CD = '001'
     AND    p_run_dt BETWEEN APL_ST_DT AND APL_CLS_DT
     AND    BKCL_USE_FLG = 'Y';

     IF p_psrm_cl_cd = '1' THEN     /* �Ϲݼ� */
        v_price := v_stdr_adul_prc  - FLOOR( (v_stdr_adul_prc  * v_rep_dcnt_rt + 50) / 100) * 100;
     ELSIF p_psrm_cl_cd = '2' THEN  /* Ư�� */
        v_price := v_psrm_fare - FLOOR( (v_psrm_fare * v_rep_dcnt_rt + 50) / 100) * 100;
     END IF;

   ELSE                          /* ���ε���� �������*/

     IF p_psrm_cl_cd = '1' THEN    /* �Ϲݼ� */
        v_price := v_stdr_adul_prc;
     ELSIF p_psrm_cl_cd = '2' THEN /* Ư�� */
        v_price := v_psrm_fare;
     END IF;

   END IF;

 RETURN v_price;

END FN_GET_PRICE_GB;