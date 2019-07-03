#!groovy

pipeline {
    agent any

    stages {
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




