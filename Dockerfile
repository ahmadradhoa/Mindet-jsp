# Production Dockerfile for Mindet JSP
FROM tomcat:10.1-jdk21-temurin

LABEL maintainer="Mindet Team"

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# Disable Tomcat shutdown port (8005 -> -1) so cloud health checks hit only HTTP port
RUN sed -i 's/<Server port="8005"/<Server port="-1"/g' /usr/local/tomcat/conf/server.xml

# Support dynamic $PORT from cloud providers, fallback to 8080
RUN sed -i 's/port="8080"/port="${PORT:-8080}"/g' /usr/local/tomcat/conf/server.xml

# Copy self-contained WAR into Tomcat webapps
COPY ROOT.war /usr/local/tomcat/webapps/ROOT.war

ENV PORT=8080
EXPOSE 8080

CMD ["catalina.sh", "run"]
