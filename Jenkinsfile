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
        imageNmae = env.JOB_NAME
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
    }
}

def imageBuild() {

    def DOCKER_IMAGE = docker.build("harbor.ynsy.com/${project}/${imageNmae}:${tag}", "-f dockerfile .")
    DOCKER_IMAGE.push()
}
