pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: node
      image: node:18
      command: ['cat']
      tty: true

    - name: kaniko
      image: gcr.io/kaniko-project/executor:debug
      command: ['cat']
      tty: true
      volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker

    - name: kubectl
      image: bitnami/kubectl:latest
      command: ['cat']
      tty: true

  volumes:
    - name: kaniko-secret
      secret:
        secretName: dockerhub-secret
"""
        }
    }

    environment {
        IMAGE = "shabaz7323/shabaz:latest"
    }

    stages {

        stage('Checkout') {
            steps {
                container('node') {
                    checkout scm
                }
            }
        }

        stage('Install') {
            steps {
                container('node') {
                    sh 'npm install'
                }
            }
        }

        stage('Build & Push Image with Kaniko') {
            steps {
                container('kaniko') {
                    sh """
                    /kaniko/executor \
                      --dockerfile=Dockerfile \
                      --context=`pwd` \
                      --destination=$IMAGE \
                      --verbosity=info
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                container('kubectl') {
                    sh 'kubectl rollout restart deployment shabaz'
                }
            }
        }
    }
}
