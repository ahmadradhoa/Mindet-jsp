# Production Dockerfile for Mindet JSP
FROM tomcat:10.1-jdk21-temurin

LABEL maintainer="Mindet Team"

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# Copy self-contained WAR into Tomcat webapps
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war

# Default Tomcat Port
EXPOSE 8080

CMD ["catalina.sh", "run"]
