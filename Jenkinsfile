pipeline {
    agent { label "{$LABEL_NAME}" }
    stages {
        stage('CODE') {
            steps {
                git url:"https://github.com/netlitrain/agentdocker.git", branch:"main"
            }
        }
        stage('BUILD') {
            steps {
                sh "docker build -t simpleapp:1 ."
            }
        }
        stage('DEPLOY') {
            steps {
                sh """
                    docker stop c1 || true
                    docker rm c1 || true
                    docker run -d --name c1 -p 80:80 simpleapp:1 --restart always
                """
            }
        }
    }
}
