pipeline {
    agent any
    environment {
        IMAGE_NAME = "${param_image_name}"
        IMAGE_TAG = "${param_image_tag}"
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }
    stages {
        stage('Gerando_Imagem') {
            steps ('Build'){
                sh 'docker image build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
            }
            steps ('Login') {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
            steps ('Push') {
                sh 'docker push ${IMAGE_NAME}::${IMAGE_TAG}'
            }
            steps ('Logout') {
                sh 'docker logout'
            }
        }
    }
}
