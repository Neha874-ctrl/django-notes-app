pipeline {
    agent { label 'dev-server'}

    stages {
        stage("Code clone") {
            steps {
                sh "whoami"
                git url: "https://github.com/LondheShubham153/django-notes-app.git", branch: "main"
            }
        }

        stage("Code Build") {
            steps {
                sh "docker compose build"
            }
        }

        stage("Run Containers") {
            steps {
                // This will stop and remove old containers before starting new ones
                sh "docker compose down --remove-orphans || true"
                sh "docker compose up -d --remove-orphans"
            }
        }

        stage("Push to DockerHub") {
            steps {
                // add your docker push commands here
            }
        }

        stage("Deploy") {
            steps {
                // add deploy commands here
            }
        }
    }
}
