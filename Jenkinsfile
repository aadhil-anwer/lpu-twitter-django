pipeline {
    agent any

    environment {
        IMAGE_NAME = 'Silent Stories'
    }

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/aadhil-anwer/lpu-twitter-django.git'
            }
        }

        stage('Build Docker Image') {
            steps {
               script {
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop and remove any running container first
                    sh "docker rm -f ${IMAGE_NAME} || true"
                    // Run the new container
                    sh "docker run -d -p 8000:8000 --name ${IMAGE_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        failure {
            echo "Build failed, your majesty 😞"
        }
        success {
            echo "Deployed successfully on http://localhost:8000 🎉"
        }
    }
}
