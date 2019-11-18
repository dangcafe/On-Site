@echo off

echo "=========================应设为0======================"
Reg Query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer"
set key="HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareServer"
reg add %key% /t REG_DWORD /d 0x0 /f

echo "=========================应设为0======================"
Reg Query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWKS"
set key="HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWKS"
reg add %key% /t REG_DWORD /d 0x0 /f

echo "=========================应设为0======================"
Reg Query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon"
set key="HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" /v "AutoAdminLogon"
reg add %key% /t REG_DWORD /d 0x0 /f

echo "=========================应设为0======================"
Reg Query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery"
set key="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery"
reg add %key% /t REG_DWORD /d 0x0 /f

echo "=========================应设为1======================"
Reg Query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SynAttackProtect"
set key="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SynAttackProtect"
reg add %key% /t REG_DWORD /d 0x1 /f

echo "=========================应设为0x1f4======================"
Reg Query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxHalfOpen"
set key="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxHalfOpen"
reg add %key% /t REG_DWORD /d 0x1f4 /f

echo "=========================应设为0x190======================"
Reg Query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxHalfOpenRetried"
set key="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxHalfOpenRetried"
reg add %key% /t REG_DWORD /d 0x190 /f

echo "=========================应设为0x5======================"
Reg Query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxPortsExhausted"
set key="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxPortsExhausted"
reg add %key% /t REG_DWORD /d 0x5 /f

echo "=========================应设为1======================"
Reg Query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableIPSourceRouting"
set key="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableIPSourceRouting"
reg add %key% /t REG_DWORD /d 0x1 /f

echo "=========================应设为0======================"
Reg Query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect"
set key="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" 
for /f "tokens=3* delims= " %%a in ('reg query %key%') do set v=%%a
if not "%v%"=="0x0" reg add %key% /t REG_DWORD /d 0x0 /f

echo "=========================应设为1======================"
Reg Query "HKEY_LOCAL_MACHINE\system\currentcontrolset\control\lsa" /v "restrictanonymous"
set key="HKEY_LOCAL_MACHINE\system\currentcontrolset\control\lsa" /v "restrictanonymous" 
for /f "tokens=3* delims= " %%a in ('reg query %key%') do set v=%%a
if not "%v%"=="0x1" reg add %key% /t REG_DWORD /d 0x1 /f

pause
