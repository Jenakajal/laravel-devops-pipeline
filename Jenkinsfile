pipeline {
    agent any

    environment {
        IMAGE_NAME = 'laravel-app'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Run Docker Locally (Optional)') {
            steps {
                script {
                    sh "docker run -d -p 8080:80 ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Docker build and run successful!"
        }
        failure {
            echo "❌ Docker build failed."
        }
    }
}

