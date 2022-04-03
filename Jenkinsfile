pipeline{
    agent any
    stages{

        stage('Build Artifact') {
            steps{
                echo 'Building Artifact'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build and Deploy to ECR'){
            steps{
               withCredentials([string(credentialsID: 'ecr-url-user', variable: 'ECR_URL')]){
                   sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_URL'
                   sh 'docker build -t aline-user-sd'
                   sh 'docker tag aline-user-sd:latest $ECR_URL/aline-user-sd:latest'
                   sh 'docker push $ECR_URL/aline-user-sd:latest'
               }
            }
        }
    }
}