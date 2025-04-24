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
                REM Stop containers using port 8000
                for /f "tokens=*" %%i in ('docker ps -q --filter "publish=8000"') do docker stop %%i
                for /f "tokens=*" %%i in ('docker ps -aq --filter "publish=8000"') do docker rm %%i

                REM Run the container and mount the SQLite database
                docker run -d -p 8000:8000 -v ${dbPath}:/app/db.sqlite3 twitter-django
            """
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
