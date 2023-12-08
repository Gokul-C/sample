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
      withSonarQubeEnv() {
      sh "mvn clean verify sonar:sonar -Dsonar.projectKey=Test -Dsonar.projectName='Test'"
      }
    }
  }
      
}
  
