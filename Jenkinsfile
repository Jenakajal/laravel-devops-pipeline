pipeline {
agent any

```
environment {
    IMAGE_NAME = 'laravel-app'
    IMAGE_TAG = 'latest'
}

stages {
    stage('Build Docker Image') {
        steps {
            script {
                // Assuming Dockerfile is in current workspace directory
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
    }

    stage('Run Docker Locally (Optional)') {
        steps {
            script {
                // Run the image locally on port 8080 -> container's port 80
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
```

}

