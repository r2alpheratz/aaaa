/* Formatted on 2014-03-13 ���� 10:15:17 (QP5 v5.185.11230.41888) */
  SELECT /*+ com.korail.yz.yf.aa.YFAA001QMDAO.selectListStgpInfo*/
        A.KOR_STN_NM AS KOR_GRUP_STN_NM,            /* ���׷��(�ѱ�)             */
         B.KOR_STN_NM AS KOR_STN_NM,                /* �Ҽӿ���(�ѱ�)             */
         DECODE (B.REP_STN_FLG, 'Y', 'Y', '') REP_STN_FLG, /* ��ǥ������                 */
         A.STGP_CD,                                /* ���׷��ڵ�                 */
         CASE WHEN B.DEAL_TRN_CLSF_CD = '00' THEN 'KTX' ELSE '������' END
            DEAL_TRN_CLSF_CD,                           /* ��޿��������ڵ�         */
         A.RS_STN_CD AS RS_STN_CD_1,                    /* ���߿��ڵ�(���׷��ڵ�)     */
         B.RS_STN_CD AS RS_STN_CD_2                     /* ���߿��ڵ�(�Ҽӿ��ڵ�)     */
    FROM (SELECT A.RS_STN_CD,                          /* ���߿��ڵ�             */
                             B.KOR_STN_NM,           /* �ѱۿ���                */
                                          A.STGP_CD    /* ���׷��ڵ�             */
            FROM TB_YYFD002 A,                            /* ���׷��γ��� TBL     */
                              TB_YYDK001 B              /* ���߿��ڵ� TBL        */
           WHERE     A.STGP_DEGR =
                        (SELECT STGP_DEGR
                           FROM TB_YYFB001                       /* ���׷������⺻ */
                          WHERE     APL_ST_DT <= TO_CHAR (SYSDATE, 'YYYYMMDD')
                                AND APL_CLS_DT >= TO_CHAR (SYSDATE, 'YYYYMMDD'))
                 AND A.REP_STN_FLG = 'Y'
                 AND A.RS_STN_CD = B.RS_STN_CD
                 AND B.DEAL_TRN_CLSF_CD IN ('00', '01')
                 AND A.STGP_CD IN
                        (SELECT DISTINCT A.STGP_CD             /* ���׷��ڵ�     */
                           FROM TB_YYFD002 A                  /* ���׷��γ��� TBL */
                          WHERE EXISTS
                                   (SELECT 'X'
                                      FROM TB_YYDK001           /* ���߿��ڵ� TBL*/
                                     WHERE     RS_STN_CD = A.RS_STN_CD
                                           AND DEAL_TRN_CLSF_CD IN ('00', '01')
                                           AND CHTN_STN_FLG IN ('Y', 'N')))
                 AND (null IS NULL OR A.STGP_CD = '')) A,
         (SELECT A.RS_STN_CD,                          /* ���߿��ڵ�             */
                 B.KOR_STN_NM,                       /* �ѱۿ���                */
                 A.STGP_CD,                            /* ���׷��ڵ�             */
                 A.STGP_DEGR,                           /* ���׷�����            */
                 A.REP_STN_FLG,                         /* ��ǥ������            */
                 B.DEAL_TRN_CLSF_CD                             /* ��޿��������ڵ� */
            FROM TB_YYFD002 A,                                /* ���׷��γ��� TBL */
                              TB_YYDK001 B                  /* ���߿��ڵ� TBL    */
           WHERE     A.RS_STN_CD = B.RS_STN_CD
                 AND A.STGP_DEGR =
                        (SELECT STGP_DEGR
                           FROM TB_YYFB001                       /* ���׷������⺻ */
                          WHERE     APL_ST_DT <= TO_CHAR (SYSDATE, 'YYYYMMDD')
                                AND APL_CLS_DT >= TO_CHAR (SYSDATE, 'YYYYMMDD'))
                 AND B.DEAL_TRN_CLSF_CD IN ('00', '01')
                 AND B.CHTN_STN_FLG IN ('Y', 'N')
                 AND B.DEL_FLG = 'N'
                 AND (null IS NULL OR A.STGP_CD = null)) B
   WHERE     A.STGP_CD = B.STGP_CD
         AND ('00' IS NULL OR B.DEAL_TRN_CLSF_CD LIKE '00')
ORDER BY A.RS_STN_CD, B.RS_STN_CD