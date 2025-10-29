pipeline {
    agent any

    tools {
        maven 'M3'
        jdk 'jdk-21'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
        DOCKERHUB_USERNAME = 'nbhf'
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/application-tp2"
        IMAGE_TAG = "${BUILD_NUMBER}-${new Date().format('yyyyMMdd-HHmmss')}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Cloning repository from GitHub...'
                git branch: 'main', url: 'https://github.com/nbhf/ApplicationTp2-DevOps.git'
            }
        }

        stage('Build with Maven') {
            steps {
                echo 'Building application with Maven...'
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running unit tests...'
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
                    sh "docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                echo 'Logging in to Docker Hub...'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo "Pushing image to Docker Hub..."
                sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                sh "docker push ${IMAGE_NAME}:latest"
            }
        }

        stage('Deploy with Helm') {
            steps {
                echo 'Deploying with Helm...'
                script {
                    sh "helm upgrade --install app-tp2 ./helm/app-tp2 --set image.tag=${IMAGE_TAG}"
                }
            }
        }

        stage('Cleanup') {
            steps {
                echo 'Cleaning up local Docker images...'
                sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true"
                sh "docker rmi ${IMAGE_NAME}:latest || true"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
            echo "Image available: ${IMAGE_NAME}:${IMAGE_TAG}"
            echo "Image available: ${IMAGE_NAME}:latest"
        }
        failure {
            echo 'Pipeline failed!'
        }
        always {
            echo 'Logging out from Docker Hub...'
            sh 'docker logout || true'
        }
    }
}
