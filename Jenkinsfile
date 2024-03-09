pipeline {
    stages {
        stage('更新开始') {
            steps {
                echo '更新开始'
                sh 'printenv'
            }
        }

       stage('Preparation') {
          git 'git@github.com:lennonn/zlennon-java-tutorials.git'
       }

          stage('Maven Build') {
             sh "clean install -pl cloud-native  -am -amd -Pdev -Dmaven.test.skip=true"
          }

        stage('build-image') {
            steps {
                retry(2) { sh 'docker build . -t cloud-native:latest'}    #构建镜像
            }
        }
        stage('deploy') {
            steps {
                timeout(time: 1, unit: 'MINUTES') {sh "kubectl apply -f deploy/"     #创建deployment
                }
            }
        }
    }
}