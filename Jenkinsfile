pipeline {
    agent any

    environment {
        AWS_REGION      = "us-east-1"
        AWS_ACCOUNT_ID  = "238845559349"
        ECR_REPO        = "app-repository"
        ECR_URL         = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO}"
        GITOPS_BRANCH   = "gitops-deploy"
        GITOPS_VALUES   = "gitops/dev/values.yaml"
    }

    stages {

        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('AWS Login to ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION \
                    | docker login --username AWS --password-stdin $ECR_URL
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    IMAGE_TAG = "${BUILD_NUMBER}-${GIT_COMMIT.take(7)}"
                }
                sh '''
                docker build -t $ECR_URL:$IMAGE_TAG ./app
                '''
            }
        }

        stage('Push Image to ECR') {
            steps {
                sh '''
                docker push $ECR_URL:$IMAGE_TAG
                '''
            }
        }

        stage('Update GitOps Repo (dev)') {
            steps {
                sh '''
                git config user.email "jenkins@automation"
                git config user.name "Jenkins CI"

                git checkout $GITOPS_BRANCH

                # Update the image tag in the GitOps values.yaml
                sed -i "s/tag:.*/tag: \\"$IMAGE_TAG\\"/" $GITOPS_VALUES

                git add $GITOPS_VALUES
                git commit -m "Update dev image tag to $IMAGE_TAG