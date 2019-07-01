def app

pipeline {
    agent {
        kubernetes {
        label 'docker'
        yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:latest
    commands: ['ls -la']
    tty: true
    volumeMounts:
    - name: docker-sock
      mountPath: /var/run/docker.sock
  volumes:
  - name: docker-sock
    hostPath:
      path: /var/run/docker.sock
"""
        }
    }

    stages {

        stage('Clone Repository') {
            /* Let's make sure we have the repository cloned to our workspace */
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            /* This builds the actual image; synonymous to
             * docker build on the command line */
            steps {
                container('docker') {
                    script {
                        app = docker.build("jslay/jslay.net")
                    }
                }
            }
        }

        stage('Push Docker Image to Nexus') {
            /* Finally, we'll push the image with two tags:
             * First, the incremental build number from Jenkins
             * Second, the 'latest' tag.
             * Pushing multiple tags is cheap, as all the layers are reused. */
            steps {
                container('docker') {
                    script {
                        docker.withRegistry('https://docker.home.jslay.net', 'nexus-docker-push') {
                            app.push("${env.BUILD_NUMBER}")
                            app.push("latest")
                        }
                    }
                }
            }
        }

        stage('Deploy Image') {
            steps {
                kubernetesDeploy configs: 'k8s-deploy/*.yaml', dockerCredentials: [
                [credentialsId: 'nexus-docker-push', url: 'https://docker.home.jslay.net']
                ], kubeconfigId: 'jslay-k8s'
            }
        }
    }
}
