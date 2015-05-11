#!/bin/bash
cd /opt/tomcat_mzcms/webapps
rsync -avz -e ssh root@dx.caiwuhao.com:/home/yujiajia/mzcms  /opt1/mzcms2
tar cf mzcms`date +%Y%m%d%H%M%S`.tar mzcms
cp -rf /opt1/mzcms2/mzcms/ /opt/tomcat_mzcms/webapps/
chown -R tomcat:tomcat /opt/tomcat_mzcms/webapps/*
