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
        project = "test"
        imageNmae = "${env.JOB_NAME}${env.BUILD_ID}"
        branchname = "${params.branchname}"
        tag = "${branchname.replaceAll(/master/,'latest').replaceAll(/\//,'')}"
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
        stage('yaml') {
            steps {
                echo "Generate the Kubernetes file"
                sh "/bin/bash /opt/sh/1.sh"
            }
        }
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/${project}/${imageNmae}:${tag}", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
