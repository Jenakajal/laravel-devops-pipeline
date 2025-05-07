pipeline {
    agent any

    environment {
        IMAGE_NAME = "laravel-app"
        AWS_REGION = "us-east-1"
        ECR_REPO = "your_ecr_repo_url"  // Replace with actual ECR repo
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/laravel-devops-pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Login to ECR') {
            steps {
                script {
                    sh '''
                    aws ecr get-login-password --region $AWS_REGION | \
                    docker login --username AWS --password-stdin $ECR_REPO
                    '''
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    sh '''
                    docker tag $IMAGE_NAME:latest $ECR_REPO:latest
                    docker push $ECR_REPO:latest
                    '''
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                script {
                    sh '''
                    kubectl apply -f deployment.yml
                    kubectl apply -f service.yml
                    '''
                }
            }
        }

        stage('Post Deploy Config with Ansible') {
            steps {
                script {
                    sh '''
                    ansible-playbook -i inventory.ini ansible/deploy.yml
                    '''
                }
            }
        }
    }
}

