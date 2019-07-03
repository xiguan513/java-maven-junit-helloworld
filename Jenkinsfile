#!groovy

pipeline {
    agent any

    parameters {
        string(
            description: "描述信息",
            name: 'branchname',
            defaultValue: 'master', 
            )
    }


    stages {
        stage('Maven') {
            steps {
                sh "mvn clean install -Dmaven.test.skip=true"
            }
        }
        stage('Build') {
            steps {
                echo "Deploying ${params.branchname}.replaceAll("master","latest")"
                imageBuild()
            }
        }
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/test/java:${params.branchname}.replaceAll("master","latest")", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
