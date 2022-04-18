pipeline{
    agent any
    stages{

        stage('Build Artifact') {
            steps{
                echo 'Building Artifact'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Image') {
            steps {
                script{
                    app= docker.build("aline-users-sd")
                }

            }

        }

        stage('Deploy to ECR'){
            steps{
                script {
                    docker.withRegistry('https://032797834308.dkr.ecr.us-east-1.amazonaws.com/', 'ecr:us-east-1:aws-sd'){
                        app.push('latest-' + env.BRANCH_NAME)
                    }
               }
            }
        }
        stage('Cleanup') {
            steps{
                sh 'docker system prune -f'
            }
        }
    }
}
