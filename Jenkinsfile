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
                    pwd
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
                    echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin 
                    docker push $FRONTIMAGE_NAME:$TAG
                    docker push $BACKENDIMAGE_NAME:$TAG
                    '''
                }
            }
        }
        stage('Update Images'){
            steps{
                script {
                    sh '''
                    pwd && ls -la
                    cat Frontend-deployment.yaml              
                    sed -i 's|image: ma7moudsabra/frontend:.*|image: '"$FRONTIMAGE_NAME:$TAG"'|' ./Frontend-deployment.yaml
                    sed -i 's|image: ma7moudsabra/backend:.*|image: '"$BACKENDIMAGE_NAME:$TAG"'|' ./Backend-deployment.yaml
                    cat Frontend-deployment.yaml   
                             
                '''                
                }
            }
        }
        stage('Roll out'){
            steps{
                script {
                    sh '''
                    kubectl apply -f Frontend-deployment.yaml
                    kubectl apply -f Backend-deployment.yaml 
                    kubectl rollout status deployments/frontend-deployment
                    kubectl rollout status deployments/backend-deployment
                    '''
                }
            }
        }
//     }
//     post {
//         always {
//             cleanWs()  To clean images after pushing it
//         }
    }
}
