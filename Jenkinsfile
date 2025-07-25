
pipeline {
    agent any
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
        AWS_REGION = "us-east-1"
        ECR_REPO = "your-ecr-repo-url"
    }
    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $ECR_REPO:$IMAGE_TAG .'
            }
        }
        stage('Login to ECR') {
            steps {
                sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO'
            }
        }
        stage('Push Docker Image') {
            steps {
                sh 'docker push $ECR_REPO:$IMAGE_TAG'
            }
        }
        stage('Update Helm values.yaml') {
            steps {
                sh '''
                  sed -i "s/tag: .*/tag: '$IMAGE_TAG'/" charts/django-app/values.yaml
                  git config user.email "ci@example.com"
                  git config user.name "CI Bot"
                  git add charts/django-app/values.yaml
                  git commit -m "Update image tag to $IMAGE_TAG"
                  git push origin main
                '''
            }
        }
    }
}
