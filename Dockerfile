FROM tomcat:latest
RUN apt-get update -y 
ADD webapp/target/webapp.war /usr/local/tomcat/webapps
EXPOSE 8080
