@echo off
 title 创建IP安全策略，屏蔽135、139 . . . 等端口 (win7)
 echo “正在关闭,请等待”
netsh ipsec static add policy name=qianye
 netsh ipsec static add filterlist name=Filter1
 netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=135 protocol=TCP
 echo “135端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=139 protocol=TCP
 echo “139端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=137 protocol=TCP
 echo “137端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=443 protocol=TCP
 echo “443端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=445 protocol=TCP
 echo “445端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=902 protocol=TCP
 echo “902端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=912 protocol=TCP
 echo “912端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=3306 protocol=TCP
 echo “3306端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=3389 protocol=TCP
 echo “3389端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=1443 protocol=TCP
 echo “1443端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=1444 protocol=TCP
 echo “1444端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=1521 protocol=TCP
 echo “1521端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=8010 protocol=TCP
 echo “8010端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=8081 protocol=TCP
 echo “8081端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=8084 protocol=TCP
 echo “8084端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=16992 protocol=TCP
 echo “16992端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49152 protocol=TCP
 echo “49152端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49153 protocol=TCP
 echo “49153端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49154 protocol=TCP
 echo “49154端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49155 protocol=TCP
 echo “49155端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49158 protocol=TCP
 echo “49158端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49159 protocol=TCP
 echo “49159端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49160 protocol=TCP
 echo “49160端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=21 protocol=TCP
 echo “21端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49156 protocol=TCP
 echo “49156端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=5357 protocol=TCP
 echo “5357端口已经关闭”
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=135 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=139 protocol=UDP  
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=137 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=443 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=445 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=902 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=912 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=3306 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=3389 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=1443 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=1521 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=5357 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=8010 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=8081 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=8084protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=16992 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49152 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49153 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49154 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49155 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49158 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49159 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49160 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=49156 protocol=UDP
netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=21 protocol=UDP
 netsh ipsec static add filter filterlist=Filter1 srcaddr=any dstaddr=Me dstport=1444 protocol=UDP
 netsh ipsec static add filteraction name=FilteraAtion1 action=block
 netsh ipsec static add rule name=Rule1 policy=qianye filterlist=Filter1 filteraction=FilteraAtion1
 netsh ipsec static set policy name=qianye assign=y
 echo “恭喜您，危险端口已经关闭” 
echo “按任意键退出 ” 
pause
