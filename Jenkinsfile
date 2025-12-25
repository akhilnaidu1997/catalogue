pipeline {
    agent {
        node {
            label 'Agent'
        }
    }
    options {
        // timeout(time: 10, unit: 'SECONDS') 
        disableConcurrentBuilds()
    }
    environment {
        COURSE = "DevOps"
        appVersion = "" // defining here empty and can be used for all stages
    }
    stages {
        stage('Read Version') { // This is build stage as example
            steps{
                script {  //using scripts here is a hybrid approach
                    def packageJSON = readJSON file: 'package.json'
                    appVersion = packageJSON.version
                    echo "appVersion is ${appVersion}"
                }
            }
        }
        stage('Install Dependencies'){ // This is a test stage
            steps {
                script {
                    sh """
                        npm install
                    """
                }
            }
        }
        stage('Build Image'){ // This is a deploy stage for practice
            steps {
                script {
                    sh """
                        docker build -t catalogue:${appVersion}
                    """
                }
            }
        }
    }
    post {
        always {
            echo 'I will say hello again regardless of build result'
            cleanWs()
        }
        success {
            echo "I will run this if build is success"
        }
        aborted {
            withCredentials([string(credentialsId: 'slack-webhook-url', variable: 'SLACK_URL')]) {
                    sh '''
                    curl -X POST -H 'Content-type: application/json' \
                    --data '{"text":"Build Failed ✅"}' \
                    $SLACK_URL
                    '''
            }
        }
        changed {
            echo "I will run this if pipeline status is changed"
        }
    }
}