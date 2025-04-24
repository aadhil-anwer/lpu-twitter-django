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
                    bat """
                        REM Create volume if it doesn't exist
                        docker volume inspect twitter_db_volume >nul 2>&1 || docker volume create twitter_db_volume

                        REM Check if the db.sqlite3 file exists in the volume
                        docker run --rm -v twitter_db_volume:/app db_docker twitter-django python manage.py migrate

                        REM Stop and remove containers using port 8000
                        for /f "tokens=*" %%i in ('docker ps -q --filter "publish=8000"') do docker stop %%i
                        for /f "tokens=*" %%i in ('docker ps -aq --filter "publish=8000"') do docker rm %%i

                        REM Run the container using the persistent volume
                        docker run -d -p 8000:8000 -v twitter_db_volume:/app/db.sqlite3 twitter-django
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
