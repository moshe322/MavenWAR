FROM ubuntu:latest

EXPOSE 8080

COPY MavenWAR /usr/local/tomcat/webapps

WORKDIR /usr/local/tomcat/webapps

RUN apt install maven -y

RUN mvn clean install

CMD ["catalina.sh", "run"]
