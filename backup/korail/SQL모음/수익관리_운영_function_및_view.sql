CREATE OR REPLACE FUNCTION YZDBA.FN_GET_PRICE_GB( P_RUN_DT VARCHAR2,
                                                  P_TRN_NO VARCHAR2,
                                                  P_PSRM_CL_CD VARCHAR2,
                                                  P_ROUT_CD VARCHAR2,
                                                  P_TRN_CLSF_CD VARCHAR2,
                                                  P_DPT_STOP_RS_STN_CD VARCHAR2,
                                                  P_ARV_STOP_RS_STN_CD VARCHAR2,
                                                  P_DPT_STN_CONS_ORDR NUMBER,
                                                  P_ARV_STN_CONS_ORDR NUMBER,
                                                  P_BKCLS_CD VARCHAR2)
 RETURN NUMBER IS
  V_PRICE       TB_RE590.ADLT_PRC%TYPE;
  V_ADLT_PRC    TB_RE590.ADLT_PRC%TYPE;
  V_CHILD_PRC   TB_RE590.CHILD_PRC%TYPE;
  V_SPRM_FARE   TB_RE590.SPRM_FARE%TYPE;
  V_DAY_GB      VARCHAR2(1);
  V_REP_DISC_RT TB_YB150.REP_DISC_RT%TYPE;
  V_ARV_ORDR    NUMBER;
  V_DPT_ORDR    NUMBER;

BEGIN

   /*
   * P_RUN_DT             : 운영일자
   * P_TRN_NO             : 운행열차번호
   * P_PSRM_CL_CD         : 객실등급코드
   * P_ROUT_CD            : 노선코드            (TB_RD215)
   * P_TRN_CLSF_CD        : 열차종별코드        (TB_RD215)
   * P_DPT_STOP_RS_STN_CD : 출발 정차예발역코드 (TB_RD225)
   * P_ARV_STOP_RS_STN_CD : 도착 정차예발역코드 (TB_RD225)
   * P_DPT_STN_CONS_ORDR  : 출발 역구성순서     (TV_RD225)
   * P_ARV_STN_CONS_ORDR  : 도착 역구성순서     (TV_RD225)
   * P_BKCLS_CD           : 할인등급코드
                          -> NULL 경우 할인율 적용을 안함
   */

   V_PRICE := 0;

   /* 할인 , 할증 구분
    * 할인 : 월~ 목 => 0.5%
    * 할증 : 금~일, 공휴일 => 6.5% */

   SELECT CASE WHEN DAY_DV_CD IN('2', '3', '4', '5') AND HOLI_DV_CD IS NULL THEN '1' ELSE '2' END DAY_GB
   INTO   V_DAY_GB
   FROM   TB_RB715
   WHERE  RUN_DT =  P_RUN_DT;

   V_DPT_ORDR := LEAST(P_DPT_STN_CONS_ORDR, P_ARV_STN_CONS_ORDR);
   V_ARV_ORDR := GREATEST(P_DPT_STN_CONS_ORDR, P_ARV_STN_CONS_ORDR);


   SELECT NVL(SUM(DECODE(V_DAY_GB,'1',(ADLT_PRC  - FLOOR( (ADLT_PRC * 0.005 + 50) / 100) * 100)
                             ,(ADLT_PRC  + FLOOR( (ADLT_PRC * 0.065 + 50) / 100) * 100))),0) ADLT_PRC,
          NVL(SUM(DECODE(V_DAY_GB,'1',(SPRM_FARE - FLOOR( (SPRM_FARE * 0.005 + 50) / 100) * 100)
                             ,(SPRM_FARE + FLOOR( (SPRM_FARE * 0.065 + 50) / 100) * 100))),0) SPRM_FARE
   INTO  V_ADLT_PRC,
         V_SPRM_FARE
   FROM
   (
          SELECT GREATEST(A.ADLT_PRC,A.ADLT_LWST_PRC) ADLT_PRC,
                 GREATEST(A.ADLT_PRC,A.ADLT_LWST_PRC) + GREATEST(A.SPRM_FARE,A.LWST_SPRM_FARE) SPRM_FARE
          FROM   TB_RE590 A
          WHERE  A.CHG_MG_DV_CD = '11'
          AND    A.PRC_DV_CD = '1'
          AND    A.DPT_RS_STN_CD = LEAST(P_DPT_STOP_RS_STN_CD, P_ARV_STOP_RS_STN_CD)
          AND    A.ARV_RS_STN_CD = GREATEST(P_DPT_STOP_RS_STN_CD, P_ARV_STOP_RS_STN_CD)
          AND    A.PRC_CL_CD = P_TRN_CLSF_CD || '1'
          AND    A.CHG_MG_NO = (SELECT Z.CHG_MG_NO
                                FROM   TB_RE110 Z
                                WHERE  Z.CHG_MG_DV_CD = '11'
                                AND    P_RUN_DT BETWEEN Z.DEAL_ST_DT AND Z.DEAL_CLS_DT
                                AND    P_RUN_DT BETWEEN Z.ABRD_ST_DT AND Z.ABRD_CLS_DT)
          AND    A.DST = (SELECT FN_YB_GETROUTDSTCAL(P_ROUT_CD, V_DPT_ORDR, V_ARV_ORDR, P_RUN_DT, 2) FROM DUAL)
   );

   /*
     단축거리인해  FN_YB_GETROUTDSTCAL 거리와 TB_RE590 의 DST 거리가 차이가 발생한다
     FN_YB_GETROUTDSTCAL를 사용안하고 운임을 구한다
     예) 414열차 서울(1/0001) - 안강(73/0192)
   */
   IF V_ADLT_PRC = 0 OR  V_SPRM_FARE = 0 THEN

       SELECT NVL(DECODE(V_DAY_GB,'1',(ADLT_PRC  - FLOOR( (ADLT_PRC * 0.005 + 50) / 100) * 100)
                                 ,(ADLT_PRC  + FLOOR( (ADLT_PRC * 0.065 + 50) / 100) * 100)),0) ADLT_PRC,
              NVL(DECODE(V_DAY_GB,'1',(SPRM_FARE - FLOOR( (SPRM_FARE * 0.005 + 50) / 100) * 100)
                                 ,(SPRM_FARE + FLOOR( (SPRM_FARE * 0.065 + 50) / 100) * 100)),0) SPRM_FARE
       INTO  V_ADLT_PRC,
             V_SPRM_FARE
       FROM
       (
              SELECT MIN(GREATEST(A.ADLT_PRC,A.ADLT_LWST_PRC)) ADLT_PRC,
                     MIN(GREATEST(A.ADLT_PRC,A.ADLT_LWST_PRC) + GREATEST(A.SPRM_FARE,A.LWST_SPRM_FARE)) SPRM_FARE
              FROM   TB_RE590 A
              WHERE  A.CHG_MG_DV_CD = '11'
              AND    A.PRC_DV_CD = '1'
              AND    A.DPT_RS_STN_CD = LEAST(P_DPT_STOP_RS_STN_CD, P_ARV_STOP_RS_STN_CD)
              AND    A.ARV_RS_STN_CD = GREATEST(P_DPT_STOP_RS_STN_CD, P_ARV_STOP_RS_STN_CD)
              AND    A.PRC_CL_CD = P_TRN_CLSF_CD || '1'
              AND    A.CHG_MG_NO = (SELECT Z.CHG_MG_NO
                                    FROM   TB_RE110 Z
                                    WHERE  Z.CHG_MG_DV_CD = '11'
                                    AND    P_RUN_DT BETWEEN Z.DEAL_ST_DT AND Z.DEAL_CLS_DT
                                    AND    P_RUN_DT BETWEEN Z.ABRD_ST_DT AND Z.ABRD_CLS_DT)
       );

   END IF;

   IF P_BKCLS_CD IS NOT NULL THEN /* 할인등급이 있을경우*/
         /* 할인율 */
     SELECT REP_DISC_RT
     INTO   V_REP_DISC_RT
     FROM   TB_YB150
     WHERE  BKCLS_CD = P_BKCLS_CD
     AND    P_RUN_DT BETWEEN APL_ST_DT AND APL_CLS_DT;

     IF P_PSRM_CL_CD = '1' THEN     /* 일반석 */
        V_PRICE := V_ADLT_PRC  - FLOOR( (V_ADLT_PRC  * V_REP_DISC_RT + 50) / 100) * 100;
     ELSIF P_PSRM_CL_CD = '2' THEN  /* 특실 */
        V_PRICE := V_SPRM_FARE - FLOOR( (V_SPRM_FARE * V_REP_DISC_RT + 50) / 100) * 100;
     END IF;

   ELSE                          /* 할인등급이 없을경우*/

     IF P_PSRM_CL_CD = '1' THEN    /* 일반석 */
        V_PRICE := V_ADLT_PRC;
     ELSIF P_PSRM_CL_CD = '2' THEN /* 특실 */
        V_PRICE := V_SPRM_FARE;
     END IF;

   END IF;

 RETURN V_PRICE;

END FN_GET_PRICE_GB;


CREATE OR REPLACE FUNCTION YZDBA.FN_RMN_CNT( i_st_pnt   IN   NUMBER,
                                        i_data     IN   VARCHAR2 )
RETURN NUMBER IS
    v_chr1                 CHAR(1);
    v_chr2                 CHAR(1);
    v_num1                 NUMBER;
    v_num2                 NUMBER;
    v_rmn_cnt              NUMBER;
BEGIN
    v_chr1 := SUBSTR( i_data, i_st_pnt, 1);
    v_chr2 := SUBSTR( i_data, i_st_pnt + 1, 1);

    IF v_chr1 BETWEEN 'A' AND 'Z' THEN
        v_num1 := (ASCII(v_chr1) - 55)*64;
    ELSIF v_chr1 BETWEEN 'a' and 'z' THEN
        v_num1 := (ASCII(v_chr1) - 61)*64;
    ELSIF v_chr1 = '+' THEN
        v_num1 := 62*64;
    ELSIF v_chr1 = '/' THEN
        v_num1 := 63*64;
    ELSE
        v_num1 := to_number(v_chr1)*64;
    END IF;

    IF v_chr2 BETWEEN 'A' AND 'Z' THEN
        v_num2 := ASCII(v_chr2) - 55;
    ELSIF v_chr2 BETWEEN 'a' and 'z' THEN
        v_num2 := ASCII(v_chr2) - 61;
    ELSIF v_chr2 = '+' THEN
        v_num2 := 62;
    ELSIF v_chr2 = '/' THEN
        v_num2 := 63;
    ELSE
        v_num2 := to_number(v_chr2);
    END IF;

    v_rmn_cnt := v_num1 + v_num2;

    RETURN  v_rmn_cnt;
END FN_RMN_CNT;
/

CREATE OR REPLACE FUNCTION YZDBA.FN_ST_PNT( i_max_run_ordr  IN   NUMBER,
                                       i_dpt_run_ordr  IN   NUMBER,
                                       i_arv_run_ordr  IN   NUMBER )
RETURN NUMBER IS
    inx                    NUMBER := 1;
    v_st_pnt               NUMBER;
BEGIN
    v_st_pnt := 0;

    WHILE inx < i_dpt_run_ordr LOOP
        v_st_pnt := v_st_pnt + i_max_run_ordr - inx;
        inx := inx + 1;
    END LOOP;

    v_st_pnt := ( v_st_pnt + ( i_arv_run_ordr - i_dpt_run_ordr - 1 ) ) * 2;
    v_st_pnt := v_st_pnt + 1;

    RETURN v_st_pnt;
END FN_ST_PNT;
/

CREATE OR REPLACE FUNCTION YZDBA.FN_YB_GetCgPsNm ( h_cg_ps_id      IN  CHAR )
RETURN VARCHAR2 IS
    h_cg_ps_nm        TB_ZZ100.USE_PS_NM%TYPE;
BEGIN
    SELECT USE_PS_NM
    INTO   h_cg_ps_nm
    FROM   YZDBA.TB_ZZ100
    WHERE  USE_PS_ID = h_cg_ps_id
    AND    VALID_USE_PS_FLG = 'Y';

    RETURN h_cg_ps_nm ;
END FN_YB_GetCgPsNm;
/

CREATE OR REPLACE FUNCTION YZDBA.FN_YB_GetCommCdNm( v_comn_cd_id CHAR,
                                              v_comn_cd    VARCHAR2,
                                              v_select_opt NUMBER
                                            )
RETURN VARCHAR2 IS   v_code_nm  tb_kr005.eng_cd_val%TYPE;  --Varchar2(50)

BEGIN
    v_code_nm  := '';

    BEGIN
        SELECT  CASE
                    WHEN v_select_opt = 1   THEN kor_cd_val_avvr
                    WHEN v_select_opt = 2   THEN eng_cd_val_avvr
                    WHEN v_select_opt = 3   THEN kor_cd_val
                    WHEN v_select_opt = 4   THEN eng_cd_val
                                            ELSE ''
                END
        INTO   v_code_nm
        FROM   yzdba.tb_kr005                   /* 공통코드 Table   */
        WHERE  comn_cd_id = v_comn_cd_id  /* 공통 코드 ID     */
    	AND    comn_cd    = v_comn_cd;	  /* 공통 코드        */

        EXCEPTION
        WHEN OTHERS  THEN
             v_code_nm := '';
    END;

    RETURN  TRIM( v_code_nm );

END FN_YB_GetCommCdNm;
/


CREATE OR REPLACE FUNCTION YZDBA.FN_YB_GetRoutDstCal( v_rout_cd           IN  CHAR,
                                                v_st_stn_cons_ordr  IN  NUMBER,
                                                v_cls_stn_cons_ordr IN  NUMBER,
                                                v_run_dt            IN  CHAR,
                                                v_flag              IN  NUMBER DEFAULT 1 )
RETURN NUMBER IS
    v_dst                 tb_sz060.exs_ln_acm_dst%TYPE;
    h_dpt_new_ln_acm_dst  tb_sz060.new_ln_acm_dst%TYPE;
    h_dpt_exs_ln_acm_dst  tb_sz060.exs_ln_acm_dst%TYPE;
    h_arv_new_ln_acm_dst  tb_sz060.new_ln_acm_dst%TYPE;
    h_arv_exs_ln_acm_dst  tb_sz060.exs_ln_acm_dst%TYPE;
    h_st_stn_cons_ordr    tb_sz060.stn_cons_ordr%TYPE;
    h_cls_stn_cons_ordr   tb_sz060.stn_cons_ordr%TYPE;

BEGIN

    v_dst := 0;
    /*-----------------------------------------------------------------------*/
    /* 노선구성역 조회                                                       */
    /*-----------------------------------------------------------------------*/

        SELECT a.new_ln_acm_dst,
               a.exs_ln_acm_dst,
               b.new_ln_acm_dst,
               b.exs_ln_acm_dst
        INTO   h_dpt_new_ln_acm_dst,
               h_dpt_exs_ln_acm_dst,
               h_arv_new_ln_acm_dst,
               h_arv_exs_ln_acm_dst
        FROM   yzdba.tb_sz060 a,
               yzdba.tb_sz060 b
        WHERE  a.rout_cd       = v_rout_cd
        AND    a.rout_cd       = b.rout_cd
        AND    a.stn_cons_ordr = v_st_stn_cons_ordr
        AND    b.stn_cons_ordr = v_cls_stn_cons_ordr
        AND    v_run_dt BETWEEN  a.apl_st_dt AND a.apl_cls_dt
        AND    v_run_dt BETWEEN  b.apl_st_dt AND b.apl_cls_dt;

    IF SQL%FOUND THEN
        /*-----------------------------------------------------------------------*/
        /* 승차거리 계산                                                         */
        /*-----------------------------------------------------------------------*/
        IF (v_cls_stn_cons_ordr > v_st_stn_cons_ordr) THEN
            h_st_stn_cons_ordr  := v_st_stn_cons_ordr;
            h_cls_stn_cons_ordr := v_cls_stn_cons_ordr;
            h_dpt_new_ln_acm_dst := h_arv_new_ln_acm_dst - h_dpt_new_ln_acm_dst;
            h_dpt_exs_ln_acm_dst := h_arv_exs_ln_acm_dst - h_dpt_exs_ln_acm_dst;
        ELSE

            h_st_stn_cons_ordr   := v_cls_stn_cons_ordr;
            h_cls_stn_cons_ordr  := v_st_stn_cons_ordr;
            h_dpt_new_ln_acm_dst := h_dpt_new_ln_acm_dst - h_arv_new_ln_acm_dst;
            h_dpt_exs_ln_acm_dst := h_dpt_exs_ln_acm_dst - h_arv_exs_ln_acm_dst;
        END IF;
        /*-----------------------------------------------------------------------*/
        /* 거리특정 계산                                                         */
        /*-----------------------------------------------------------------------*/
        SELECT h_dpt_new_ln_acm_dst - NVL(SUM(new_ln_dduc_dst),0),
               h_dpt_exs_ln_acm_dst - NVL(SUM(exs_ln_dduc_dst),0)
        INTO   h_dpt_new_ln_acm_dst,
               h_dpt_exs_ln_acm_dst
        FROM    yzdba.tb_rb800
        WHERE  rout_cd = v_rout_cd
        AND    st_stn_cons_ordr  >= h_st_stn_cons_ordr
        AND    cls_stn_cons_ordr <= h_cls_stn_cons_ordr
        AND    v_run_dt  BETWEEN apl_st_dt  AND  apl_cls_dt;
        /*------------------------------------------------------------------------*/
        /* 거리의 단수                                                            */
        /*------------------------------------------------------------------------*/
        /*IF (v_flag = 1) THEN
        /*    v_dst := ROUND(h_dpt_new_ln_acm_dst) + ROUND(h_dpt_exs_ln_acm_dst);
        /*ELSE
        /*    v_dst := h_dpt_new_ln_acm_dst + h_dpt_exs_ln_acm_dst;
        /*
        /*END IF;
        */
        /* v_flag 상관없이 소숫 첫째자리로 계산 : pc 소스 수정없이 DB 함수 수정*/
        /* 예약발매와 수익관리가 이부분을 다르게 처리     2011.12.26 강영숙    */
        v_dst := h_dpt_new_ln_acm_dst + h_dpt_exs_ln_acm_dst;
    END IF;
RETURN v_dst;
END FN_YB_GetRoutDstCal;
/

CREATE OR REPLACE FUNCTION YZDBA.FN_YB_GetRoutNmOrLnNm (
                           h_rout_cd            IN char,
                           h_rtn_flag           IN number )
RETURN VARCHAR2 IS
    h_rout_nm            tb_sz001.rout_nm%TYPE;
    h_ln_nm              tb_oz104.ln_nm%TYPE;

BEGIN
    h_rout_nm       := '';
    h_ln_nm         := '';
    /*--------------------------------------------------------------*/
    /*-- 리턴값구분을 체크하여 해당 SQL을 실행하여 값을 리턴한다. --*/
    /*-- 리턴값구분 : 1 - 노선명  2 - 대표선명                    --*/
    /*--------------------------------------------------------------*/

    if h_rtn_flag = 1 then
        BEGIN
            SELECT rout_nm                            /* 노선명 */
            INTO   h_rout_nm
            FROM   tb_sz001
            WHERE  rout_cd  = h_rout_cd;

            EXCEPTION
                WHEN NO_DATA_FOUND then
                    h_rout_nm := '';
        END;

        RETURN RTRIM(h_rout_nm);

    elsif h_rtn_flag = 2 then
        BEGIN
            SELECT ln_nm                              /* 대표선명 */
            INTO   h_ln_nm
            FROM   tb_sz001 a,
                   tb_oz104 b
            WHERE  a.rout_cd      = h_rout_cd
            AND    a.mn_run_ln_cd = b.ln_cd
            AND    TO_CHAR(sysdate,'YYYYMMDD') BETWEEN b.apl_st_dt AND b.apl_cls_dt;

            EXCEPTION
                WHEN NO_DATA_FOUND then
                    h_ln_nm := '';
        END;

        RETURN RTRIM(h_ln_nm);

    else
        RETURN RTRIM('');

    end if;

END FN_YB_GetRoutNmOrLnNm;
/


CREATE OR REPLACE FUNCTION YZDBA.FN_YB_GetRsvSaleStnNm(h_rs_stn_cd VARCHAR2,
                                                 h_apl_dt    CHAR DEFAULT NULL)
RETURN VARCHAR2 IS h_kor_stn_nm TB_OZ101.kor_stn_nm%TYPE;

BEGIN

  h_kor_stn_nm := '';

  SELECT b.kor_stn_nm
  INTO   h_kor_stn_nm
  FROM   TB_RB101 a,
         TB_OZ101 b
  WHERE  a.rs_stn_cd = h_rs_stn_cd
  AND    a.stn_cd  = b.stn_cd
  AND    NVL(h_apl_dt, TO_CHAR(SYSDATE,'YYYYMMDD')) BETWEEN
         b.apl_st_dt AND  b.apl_cls_dt;

  RETURN TRIM(h_kor_stn_nm);

EXCEPTION
  WHEN OTHERS THEN
    RETURN NULL;

END FN_YB_GetRsvSaleStnNm;
/

CREATE OR REPLACE FUNCTION YZDBA.FN_YB_GetStGpRepStnNm (
                           h_stgp_cd          IN  CHAR,
                           h_run_dt           IN  CHAR DEFAULT NULL )
RETURN VARCHAR2 IS
    h_rs_stn_nm            tb_oz101.kor_stn_nm %TYPE;

BEGIN
    h_rs_stn_nm := '';

    SELECT d.kor_stn_nm rs_stn_nm
    INTO   h_rs_stn_nm
    FROM   yzdba.tb_yf120 a,
           yzdba.tb_yf110 b,
           yzdba.tb_rb101 c,
           yzdba.tb_oz101 d
    WHERE  stgp_cd       = h_stgp_cd
    AND    a.stgp_degr   = b.stgp_degr
    AND    NVL(h_run_dt, TO_CHAR(SYSDATE, 'YYYYMMDD')) BETWEEN b.apl_run_st_dt AND b.apl_run_cls_dt
    AND    a.rep_stn_flg = 'Y'
    AND    a.rs_stn_cd   = c.rs_stn_cd
    AND    c.stn_cd      = d.stn_cd
    AND    NVL(h_run_dt, TO_CHAR(SYSDATE, 'YYYYMMDD')) BETWEEN d.apl_st_dt AND d.apl_cls_dt;

    RETURN TRIM(h_rs_stn_nm);
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END FN_YB_GetStGpRepStnNm;
/

CREATE OR REPLACE FUNCTION YZDBA.FN_YB_RmnCnt( i_max_run_ordr  IN   NUMBER,
                                          i_dpt_run_ordr  IN   NUMBER,
                                          i_arv_run_ordr  IN   NUMBER,
                                          i_data          IN   VARCHAR2 )

RETURN NUMBER IS
    inx                    NUMBER := 1;
    v_st_pnt               NUMBER;
    v_chr1                 CHAR(1);
    v_chr2                 CHAR(1);
    v_num1                 NUMBER;
    v_num2                 NUMBER;
    v_rmn_cnt              NUMBER;
BEGIN

    v_st_pnt := 0;
    WHILE inx < i_dpt_run_ordr LOOP
        v_st_pnt := v_st_pnt + i_max_run_ordr - inx;
        inx := inx + 1;
    END LOOP;

    v_st_pnt := ( v_st_pnt + ( i_arv_run_ordr - i_dpt_run_ordr - 1 ) ) * 2;
    v_st_pnt := v_st_pnt + 1;

    v_chr1 := SUBSTR( i_data, v_st_pnt, 1);
    v_chr2 := SUBSTR( i_data, v_st_pnt + 1, 1);

    IF v_chr1 BETWEEN 'A' AND 'Z' THEN
        v_num1 := (ASCII(v_chr1) - 55)*64;
    ELSIF v_chr1 BETWEEN 'a' and 'z' THEN
        v_num1 := (ASCII(v_chr1) - 61)*64;
    ELSIF v_chr1 = '+' THEN
        v_num1 := 62*64;
    ELSIF v_chr1 = '/' THEN
        v_num1 := 63*64;
    ELSE
        v_num1 := to_number(v_chr1)*64;
    END IF;

IF v_chr2 BETWEEN 'A' AND 'Z' THEN
        v_num2 := ASCII(v_chr2) - 55;
    ELSIF v_chr2 BETWEEN 'a' and 'z' THEN
        v_num2 := ASCII(v_chr2) - 61;
    ELSIF v_chr2 = '+' THEN
        v_num2 := 62;
    ELSIF v_chr2 = '/' THEN
        v_num2 := 63;
ELSE
        v_num2 := to_number(v_chr2);
    END IF;

    v_rmn_cnt := v_num1 + v_num2;

    RETURN  v_rmn_cnt;

END FN_YB_RmnCnt;
/

CREATE OR REPLACE FUNCTION YZDBA.FN_YR_GET_PRICE(P_RUN_DT IN VARCHAR2,
                                           P_TRN_NO IN VARCHAR2,
                                           P_GROUP_NO NUMBER)
   RETURN NUMBER
IS
   V_PRICE                     NUMBER;
BEGIN


   SELECT (SELECT CASE
                     WHEN B.DAY_DV_CD IN('2', '3', '4', '5')
                  AND    B.HOLI_DV_CD IS NULL
                        THEN(A.ADLT_PRC - FLOOR( (A.ADLT_PRC * 0.005 + 50) / 100) * 100)
                     ELSE(A.ADLT_PRC + FLOOR( (A.ADLT_PRC * 0.065 + 50) / 100) * 100)
                  END
           FROM   TB_RE590 A,
                  TB_RB715 B
           WHERE  B.RUN_DT = A2.RUN_DT
           AND    A.CHG_MG_DV_CD = '11'
           AND    A.PRC_DV_CD = '1'
           AND    A.DPT_RS_STN_CD = LEAST(A2.DPT_RS_STN_CD, A2.ARV_RS_STN_CD)
           AND    A.ARV_RS_STN_CD = GREATEST(A2.DPT_RS_STN_CD, A2.ARV_RS_STN_CD)
           AND    A.PRC_CL_CD = (SELECT Z.TRN_CLSF_CD || '1'
                                 FROM   TB_RD215 Z
                                 WHERE  Z.RUN_DT = A2.RUN_DT
                                 AND    Z.TRN_NO = A2.TRN_NO)
           AND    A.CHG_MG_NO = (SELECT Z.CHG_MG_NO
                                 FROM   TB_RE110 Z
                                 WHERE  Z.CHG_MG_DV_CD = '11'
                                 AND    A2.RUN_DT BETWEEN Z.DEAL_ST_DT AND Z.DEAL_CLS_DT
                                 AND    A2.RUN_DT BETWEEN Z.ABRD_ST_DT AND Z.ABRD_CLS_DT)
           AND    A.DST = (SELECT FN_YB_GETROUTDSTCAL(Z.ROUT_CD, Y.STN_CONS_ORDR, V.STN_CONS_ORDR, Z.RUN_DT, 2)
                           FROM   TB_RD215 Z,
                                  TB_RD225 Y,
                                  TB_RD225 V
                           WHERE  Z.RUN_DT = A2.RUN_DT
                           AND    Z.TRN_NO = A2.TRN_NO
                           AND    Z.RUN_DT = Y.RUN_DT
                           AND    Z.TRN_NO = Y.TRN_NO
                           AND    Y.STOP_RS_STN_CD = LEAST(A2.DPT_RS_STN_CD, A2.ARV_RS_STN_CD)
                           AND    Z.TRN_NO = V.TRN_NO
                           AND    Z.RUN_DT = V.RUN_DT
                           AND    V.STOP_RS_STN_CD = GREATEST(A2.DPT_RS_STN_CD, A2.ARV_RS_STN_CD) ) )
   INTO   V_PRICE
   FROM   (SELECT   A1.TRN_NO,
                    A1.RUN_DT,
                    A1.DPT_STN_CONS_ORDR,
                    A1.ARV_STN_CONS_ORDR,
                    C1.STOP_RS_STN_CD DPT_RS_STN_CD,
                    D1.STOP_RS_STN_CD ARV_RS_STN_CD,
                    C1.RUN_ORDR DPT_ORDR,
                    D1.RUN_ORDR ARV_ORDR
           FROM     (SELECT RUN_DT,
                            TRN_NO,
                            DPT_STN_CONS_ORDR,
                            ARV_STN_CONS_ORDR
                     FROM   TB_YD330
                     WHERE  RUN_DT = P_RUN_DT
                     AND    TRN_NO = P_TRN_NO) A1,
                    TB_RD215 B1,
                    TB_RD225 C1,
                    TB_RD225 D1,
                    TB_RI160 E1
           WHERE    A1.RUN_DT = B1.RUN_DT
           AND      A1.TRN_NO = B1.TRN_NO
           AND      A1.RUN_DT = C1.RUN_DT
           AND      A1.TRN_NO = C1.TRN_NO
           AND      A1.DPT_STN_CONS_ORDR = C1.STN_CONS_ORDR
           AND      A1.RUN_DT = D1.RUN_DT
           AND      A1.TRN_NO = D1.TRN_NO
           AND      A1.ARV_STN_CONS_ORDR = D1.STN_CONS_ORDR
           AND      A1.RUN_DT = E1.RUN_DT
           AND      A1.TRN_NO = E1.TRN_NO
           AND      C1.ZONE_NO = DECODE(B1.UND_DV_CD, 'D', E1.DPT_ZONE_NO, E1.ARV_ZONE_NO)
           AND      D1.ZONE_NO = DECODE(B1.UND_DV_CD, 'D', E1.ARV_ZONE_NO, E1.DPT_ZONE_NO)
           AND      E1.ZONE_SEG_GRUP_NO = P_GROUP_NO
           ORDER BY C1.RUN_ORDR,
                    D1.RUN_ORDR ) A2
   WHERE  ROWNUM = 1;


   RETURN(V_PRICE);
END FN_YR_GET_PRICE;
/

DROP VIEW YZDBA.VW_YF120_01;

/* Formatted on 2014-03-19 오전 11:39:34 (QP5 v5.185.11230.41888) */
CREATE OR REPLACE FORCE VIEW YZDBA.VW_YF120_01
(
   STGP_CD,
   STGP_DEGR,
   KOR_STN_NM
)
AS
   SELECT a.stgp_cd, a.stgp_degr, d.kor_stn_nm
     FROM yzdba.tb_yf120 a,
          yzdba.tb_yf110 b,
          yzdba.tb_rb101 c,
          yzdba.tb_oz101 d
    WHERE     a.rep_stn_flg = 'Y'
          AND a.rs_stn_cd = c.rs_stn_cd
          AND a.stgp_degr = b.stgp_degr
          AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN b.apl_run_st_dt
                                                AND b.apl_run_cls_dt
          AND c.stn_cd = d.stn_cd
          AND TO_CHAR (SYSDATE, 'YYYYMMDD') BETWEEN d.apl_st_dt
                                                AND d.apl_cls_dt;


GRANT SELECT ON YZDBA.VW_YF120_01 TO RL_YZ_APP;



















