delete FROM   TB_FR_SYS_IMPERSON_LOG;
delete FROM   TB_FR_MULTI_MESSAGE_INFO;
delete FROM   TB_FR_MESSAGE_INFO;
delete FROM   TB_FR_MENU_PAGE_INFO;
delete FROM   TB_FR_MENU_AUTH_MAP;
delete FROM   TB_FR_MENU_MULTI_LANG_INFO;
delete FROM   TB_FR_MENU_INFO;
delete FROM   TB_FR_USER_ROLE_MAP;
delete FROM   TB_FR_DEPT_USER_MAP;
delete FROM   TB_FR_WORKGROUP_USER_MAP;
delete FROM   TB_FR_USER_INFO;
delete FROM   TB_FR_WORKGROUP_ROLE_MAP;
delete FROM   TB_FR_ROLE_INFO;
delete FROM   TB_FR_DEPT_INFO;
delete FROM   TB_FR_SYS_LOG;
delete FROM   TB_FR_WORKGROUP_INFO;
delete FROM   TB_FR_CODE_MULTI_LANG_INFO;
delete FROM   TB_FR_CODE_INFO;
delete FROM   TB_FR_LANGUAGE_INFO;



--select a.username, a.sid, a.serial#, b.xidusn, b.process, b.locked_mode, c.object_name, a.sql_id
--     from v$session a, v$locked_object b, dba_objects c
--      where a.sid = b.session_id
--      and b.object_id = c.object_id
--      order by b.xidusn desc;
--
--
--       alter system kill session '17,2919';



