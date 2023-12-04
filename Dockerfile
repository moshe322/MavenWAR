# Use a base Tomcat image
FROM tomcat:9.0-jdk11

# Set the working directory
WORKDIR /app

# Download and install Maven
ENV MAVEN_VERSION 3.9.6
ENV MAVEN_HOME /usr/share/maven

RUN apt-get update && \
    apt-get install -y wget && \
    wget -q "https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" && \
    tar xzvf apache-maven-3.9.6-bin.tar.gz

# Your Maven project files are copied into the container
COPY . .

# Build your Maven project and deploy the WAR file to Tomcat
RUN mvn clean install

# Start Tomcat
CMD ["catalina.sh", "run"]
