#!/bin/bash

#chown tomcat:tomcat /var/log/tomcat;
/opt/tomcat6/bin/startup.sh
tail -f /var/log/tomcat/*