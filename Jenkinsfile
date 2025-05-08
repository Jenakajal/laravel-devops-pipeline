pipeline {
    agent any

    environment {
        IMAGE_NAME = "laravel-app"
        AWS_REGION = "ap-south-1"
        AWS_ACCOUNT_ID = "686255941923"
        ECR_REPO = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${IMAGE_NAME}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Provision EKS Infrastructure with Terraform') {
            steps {
                script {
                    sh '''
                    cd terraform
                    terraform init
                    terraform plan
                    terraform apply -auto-approve
                    '''
                }
            }
        }

        stage('Wait for EKS Cluster and Node Group to be Active') {
            steps {
                script {
                    // Wait for EKS cluster to be active
                    sh "aws eks wait cluster-active --name devops-eks-cluster --region $AWS_REGION"

                    // Wait for Node Group to be active (corrected name: eks_nodes)
                    def eksNodeGroupStatus = sh(
                        script: "aws eks describe-nodegroup --cluster-name devops-eks-cluster --nodegroup-name eks_nodes --region $AWS_REGION --query 'nodegroup.status' --output text",
                        returnStdout: true
                    ).trim()

                    while (eksNodeGroupStatus != 'ACTIVE') {
                        echo "Waiting for EKS Node Group to become ACTIVE. Current status: ${eksNodeGroupStatus}"
                        sleep(30)
                        eksNodeGroupStatus = sh(
                            script: "aws eks describe-nodegroup --cluster-name devops-eks-cluster --nodegroup-name eks_nodes --region $AWS_REGION --query 'nodegroup.status' --output text",
                            returnStdout: true
                        ).trim()
                    }

                    echo "EKS Node Group is now ACTIVE."
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME -f Dockerfile .'
                }
            }
        }

        stage('Login to ECR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    script {
                        sh '''
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws configure set region $AWS_REGION

                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO
                        '''
                    }
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

