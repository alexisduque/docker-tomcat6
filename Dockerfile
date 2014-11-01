# Pull base image.
FROM dockerfile/ubuntu

# Install Java.
RUN \
  echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java6-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk6-installer

# Define JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-6-oracle

# Install Apache Tomcat
RUN cd /opt && \
    wget "http://ftp.halifax.rwth-aachen.de/apache/tomcat/tomcat-6/v6.0.41/bin/apache-tomcat-6.0.41.tar.gz" && \
    tar xfz apache-tomcat-6.0.41.tar.gz && \
    mv /opt/apache-tomcat-6.0.41 /opt/tomcat6 && \
    rm /opt/apache-tomcat-6.0.41.tar.gz \
    rm -rf /opt/tomcat6/webapps/*

ADD start.sh /opt/tomcat6/start.sh

RUN chmod -R 755 /opt/tomcat6 && chmod a+x /opt/tomcat6/start.sh

RUN rm -rf /opt/tomcat6/logs ;\
    mkdir /var/log/tomcat/ ;\
    ln -s /var/log/tomcat/ /opt/tomcat6/logs

# Finally run it
EXPOSE 8080

# Define default command.
CMD /opt/tomcat6/start.sh