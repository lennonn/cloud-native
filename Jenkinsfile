pipeline {
    agent {
        kubernetes {
            inheritFrom 'zlennon-k8s'
            inheritFrom 'mypod'
        }
    }
    environment {
        DOCKER_REGISTRY = "zlennon" // 设置 Docker Registry 地址
        IMAGE_NAME = "cloud-native" // 设置镜像名称
        TAG = "latest" // 设置标签
    }

    stages {
            // 拉取代码
        stage('git clone') {
            steps {
                git branch: "main", credentialsId: "github-private-key", url: "https://github.com/lennonn/cloud-native.git"
                echo 'git success'
                echo $PATH
            }
        }
        //  运行源码打包命令
        stage('Package'){
         steps{
              container('maven') {
                  // sh 'java -version'
                 sh 'mvn clean package'
                 echo 'package success'
              }
          }
        }

        // 运行容器镜像构建和推送命令
        stage('Image Build And Publish'){
            steps {
                container('docker') {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-account', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                        docker build -t $DOCKER_REGISTRY/$IMAGE_NAME:$TAG .
                        echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                        docker push $DOCKER_REGISTRY/$IMAGE_NAME:$TAG
                        """
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                sh 'kubectl apply -f kube.yaml'
            }
        }
    }
}