pipeline { 
  agent any
  environment {
    deploymentName = "devsecops"
    containerName = "devsecops-container"
    serviceName = "devsecops-svc"
    imageName = "training:${GIT_COMMIT}"
    applicationURL = "http://192.168.0.106"
    applicationURI = "/increment/99"
  }
  stages {
    stage('Build Artifact') {
       steps {
         sh "mvn clean package -DskipTests=true"
         archive 'target/*.jar' //so that they can be downloaded later            
       }
    }
    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv('sonarqube-latest') { 
          sh "mvn clean verify sonar:sonar -Dsonar.projectKey=Test -Dsonar.projectName='Test'  -Dsonar.host.url='http://192.168.0.106:9001'  -Dsonar.token='sqa_751bc660bcb8f149364df5a56274e603895fd2be'"
        }
        timeout(time: 2, unit: 'MINUTES') {    //will pause pipeline for 2 mins to fetch the sonarqube results
              script {
                waitForQualityGate abortPipeline: true
              }
        }
      }
    }
    stage('Build docker image') {
       steps {
         sh 'printenv'
         sh 'sudo docker build -t training:""$GIT_COMMIT"" .'
                            
       }
    }
    stage('K8s-Deploy') {
       steps {
         sh "sed -i 's#replace#training:${GIT_COMMIT}#g' k8s-deploy.yaml"
         sh "kubectl apply -f k8s-deploy.yaml"
                   
       }
    }
  }
      
}
  
