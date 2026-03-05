FROM tomcat:9.0-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR and extract it as ROOT directory (exploded deployment)
COPY Whatsapp_Final_v5.war /tmp/ROOT.war
RUN mkdir -p /usr/local/tomcat/webapps/ROOT && \
    cd /usr/local/tomcat/webapps/ROOT && \
    jar -xf /tmp/ROOT.war && \
    rm /tmp/ROOT.war

# Disable shutdown port
RUN sed -i 's/port="8005" shutdown="SHUTDOWN"/port="-1" shutdown="SHUTDOWN"/' \
    /usr/local/tomcat/conf/server.xml

# Java 17 needs these flags for Hibernate/reflection to work
ENV JAVA_OPTS="-Xms256m -Xmx512m \
  -Djava.security.egd=file:/dev/./urandom \
  --add-opens java.base/java.lang=ALL-UNNAMED \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.io=ALL-UNNAMED \
  --add-opens java.rmi/sun.rmi.transport=ALL-UNNAMED"

EXPOSE 8080

CMD ["catalina.sh", "run"]
