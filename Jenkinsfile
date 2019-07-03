#!groovy

pipeline {
    agent any

    stages {
        stage('Git') {
            branchname=branchname
            git branch: $branchname, url: 'https://github.com/xiguan513/java-maven-junit-helloworld.git'
        }
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
    DOCKER_IMAGE.push()
}
