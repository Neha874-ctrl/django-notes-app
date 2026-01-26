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
                withCredentials([jenkinsdckr_pat_n3KV9E2_ZOE3kBIyrvanR6pSmcE(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                      echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                      docker push cloudcrates/django-notes-app
                      docker push cloudcrates/django-nginx
                    """
                }
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
