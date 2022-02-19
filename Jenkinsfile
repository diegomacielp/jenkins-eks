pipeline {
    agent any
    environment {
        IMAGE_NAME = "${param_image_name}"
        IMAGE_TAG = "${param_image_tag}"
        DEPLOY_NAME = "${param_deploy_name}"
        CLUSTER_NAME = "${param_cluster_name}"
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
        stage('Instalando EKSCTL'){
            steps{
                sh 'curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp'
                sh 'mv /tmp/eksctl /usr/local/bin'
            }
        }
        stage('Conectando ao cluster'){
            steps{
                withAWS(region:'us-east-2', credentials:'aws') {
                    sh 'eksctl utils write-kubeconfig --name=$CLUSTER_NAME'
                    sh 'eksctl get cluster'
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