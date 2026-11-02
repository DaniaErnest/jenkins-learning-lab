pipeline {
    agent any

    environment {
        IMAGE_NAME = 'jenkins-learning-app'
        IMAGE_TAG = 'v1'
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
                echo 'Building Docker image'

                sh '''
                    docker build \
                      -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Verify Docker Image') {
            steps {
                echo 'Checking generated image'

                sh 'docker images ${IMAGE_NAME}'

                echo 'Running application container'

                sh 'docker run --rm ${IMAGE_NAME}:${IMAGE_TAG}'
            }
        }
    }

    post {
        success {
            echo 'CI pipeline completed successfully!'
        }

        failure {
            echo 'CI pipeline failed. Check the console output.'
        }

        always {
            echo 'Pipeline execution finished.'
        }
    }
}