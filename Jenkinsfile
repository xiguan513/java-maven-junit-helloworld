#!groovy

pipeline {
    agent any

    stages {
        stage('Maven') {
            steps {
                sh "mvn clean install -Dmaven.test.skip=true"
            }
        }
        stage('Build') {
            steps {
                echo 'Deploying....'
                mvnFileRead()
            }
        }
    }
}

def mvnFileRead() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/test/java:latest", "-f dockerfile .")
    
    docker.withRegistry(
      "https://${DOCKER_ECR_SERVER}",
      "ecr:us-west-2:${DOCKER_ECR_CREDENTIAL}") {
      DOCKER_IMAGE.push()
    }
    
  }