# Use a base Tomcat image
FROM tomcat:9.0-jdk11

# Set the working directory
WORKDIR /app

# Download and install Maven
ENV MAVEN_VERSION 3.8.4
ENV MAVEN_HOME /usr/share/maven
ENV PATH $MAVEN_HOME/bin:$PATH

RUN apt-get update && \
    apt-get install -y wget && \
    wget -q "https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" && \
    tar -xzf "apache-maven-$MAVEN_VERSION-bin.tar.gz" -C /usr/share && \
    ln -s "/usr/share/apache-maven-$MAVEN_VERSION/bin/mvn" /usr/bin/mvn && \
    rm "apache-maven-$MAVEN_VERSION-bin.tar.gz" && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Your Maven project files are copied into the container
COPY . .

# Build your Maven project and deploy the WAR file to Tomcat
RUN mvn clean install && \
    cp target/your-app.war /usr/local/tomcat/webapps/

# Start Tomcat
CMD ["catalina.sh", "run"]
