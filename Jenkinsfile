pipeline {
    stages {
        stage('更新开始') {
            steps {
                echo '更新开始'
                sh 'printenv'
            }
        }

       stage('Preparation') {
          git 'git@github.com:lennonn/cloud-native.git'
       }

          stage('Maven Build') {
             sh "clean install -Dmaven.test.skip=true"
          }
    }
}