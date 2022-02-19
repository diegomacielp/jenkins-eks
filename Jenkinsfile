pipeline {
    agent any
    environment {
        IMAGE_NAME = "${param_image_name}"
        IMAGE_TAG = "${param_image_tag}"
        DEPLOY_NAME = "${param_deploy_name}"
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker image build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }    
        stage('Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('Push') {   
            steps {
                sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }
        stage('Deploy EKS') {
            steps {
                withAWS(region:'us-east-2', credentials:'eks) {
                    sh 'kubectl create deploy --image=${IMAGE_NAME}:${IMAGE_TAG} ${param_deploy_name}'
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}