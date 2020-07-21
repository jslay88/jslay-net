def app

pipeline {
  agent any
  environment {
    KUBECONFIG = credentials('jslay-k8s-kubeconfig')
  }
  stages {

    stage('Clone Repository') {
      /* Let's make sure we have the repository cloned to our workspace */
      steps {
        checkout scm
      }
    }
    stage('Deploy k8s YAMLs') {
      steps {
        docker.image('alpine/helm:3.2.1').inside("-v $KUBECONFIG:/tmp/kubeconfig -e KUBECONFIG=/tmp/kubeconfig --entrypoint=''") {
          sh """
          kubectl apply -f k8s-deploy/
          """
        }
      }
    }
  }
}
