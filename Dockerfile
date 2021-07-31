FROM tomcat:8.0.51-jre8-alpine
LABEL maintainer="abc@gmail.com"
COPY target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
