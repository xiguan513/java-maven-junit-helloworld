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

    environment {
        branchname = "${params.branchname}"
    }
    

    stages {
        stage('Maven') {
            steps {
                echo "${branchname.replaceAll(/master/,'latest')}"
                // sh "mvn clean install -Dmaven.test.skip=true"
            }
        }
        stage('Build') {
            steps {
                echo "Deploying ${branchname}"
                // imageBuild()
            }
        }
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/test/java:${branchname}", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
