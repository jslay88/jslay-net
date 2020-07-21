pipeline {
  agent any
  environment {
    KUBECONFIG = credentials('jslay-k8s-kubeconfig')
    REPO_USER = "jslay88"
    REPO_NAME = "jslay-net"
    COPY_DIR = "site"
    HOST = "jslay.net"
  }
  stages {
    stage('Deploy k8s YAMLs') {
      when {
        anyOf {
          branch 'master'
        }
      }
      steps {
        script {
          docker.image('alpine/k8s:1.18.2').inside("-v $KUBECONFIG:/tmp/kubeconfig \
                                                    -e KUBECONFIG=/tmp/kubeconfig \
                                                    --entrypoint=''") {
            sh """
            sed -i s/REPO_USER/$REPO_USER/g k8s-deploy/* && \
            sed -i s/REPO_NAME/$REPO_NAME/g k8s-deploy/* && \
            sed -i s/COPY_DIR/$COPY_DIR/g k8s-deploy/* && \
            sed -i s/HOST/$HOST/g k8s-deploy/* && \
            sed -i s/GIT_COMMIT/$GIT_COMMIT/g k8s-deploy/* && \
            kubectl apply --namespace $REPO_NAME -f k8s-deploy/
            """
          }
        }
      }
    }
  }
}
