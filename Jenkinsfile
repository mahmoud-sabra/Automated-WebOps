pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'repo']], userRemoteConfigs: [[url: 'https://github.com/mahmoud-sabra/Docker-test-api.git']]])
            }
        }
        
        stage('Build and Push Images') {
            steps {
                script {
                    sh 'docker-compose -f repo/docker-compose.yml build'
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        sh 'docker-compose -f repo/docker-compose.yml push'
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
