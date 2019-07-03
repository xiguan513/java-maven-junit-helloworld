#!groovy

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                git branch: ${BRANCHNAME}, url: 'https://github.com/xiguan513/java-maven-junit-helloworld.git'
            }
        }
        stage('Test') {
            steps {
                sh "mvn clean install -Dmaven.test.skip=true"
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}




