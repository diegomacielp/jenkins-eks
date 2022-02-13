pipeline {
    agent any
    environment {
        IMAGE_TAG = "${param_image_tag}"
    }
    stages {
        stage('Gerando_Imagem') {
            steps ('Build'){
                sh 'docker image build -t diegomacielp/nginx:${IMAGE_TAG}'
            }
        }
    }
}