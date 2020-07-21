pipeline {
  agent any
  environment {
    KUBECONFIG = credentials('jslay-k8s-kubeconfig')
  }
  stages {
    stage('Deploy k8s YAMLs') {
      steps {
        script {
          docker.image('alpine/k8s:1.18.2').inside("-v $KUBECONFIG:/tmp/kubeconfig -e KUBECONFIG=/tmp/kubeconfig --entrypoint=''") {
            sh """
            sed -i s/GIT_COMMIT/$GIT_COMMIT/g k8s-deploy/* && kubectl apply --namespace jslay-net -f k8s-deploy/
            """
          }
        }
      }
    }
  }
}
