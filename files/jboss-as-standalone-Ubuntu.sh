#!/bin/bash  
### BEGIN INIT INFO  
# Provides:          jbossas7  
# Required-Start:    $local_fs $remote_fs $network $syslog  
# Required-Stop:     $local_fs $remote_fs $network $syslog  
# Default-Start:     2 3 4 5  
# Default-Stop:      0 1 6  
# Short-Description: Start/Stop JBoss AS 7  
### END INIT INFO  
# chkconfig: 35 92 1  
  
## Include some script files in order to set and export environmental variables  
## as well as add the appropriate executables to $PATH.  
[ -r /etc/profile.d/java.sh ] && . /etc/profile.d/java.sh  
[ -r /etc/profile.d/jboss.sh ] && . /etc/profile.d/jboss.sh  
  
JBOSS_HOME=/usr/share/jboss-as 
  
AS7_OPTS="$AS7_OPTS -Dorg.apache.tomcat.util.http.ServerCookie.ALLOW_HTTP_SEPARATORS_IN_V0=true"   ## See AS7-1625  
AS7_OPTS="$AS7_OPTS -Djboss.bind.address.management=0.0.0.0"  
AS7_OPTS="$AS7_OPTS -Djboss.bind.address=0.0.0.0"  
  
case "$1" in  
    start)  
        echo "Starting JBoss AS 7..."  
        #sudo -u jboss sh ${JBOSS_HOME}/bin/standalone.sh $AS7_OPTS           ##  If running as user "jboss"  
        #start-stop-daemon --start --quiet --background --chuid jboss --exec ${JBOSS_HOME}/bin/standalone.sh -- $AS7_OPTS   ## Ubuntu  
        ${JBOSS_HOME}/bin/standalone.sh $AS7_OPTS &  
    ;;  
    stop)  
        echo "Stopping JBoss AS 7..."  
        #sudo -u jboss sh ${JBOSS_HOME}/bin/jboss-admin.sh --connect command=:shutdown            ##  If running as user "jboss"  
        #start-stop-daemon --start --quiet --background --chuid jboss --exec ${JBOSS_HOME}/bin/jboss-admin.sh -- --connect command=:shutdown     ## Ubuntu  
        ${JBOSS_HOME}/bin/jboss-cli.sh --connect command=:shutdown  
    ;;  
    *)  
        echo "Usage: /etc/init.d/jbossas7 {start|stop}"; exit 1;  
    ;;  
esac  
  
exit 0  