#!groovy

pipeline {
    agent any

    environment {
        def bracnname = "${params.bracnname}"
    }

    stages {
        stage('Maven') {
            steps {
                sh "mvn clean install -Dmaven.test.skip=true"
            }
        }
        stage('Build') {
            steps {
                echo 'Deploying ${bracnname}'
                imageBuild()
            }
        }
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/test/java:${bracnname}", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
