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
                imageBuild()
            }
        }
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/test/java:latest", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
