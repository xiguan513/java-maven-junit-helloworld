#!groovy

pipeline {
    agent any


    properties([parameters([string(defaultValue: '', description: '', name: 'branchname', trim: false)])])


    stages {
        stage('Maven') {
            steps {
                sh "mvn clean install -Dmaven.test.skip=true"
            }
        }
        stage('Build') {
            steps {
                echo 'Deploying ${params.bracnname}'
                imageBuild()
            }
        }
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/test/java:${params.bracnname}", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
