pipeline {
    agent any
    
    triggers {
        pollSCM '* * * * *'
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    def frontImage = docker.build("ma7moudsabra/rubytask_front:${env.BUILD_NUMBER}", "./front")
                    def backImage = docker.build("ma7moudsabra/rubytask_back:${env.BUILD_NUMBER}", "./back")
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        frontImage.push()
                        backImage.push()
                    }
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
