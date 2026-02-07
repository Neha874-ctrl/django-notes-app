pipeline {
    agent any

    environment {
        ENV = "prod"
        IMAGE_TAG = "${BUILD_NUMBER}"
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

        stage("Prepare Environment") {
            steps {
                sh '''
                  if [ "$ENV" = "prod" ]; then
                    cp .env.prod .env
                  else
                    cp .env.dev .env
                  fi
                '''
            }
        }

        stage("Build Images") {
            steps {
                sh '''
                  docker compose build

                  docker tag neha874/django-notes-app:latest neha874/django-notes-app:$IMAGE_TAG
                  docker tag neha874/django-nginx:latest neha874/django-nginx:$IMAGE_TAG
                '''
            }
        }

        stage("Push to DockerHub") {
    when {
        expression { params.ENV == 'prod' }
    }
    steps {
        withCredentials([
            usernamePassword(
                credentialsId: 'dockerhub-creds',
                usernameVariable: 'DOCKER_USER',
                passwordVariable: 'DOCKER_PASS'
            )
        ]) {
            sh '''
              echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

              docker push $DOCKER_USER/django-notes-app:$IMAGE_TAG
              docker push $DOCKER_USER/django-nginx:$IMAGE_TAG
            '''
        }
    }
}


        stage("Deploy") {
            steps {
                sh '''
                  docker compose down
                  docker compose up -d
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Build ${IMAGE_TAG} deployed successfully"
        }
        failure {
            echo "❌ Build ${IMAGE_TAG} failed"
        }
        always {
            sh "docker system prune -f"
        }
    }
}
