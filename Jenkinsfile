pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "vahtyah/flashapp"
        DOCKER_TAG = "latest"
        STAGING_SERVER = "staging_server_ip"
        PRODUCTION_SERVER = "production_server_ip"
        DOCKER_CREDENTIALS_ID = "8268826"
        SSH_CREDENTIALS_ID = "8268826123"
    }

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Test') {
            steps {
                sh 'docker run -d --name test_container -p 5000:5000 $DOCKER_IMAGE:$DOCKER_TAG'
                sh 'sleep 5'
                sh '''
                    RESPONSE=$(curl -s http://localhost:5000/)
                    if [ "$RESPONSE" != "Hello, World from Flask!" ]; then
                        echo "Test failed"
                        docker logs test_container
                        docker stop test_container
                        docker rm test_container
                        exit 1
                    fi
                '''
                sh 'docker stop test_container && docker rm test_container'
            }
        }

        stage('Push to Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: "$DOCKER_CREDENTIALS_ID", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $PASSWORD | docker login -u $USERNAME --password-stdin'
                    sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                sshagent (credentials: ["$SSH_CREDENTIALS_ID"]) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no user@$STAGING_SERVER '
                        docker pull $DOCKER_IMAGE:$DOCKER_TAG
                        docker stop staging_container || true
                        docker rm staging_container || true
                        docker run -d --name staging_container -p 5000:5000 $DOCKER_IMAGE:$DOCKER_TAG
                        '
                    '''
                }
            }
        }

        stage('Availability Test on Staging') {
            steps {
                sh 'sleep 10'
                sh '''
                    RESPONSE=$(curl -s http://$STAGING_SERVER:5000/)
                    if [ "$RESPONSE" != "Hello, World from Flask!" ]; then
                        echo "Staging test failed"
                        exit 1
                    fi
                '''
            }
        }

        stage('Deploy to Production') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                input message: 'Deploy to Production?', ok: 'Deploy'
                sshagent (credentials: ["$SSH_CREDENTIALS_ID"]) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no user@$PRODUCTION_SERVER '
                        docker pull $DOCKER_IMAGE:$DOCKER_TAG
                        docker stop production_container || true
                        docker rm production_container || true
                        docker run -d --name production_container -p 5000:5000 $DOCKER_IMAGE:$DOCKER_TAG
                        '
                    '''
                }
            }
        }
    }

    post {
        always {
            sh 'docker image prune -f'
        }
    }
}
