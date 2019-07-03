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
        temp = "${params.branchname}"
        branchname = "${temp.replaceAll(/master/,'latest')}"
        branchname = "${temp.replaceAll(/\//,'')}"
    }
    

    stages {
        stage('Maven') {
            steps {
                echo "maven branch : ${branchname}"
                sh "mvn clean install -Dmaven.test.skip=true"
            }
        }
        stage('Build') {
            steps {
                echo "building ${branchname}"
                imageBuild()
            }
        }
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/test/java:${branchname}", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
