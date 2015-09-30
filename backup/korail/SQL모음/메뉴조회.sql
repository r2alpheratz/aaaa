    SELECT /*+ com.korail.yz.comm.COMMQMDAO.listMenuLst */
           TRVL_MENU_ID,
           MENU_NM,
           LVL_NUM,
           HRNK_TRVL_MENU_ID,
           TRVL_SCN_ID,
           SCN_NM,
           TRVL_SCN_URL_ADR,
           MENU_GP_CD,
           RN,
           MYPG_REG_FLG
      FROM (           SELECT A.TRVL_MENU_ID,
                              A.MENU_NM,
                              A.LVL_NUM,
                              A.HRNK_TRVL_MENU_ID,
                              B.TRVL_SCN_ID,
                              B.SCN_NM,
                              B.TRVL_SCN_URL_ADR,
                              DECODE (CONNECT_BY_ISLEAF,  0, '01',  1, '02') AS MENU_GP_CD,
                              (SELECT CASE WHEN NVL(YMGT_PGM_NM, '0') != '0' THEN '1' ELSE '0' END FROM TB_YYBD014 WHERE YMGT_PGM_NM = A.TRVL_MENU_ID) MYPG_REG_FLG,
                              ROWNUM RN
                         FROM TB_YYBB011 A, TB_YYBB012 B
                        WHERE     A.TRVL_SCN_ID = B.TRVL_SCN_ID(+)
                              AND A.TRVL_MENU_ID LIKE 'MY%'
                              AND (   'tu0001' IS NULL
                                   OR EXISTS
                                         (SELECT '1'
                                            FROM TB_YYBR008 S1, TB_YYBR010 S2
                                           WHERE     S1.TRVL_USR_ID = 'tu0001'
                                                 AND S1.ROLE_ID = S2.ROLE_ID
                                                 AND S2.TRVL_MENU_ID = A.TRVL_MENU_ID))
                   CONNECT BY PRIOR TRVL_MENU_ID = HRNK_TRVL_MENU_ID
                   START WITH LVL_NUM = '0'
            ORDER SIBLINGS BY SORT_ORDR)
     WHERE RN > NVL (0, 0)
     
     
     ;
     
     SELECT * FROM TB_YYBB011 WHERE TRVL_MENU_ID LIKE 'MY%' ORDER BY TRVL_MENU_ID;;

DELETE FROM TB_YYBB011 WHERE TRVL_MENU_ID LIKE 'MY%';;

SELECT * FROM TB_YYBB012 WHERE TRVL_SCN_ID LIKE 'Y%' ORDER BY TRVL_SCN_ID;

DELETE FROM TB_YYBB012 WHERE TRVL_SCN_ID LIKE 'Y%' ;