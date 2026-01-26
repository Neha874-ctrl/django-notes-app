pipeline {
    agent any

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
                withcredentials([usernamePassword(credentialsID: 'dockerhub-creds', usernameVariable: 'DOCKER-USER', passwordVariable: 'DOCKER_PASS')]) {
                  sh "docker login -u $DOCKER-USER -p $DOCKER_PASS"
                  sh "docker tag django_app $DOCKER_USER/django-notes-app:latest"
                  sh "docker push $DOCKER_USER/django-notes-app:latest"

                  sh "docker tag nginx $DOCKER_USER/django-nginx:latest"
                  sh "docker push $DOCKER_USER/django-nginx:latest"
            }
        }

        stage("Deploy") {
            steps {
                sh "docker compose down"
                sh "docker compose up -d"
                // add deploy command here
            }
        }
    }
}
