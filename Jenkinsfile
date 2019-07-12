#!groovy

pipeline {
    agent any

    parameters {
        string(
            description: "输入分支名称",
            name: 'branchname',
            defaultValue: '', 
            )
        string(
            description: "镜像仓库的项目名",
            name: 'harborpro',
            defaultValue: '',
            )

    }

    environment {
        project = "${params.harborpro}"
        imageNmae = "${env.JOB_NAME}${env.BUILD_ID}_${env.GIT_COMMIT.substring(0,6)}"
        branchname = "${params.branchname}"
        tag = "${branchname.replaceAll(/master/,'latest').replaceAll(/\//,'')}"
    }
    

    stages {
        stage('Maven') {
            steps {
                echo "maven branch : ${branchname}"
                sh "mvn clean install"
            }
        }
        stage('Build') {
            steps {
                echo "building ${tag} ${project}"
                imageBuild()
            }
        }
        stage('yaml') {
            steps {
                echo "Generate the Kubernetes file"
                sh "/bin/bash -x /opt/sh/k8s.sh"
            }
        }
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/${project}/${imageNmae}:${tag}", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
