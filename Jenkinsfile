pipeline {
    agent any
    /*tools {
        sonarQubeScanner 'sonar-scanner'  // Name must match what you added in Jenkins 
    }*/
    environment {
        IMAGE_NAME = "thethymca/weather_forecasting_project:${BUILD_NUMBER}"
        DOCKER_REGISTRY = "https://index.docker.io/v1"
        //SLACK_CHANNEL = '#jenkins-new'
        //SONAR_SCANNER_HOME = tool name: 'SonarScanner CLI', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
        PATH = "/opt/sonar-scanner/bin:${env.PATH}"
        SONAR_TOKEN = credentials('sonar-credentials') // Added this in Jenkins → Credentials

    }
    stages {
        stage ('git checkout code'){
            steps {
                git branch: 'main', url: 'https://github.com/harkaur02/weather_forecasting_project.git'
            }
        }
        /* //following code is correct too
        stage('SonarQube Analysis') {
          steps {
            sh 'echo $PATH'
            withSonarQubeEnv('SonarQube') { /*'SonarQube' from Manage-jenkins -> system -> SonarQube servers -> SonarQube installations -> Name*/
              /*sh '''
                sonar-scanner \
                  -Dsonar.projectKey=weather-forecast \
                  -Dsonar.sources=. \
                  -Dsonar.host.url=http://15.223.220.252:9000/ \
                  -Dsonar.login=$SONAR_TOKEN
              '''
            }
          }
        }*/
        /*stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarScanner CLI') {
                    sh '$SONAR_SCANNER_HOME/bin/sonar-scanner'
                }
            }
        }*/
        stage('SonarQube Scan') {
            steps {
                withCredentials([string(credentialsId: 'sonar-credentials', variable: 'SONAR_TOKEN')]) {
                sh 'sonar-scanner -Dsonar.login=$SONAR_TOKEN'
                }
            }
        }
        /*stage('Docker build') {
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
        }
        stage('Trigger Next Pipeline for CD part') {
            steps {
                build job: 'weather-forecast-CD', wait: false
            }
        }*/
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
