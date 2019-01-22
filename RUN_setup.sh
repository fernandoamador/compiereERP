#!/bin/sh
# Copyright 1999-2009 Compiere, Inc.
# $Id: RUN_setup.sh 7717 2009-05-28 05:15:56Z freyes $

echo Install Compiere Server

if [ $JAVA_HOME ]; then
  JAVA=$JAVA_HOME/bin/java
  KEYTOOL=$JAVA_HOME/bin/keytool
else
  JAVA=java
  KEYTOOL=keytool
  echo JAVA_HOME is not set.
  echo You may not be able to start the Setup
  echo Set JAVA_HOME to the directory of your local JDK6.
fi

echo ===================================
echo Setup Dialog
echo ===================================
CP=lib/CInstall.jar:lib/CompiereInstall.jar:lib/jPDF.jar:lib/CCTools.jar:lib/oracle.jar:lib/jboss.jar:lib/db2.jar:lib/postgreSQL.jar:lib\sqlServer.jar

# Trace Level Parameter, e.g. ARGS=ALL
ARGS=CONFIG

# Compiere requires internet connection to install. Uncomment and edit the line below if you are using a Proxy server
#PROXY_OPTIONS=-Dhttp.proxyHost=xxx -Dhttp.proxyPort=##

$JAVA -Xmx258m -classpath $CP $PROXY_OPTIONS -DCOMPIERE_HOME=$COMPIERE_HOME org.compiere.install.Setup $ARGS


#echo ===================================
#echo Setup Compiere Server Environment
#echo ===================================
#$JAVA -classpath $CP -DCOMPIERE_HOME=$COMPIERE_HOME -Dant.home="." org.apache.tools.ant.launch.Launcher setup


echo ===================================
echo Make .sh executable & set Env
echo ===================================
chmod -R a+x *.sh
find . -name '*.sh' -exec chmod a+x '{}' \;

. utils/RUN_UnixEnv.sh

#echo ================================
#echo	Test local Connection
#echo ================================
#%JAVA% -classpath lib/Compiere.jar:lib/CompiereCLib.jar org.compiere.install.ConnectTest localhost

echo .
echo For problems, check log file in base directory
