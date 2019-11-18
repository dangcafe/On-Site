#/bin/sh
#
# . ###########################################################
#
# Local Information gather Script for Linux
#
# Note: I write it based on RedHat, you should change it to your
# taste for other Linux release. 

# $Id: Linux_local_info_gather.sh,v 1.4.3 2 $
#
# . ############################################################
mkdir /tmp/safeee
clear
echo
echo " ____________________________________________________________________ "
echo "|                                                                    |"
echo "|       бя Local Information gather Script for Linux                 |"
echo "|                                                                    |"
echo "|____________________________________________________________________|"
echo
echo
echo "STARTING >>>>>>"
echo
echo "Running Time: `date |awk '{print $6" "$2" "$3" "$4}'`"
echo
echo "######################################################################"
echo

# > ############################################################

echo -n "Step 1."
echo "  Hi, r u root?"


if [ -f /usr/bin/id ]; then
/usr/bin/id |grep "uid=0" >/dev/null 2>&1
  if [ $? -eq 0 ] ; then
     echo "         yes, I am root."
     else
     echo "         Please su root first."
     exit
  fi
else 
echo "Please check /usr/bin/id, it is not exist."
exit
fi

# >> ###########################################################

echo
echo -n "Step 2."
echo "  Backup original PATH variable, use own PATH at this time."


echo $PATH >/tmp/safeee/.PATH
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin/X11:/usr/X11R6/bin:/usr/ccs/bin
export PATH

# >>> ##########################################################

echo
echo -n "Step 3."
echo "  Please change to /tmp/safeee directory to see the REPORT."


RUNTIME=`date |awk '{print $6" "$2" "$3" "$4}'`
REPORTMAINDIR=/tmp/safeee
REPORTMAINFILE=$REPORTMAINDIR/report.`uname -s`.`/sbin/ifconfig -a |grep inet |grep -v "127.0.0.1" |awk '{print $2}' |head -n 1`.log

  
if [ -d "$REPORTMAINDIR" ] ; then
   echo "         Reportmaindir OK"
else
   echo -n "         Make Reportmaindir..."
   mkdir $REPORTMAINDIR
   chmod 775 $REPORTMAINDIR
   echo "    [ OK ]"
fi

# >>>> #########################################################

echo
echo -n "Step 4."
echo "  Information gathering..."
echo

echo " ____________________________________________________________________ " >$REPORTMAINFILE
echo "|                                                                    |" >>$REPORTMAINFILE
echo "|       бя Local Information gather REPORT for Linux                 |" >>$REPORTMAINFILE
echo "|____________________________________________________________________|" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "Generate Time: $RUNTIME" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE

######

HOSTNAME=`hostname`
DOMAINNAME=`domainname`
OSTYEP=`uname -s`" "`uname -p`" "`uname -r`
OS=`uname -s`
UPTIME=`uptime`
DATE=`date`
MAINIPADD=`/sbin/ifconfig -a |grep inet |grep -v "127.0.0.1" |awk '{print $2}' |head -n 1`
MAINNETMASK=`/sbin/ifconfig -a |grep inet |grep -v "127.0.0.1" |awk '{print $4}' |head -n 1`
MAINBROADCAST=`/sbin/ifconfig -a |grep inet |grep -v "127.0.0.1" |awk '{print $6}' |head -n 1`
ROUTETABLE=`netstat -nr`
DNSADDR=`cat /etc/resolv.conf |grep nameserver | awk '{ print $2 }'`
BASH=`env x='() { :;}; echo vulnerable' bash -c "echo this is a test"`

######

echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= Basic Information =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE

echo -n "Checking OS..."
echo "OS: $OS" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking BASH..."
echo "BASH: $BASH" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking hostname..."
echo "HostName: $HOSTNAME" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking domainname..."
echo "DomainName: $DOMAINNAME" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking dnsdomainname..."
echo "dnsdomainname: `hostname`" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking nisdomainname..."
echo "nisdomainname: `nisdomainname`" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking ypdomainname..."
echo "ypdomainname: `ypdomainname`" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking nodename..."
echo "nodename: `nodename`" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking ostype..."
echo "OsType: $OSTYEP" >>$REPORTMAINFILE
echo "issus: `cat /etc/issue`" >>$REPORTMAINFILE
echo "issus: `cat /etc/issus.net`" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking uptime..."
echo "Uptime: $UPTIME" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE


echo -n "Checking date..."
echo "DATE: $DATE" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE


echo -n "Checking hostmainip..."
echo "HostMainIP: $MAINIPADD" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking mainnetmask..."
echo "MainNetMask: $MAINNETMASK" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking mainbroadcast..."
echo "MainBroadCast: $MAINBROADCAST" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking othernetinfo..."
/sbin/ifconfig -a |grep inet |grep -v "127.0.0.1" |grep -v $MAINIPADD >/dev/null 2>&1
if [ $? -ne 0 ];then 
echo "OtherNetInfo = NONE" >>$REPORTMAINFILE
else
echo "OtherNetInfo :" >>$REPORTMAINFILE
OTHERNETINFO=`/sbin/ifconfig -a |grep inet |grep -v "127.0.0.1" |grep -v $MAINIPADD 2>/dev/null`
echo $OTHERNETINFO >>$REPORTMAINFILE
fi
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking route table..."
echo "RouteTable: $ROUTETABLE" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking DNS address..."
echo "DNSAddress: $DNSADDR" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking syspath variable..."
echo "SysPath: `cat /tmp/safeee/.PATH`" >>$REPORTMAINFILE
echo "    [ OK ]"
echo "" >>$REPORTMAINFILE

echo -n "Checking gcc..."
which gcc >/dev/null 2>&1
if [ $? -eq 0 ];then
echo "GccPath: `which gcc`" >>$REPORTMAINFILE
else
echo "GccPath: NO Gcc installed." >>$REPORTMAINFILE
fi
echo "    [ OK ]"

######

echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= Accounts Password Information =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE



echo -n "Checking /etc/login.defs file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/login.defs File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/login.defs ];then
grep -v "^#" /etc/login.defs >>$REPORTMAINFILE
else
echo "no /etc/login.defs file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"




echo -n "Checking pam_tally2.so file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "pam_tally2.so File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
find /lib64/ -name pam_tally*.so
if [ -f /lib64/security/pam_tally2.so ];then
echo "" >>$REPORTMAINFILE
else
echo "no pam_tally2.so file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"


echo -n "Checking /etc/pam.d/system-auth ..." 
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/pam.d/system-auth "  >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
cat /etc/pam.d/system-auth >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking umask..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "Umask Current Value   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
echo "Umask = `umask 2>/dev/null`" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo "**********************************************************************" >>$REPORTMAINFILE
echo "File/Directory Permission Information    " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "/etc/passwd group shadow    " >>$REPORTMAINFILE
echo "_____________________________________________________________________" >>$REPORTMAINFILE
ls -al /etc/passwd >>$REPORTMAINFILE 2>/dev/null
echo "" >>$REPORTMAINFILE
ls -al /etc/group >>$REPORTMAINFILE 2>/dev/null
echo "" >>$REPORTMAINFILE
ls -al /etc/shadow >>$REPORTMAINFILE 2>/dev/null
echo "" >>$REPORTMAINFILE

echo -n "Checking chkconfig information..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "Chkconfig Information" >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
chkconfig --list >>$REPORTMAINFILE 2>/dev/null
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking /etc/xinetd.conf file (uncomment lines)..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/xinetd.conf File Content " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/xinetd.conf ];then
cat /etc/xinetd.conf >>$REPORTMAINFILE
else
echo "no /etc/xinetd.conf file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

a=`ls /etc/xinetd.d`
for i in $a;do
echo -n "Checking /etc/xinetd.d/$i  file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/xinetd.d/$i  File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
cat /etc/xinetd.d/$i >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"
done
echo "" >>$REPORTMAINFILE


#ftpusers
echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= FTPD Information =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo -n "Checking /etc/ftpusers file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/ftpusers File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/ftpusers ];then
cat /etc/ftpusers >>$REPORTMAINFILE
else
echo "no /etc/ftpusers file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking vsftpd.conf file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/vsftpd.conf File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/vsftpd.conf ];then
grep -v "^#" /etc/vsftpd.conf >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/vsftpd.user File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
grep -v "^#" /etc/vsftpd.user>>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/vsftpd.user_list File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
cat /etc/vsftpd.user_list>>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/vsftpd.chroot_list File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
grep -v "^#" /etc/vsftpd.chroot_list>>$REPORTMAINFILE
else
echo "no /etc/vsftpd.conf file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking /etc/security/limits.conf file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/security/limits.conf File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/security/limits.conf ];then
grep -v "^#" /etc/security/limits.conf >>$REPORTMAINFILE
else
echo "no /etc/security/limits.conf" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

######sshd
echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= SSHD Information =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo -n "Checking /etc/ssh/sshd_config file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/ssh/sshd_config File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/ssh/sshd_config ];then
grep -v "^#" /etc/ssh/sshd_config >>$REPORTMAINFILE
else
echo "no /etc/ssh/sshd_config file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking /etc/ssh2/sshd2_config file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/ssh2/sshd2_config File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/ssh2/sshd2_config ];then
grep -v "^#" /etc/ssh2/sshd2_config >>$REPORTMAINFILE
else
echo "no /etc/ssh2/sshd2_config file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking /etc/security/console.perms..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/security/console.perms File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/security/console.perms ];then
grep -v "^#" /etc/security/console.perms >>$REPORTMAINFILE
else
echo "no /etc/security/console.perms" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"




echo -n "Checking /etc/passwd file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/passwd File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
cat /etc/passwd >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking /etc/shadow file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/shadow File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/shadow ];then
cat /etc/shadow >>$REPORTMAINFILE
else
echo "no /etc/shadow file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking /etc/group file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/group File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/group ];then
cat /etc/group >>$REPORTMAINFILE
else 
echo "no /etc/group file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking /etc/gshadow file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/gshadow File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/gshadow ];then
cat /etc/gshadow >>$REPORTMAINFILE
else
echo "no /etc/gshadow file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking uid=0 accounts..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "uid=0 accounts   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
awk -F: '{if ($3=="0") print $1}' /etc/passwd >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking no password accounts..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "No Password Accounts   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
awk -F: '{if ($2=="") print $1}' /etc/passwd >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"


echo -n "Checking /etc/profile file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/profile File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/profile ];then
cat /etc/profile >>$REPORTMAINFILE
else
echo "no /etc/profile file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"





######



######

echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= Process Information =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE

echo -n "Checking process status information..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "Process Status Information    " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
ps -auxww >>$REPORTMAINFILE 2>/dev/null
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

######

echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= Network Information =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE


echo -n "Checking /etc/inetd.conf file (uncomment lines)..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/inetd.conf File Content (uncomment lines) " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/inetd.conf ];then
cat /etc/inetd.conf | grep -v "#" >>$REPORTMAINFILE
else
echo "no /etc/inetd.conf file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"





echo -n "Checking netstat information..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "Listening netstat Information" >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
netstat -na >>$REPORTMAINFILE 2>/dev/null
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking listening server services information..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "Listening Server Services Information" >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
netstat -nalpe | grep LISTEN >>$REPORTMAINFILE 2>/dev/null
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"



echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= Syslog Information =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE

echo -n "Checking /etc/rsyslog.conf file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/rsyslog.conf File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/rsyslog.conf ];then
grep -v "^#" /etc/rsyslog.conf >>$REPORTMAINFILE
else
echo "no /etc/rsyslog.conf file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"


echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= logrotate.conf Information =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo -n "Checking /etc/logrotate.conf file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/logrotate.conf File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/logrotate.conf ];then
cat /etc/logrotate.conf >>$REPORTMAINFILE
else
echo "no /etc/logrotate.conf file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= history =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo -n "Checking bash_history file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "history File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /.bash_history ];then
ls -al /.bash_history >>$REPORTMAINFILE
else
echo "no .bash_history file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

echo -n "Checking /etc/syslog.conf file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/syslog.conf File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
if [ -f /etc/syslog.conf ];then
grep -v "^#" /etc/syslog.conf >>$REPORTMAINFILE
else
echo "no /etc/syslog.conf file" >>$REPORTMAINFILE
fi
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"



echo "**********************************************************************" >>$REPORTMAINFILE
echo "/var/log/secure" >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
tail -50 /var/log/secure >>$REPORTMAINFILE
echo "_____________________________________________________________________" >>$REPORTMAINFILE


echo "**********************************************************************" >>$REPORTMAINFILE
echo "/var/log/wtmp" >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
last -n 50 -f /var/log/wtmp >>$REPORTMAINFILE
echo "_____________________________________________________________________" >>$REPORTMAINFILE


echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
ls -al /etc/rsyslog.conf >>$REPORTMAINFILE 2>/dev/null
ls -al /etc/syslog.conf >>$REPORTMAINFILE 2>/dev/null
ls -al /etc/crontab >>$REPORTMAINFILE 2>/dev/null
ls -al /var/log/>>$REPORTMAINFILE 2>/dev/null
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"

######

echo "_____________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "-= Packages/Patches Information =-" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE

echo -n "Checking packages installed information..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "Packages Installed Information" >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
rpm -qa >>$REPORTMAINFILE 2>/dev/null
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"


#####hosts

if [ -f /etc/hosts.allow ];then
echo -n "Checking /etc/hosts.allow file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/hosts.allow File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
cat /etc/hosts.allow >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"
fi

if [ -f /etc/hosts.deny ];then
echo -n "Checking /etc/hosts.deny file..."
echo "**********************************************************************" >>$REPORTMAINFILE
echo "/etc/hosts.deny File Content   " >>$REPORTMAINFILE
echo "**********************************************************************" >>$REPORTMAINFILE
cat /etc/hosts.deny >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "    [ OK ]"
fi

env x='() { :;}; echo vulnerable' bash -c "echo this is a test"

# >>>>> #################################################################### >>>>> ###################################################################

echo
echo -n "Step 5."
echo "  ALL Done."


PATH=`cat /tmp/safeee/.PATH`
export PATH

echo "______________________________________________________________________" >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "ALL Done." >>$REPORTMAINFILE
echo "" >>$REPORTMAINFILE
echo "______________________________________________________________________" >>$REPORTMAINFILE

echo "######################################################################"
echo ""
echo "ALL Done."
echo ""
echo "######################################################################"
echo "Please read report $REPORTMAINFILE for more details."
echo

######

# >>>>> ###################################################################

#echo
#echo -n "Step 6."
#echo "  Receive Reports."

    
rm -r $0

exit 0
