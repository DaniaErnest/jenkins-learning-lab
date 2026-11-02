pipeline {
    agent any

    stages {
        stage('inspect') {
            steps {
                echo 'Starting Jenkins Pipeline'

                sh '''
                    echo "Application: Jenkins Learning Lab"
                    echo "Build Number: $BUILD_NUMBER"
                    echo "Workspace: $WORKSPACE"
                    echo "Git Commit:"
                    git log -1 --oneline
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Running application checks'
                sh 'bash app.sh'
            }
        }
        stage('Build') {
            steps {
                echo 'Application build stage completed'
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check the logs.'
        }

        always {
            echo 'Pipeline execution finished.'
        }
    }
}