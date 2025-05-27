pipeline {
    agent any
    /*tools {
        sonarScanner 'SonarScanner CLI'  // Name must match what you added in Jenkins
    }*/
    environment {
        IMAGE_NAME = "thethymca/weather_forecasting_project:${BUILD_NUMBER}"
        DOCKER_REGISTRY = "https://index.docker.io/v1"
        SONAR_TOKEN = credentials('sonar-credentials')
        //SLACK_CHANNEL = '#jenkins-new'
        //SONAR_SCANNER_HOME = tool name: 'SonarScanner CLI', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
    }
    stages {
        stage ('git checkout code'){
            steps {
                git branch: 'main', url: 'https://github.com/harkaur02/weather_forecasting_project.git'
            }
        }
        /* stage('Docker build') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
                echo "Image built successfully!"
            }
        }
        stage ('Docker image push') {
            steps {
                echo "Image push process starting..."
                withCredentials([usernamePassword(credentialsId: 'docker-credentials', usernameVariable:'DOCKER_USER', passwordVariable:'DOCKER_PASS')]){
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE_NAME}
                    """
                }
            }
        } */
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('MySonarQube') {
                    /* sh '$SONAR_SCANNER_HOME/bin/sonar-scanner' */
                    sh 'MySonarQube'

                }
            }
        }
        /* stage('SonarQube Scan') {
            steps {
                withCredentials([string(credentialsId: 'sonar-credentials', variable: 'SONAR_TOKEN')]) {
                sh 'sonar-scanner -Dsonar.login=$SONAR_TOKEN'
                }
            }
        } */
    }
    /* post {
        success {
            slackSend(channel: "${SLACK_CHANNEL}", message: "✅ *Pipeline Successful*: `${JOB_NAME}` build #${BUILD_NUMBER} (<${BUILD_URL}|View Build>)")
        }
        failure {
            slackSend(channel: "${SLACK_CHANNEL}", message: "🚨 *Pipeline Failed*: `${JOB_NAME}` build #${BUILD_NUMBER} (<${BUILD_URL}|View Build>)")
        }
        always {
            cleanWs()
        }
    } */
}
