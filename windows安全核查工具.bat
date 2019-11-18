@echo off
title Windows安全核查工具 V1.0 by ChinaGDN
cls
echo  ======================= Windows安全核查工具 V1.0 ========================
echo.
echo             系统编号：1、Windows2003  2、Windows2008  3、退出
echo.         
echo      请耐心等候程序执行完毕，期间请不要进行任何操作，以免影响收集结果
echo                          如发现问题，请及时反馈！
echo.
echo  =========================================================================
echo                                                               Copyright 
echo                                                         编写人:dangcafe
echo                                                         编写人:dangcafe
echo  =========================================================================
echo.
set /p choice=请选择系统编号：
if "%choice%"=="1" goto win2k3
if "%choice%"=="2" goto win2k8
if "%choice%"=="3" goto exit222

:win2k3
cls
setlocal enabledelayedexpansion
echo .                                                                         .
echo  ======================= Windows安全核查工具 V1.0 ========================
set "str=  Windows2003安全核查工具正在工作，请不要进行任何操作，以免影响结果......"

call :ShowStr "%str%"

:Delay_Time num(次数)
for /l %%i in (0 1 %1) do ver>nul
goto :eof
:ShowStr
set "Sstr=%~1"
for /l %%i in (0 1 100) do set /p=!Sstr:~%%i,1!<nul& call :Delay_Time 120
echo.
set "str=   本程序按照等保三级测评表进行信息收集，若检测二级系统，可自行筛选结果"
call :ShowStr "%str%"

:Delay_Time num(次数)
for /l %%i in (0 1 %1) do ver>nul
goto :eof
:ShowStr
set "Sstr=%~1"
for /l %%i in (0 1 100) do set /p=!Sstr:~%%i,1!<nul& call :Delay_Time 120
echo.
set "str=            部分需要访谈的测评项请自行联系相关管理员进行测评"
call :ShowStr "%str%"

:Delay_Time num(次数)
for /l %%i in (0 1 %1) do ver>nul
goto :eof
:ShowStr
set "Sstr=%~1"
for /l %%i in (0 1 100) do set /p=!Sstr:~%%i,1!<nul& call :Delay_Time 120
echo.
set "str=　　请耐心等候程序执行完毕，期间请不要进行任何操作，以免影响收集结果"
call :ShowStr "%str%"

:Delay_Time num(次数)
for /l %%i in (0 1 %1) do ver>nul
goto :eof
:ShowStr
set "Sstr=%~1"
for /l %%i in (0 1 100) do set /p=!Sstr:~%%i,1!<nul& call :Delay_Time 120
echo.
set "str=　　　　　　　　　　　  如发现问题，请及时反馈！"
call :ShowStr "%str%"

:Delay_Time num(次数)
for /l %%i in (0 1 %1) do ver>nul
goto :eof
:ShowStr
set "Sstr=%~1"
for /l %%i in (0 1 100) do set /p=!Sstr:~%%i,1!<nul& call :Delay_Time 120
echo.
echo  =========================================================================
set "str=                                                        Copyright ChinaGDN"
call :ShowStr "%str%"

:Delay_Time num(次数)
for /l %%i in (0 1 %1) do ver>nul
goto :eof
:ShowStr
set "Sstr=%~1"
for /l %%i in (0 1 100) do set /p=!Sstr:~%%i,1!<nul& call :Delay_Time 120
echo.
echo  =========================================================================
echo .                                                                         .
setlocal
::本机基本信息收集
for /f "tokens=15" %%i in ('ipconfig /all ^| find /i "IP Address"') do set ipaddr=%%i
if "%ipaddr%"=="" set ipaddr=%COMPUTERNAME%
for /f "tokens=15" %%i in ('ipconfig /all ^| find /i "Subnet Mask"') do set mask=%%i
for /f "tokens=15" %%i in ('ipconfig /all ^| find /i "DNS Servers"') do set dns=%%i
for /f "delims=" %%i in ('ver') do set vvv=%%i
echo ===================================基本信息==================================>%ipaddr%.txt
echo 计算机名称: %COMPUTERNAME%>>%ipaddr%.txt
echo 当前登陆帐号: %USERNAME%>>%ipaddr%.txt
if "%ipaddr%"=="%COMPUTERNAME%" echo 本机IP: 获取失败，请手动获取>>%ipaddr%.txt
if "%ipaddr%" NEQ "%COMPUTERNAME%" echo 本机IP: %ipaddr%>>%ipaddr%.txt
if "%mask%"=="" echo 本机子网掩码为:获取失败，请手动获取>>%ipaddr%.txt
if "%mask%" NEQ "" echo 本机子网掩码为: %mask%>>%ipaddr%.txt
if "%dns%"=="" echo 本机DNS为:获取失败，请手动获取>>%ipaddr%.txt
if "%dns%" NEQ "" echo 本机DNS为: %dns%>>%ipaddr%.txt
echo 当前执行脚本目录: %CD%>>%ipaddr%.txt
echo 本机操作系统: %vvv%	（5.X为2003系列，6.X为2008系列）>>%ipaddr%.txt
echo 当前操作系统时间与日期(24小时制): %date% %time% >>%ipaddr%.txt
echo =============================================================================>>%ipaddr%.txt
echo.
echo 主机基本信息收集完毕
echo.

echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt

::身份鉴别信息收集
echo ===================================身份鉴别==================================>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------身份鉴别A项，用户信息---------------->>%ipaddr%.txt
for /f "eol=- skip=3 tokens=1,2,3" %%u in ('net user') do if not '%%u'=='命令成功完成。' net user %%u |findstr /i "用户名 帐户启用 帐户到期 密码到期 需要密码 本地组成员">>%ipaddr%.txt&echo.>>%ipaddr%.txt&if not '%%v'=='' net user %%v |findstr /i "用户名 帐户启用 帐户到期 密码到期 需要密码 本地组成员" >>%ipaddr%.txt&echo.>>%ipaddr%.txt&if not '%%w'=='' net user %%w |findstr /i "用户名 帐户启用 帐户到期 密码到期 需要密码 本地组成员">>%ipaddr%.txt&echo.>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------身份鉴别B项，密码策略---------------->>%ipaddr%.txt
secedit /export /cfg sec.tmp>nul
for /f "tokens=3" %%t in ('type sec.tmp ^|find /i "PasswordComplexity"') do echo 密码复杂度：	%%t	（0为关闭，1为开启）>>%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "密码长度最小值"') do echo %%t>>%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "密码最长使用期限"') do echo %%t>>%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "密码最短使用期限"') do echo %%t>>%ipaddr%.txt
for /f "tokens=2" %%t in ('net accounts ^|find /i "保持的密码历史记录长度"') do echo 强制密码历史：%%t 次>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------身份鉴别C项，登陆失败---------------->>%ipaddr%.txt
for /f "tokens=2" %%t in ('net accounts ^|find /i "锁定观测窗口"') do echo 复位帐户锁定计数器（分）：	 %%t>>%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "锁定持续时间"') do echo %%t>>%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "锁定阈值"') do echo %%t>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------身份鉴别D项，传输保密---------------->>%ipaddr%.txt
for /f "delims=" %%t in ('systeminfo ^|find "OS 名称"') do echo %%t>>%ipaddr%.txt
for /f "eol=B delims=" %%t in ('systeminfo ^|find "OS 版本"') do echo %%t>>%ipaddr%.txt
for /f "delims=" %%t in ('systeminfo ^|find "OS 配置"') do echo %%t>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo 说明：注意OS版本即可>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo 说明：F项可参考上面所收集的信息，三级系统G、H项请自行检测或访谈相关管理员>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo =============================================================================>>%ipaddr%.txt
echo 身份鉴别信息收集完毕
echo.

echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt

::访问控制信息收集
echo ===================================访问控制==================================>>%ipaddr%.txt
echo.>>%ipaddr%.txt

echo ----------------访问控制A项，权限、共享、服务---------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ------------权限------------>>%ipaddr%.txt
echo cmd.exe权限：>>%ipaddr%.txt
cacls c:\windows\system32\cmd.exe>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo C:\权限：>>%ipaddr%.txt
cacls c:\>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo C:\Program Files权限：>>%ipaddr%.txt
cacls C:\Progra~1>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo 说明：R为读取、W为写入、C为更改、F为完全控制，后者继承前者权限>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ---------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ------------共享------------>>%ipaddr%.txt
echo 存在以下默认共享：>>%ipaddr%.txt
net share |find "$">>%ipaddr%.txt
echo ---------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ------------服务------------>>%ipaddr%.txt
for /f "eol=命 delims=" %%r in ('net start') do echo %%r>>%ipaddr%.txt
echo ---------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ------------------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------访问控制B项，最小授权---------------->>%ipaddr%.txt
for /f "tokens=3" %%t in ('type sec.tmp ^|find /i "SeRemoteShutdownPrivilege"') do set srsp=%%t
for /f "delims=" %%x in ('type sec.tmp ^|find /i "SeRemoteShutdownPrivilege"')  do echo 现场记录：%%x>>%ipaddr%.txt
if "%srsp%"=="*S-1-5-32-544" echo √只有administrators组才能从远端系统强制关机>>%ipaddr%.txt
if "%srsp%" NEQ "*S-1-5-32-544" echo ×不需要administrators组就能从远端系统强制关机>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo 说明：值为S-1-5-32-544时，表示只有administrators组才能使用该功能，若为其他值，则表示不需要administrators组也可以从远端系统强制关机>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------访问控制C、D、E、F、G项---------------->>%ipaddr%.txt
echo 请参考前面的信息或访谈相关管理员>>%ipaddr%.txt
echo ---------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------访问控制电力企标---------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ---------系统失败自动重新启动--------->>%ipaddr%.txt
for /f "tokens=3" %%y in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Crashcontrol" ^|find /i "AutoReboot"') do set yyy=%%y
for /f "eol=H tokens=1 delims=" %%x in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Crashcontrol" ^|find /i "AutoReboot"') do echo 现场记录：%%x>>%ipaddr%.txt
if "%yyy%"=="0x0" echo √已禁止“系统失败自动重新启动”功能>>%ipaddr%.txt
if "%yyy%" NEQ "0x0" echo ×没有禁止“系统失败自动重新启动”功能>>%ipaddr%.txt
echo -------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ---------自动播放--------->>%ipaddr%.txt
for /f "tokens=3" %%j in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" ^|find /i "NoDriveTypeAutoRun"') do set aua=%%j
for /f "delims=" %%x in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" ^|find /i "NoDriveTypeAutoRun"') do echo 现场记录：%%x>>%ipaddr%.txt
if "%aua%"=="" echo ×没有禁止“自动播放”功能，所以注册表没有相关键值>>%ipaddr%.txt
if "%aua%"=="0xb5" echo ×已禁止“自动播放”功能，但只禁止了CD-ROM自动播放>>%ipaddr%.txt
if "%aua%"=="0xff" echo √已禁止“自动播放”功能，禁止了所有驱动器的自动播放功能>>%ipaddr%.txt
echo -------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ---------硬盘类型--------->>%ipaddr%.txt
for %%d in (c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) do if exist %%d:\ chkntfs %%d:>>%ipaddr%.txt
echo -------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ---------------------------------------------------->>%ipaddr%.txt

echo.>>%ipaddr%.txt
echo ===================================访问控制==================================>>%ipaddr%.txt
echo 访问控制信息收集完毕
echo.

echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt

::安全审计信息收集
echo ===================================安全审计==================================>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------安全审计A、B、C项，审计策略---------------->>%ipaddr%.txt
for /f "tokens=3" %%d in ('type sec.tmp ^|find "AuditSystemEvents"') do set ddd=%%d
if "%ddd%"=="0" echo 审核系统事件：关闭>>%ipaddr%.txt
if "%ddd%"=="1" echo 审核系统事件：成功>>%ipaddr%.txt
if "%ddd%"=="2" echo 审核系统事件：失败>>%ipaddr%.txt
if "%ddd%"=="3" echo 审核系统事件：成功与失败>>%ipaddr%.txt
for /f "tokens=3" %%d in ('type sec.tmp ^|find "AuditLogonEvents"') do set ddd=%%d
if "%ddd%"=="0" echo 审核登录事件：关闭>>%ipaddr%.txt
if "%ddd%"=="1" echo 审核登录事件：成功>>%ipaddr%.txt
if "%ddd%"=="2" echo 审核登录事件：失败>>%ipaddr%.txt
if "%ddd%"=="3" echo 审核登录事件：成功与失败>>%ipaddr%.txt
for /f "tokens=3" %%d in ('type sec.tmp ^|find "AuditObjectAccess"') do set ddd=%%d
if "%ddd%"=="0" echo 审核对象访问：关闭>>%ipaddr%.txt
if "%ddd%"=="1" echo 审核对象访问：成功>>%ipaddr%.txt
if "%ddd%"=="2" echo 审核对象访问：失败>>%ipaddr%.txt
if "%ddd%"=="3" echo 审核对象访问：成功与失败>>%ipaddr%.txt
for /f "tokens=3" %%d in ('type sec.tmp ^|find "AuditPrivilegeUse"') do set ddd=%%d
if "%ddd%"=="0" echo 审核特权使用：关闭>>%ipaddr%.txt
if "%ddd%"=="1" echo 审核特权使用：成功>>%ipaddr%.txt
if "%ddd%"=="2" echo 审核特权使用：失败>>%ipaddr%.txt
if "%ddd%"=="3" echo 审核特权使用：成功与失败>>%ipaddr%.txt
for /f "tokens=3" %%d in ('type sec.tmp ^|find "AuditPolicyChange"') do set ddd=%%d
if "%ddd%"=="0" echo 审核策略更改：关闭>>%ipaddr%.txt
if "%ddd%"=="1" echo 审核策略更改：成功>>%ipaddr%.txt
if "%ddd%"=="2" echo 审核策略更改：失败>>%ipaddr%.txt
if "%ddd%"=="3" echo 审核策略更改：成功与失败>>%ipaddr%.txt
for /f "tokens=3" %%d in ('type sec.tmp ^|find "AuditAccountManage"') do set ddd=%%d
if "%ddd%"=="0" echo 审核帐户管理：关闭>>%ipaddr%.txt
if "%ddd%"=="1" echo 审核帐户管理：成功>>%ipaddr%.txt
if "%ddd%"=="2" echo 审核帐户管理：失败>>%ipaddr%.txt
if "%ddd%"=="3" echo 审核帐户管理：成功与失败>>%ipaddr%.txt
for /f "tokens=3" %%d in ('type sec.tmp ^|find "AuditProcessTracking"') do set ddd=%%d
if "%ddd%"=="0" echo 审核过程跟踪：关闭>>%ipaddr%.txt
if "%ddd%"=="1" echo 审核过程跟踪：成功>>%ipaddr%.txt
if "%ddd%"=="2" echo 审核过程跟踪：失败>>%ipaddr%.txt
if "%ddd%"=="3" echo 审核过程跟踪：成功与失败>>%ipaddr%.txt
for /f "tokens=3" %%d in ('type sec.tmp ^|find "AuditDSAccess"') do set ddd=%%d
if "%ddd%"=="0" echo 审核目录服务访问：关闭>>%ipaddr%.txt
if "%ddd%"=="1" echo 审核目录服务访问：成功>>%ipaddr%.txt
if "%ddd%"=="2" echo 审核目录服务访问：失败>>%ipaddr%.txt
if "%ddd%"=="3" echo 审核目录服务访问：成功与失败>>%ipaddr%.txt
for /f "tokens=3" %%d in ('type sec.tmp ^|find "AuditAccountLogon"') do set ddd=%%d
if "%ddd%"=="0" echo 审核帐户登录事件：关闭>>%ipaddr%.txt
if "%ddd%"=="1" echo 审核帐户登录事件：成功>>%ipaddr%.txt
if "%ddd%"=="2" echo 审核帐户登录事件：失败>>%ipaddr%.txt
if "%ddd%"=="3" echo 审核帐户登录事件：成功与失败>>%ipaddr%.txt
echo ----------------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------安全审计D、E项，审计报表、审计保护--------->>%ipaddr%.txt
echo D项请自行检查或访谈相关管理员，E项若只使用了windows自身审计功能，则符合，若是用第三方审计工具，请自行检查或访谈相关管理员>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------安全审计F项，日志容量---------------->>%ipaddr%.txt
echo 应用日志信息：>>%ipaddr%.txt
dir C:\WINDOWS\system32\config\software /t:c>sf1.txt
dir C:\WINDOWS\system32\config\software /t:w>sf2.txt
for /f "tokens=1" %%g in ('type sf1.txt ^|find /i " software"') do echo 日志创建时间：%%g>>%ipaddr%.txt
for /f "tokens=1" %%g in ('type sf2.txt ^|find /i " software"') do echo 最后修改时间：%%g>>%ipaddr%.txt
del sf1.txt
del sf2.txt
for /f "tokens=3" %%f in ('REG query HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\EventLog\Application /v MaxSize') do set /a sss=%%f/1024/1024
echo 日志大小：%sss% MB>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo 系统日志信息：>>%ipaddr%.txt
dir C:\WINDOWS\system32\config\system /t:c>st1.txt
dir C:\WINDOWS\system32\config\system /t:w>st2.txt
for /f "tokens=1" %%g in ('type st1.txt ^|find /i " system"') do echo 日志创建时间：%%g>>%ipaddr%.txt
for /f "tokens=1" %%g in ('type st2.txt ^|find /i " system"') do echo 最后修改时间：%%g>>%ipaddr%.txt
del st1.txt
del st2.txt
for /f "tokens=3" %%f in ('REG query HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\EventLog\System /v MaxSize') do set /a sss=%%f/1024/1024
echo 日志大小：%sss% MB>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo 安全日志信息：>>%ipaddr%.txt
dir C:\WINDOWS\system32\config\security /t:c>se1.txt
dir C:\WINDOWS\system32\config\security /t:w>se2.txt
for /f "tokens=1" %%g in ('type se1.txt ^|find /i " security"') do echo 日志创建时间：%%g>>%ipaddr%.txt
for /f "tokens=1" %%g in ('type se2.txt ^|find /i " security"') do echo 最后修改时间：%%g>>%ipaddr%.txt
del se1.txt
del se2.txt
for /f "tokens=3" %%f in ('REG query HKEY_LOCAL_MACHINE\system\CurrentControlSet\Services\EventLog\Security /v maxsize') do set /a sss=%%f/1024/1024
echo 日志大小：%sss% MB>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo =============================================================================>>%ipaddr%.txt
echo 安全审计信息收集完毕
echo.
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
::剩余信息保护配置收集
echo =================================剩余信息保护================================>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo -------------------剩余信息保护A项------------------->>%ipaddr%.txt
for /f "tokens=3" %%s in ('reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System /v dontdisplaylastusername') do set /a lastn=%%s
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System /v dontdisplaylastusername') do echo 现场记录：%%x>>%ipaddr%.txt
if "%lastn%"=="1" echo √已开启“不显示上次的用户名”功能>>%ipaddr%.txt
if "%lastn%"=="0" echo ×没有开启“不显示上次的用户名”功能>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo -------------------剩余信息保护B项------------------->>%ipaddr%.txt
for /f "tokens=3" %%s in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown') do set /a lastn=%%s
for /f "eol=H tokens=1 delims=" %%x in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown') do echo 现场记录：%%x>>%ipaddr%.txt
if "%lastn%"=="1" echo √已开启“关机前清除虚拟内存页面”功能>>%ipaddr%.txt
if "%lastn%"=="0" echo ×没有开启“关机前清除虚拟内存页面”功能>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo =============================================================================>>%ipaddr%.txt
echo 剩余信息保护配置收集完毕
echo.
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
::入侵防范信息收集
echo ===================================入侵防范==================================>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo -------------------入侵防范A、B项-------------------->>%ipaddr%.txt
echo 入侵防范三级A、B项请自行访谈相关管理员>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo -----------入侵防范C项，最小安装、补丁情况----------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo -----------已安装第三方软件----------->>%ipaddr%.txt
for /f "tokens=3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" %%i in ('reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /v displayname /s') do echo %%i %%j %%k %%l %%m %%n %%o %%p %%q %%r %%s %%t %%u %%v %%x %%y>>%ipaddr%.txt
echo -------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo --------------已安装补丁-------------->>%ipaddr%.txt
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Updates" /v InstalledDate /s>re.txt
setlocal enabledelayedexpansion
for /f "tokens=*" %%i in (re.txt) do (
set var=%%i
set "var=!var:HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Updates\=!"
set "var=!var:InstalledDate=更新日期：!"
set "var=!var:   REG_SZ  =!"
set "var=!var:搜索结束: 找到=一共安装了!"
set "var=!var:匹配=个补丁!"
echo !var!>>%ipaddr%.txt
)
del re.txt
echo -------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo -------------------入侵防范电力企标------------------>>%ipaddr%.txt
for /f "tokens=3" %%t in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymousSAM') do set rrr=%%t
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymousSAM') do echo 现场记录：%%x>>%ipaddr%.txt
if "%rrr%"=="0x1" echo √已开启“网络访问：不允许 SAM 帐户的匿名枚举”选项>>%ipaddr%.txt
if "%rrr%"=="0x0" echo ×没有开启“网络访问：不允许 SAM 帐户的匿名枚举”选项>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ------------------------------------------>>%ipaddr%.txt
echo.>>%ipaddr%.txt
for /f "tokens=3" %%t in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymous') do set rrr=%%t
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymous') do echo 现场记录：%%x>>%ipaddr%.txt
if "%rrr%"=="0x1" echo √已开启“网络访问：不允许 SAM 帐户和共享的匿名枚举”选项>>%ipaddr%.txt
if "%rrr%"=="0x0" echo ×没有开启“网络访问：不允许 SAM 帐户和共享的匿名枚举”选项>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo =============================================================================>>%ipaddr%.txt
echo 入侵防范信息收集完毕
echo.
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
::恶意代码防范信息收集
echo =================================恶意代码防范================================>>%ipaddr%.txt
echo 恶意代码防范各测评项请自行检测或访谈相关管理员>>%ipaddr%.txt
echo =============================================================================>>%ipaddr%.txt
echo 恶意代码防范信息收集完毕
echo.
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
::资源控制信息收集
echo ===================================资源控制==================================>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------资源控制A项，限制准入---------------->>%ipaddr%.txt
for /f "tokens=3" %%q in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\Tcpip\parameters /v EnableSecurityFilters') do set tip=%%q
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\ControlSet002\Services\Tcpip\parameters /v EnableSecurityFilters') do echo 现场记录：%%x>>%ipaddr%.txt
if "%tip%"=="0x0" echo ×没有开启“TCP/IP筛选”功能>>%ipaddr%.txt
if "%tip%"=="0x1" echo √已开启“TCP/IP筛选”功能>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------资源控制B项，终端超时---------------->>%ipaddr%.txt
for /f "eol=H tokens=3" %%o in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT" /s') do set ccc=%%o
if "%ccc%" NEQ "" for /f "eol=H tokens=1 delims=" %%x in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT" /s') do echo “为断开的会话设置时间限制”功能现场记录：%%x>>%ipaddr%.txt
if "%ccc%"=="" echo ×没有开启“为断开的会话设置时间限制”功能，所以注册表没有相关键值>>%ipaddr%.txt
for /f "tokens=3" %%o in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT" /s') do set /a ccc=%%o/60000
if "%ccc%" NEQ "" echo √已开启“为断开的会话设置时间限制”功能，断开时间为%ccc%分钟>>%ipaddr%.txt
echo.>>%ipaddr%.txt
for /f "tokens=3" %%c in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverIsSecure') do set ccc=%%c
for /f "tokens=3" %%g in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveTimeOut') do set /a c11=%%g/60
for /f "eol=H tokens=1 delims=" %%x in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverIsSecure') do echo “屏幕保护密码”功能现场记录：%%x>>%ipaddr%.txt
if "%ccc%"=="1" echo √已开启屏幕保护密码，屏幕保护时间为：%c11% 分钟>>%ipaddr%.txt
if "%ccc%" NEQ "1" echo ×没有开启屏幕保护密码>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ---------------------资源控制C项--------------------->>%ipaddr%.txt
echo 资源控制C项请自行检测或访谈相关管理员>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ----------------资源控制D项，磁盘配额---------------->>%ipaddr%.txt
for %%d in (c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) do if exist %%d:\ fsutil quota query %%d:\>>%ipaddr%.txt
echo ----------------------------------------------------->>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo.>>%ipaddr%.txt
echo ---------------------资源控制E项--------------------->>%ipaddr%.txt
echo 资源控制E项请自行检测或访谈相关管理员>>%ipaddr%.txt

echo ********************************************************************************>>%ipaddr%.txt
echo ---------------------2014新加内容--------------------->>%ipaddr%.txt

echo 查看是否禁止IPC空连接,建议将restrictanonymous值设为1>>%ipaddr%.txt
set s=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows" "NT\CurrentVersion\SeCEdit\Reg" "Values\MACHINE/System/CurrentControlSet/Control/Lsa/RestrictAnonymous
reg query   %s% /s >> %ipaddr%.txt

echo 查看icmp重定向报文攻击保护是否设置，搜索enableicmpredirects项是否存在或设置值 >>%ipaddr%.txt
set t=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters
REG query %t% /s >>%ipaddr%.txt

echo 查看当前用户是否禁用多余的启动项。查看在run下面是否在多余启动在系统启用时启动 >>%ipaddr%.txt
REG query HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /s >>%ipaddr%.txt

echo 查看本机其他用户是否禁用多余的启动项。查看在run下面是否在多余启动在系统启用时启动 >>%ipaddr%.txt
REG query HKEY_local_machine\Software\Microsoft\Windows\CurrentVersion\Run /s >>%ipaddr%.txt

echo 查看使系统“运行”选项是否有多余的软件启动 >>%ipaddr%.txt
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /s >>%ipaddr%.txt

echo 查看使系统“运行”选项是否有多余的软件启动 >>%ipaddr%.txt
reg query HKEY_current_user\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /s >>%ipaddr%.txt

echo 查看是否设置防止icmp重定向报文的攻击 ，建议将enableicmpredirects 值设为0 >>%ipaddr%.txt
echo 查看是否启用SYN攻击保护,SynAttackProtect推荐值2 >>%ipaddr%.txt
reg query HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /s >>%ipaddr%.txt

echo.>>%ipaddr%.txt
echo =============================================================================>>%ipaddr%.txt
echo 资源控制信息收集完毕
echo.
del sec.tmp
echo 清除释放的残余文件完毕
echo.
echo 所有核查信息已保存到%ipaddr%.txt，请按任意键关闭本窗口
goto exit222
:win2k8
cls
setlocal enabledelayedexpansion
echo .                                                                         .
echo  ======================= Windows安全核查工具 V1.0 ========================
echo.
echo   Windows2008安全核查工具正在工作，请不要进行任何操作，以免影响结果......
echo.
echo    本程序按照等保三级测评表进行信息收集，若检测二级系统，可自行筛选结果
echo            部分需要访谈的测评项请自行联系相关管理员进行测评
echo      请耐心等候程序执行完毕，期间请不要进行任何操作，以免影响收集结果
echo                          如发现问题，请及时反馈！
echo.
echo  =========================================================================
echo                                                                  Copyright 
echo  =========================================================================
echo .                                                                         .
setlocal
::本机基本信息收集
for /f "tokens=16" %%i in ('ipconfig /all ^| find /i "IPv4"') do set ipaddr=%%i
if "%ipaddr%"=="" set ipaddr=%COMPUTERNAME%
for /f "tokens=15" %%i in ('ipconfig /all ^| find /i "子网掩码"') do set mask=%%i
for /f "tokens=15" %%i in ('ipconfig /all ^| find /i "DNS 服务器"') do set dns=%%i
for /f "delims=" %%i in ('ver') do set vvv=%%i
echo ===================================基本信息==================================>c:\%ipaddr%.txt
echo 计算机名称: %COMPUTERNAME%>>c:\%ipaddr%.txt
echo 当前登陆帐号: %USERNAME%>>c:\%ipaddr%.txt
if "%ipaddr%"=="%COMPUTERNAME%" echo 本机IP: 获取失败，请手动获取>>c:\%ipaddr%.txt
if "%ipaddr%" NEQ "%COMPUTERNAME%" echo 本机IP: %ipaddr%>>c:\%ipaddr%.txt
if "%mask%"=="" echo 本机子网掩码为:获取失败，请手动获取>>c:\%ipaddr%.txt
if "%mask%" NEQ "" echo 本机子网掩码为: %mask%>>c:\%ipaddr%.txt
if "%dns%"=="" echo 本机DNS为:获取失败，请手动获取>>c:\%ipaddr%.txt
if "%dns%" NEQ "" echo 本机DNS为: %dns%>>c:\%ipaddr%.txt
echo 当前执行脚本目录: %CD%>>c:\%ipaddr%.txt
echo 本机操作系统: %vvv%	（5.X为2003系列，6.X为2008系列）>>c:\%ipaddr%.txt
echo 当前操作系统时间与日期(24小时制): %date% %time% >>c:\%ipaddr%.txt
echo =============================================================================>>c:\%ipaddr%.txt
echo.
echo 主机基本信息收集完毕
echo.

echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt

::身份鉴别信息收集
echo ===================================身份鉴别==================================>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------身份鉴别A项，用户信息---------------->>c:\%ipaddr%.txt
for /f "eol=- skip=3 tokens=1,2,3" %%u in ('net user') do if not '%%u'=='命令成功完成。' net user %%u |findstr /i "用户名 帐户启用 帐户到期 密码到期 需要密码 本地组成员">>c:\%ipaddr%.txt&echo.>>c:\%ipaddr%.txt&if not '%%v'=='' net user %%v |findstr /i "用户名 帐户启用 帐户到期 密码到期 需要密码 本地组成员" >>c:\%ipaddr%.txt&echo.>>c:\%ipaddr%.txt&if not '%%w'=='' net user %%w |findstr /i "用户名 帐户启用 帐户到期 密码到期 需要密码 本地组成员">>c:\%ipaddr%.txt&echo.>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------身份鉴别B项，密码策略---------------->>c:\%ipaddr%.txt
secedit /export /cfg c:\sec.tmp>nul
for /f "tokens=3" %%t in ('type c:\sec.tmp ^|find /i "PasswordComplexity"') do echo 密码复杂度：	%%t	（0为关闭，1为开启）>>c:\%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "密码长度最小值"') do echo %%t>>c:\%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "密码最长使用期限"') do echo %%t>>c:\%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "密码最短使用期限"') do echo %%t>>c:\%ipaddr%.txt
for /f "tokens=2" %%t in ('net accounts ^|find /i "保持的密码历史记录长度"') do echo 强制密码历史：%%t 次>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------身份鉴别C项，登陆失败---------------->>c:\%ipaddr%.txt
for /f "tokens=2" %%t in ('net accounts ^|find /i "锁定观测窗口"') do echo 复位帐户锁定计数器（分）：	 %%t>>c:\%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "锁定持续时间"') do echo %%t>>c:\%ipaddr%.txt
for /f "delims=" %%t in ('net accounts ^|find /i "锁定阈值"') do echo %%t>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------身份鉴别D项，传输保密---------------->>c:\%ipaddr%.txt
for /f "delims=" %%t in ('systeminfo ^|find "OS 名称"') do echo %%t>>c:\%ipaddr%.txt
for /f "eol=B delims=" %%t in ('systeminfo ^|find "OS 版本"') do echo %%t>>c:\%ipaddr%.txt
for /f "delims=" %%t in ('systeminfo ^|find "OS 配置"') do echo %%t>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo 说明：注意OS版本即可>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo 说明：F项可参考上面所收集的信息，三级系统G、H项请自行检测或访谈相关管理员>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo =============================================================================>>c:\%ipaddr%.txt
echo 身份鉴别信息收集完毕
echo.

echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt

::访问控制信息收集
echo ===================================访问控制==================================>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt

echo ----------------访问控制A项，权限、共享、服务---------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ------------权限------------>>c:\%ipaddr%.txt
echo cmd.exe权限：>>c:\%ipaddr%.txt
cacls c:\windows\system32\cmd.exe>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo C:\权限：>>c:\%ipaddr%.txt
cacls c:\>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo C:\Program Files权限：>>c:\%ipaddr%.txt
cacls C:\Progra~1>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo 说明：R为读取、W为写入、C为更改、F为完全控制，后者继承前者权限>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ---------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ------------共享------------>>c:\%ipaddr%.txt
echo 存在以下默认共享：>>c:\%ipaddr%.txt
net share |find "$">>c:\%ipaddr%.txt
echo ---------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ------------服务------------>>c:\%ipaddr%.txt
for /f "eol=命 delims=" %%r in ('net start') do echo %%r>>c:\%ipaddr%.txt
echo ---------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ------------------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------访问控制B项，最小授权---------------->>c:\%ipaddr%.txt
for /f "tokens=3" %%t in ('type c:\sec.tmp ^|find /i "SeRemoteShutdownPrivilege"') do set srsp=%%t
for /f "delims=" %%x in ('type c:\sec.tmp ^|find /i "SeRemoteShutdownPrivilege"')  do echo 现场记录：%%x>>c:\%ipaddr%.txt
if "%srsp%"=="*S-1-5-32-544" echo √只有administrators组才能从远端系统强制关机>>c:\%ipaddr%.txt
if "%srsp%" NEQ "*S-1-5-32-544" echo ×不需要administrators组就能从远端系统强制关机>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo 说明：值为S-1-5-32-544时，表示只有administrators组才能使用该功能，若为其他值，则表示不需要administrators组也可以从远端系统强制关机>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------访问控制C、D、E、F、G项---------------->>c:\%ipaddr%.txt
echo 请参考前面的信息或访谈相关管理员>>c:\%ipaddr%.txt
echo ---------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------访问控制电力企标---------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ---------系统失败自动重新启动--------->>c:\%ipaddr%.txt
for /f "tokens=3" %%y in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Crashcontrol" ^|find /i "AutoReboot"') do set yyy=%%y
for /f "eol=H tokens=1 delims=" %%x in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Crashcontrol" ^|find /i "AutoReboot"') do echo 现场记录：%%x>>c:\%ipaddr%.txt
if "%yyy%"=="0x0" echo √已禁止“系统失败自动重新启动”功能>>c:\%ipaddr%.txt
if "%yyy%" NEQ "0x0" echo ×没有禁止“系统失败自动重新启动”功能>>c:\%ipaddr%.txt
echo -------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ---------自动播放--------->>c:\%ipaddr%.txt
for /f "tokens=3" %%j in ('reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\ ^|find /i "NoDriveTypeAutoRun"') do set aua=%%j
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\ ^|find /i "NoDriveTypeAutoRun"') do echo 现场记录：%%x>>c:\%ipaddr%.txt
if "%aua%"=="" echo ×没有禁止“自动播放”功能，所以注册表没有相关键值>>c:\%ipaddr%.txt
if "%aua%"=="0xb5" echo ×已禁止“自动播放”功能，但只禁止了CD-ROM自动播放>>c:\%ipaddr%.txt
if "%aua%"=="0xff" echo √已禁止“自动播放”功能，禁止了所有驱动器的自动播放功能>>c:\%ipaddr%.txt
echo -------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ---------硬盘类型--------->>c:\%ipaddr%.txt
for %%d in (c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) do if exist %%d:\ chkntfs %%d:>>c:\%ipaddr%.txt
echo -------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ---------------------------------------------------->>c:\%ipaddr%.txt

echo.>>c:\%ipaddr%.txt
echo ===================================访问控制==================================>>c:\%ipaddr%.txt
echo 访问控制信息收集完毕
echo.

echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt

::安全审计信息收集
echo ===================================安全审计==================================>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------安全审计A、B、C项，审计策略---------------->>c:\%ipaddr%.txt
for /f "tokens=3" %%d in ('type c:\sec.tmp ^|find "AuditSystemEvents"') do set ddd=%%d
if "%ddd%"=="0" echo 审核系统事件：关闭>>c:\%ipaddr%.txt
if "%ddd%"=="1" echo 审核系统事件：成功>>c:\%ipaddr%.txt
if "%ddd%"=="2" echo 审核系统事件：失败>>c:\%ipaddr%.txt
if "%ddd%"=="3" echo 审核系统事件：成功与失败>>c:\%ipaddr%.txt
for /f "tokens=3" %%d in ('type c:\sec.tmp ^|find "AuditLogonEvents"') do set ddd=%%d
if "%ddd%"=="0" echo 审核登录事件：关闭>>c:\%ipaddr%.txt
if "%ddd%"=="1" echo 审核登录事件：成功>>c:\%ipaddr%.txt
if "%ddd%"=="2" echo 审核登录事件：失败>>c:\%ipaddr%.txt
if "%ddd%"=="3" echo 审核登录事件：成功与失败>>c:\%ipaddr%.txt
for /f "tokens=3" %%d in ('type c:\sec.tmp ^|find "AuditObjectAccess"') do set ddd=%%d
if "%ddd%"=="0" echo 审核对象访问：关闭>>c:\%ipaddr%.txt
if "%ddd%"=="1" echo 审核对象访问：成功>>c:\%ipaddr%.txt
if "%ddd%"=="2" echo 审核对象访问：失败>>c:\%ipaddr%.txt
if "%ddd%"=="3" echo 审核对象访问：成功与失败>>c:\%ipaddr%.txt
for /f "tokens=3" %%d in ('type c:\sec.tmp ^|find "AuditPrivilegeUse"') do set ddd=%%d
if "%ddd%"=="0" echo 审核特权使用：关闭>>c:\%ipaddr%.txt
if "%ddd%"=="1" echo 审核特权使用：成功>>c:\%ipaddr%.txt
if "%ddd%"=="2" echo 审核特权使用：失败>>c:\%ipaddr%.txt
if "%ddd%"=="3" echo 审核特权使用：成功与失败>>c:\%ipaddr%.txt
for /f "tokens=3" %%d in ('type c:\sec.tmp ^|find "AuditPolicyChange"') do set ddd=%%d
if "%ddd%"=="0" echo 审核策略更改：关闭>>c:\%ipaddr%.txt
if "%ddd%"=="1" echo 审核策略更改：成功>>c:\%ipaddr%.txt
if "%ddd%"=="2" echo 审核策略更改：失败>>c:\%ipaddr%.txt
if "%ddd%"=="3" echo 审核策略更改：成功与失败>>c:\%ipaddr%.txt
for /f "tokens=3" %%d in ('type c:\sec.tmp ^|find "AuditAccountManage"') do set ddd=%%d
if "%ddd%"=="0" echo 审核帐户管理：关闭>>c:\%ipaddr%.txt
if "%ddd%"=="1" echo 审核帐户管理：成功>>c:\%ipaddr%.txt
if "%ddd%"=="2" echo 审核帐户管理：失败>>c:\%ipaddr%.txt
if "%ddd%"=="3" echo 审核帐户管理：成功与失败>>c:\%ipaddr%.txt
for /f "tokens=3" %%d in ('type c:\sec.tmp ^|find "AuditProcessTracking"') do set ddd=%%d
if "%ddd%"=="0" echo 审核过程跟踪：关闭>>c:\%ipaddr%.txt
if "%ddd%"=="1" echo 审核过程跟踪：成功>>c:\%ipaddr%.txt
if "%ddd%"=="2" echo 审核过程跟踪：失败>>c:\%ipaddr%.txt
if "%ddd%"=="3" echo 审核过程跟踪：成功与失败>>c:\%ipaddr%.txt
for /f "tokens=3" %%d in ('type c:\sec.tmp ^|find "AuditDSAccess"') do set ddd=%%d
if "%ddd%"=="0" echo 审核目录服务访问：关闭>>c:\%ipaddr%.txt
if "%ddd%"=="1" echo 审核目录服务访问：成功>>c:\%ipaddr%.txt
if "%ddd%"=="2" echo 审核目录服务访问：失败>>c:\%ipaddr%.txt
if "%ddd%"=="3" echo 审核目录服务访问：成功与失败>>c:\%ipaddr%.txt
for /f "tokens=3" %%d in ('type c:\sec.tmp ^|find "AuditAccountLogon"') do set ddd=%%d
if "%ddd%"=="0" echo 审核帐户登录事件：关闭>>c:\%ipaddr%.txt
if "%ddd%"=="1" echo 审核帐户登录事件：成功>>c:\%ipaddr%.txt
if "%ddd%"=="2" echo 审核帐户登录事件：失败>>c:\%ipaddr%.txt
if "%ddd%"=="3" echo 审核帐户登录事件：成功与失败>>c:\%ipaddr%.txt
echo ----------------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------安全审计D、E项，审计报表、审计保护--------->>c:\%ipaddr%.txt
echo D项请自行检查或访谈相关管理员，E项若只使用了windows自身审计功能，则符合，若是用第三方审计工具，请自行检查或访谈相关管理员>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------安全审计F项，日志容量---------------->>c:\%ipaddr%.txt
echo 应用日志信息：>>c:\%ipaddr%.txt
dir C:\WINDOWS\system32\config\software /t:c>c:\sf1.txt
dir C:\WINDOWS\system32\config\software /t:w>c:\sf2.txt
for /f "tokens=1" %%g in ('type c:\sf1.txt ^|find /i " software"') do echo 日志创建时间：%%g>>c:\%ipaddr%.txt
for /f "tokens=1" %%g in ('type c:\sf2.txt ^|find /i " software"') do echo 最后修改时间：%%g>>c:\%ipaddr%.txt
del c:\sf1.txt
del c:\sf2.txt
for /f "tokens=3" %%f in ('REG query HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\EventLog\Application /v MaxSize') do set /a sss=%%f/1024/1024
echo 日志大小：%sss% MB>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo 系统日志信息：>>c:\%ipaddr%.txt
dir C:\WINDOWS\system32\config\system /t:c>c:\st1.txt
dir C:\WINDOWS\system32\config\system /t:w>c:\st2.txt
for /f "tokens=1" %%g in ('type c:\st1.txt ^|find /i " system"') do echo 日志创建时间：%%g>>c:\%ipaddr%.txt
for /f "tokens=1" %%g in ('type c:\st2.txt ^|find /i " system"') do echo 最后修改时间：%%g>>c:\%ipaddr%.txt
del c:\st1.txt
del c:\st2.txt
for /f "tokens=3" %%f in ('REG query HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\EventLog\System /v MaxSize') do set /a sss=%%f/1024/1024
echo 日志大小：%sss% MB>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo 安全日志信息：>>c:\%ipaddr%.txt
dir C:\WINDOWS\system32\config\security /t:c>c:\se1.txt
dir C:\WINDOWS\system32\config\security /t:w>c:\se2.txt
for /f "tokens=1" %%g in ('type c:\se1.txt ^|find /i " security"') do echo 日志创建时间：%%g>>c:\%ipaddr%.txt
for /f "tokens=1" %%g in ('type c:\se2.txt ^|find /i " security"') do echo 最后修改时间：%%g>>c:\%ipaddr%.txt
del c:\se1.txt
del c:\se2.txt
for /f "tokens=3" %%f in ('REG query HKEY_LOCAL_MACHINE\system\CurrentControlSet\Services\EventLog\Security /v maxsize') do set /a sss=%%f/1024/1024
echo 日志大小：%sss% MB>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo =============================================================================>>c:\%ipaddr%.txt
echo 安全审计信息收集完毕
echo.
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
::剩余信息保护配置收集
echo =================================剩余信息保护================================>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo -------------------剩余信息保护A项------------------->>c:\%ipaddr%.txt
for /f "tokens=3" %%s in ('reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System /v dontdisplaylastusername') do set /a lastn=%%s
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System /v dontdisplaylastusername') do echo 现场记录：%%x>>c:\%ipaddr%.txt
if "%lastn%"=="1" echo √已开启“不显示上次的用户名”功能>>c:\%ipaddr%.txt
if "%lastn%"=="0" echo ×没有开启“不显示上次的用户名”功能>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo -------------------剩余信息保护B项------------------->>c:\%ipaddr%.txt
for /f "tokens=3" %%s in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown') do set /a lastn=%%s
for /f "eol=H tokens=1 delims=" %%x in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown') do echo 现场记录：%%x>>c:\%ipaddr%.txt
if "%lastn%"=="1" echo √已开启“关机前清除虚拟内存页面”功能>>c:\%ipaddr%.txt
if "%lastn%"=="0" echo ×没有开启“关机前清除虚拟内存页面”功能>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo =============================================================================>>c:\%ipaddr%.txt
echo 剩余信息保护配置收集完毕
echo.
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
::入侵防范信息收集
echo ===================================入侵防范==================================>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo -------------------入侵防范A、B项-------------------->>c:\%ipaddr%.txt
echo 入侵防范三级A、B项请自行访谈相关管理员>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo -----------入侵防范C项，最小安装、补丁情况----------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo -----------已安装第三方软件----------->>c:\%ipaddr%.txt
for /f "tokens=3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" %%i in ('reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /v displayname /s') do echo %%i %%j %%k %%l %%m %%n %%o %%p %%q %%r %%s %%t %%u %%v %%x %%y>>c:\%ipaddr%.txt
echo -------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo --------------已安装补丁-------------->>c:\%ipaddr%.txt
echo On Error Resume Next>c:\updd.vbs
echo Set objSession = CreateObject("Microsoft.Update.Session")>>c:\updd.vbs
echo Set objSearcher = objSession.CreateUpdateSearcher>>c:\updd.vbs
echo intHistoryCount = objSearcher.GetTotalHistoryCount>>c:\updd.vbs
echo Set colHistory = objSearcher.QueryHistory(0, intHistoryCount)>>c:\updd.vbs
echo if err ^<^> 0 then>>c:\updd.vbs
echo Wscript.Quit>>c:\updd.vbs
echo end if>>c:\updd.vbs
echo Set objFS = CreateObject("Scripting.FileSystemObject")>>c:\updd.vbs
echo Set objNewFile = objFS.CreateTextFile("c:\update.tmp1")>>c:\updd.vbs
echo For Each objEntry in colHistory>>c:\updd.vbs
echo objNewFile.WriteLine  "补丁号" ^& objEntry.Title ^&"  安装时间" ^& objEntry.Date ^& "  详细描述" ^&objEntry.Description>>c:\updd.vbs
echo objNewFile.WriteLine>>c:\updd.vbs
echo Next>>c:\updd.vbs
echo objNewFile.Close>>c:\updd.vbs
cscript c:\updd.vbs>nul
if exist c:\update.tmp1 type c:\update.tmp1>>c:\%ipaddr%.txt
if not exist c:\update.tmp1 wmic qfe list full>c:\windows\temp\dd1dd.txt
type c:\windows\temp\dd1dd.txt |findstr /i "HotFixID InstalledOn">>c:\%ipaddr%.txt
if exist c:\update.tmp1 del c:\update.tmp1
if exist c:\updd.vbs del c:\updd.vbs
if exist c:\dd1dd.txt del c:\dd1dd.txt
echo -------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo -------------------入侵防范电力企标------------------>>c:\%ipaddr%.txt
for /f "tokens=3" %%t in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymousSAM') do set rrr=%%t
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymousSAM') do echo 现场记录：%%x>>c:\%ipaddr%.txt
if "%rrr%"=="0x1" echo √已开启“网络访问：不允许 SAM 帐户的匿名枚举”选项>>c:\%ipaddr%.txt
if "%rrr%"=="0x0" echo ×没有开启“网络访问：不允许 SAM 帐户的匿名枚举”选项>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ------------------------------------------>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
for /f "tokens=3" %%t in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymous') do set rrr=%%t
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKLM\SYSTEM\CurrentControlSet\Control\LSA /v RestrictAnonymous') do echo 现场记录：%%x>>c:\%ipaddr%.txt
if "%rrr%"=="0x1" echo √已开启“网络访问：不允许 SAM 帐户和共享的匿名枚举”选项>>c:\%ipaddr%.txt
if "%rrr%"=="0x0" echo ×没有开启“网络访问：不允许 SAM 帐户和共享的匿名枚举”选项>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo =============================================================================>>c:\%ipaddr%.txt
echo 入侵防范信息收集完毕
echo.
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
::恶意代码防范信息收集
echo =================================恶意代码防范================================>>c:\%ipaddr%.txt
echo 恶意代码防范各测评项请自行检测或访谈相关管理员>>c:\%ipaddr%.txt
echo =============================================================================>>c:\%ipaddr%.txt
echo 恶意代码防范信息收集完毕
echo.
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
::资源控制信息收集
echo ===================================资源控制==================================>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------资源控制A项，限制准入---------------->>c:\%ipaddr%.txt
for /f "tokens=3" %%q in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\services\SharedAccess\Parameters\FirewallPolicy\PublicProfile /v EnableFirewall') do set tip=%%q
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\services\SharedAccess\Parameters\FirewallPolicy\PublicProfile /v EnableFirewall') do echo 现场记录：%%x>>c:\%ipaddr%.txt
if "%tip%"=="0x0" echo ×没有开启“windows防火墙功能”功能>>c:\%ipaddr%.txt
if "%tip%"=="0x1" echo √已开启“windows防火墙功能”功能>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
for /f "tokens=3" %%q in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\FirewallRules /v RemoteDesktop-In-TCP ^|find /i "true"') do set tip1=%%q
for /f "eol=H tokens=1 delims=" %%x in ('reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\FirewallRules /v RemoteDesktop-In-TCP') do echo 现场记录：%%x>>c:\%ipaddr%.txt
if "%tip1%"=="" echo ×没有开启默认“3389远程协助入站规则”>>c:\%ipaddr%.txt
if "%tip1%" NEQ "" echo √已开启默认“3389远程协助入站规则”>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo 说明：windows2008已经用“windows防火墙功能”代替掉了“TCP/IP筛选”功能，顾此项检查内容更改为检查服务器是否开启“windows防火墙”和是否开启默认的“3389远程协助入站规则”。>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo 注意：即便开启了默认“3389远程协助入站规则”，没有开启“windows防火墙”，该项仍为不符合。有时可能管理员会自己添加“3389远程协助入站规则”，顾此项有时需要询问相关管理员，以确定该项是否符合。>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------资源控制B项，终端超时---------------->>c:\%ipaddr%.txt
for /f "tokens=3" %%o in ('reg query "HKlm\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"') do set ccc=%%o
if "%ccc%" NEQ "" for /f "eol=H tokens=1 delims=" %%x in ('reg query "HKlm\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"') do echo “为断开的会话设置时间限制”功能现场记录：%%x>>c:\%ipaddr%.txt
if "%ccc%"=="" echo ×没有开启“为断开的会话设置时间限制”功能，所以注册表没有相关键值>>c:\%ipaddr%.txt
for /f "tokens=3" %%o in ('reg query "HKlm\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"') do set /a ccc=%%o/60000
if "%ccc%" NEQ "" echo √已开启“为断开的会话设置时间限制”功能，断开时间为%ccc%分钟>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
for /f "tokens=3" %%c in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverIsSecure') do set ccc=%%c
for /f "tokens=3" %%g in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaveTimeOut') do set /a c11=%%g/60
for /f "eol=H tokens=1 delims=" %%x in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v ScreenSaverIsSecure') do echo “屏幕保护密码”功能现场记录：%%x>>c:\%ipaddr%.txt
if "%ccc%"=="1" echo √已开启屏幕保护密码，屏幕保护时间为：%c11% 分钟>>c:\%ipaddr%.txt
if "%ccc%" NEQ "1" echo ×没有开启屏幕保护密码>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ---------------------资源控制C项--------------------->>c:\%ipaddr%.txt
echo 资源控制C项请自行检测或访谈相关管理员>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ----------------资源控制D项，磁盘配额---------------->>c:\%ipaddr%.txt
for %%d in (c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) do if exist %%d:\ fsutil quota query %%d:\>>c:\%ipaddr%.txt
echo ----------------------------------------------------->>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo ---------------------资源控制E项--------------------->>c:\%ipaddr%.txt
echo 资源控制E项请自行检测或访谈相关管理员>>c:\%ipaddr%.txt
echo ********************************************************************************>>%ipaddr%.txt
echo ---------------------2014新加内容--------------------->>%ipaddr%.txt

echo 查看是否禁止IPC空连接,建议将restrictanonymous值设为1>>%ipaddr%.txt
set s=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows" "NT\CurrentVersion\SeCEdit\Reg" "Values\MACHINE/System/CurrentControlSet/Control/Lsa/RestrictAnonymous
reg query   %s% /s >> %ipaddr%.txt

echo 查看icmp重定向报文攻击保护是否设置，搜索enableicmpredirects项是否存在或设置值 >>%ipaddr%.txt
REG query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /s >>%ipaddr%.txt

echo 查看当前用户是否禁用多余的启动项。查看在run下面是否在多余启动在系统启用时启动 >>%ipaddr%.txt
REG query HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run /s >>%ipaddr%.txt

echo 查看本机其他用户是否禁用多余的启动项。查看在run下面是否在多余启动在系统启用时启动 >>%ipaddr%.txt
REG query HKEY_local_machine\Software\Microsoft\Windows\CurrentVersion\Run /s >>%ipaddr%.txt

echo 查看使系统“运行”选项是否有多余的软件启动 >>%ipaddr%.txt
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /s >>%ipaddr%.txt

echo 查看使系统“运行”选项是否有多余的软件启动 >>%ipaddr%.txt
reg query HKEY_current_user\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /s >>%ipaddr%.txt

echo 查看是否启用SYN攻击保护 >>%ipaddr%.txt
reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Network /s >>%ipaddr%.txt

echo 查看是否设置防止icmp重定向报文的攻击 ，建议将enableicmpredirects 值设为0 >>%ipaddr%.txt
reg query HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /s >>%ipaddr%.txt
echo.>>c:\%ipaddr%.txt
echo =============================================================================>>c:\%ipaddr%.txt
echo 资源控制信息收集完毕
echo.
del c:\sec.tmp
echo 清除释放的残余文件完毕
echo.
echo 所有核查信息已保存到c:\%ipaddr%.txt，请按任意键关闭本窗口
:exit222
pause>nul
