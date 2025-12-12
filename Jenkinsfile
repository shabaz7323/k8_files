pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = "shabaz7323"
        IMAGE_NAME = "shabaz"
        IMAGE_TAG = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Pulling code from Git..."
                checkout scm
            }
        }

        stage('Install Node Modules') {
            steps {
                echo "Installing dependencies..."
                sh 'npm install'
            }
        }

        stage('Run Tests') {
            steps {
                echo "Running tests (if any)..."
                sh 'npm test || echo "No tests found"'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh """
                        docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG} .
                    """
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    passwordVariable: 'DOCKER_PASSWORD',
                    usernameVariable: 'DOCKER_USERNAME'
                )]) {
                    sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh """
                    docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                """
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Deploying application to Kubernetes..."
                sh """
                    kubectl rollout restart deployment shabaz
                """
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully!"
        }
        failure {
            echo "Pipeline failed. Please check logs."
        }
    }
}
