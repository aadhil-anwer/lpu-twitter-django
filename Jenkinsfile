pipeline {
    agent any

   

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/aadhil-anwer/lpu-twitter-django.git'
            }
        }

        stage('Build Docker Image') {
            steps {
               script {
                    bat 'docker build -t twitter-django .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // // Stop and remove any running container first
                    // sh "docker rm -f ${IMAGE_NAME} || true"
                    // Run the new container
                    bat 'docker run -d -p 8000:8000 twitter-django'
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
