pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:

    # Node container for npm install
    - name: node
      image: node:18
      command: ['cat']
      tty: true

<<<<<<< HEAD
    # Kaniko container for Docker build & push
=======
>>>>>>> b8c8acf641e249b5e9a740a5f2ad606a8884f121
    - name: kaniko
      image: gcr.io/kaniko-project/executor:debug
      command: ['cat']
      tty: true
      volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker

<<<<<<< HEAD
    # Kubectl container for deployment
    - name: kubectl
      image: lachlanevenson/k8s-kubectl:v1.27.3
=======
    - name: kubectl
      image: bitnami/kubectl:latest
>>>>>>> b8c8acf641e249b5e9a740a5f2ad606a8884f121
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

        stage('Checkout SCM') {
            steps {
                container('node') {
                    checkout scm
                }
            }
        }

        stage('Install Node Modules') {
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
<<<<<<< HEAD
                    sh "kubectl rollout restart deployment shabaz"
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Pipeline successful! Image pushed and deployment restarted."
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
=======
                    sh 'kubectl rollout restart deployment shabaz'
                }
            }
>>>>>>> b8c8acf641e249b5e9a740a5f2ad606a8884f121
        }
    }
}
