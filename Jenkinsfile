pipeline {
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        FRONTIMAGE_NAME = 'ma7moudsabra/frontend'
        BACKENDIMAGE_NAME = 'ma7moudsabra/backend'
        TAG = "${BUILD_NUMBER}"
    }
    stages {
        stage('Build frontend') {
            steps {
                script {
                    sh '''
                    docker build -t $FRONTIMAGE_NAME:$TAG ./frontend/
                   '''
                }
            }
        }
        stage('Build backend') {
            steps {
                script {
                    sh ''' 
                    docker build -t $BACKENDIMAGE_NAME:$TAG ./ruby/
                   '''
                }
            }
        }
    stage('Push front & back') {
            steps {
                script {
                        sh '''
                        docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}
                        docker push $FRONTIMAGE_NAME:$TAG
                        docker push $BACKENDIMAGE_NAME:$TAG
                        '''
                    }
                   
                }
            }
        
    
post
        
        always {
            cleanWs()
        }

}
}
