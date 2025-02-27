pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'kinder-app:v1'
        DOCKER_REGISTRY = 'docker.io/vijay8181/kinder-app:v1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsID: 'git-cred'checkout https://github.com/vijay/kinder-app.git
            }
        }

        stage('Build Application') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([url: "$DOCKER_REGISTRY", credentialsId: 'docker-credentials']) {
                    sh 'docker tag $DOCKER_IMAGE $DOCKER_REGISTRY/$DOCKER_IMAGE'
                    sh 'docker push $DOCKER_REGISTRY/$DOCKER_IMAGE'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed! Please check the logs.'
        }
    }
}
