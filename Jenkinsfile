pipeline { 
  agent any
  stages {
    stage('Build Artifact') {
       steps {
              sh "mvn clean package -DskipTests=true"
              archive 'target/*.jar' //so that they can be downloaded later
            }
        }
    stage('SonarQube Analysis') {
      steps {
        sh "mvn clean verify sonar:sonar -Dsonar.projectKey=Test -Dsonar.projectName='Test'  -Dsonar.host.url='http://192.168.0.106:9001'  -Dsonar.token='sqa_751bc660bcb8f149364df5a56274e603895fd2be'"
      }
    }
  }
      
}
  
