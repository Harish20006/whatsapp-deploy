FROM tomcat:9.0-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*
RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY Whatsapp_Final_v4.war /usr/local/tomcat/webapps/ROOT.war

RUN sed -i 's/port="8005" shutdown="SHUTDOWN"/port="-1" shutdown="SHUTDOWN"/' /usr/local/tomcat/conf/server.xml

ENV JAVA_OPTS="-Xms256m -Xmx512m -Djava.security.egd=file:/dev/./urandom"

EXPOSE 8080

CMD ["catalina.sh", "run"]
