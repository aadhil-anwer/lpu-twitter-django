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
                    def workspace = env.WORKSPACE.replace('\\', '/')
                    def dbPath = "${workspace}/db.sqlite3"

                    bat """
                        REM Stop and remove any running container from the twitter-django image
                        for /f "tokens=*" %%i in ('docker ps -q --filter "ancestor=twitter-django"') do docker stop %%i
                        for /f "tokens=*" %%i in ('docker ps -aq --filter "ancestor=twitter-django"') do docker rm %%i

                        REM Run the container and mount the SQLite database
                        docker run -d -p 8000:8000 -v ${dbPath}:/app/db.sqlite3 twitter-django
                    """
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
