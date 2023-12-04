# Use a base Tomcat image
FROM tomcat:9.0-jdk11

# Set the working directory
WORKDIR /app

RUN apt-get update && \
    apt-get install -y maven
COPY . .
RUN mvn clean install

# Start Tomcat
CMD ["catalina.sh", "run"]
