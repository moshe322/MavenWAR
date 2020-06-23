node{
  stage('SCM Checkout'){
    git 'https://github.com/debolindhar/MavenWAR'
  }
  stage('Compile Package'){
    //Get Maven Home path
    def mvnHome = tool name: 'JenkinsMaven', type: 'maven'
    bat "${mvnHome}/bin/mvn clean package"
  }
  stage('SonarQube analysis') {
    def scannerHome = tool 'SonarqubeScanner';
    bat '${scannerHome}/bin/sonar-scanner.bat'
  }
  stage('Publish to Nexus'){
    //Create Package ID
    def timeStamp = Calendar.getInstance().getTime().format('YYYYMMdd-hhmmss',TimeZone.getTimeZone('CST'))
    bat "echo ${timeStamp}"
    def day = timeStamp.substring(0,8)
    bat "echo ${day}"
   
    bat "echo ${currentBuild.number}"
   
    def packageid = "${day}.${currentBuild.number}"
    bat "echo ${packageid}"
   
    //Publish package to Nexus Server
    nexusPublisher nexusInstanceId: 'JavaRelease', nexusRepositoryId: 'maven-releases', packages: [[$class: 'MavenPackage', mavenAssetList: [[classifier: '', extension: '', filePath: '\\target\\guestbook-1.2.0.war']], mavenCoordinate: [artifactId: 'guestbook', groupId: 'devops', packaging: 'war', version: packageid]]]
  }
  /*stage('Deplot to Tomcat'){
    //Run CURL script
    curl -v -u admin:admin -T /../my_app.war 'http://127.0.0.1:8085/manager/text/deploy?path=/my_app&update=true'
  }*/
}
