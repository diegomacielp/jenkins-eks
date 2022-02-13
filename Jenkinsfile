pipeline {
    agent any
    environment {
        IMAGE_NAME = "${param_image_name}"
        IMAGE_TAG = "${param_image_tag}"
    }
    stages {
        stage('Gerando_Imagem') {
            steps ('Build'){
                sh 'docker image build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
        }
    }
}
