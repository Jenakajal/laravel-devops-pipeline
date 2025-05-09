stage('Wait for EKS Cluster and Node Group to be Active') {
    steps {
        script {
            // Wait for EKS cluster to be active
            sh "aws eks wait cluster-active --name devops-eks-cluster --region $AWS_REGION"

            // Wait for Node Group to be active
            def eksNodeGroupStatus = sh(
                script: "aws eks describe-nodegroup --cluster-name devops-eks-cluster --nodegroup-name jenkins-node-group --region $AWS_REGION --query 'nodegroup.status' --output text",
                returnStdout: true
            ).trim()

            while (eksNodeGroupStatus != 'ACTIVE') {
                echo "Waiting for EKS Node Group to become ACTIVE. Current status: ${eksNodeGroupStatus}"
                sleep(30)
                eksNodeGroupStatus = sh(
                    script: "aws eks describe-nodegroup --cluster-name devops-eks-cluster --nodegroup-name jenkins-node-group --region $AWS_REGION --query 'nodegroup.status' --output text",
                    returnStdout: true
                ).trim()
            }

            echo "EKS Node Group is now ACTIVE."
        }
    }
}

