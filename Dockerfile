FROM tomcat:jdk14-openjdk-oracle

EXPOSE 8080

COPY ./target/guestbook-1.2.0.war /usr/local/tomcat/webapps/guestbook.war

CMD ["catalina.sh", "run"]