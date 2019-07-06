#!groovy

pipeline {
    agent any

    parameters {
        string(
            description: "输入分支名称",
            name: 'branchname',
            defaultValue: '', 
            )
    }

    environment {
        project = "test"
        imageNmae = "${env.JOB_NAME}${env.BUILD_ID}_${env.GIT_COMMIT.substring(6)}"
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
                sh "/bin/bash /opt/sh/k8s.sh"
            }
        }
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/${project}/${imageNmae}:${tag}", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
