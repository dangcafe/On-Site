REM ***************************************************************************

REM    Oracle checklist  
REM    Ver: 1.0
REM    Author: Eric Chan
REM    说明: Oracle脚本需要使用sys用户登陆
REM          运行命令 sqlplus /nolog
REM          sql> connect /as sysdba;
REM          sql> @c:\oracle_win.sql;
REM	脚本存放位置

REM ***************************************************************************
whenever sqlerror exit rollback
set feed on
set head on
set arraysize 1
set space 1
set verify off
set pages 25
set lines 140

clear screen

clear screen
define aaa='/tmp/oracle_sec.log'
spool &aaa;

prompt ========================================================================
prompt 1 身份鉴别
prompt ========================================================================

prompt ========================================================================
prompt 1.1 密码复杂度复杂度
prompt ========================================================================
prompt S_Q_L>select * from dba_profiles where resource_name = 'PASSWORD_VERIFY_FUNCTION';
prompt ========================================================================
select profile,limit from dba_profiles where resource_name = 'PASSWORD_VERIFY_FUNCTION' and profile <> 'MONITORING_PROFILE';

prompt ========================================================================
prompt S_Q_L>select * from dba_profiles where resource_name = 'PASSWORD_LOCK_TIME';
prompt ========================================================================
select profile,limit from dba_profiles where resource_name = 'PASSWORD_LOCK_TIME' and profile <> 'MONITORING_PROFILE';

prompt ========================================================================
prompt S_Q_L>select * from dba_profiles where resource_name = 'PASSWORD_REUSE_MAX';
prompt ========================================================================
select profile,limit from dba_profiles where resource_name = 'PASSWORD_REUSE_MAX' and profile <> 'MONITORING_PROFILE';

prompt ========================================================================
prompt S_Q_L>select * from dba_profiles where resource_name = 'PASSWORD_LIFE_TIME';
prompt ========================================================================
select profile,limit from dba_profiles where resource_name = 'PASSWORD_LIFE_TIME' and profile <> 'MONITORING_PROFILE';

prompt ========================================================================
prompt 1.3 失败处理
prompt S_Q_L>select * from dba_profiles where resource_name =  'FAILED_LOGIN_ATTEMPTS';
prompt ========================================================================
select * from dba_profiles where resource_name =  'FAILED_LOGIN_ATTEMPTS';

prompt ========================================================================
prompt 2 访问控制
prompt ========================================================================

prompt ========================================================================
prompt 2.1 是否有“开启XDB服务”漏洞
prompt S_Q_L>show parameter dispatcher;
prompt ========================================================================
show parameter dispatcher;

prompt ========================================================================
prompt 2.2 是否存在应用账户属于DBA组权限
prompt S_Q_L>select grantee from dba_role_privs where granted_role='DBA' and grantee not in ('SYS','SYSTEM','CTXSYS','WmSYS','SYSMAN');
prompt ========================================================================
select grantee from dba_role_privs where granted_role='DBA' and grantee not in ('SYS','SYSTEM','CTXSYS','WmSYS','SYSMAN');

prompt ========================================================================
prompt 2.3 是否锁定多余用户
prompt S_Q_L>select * from dba_users..........
prompt ========================================================================
select * from dba_users where username in ('SCOTT','HR','OE','PM','SH','COMPANY','MFG','FINANCE','ANYDATA_USER','ANYDSET_USER','ANYTYPE_USER','AQJAVA','AQUSER', 'AQXMLUSER','GPFD','GPLD','MMO2','XMLGEN1','BLAmE','ADAMS','CLARm','JONES')or username like 'QS%'or username like 'USER%'or username like '%DEMO%'or username like 'SERVICECONSUMER%';

prompt ========================================================================
prompt 2.4 是否存在默认密码
prompt S_Q_L>select username "User(s) with Default Password!" from dba_users where password in (???);
prompt ========================================================================
select username "User(s) with Default Password!"
 from dba_users
 where password in
('E066D214D5421CCC',  -- dbsnmp
 '24ABAB8B06281B4C',  -- ctxsys
 '72979A94BAD2AF80',  -- mdsys
 'C252E8FA117AF049',  -- odm
 'A7A32CD03D3CE8D5',  -- odm_mtr
 '88A2B2C183431F00',  -- ordplugins
 '7EFA02EC7EA6B86F',  -- ordsys
 '4A3BA55E08595C81',  -- outln
 'F894844C34402B67',  -- scott
 '3F9FBD883D787341',  -- wk_proxy
 '79DF7A1BD138CF11',  -- wk_sys
 '7C9BA362F8314299',  -- wmsys
 '88D8364765FCE6AF',  -- xdb
 'F9DA8977092B7B81',  -- tracesvr
 '9300C0977D7DC75E',  -- oas_public
 'A97282CE3D94E29E',  -- websys
 'AC9700FD3F1410EB',  -- lbacsys
 'E7B5D92911C831E1',  -- rman
 'AC98877DE1297365',  -- perfstat
 '66F4EF5650C20355',  -- exfsys
 '84B8CBCA4D477FA3',  -- si_informtn_schema
 'D4C5016086B2DC6A',  -- sys
 'D4DF7931AB130E37')  -- system
/           


prompt ========================================================================
prompt 2.4 是否对数据库数据字典保护
prompt S_Q_L>show parameter O7_DICTIONARY_ACCESSIBILITY;
prompt ========================================================================
show parameter O7_DICTIONARY_ACCESSIBILITY;

prompt ========================================================================
prompt 3 安全审计
prompt ========================================================================

prompt ========================================================================
prompt 3.1 查看是否开启审计?日志审计策略应OS级别
prompt S_Q_L>Select value from v$parameter where name='audit_trail';
prompt ========================================================================
Select value from v$parameter where name='audit_trail';

prompt ========================================================================
prompt 4 入侵防范
prompt ========================================================================

prompt ========================================================================
prompt 4.1 查看数据库版本
prompt S_Q_L>select * from v$version;
prompt ========================================================================
select * from v$version;

prompt ========================================================================
prompt 查看数据库所打的补丁
prompt S_Q_L>select * from dba_registry_history;
prompt ========================================================================
select * from dba_registry_history;

prompt ========================================================================
prompt 查看数据库是否启用归档模式
prompt S_Q_L>archive log list;
prompt ========================================================================
archive log list;

prompt ========================================================================
prompt 查看数据库public用户权限
prompt S_Q_L>SELECT table_name FROM dba_tab_privs WHERE grantee='PUBLIC' AND privilege='EXECUTE' AND table_name LIKE 'UTL%';
prompt ========================================================================
SELECT table_name FROM dba_tab_privs WHERE grantee='PUBLIC' AND privilege='EXECUTE' AND table_name LIKE 'UTL%';

prompt ========================================================================
prompt remote_login_passwordfile
prompt S_Q_L>show parameter remote_login_passwordfile;
prompt ========================================================================
show parameter remote_login_passwordfile;

prompt ========================================================================
prompt 5 资源控制
prompt ========================================================================

prompt ========================================================================
prompt 5.1 空闲超时
prompt S_Q_L>SELECT limit from dba_profiles where profile='DEFAULT' and resource_name='IDLE_TIME';
prompt ========================================================================
SELECT limit from dba_profiles where profile='DEFAULT' and resource_name='IDLE_TIME';

prompt ========================================================================
prompt SQL脚本执行完成!!!!!!
prompt ========================================================================

spool off;
