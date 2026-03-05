FROM tomcat:9.0-jdk17

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Remove old ROOT if any
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy WAR
COPY Whatsapp_Final_v2.war /usr/local/tomcat/webapps/ROOT.war

# Fix Tomcat server.xml - disable shutdown port to avoid WARNING
RUN sed -i 's/port="8005" shutdown="SHUTDOWN"/port="-1" shutdown="SHUTDOWN"/' /usr/local/tomcat/conf/server.xml

# Set JVM options
ENV JAVA_OPTS="-Xms256m -Xmx512m -Djava.security.egd=file:/dev/./urandom"

EXPOSE 8080

CMD ["catalina.sh", "run"]
