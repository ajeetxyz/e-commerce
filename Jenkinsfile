pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ajeetxyz/e-commerce'
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('ecommerce:latest', '.')
                }
            }
        }
        stage('Deploy') {
             steps {
                // Deploy Docker image to remote server
                // Replace <your-remote-server-credentials> with your actual SSH credentials
                sh '''
                    sshpass -p "jamesbond" scp Dockerfile bond@196.34.24.5:/var/www/
                    sshpass -p "jamesbond" scp -r bond user@196.34.24.5:/var/www/
                    sshpass -p "jamesbond" ssh bond@196.34.24.5 "docker build -t ecommerce:latest /var/www/ && docker run -d -p 80:80 ecommerce:latest"
                '''
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
