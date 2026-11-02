
pipeline {
    agent any

    environment {
        IMAGE_NAME = 'jenkins-learning-app'
    }

    stages {
        stage('Inspect') {
            steps {
                echo 'Inspecting application'
                sh 'ls -la'
                sh 'git log -1 --oneline'
            }
        }

        stage('Test') {
            steps {
                echo 'Running application tests'
                sh 'bash app.sh'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Generate a unique image tag from the Git commit
                    env.IMAGE_TAG = sh(
                        script: 'git rev-parse --short=12 HEAD',
                        returnStdout: true
                    ).trim()

                    withCredentials([
                        usernamePassword(
                            credentialsId: 'dockerhub-credentials',
                            usernameVariable: 'DOCKER_USER',
                            passwordVariable: 'DOCKER_TOKEN'
                        )
                    ]) {
                        env.IMAGE = "${env.DOCKER_USER}/${env.IMAGE_NAME}:${env.IMAGE_TAG}"

                        sh 'docker build -t "$IMAGE" .'
                    }
                }
            }
        }

        stage('Verify Docker Image') {
            steps {
                echo 'Running application container'
                sh 'docker run --rm "$IMAGE"'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-credentials',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_TOKEN'
                    )
                ]) {
                    sh '''
                        set -eu
                        printf '%s' "$DOCKER_TOKEN" |
                            docker login --username "$DOCKER_USER" --password-stdin

                        trap 'docker logout >/dev/null 2>&1 || true' EXIT

                        echo "Pushing image: $IMAGE"
                        docker push "$IMAGE"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Docker image successfully published!'
        }

        failure {
            echo 'Pipeline failed. Check the console output.'
        }

        always {
            echo 'Pipeline execution finished.'
        }
    }
}
