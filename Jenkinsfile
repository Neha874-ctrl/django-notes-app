pipeline {
    agent { label 'dev-server' }

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

        stage("Push to DockerHub") {
            steps {
                sh "echo 'Push stage running...'"
                // add docker push command here
            }
        }

        stage("Deploy") {
            steps {
                sh "echo 'Deploy stage running...'"
                // add deploy command here
            }
        }
    }
}
