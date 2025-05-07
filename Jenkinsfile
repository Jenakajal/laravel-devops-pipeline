pipeline {
    agent any

    environment {
        IMAGE_NAME = "laravel-app"
        AWS_REGION = "ap-south-1"
        AWS_ACCOUNT_ID = "686255941923"
        ECR_REPO = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${IMAGE_NAME}"
    }

    stages {

        // ❌ Removed the unnecessary checkout stage (Jenkins auto-checks out code from GitHub SCM)

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

        stage('Tag & Push Docker Image') {
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
                    aws eks update-kubeconfig --region $AWS_REGION --name devops-eks-cluster
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
                    cd ansible
                    ansible-playbook -i inventory.ini playbook.yml
                    '''
                }
            }
        }
    }
}

