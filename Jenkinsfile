pipeline {
    agent { label "${LABEL_NAME}" }
    environment {
        IMAGE_NAME = "netli"
        IMAGE_TAG  = "${BUILD_NUMBER}"
        DOCKER_IMAGE = "${IMAGE_NAME}:${IMAGE_TAG}"
    }
    stages {
        stage('CODE') {
            steps {
                git url:"https://github.com/netlitrain/agentdocker.git", branch:"main"
            }
        }
        stage('BUILD') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }
        stage('DEPLOY') {
            steps {
                sh """
                    docker stop c1 || true
                    docker rm c1 || true
                    docker run -d --name c1 -p 80:80 --restart always ${DOCKER_IMAGE}
                """
            }
        }
    }
    post {
        success {
        archiveArtifacts artifacts: '*.tar', fingerprint: 'true'
            
        emailext( 
            body: '''THIS MAIL IS REGARDING THE SUCCESSFULL BUILD.
FOR THE REFERENCE CHECK CONSOLE OUTPUT OF ${BUILD_NUMBER}''', 
    subject: 'Build SUCCESSFULL ${BUILD_NUMBER}', 
    to: '${EMAIL}'
                 )
        }
        failure {
            emailext( 
            body: '''THIS MAIL IS REGARDING THE FAILED BUILD.
FOR THE REFERENCE CHECK CONSOLE OUTPUT OF ${BUILD_NUMBER}''', 
    subject: 'Build FAILED ${BUILD_NUMBER}', 
    to: '${EMAIL}'
                 )
        }
            }
}
