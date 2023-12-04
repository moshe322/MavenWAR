# Use a base Tomcat image
FROM tomcat:9.0-jdk11

# Set the working directory
WORKDIR /app

# Your Maven project files are copied into the container
COPY . .

RUN apt-get update && \
    apt-get install -y wget && \
    wget -q "https://downloads.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz" && 
# untar maven   
RUN tar xzvf apache-maven-3.9.6-bin.tar.gz

# Build your Maven project and deploy the WAR file to Tomcat
RUN mvn clean install


# Start Tomcat
CMD ["catalina.sh", "run"]
