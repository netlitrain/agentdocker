pipeline {
    agent { label "${LABEL_NAME}" }
    environment {
        IMAGE_NAME = "netliapp"
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
                    docker run -d --name c1 -p 80:80 ${DOCKER_IMAGE} --restart always
                """
            }
        }
    }
}
