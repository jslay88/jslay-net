pipeline {
  agent any
  environment {
    KUBECONFIG = credentials('jslay-k8s-kubeconfig')
  }
  stages {
    stage('Deploy k8s YAMLs') {
      steps {
        script {
          docker.image('alpine/helm:3.2.1').inside("-v $KUBECONFIG:/tmp/kubeconfig -e KUBECONFIG=/tmp/kubeconfig --entrypoint=''") {
            sh """
            GIT_COMMIT=${GIT_COMMIT}; kubectl apply -f k8s-deploy/
            """
          }
        }
      }
    }
  }
}
