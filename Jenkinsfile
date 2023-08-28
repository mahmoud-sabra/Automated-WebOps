pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    environment {
        FRONTIMAGE_NAME = 'ma7moudsabra/frontend'
        BACKENDIMAGE_NAME = 'ma7moudsabra/backend'
        TAG = "${BUILD_NUMBER}"
    }
    stages {
        // stage('Clone Repository') {
        //     steps {
        //         checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'repo']], userRemoteConfigs: [[url: 'https://github.com/mahmoud-sabra/Docker-test-api.git']]])
        //     }
        // }
        
        stage('Build frontend') {
            steps {
                script {
                    sh '''
                    docker build -t $FRONTIMAGE_NAME:$TAG ./frontend/
                    docker ps -a
                   '''
                }
            }
        }
        stage('Build backend') {
            steps {
                script {
                    sh ''' 
                    docker ps -a
                    docker build -t $BACKENDIMAGE_NAME:$TAG ./ruby/
                    docker ps -a
                   '''
                }
            }
        }
    stage('Push front & back') {
            steps {
                script {
                     docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        sh '''
                        docker push $FRONTIMAGE_NAME:$TAG
                        docker push $BACKENDIMAGE_NAME:$TAG
                        '''
                    }
                   
                }
            }
        }
    
// post
        
//         always {
//             cleanWs()
//         }

}
}
