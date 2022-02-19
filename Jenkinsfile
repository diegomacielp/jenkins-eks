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
        stage('Instalando EKSCTL e KUBECTL'){
            steps{
                sh 'curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp'
                sh 'sudo mv /tmp/eksctl /usr/local/bin'
                sh 'curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"'
                sh 'chmod +x kubectl'
                sh 'sudo mv kubectl /usr/local/bin'
            }
        }
        stage('Realizando deploy no EKS'){
            steps{
                withAWS(region:'us-east-2', credentials:'aws') {
                    //sh 'eksctl utils write-kubeconfig --name=$CLUSTER_NAME'
                    //sh 'kubectl create deploy --image=${IMAGE_NAME}:${IMAGE_TAG} $CLUSTER_NAME'
                    sh 'echo $AWS_ACCESS_KEY_ID'
                    sh 'echo $AWS_SECRET_ACCESS_KEY'
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