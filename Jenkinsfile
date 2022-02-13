pipeline {
    agent any
    environment {
        IMAGE_NAME = "${param_image_name}"
        IMAGE_TAG = "${param_image_tag}"
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
            kubernetesDeploy(
                configs: 'k8s/app.yaml',
                kubeconfigId: 'eks',
                enableConfigSubstitution: true
            ) 
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}