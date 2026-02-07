pipeline {
    agent any

    environment {
        DOCKER_IMAGE_APP = "django-notes-app"
        DOCKER_IMAGE_NGINX = "django-nginx"
    }

    stages {

        stage("Clone Code") {
            steps {
                git branch: "main",
                    url: "https://github.com/Neha874-ctrl/django-notes-app.git"
            }
        }

        stage("Build Images") {
            steps {
                sh """
                  docker compose build
                """
            }
        }

        stage("Push to DockerHub") {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh """
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

                      docker tag neha874/django-notes-app:latest $DOCKER_USER/django-notes-app:latest
                      docker push $DOCKER_USER/django-notes-app:latest

                      docker tag neha874/django-nginx:latest $DOCKER_USER/django-nginx:latest
                      docker push $DOCKER_USER/django-nginx:latest
                    """
                }
            }
        }

        stage("Deploy") {
            steps {
                sh """
                  docker compose down
                  docker compose up -d --build
                """
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful"
        }
        failure {
            echo "❌ Deployment failed"
        }
        always {
            sh "docker system prune -f"
        }
    }
}
