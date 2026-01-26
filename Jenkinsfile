pipeline {
    agent any

    stages {
        stage("Code clone") {
            steps {
                git url: "https://github.com/Neha874-ctrl/django-notes-app.git", branch: "main"
            }
        }

        stage("Code Build") {
            steps {
                sh "docker compose build"
            }
        }

        stage("Push to DockerHub") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "docker login -u $DOCKER_USER -p $DOCKER_PASS"
                    sh "docker tag django_app $DOCKER_USER/django-notes-app:latest"
                    sh "docker push $DOCKER_USER/django-notes-app:latest"

                    sh "docker tag nginx $DOCKER_USER/django-nginx:latest"
                    sh "docker push $DOCKER_USER/django-nginx:latest"
                }
            }
        }

        stage("Deploy") {
            steps {
                sh "docker compose down -v || true"
                sh "docker compose up -d"
            }
        }
    }
}
