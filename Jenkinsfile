pipeline{
    agent any
    environment {
    VERSION = readMavenPom().getVersion()
    }
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
                    withCredentials([string(credentialsId: 'ecr-url', variable: 'ECRURL')]) {
                    docker.withRegistry("${ECRURL}", 'ecr:us-east-1:aws-sd'){
                        app.push("${VERSION}-" + env.BRANCH_NAME)
                        }
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
