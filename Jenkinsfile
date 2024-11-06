pipeline {
    agent any
    environment {
        IMAGE_NAME = "koenigfranxx/miapp"
        IMAGE_TAG = "${env.BUILD_ID}"
        KUBECONFIG_CREDENTIALS_ID = "k3s-kubeconfig"
    }
    stages {
        stage('Clonar Repositorio') {
            steps {
                git branch: 'main', url: 'https://github.com/koenigfranx/myapp.git', credentialsId: 'git-credentials'
            }
        }
        stage('Construir Imagen') {
            steps {
                script {
                    sh "buildah bud -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Pruebas Automatizadas') {
            steps {
                script {
                    sh "ctr run --rm ${IMAGE_NAME}:${IMAGE_TAG} test-container ./run_tests.sh"
                }
            }
        }
        stage('Subir Imagen') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "echo $PASSWORD | buildah login -u $USERNAME --password-stdin docker.io"
                    sh "buildah push ${IMAGE_NAME}:${IMAGE_TAG} docker://${IMAGE_NAME}:latest"
                }
            }
        }
        stage('Desplegar en K3s') {
            steps {
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }
    }
    post {
        failure {
            mail to: 'admin@example.com',
                 subject: "Falló el pipeline: ${currentBuild.fullDisplayName}",
                 body: "Revisa el log en ${env.BUILD_URL}"
        }
    }
}
