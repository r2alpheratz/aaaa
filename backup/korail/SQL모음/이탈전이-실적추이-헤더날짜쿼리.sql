        SELECT /*+ com.korail.yz.ys.eb.YSEB001QMDAO.selectListAcvmTndDate */
               MAX (DECODE (ROWNUM, 5, SUBSTR (A.RUN_DT, 5, 2) || '/' || SUBSTR (A.RUN_DT, 7, 2))),
               MAX (DECODE (ROWNUM, 4, SUBSTR (A.RUN_DT, 5, 2) || '/' || SUBSTR (A.RUN_DT, 7, 2))),
               MAX (DECODE (ROWNUM, 3, SUBSTR (A.RUN_DT, 5, 2) || '/' || SUBSTR (A.RUN_DT, 7, 2))),
               MAX (DECODE (ROWNUM, 2, SUBSTR (A.RUN_DT, 5, 2) || '/' || SUBSTR (A.RUN_DT, 7, 2)))
          FROM (  SELECT A.RUN_DT
                    FROM TB_YYDK002 A, 
                         TB_YYDK003 B
                   WHERE     A.RUN_DT = B.RUN_DT
                         AND A.RUN_DT BETWEEN TO_CHAR (TO_DATE (#RUN_DT#, 'YYYYMMDD') - 56, 'YYYYMMDD')
                                          AND #RUN_DT#
                         AND A.DAY_DV_CD = (SELECT DAY_DV_CD
                                              FROM TB_YYDK002
                                             WHERE RUN_DT = #RUN_DT#
                                           )
                         AND B.TRN_OPR_BZ_DV_CD = '001' /* 한국철도공사 */                  
                         AND B.BIZ_DD_STG_CD IN ('1', '2', '3')
                ORDER BY A.RUN_DT DESC
               ) A