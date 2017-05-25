pipeline {
  agent any   // 你也可以使用 agent {label 'mac_for_iOS'}

  #environment {
  #  BASH_PROFILE = '~/.bash_profile'
  #}

  parameters {
      string(name: 'module', defaultValue: 'A,B,C,D,E', description: '组件')
  }

  stages {
    stage('拉取项目') {
      steps {
        git 'https://github.com/ApterKingRepo/VerifyProject.git'
      }
    }

    stage('生成配置文件') {
      steps {
        dir('./VerifyProject/Config') {
          sh "echo '${params.module}' > Config"
        }
      }
    }

    stage('配置Podfile') {
      steps {
        sh 'pwd'
        dir('./VerifyProject/fastlane') {
          sh 'bundle exec fastlane ios config_pod'
        }
      }
    }

    stage('配置模块') {
      steps {
        dir('./VerifyProject/fastlane') {
          sh 'bundle exec fastlane ios config_module'
        }
      }
    }

    stage('构建项目') {
      steps {
        dir('./VerifyProject/fastlane') {
          sh 'bundle exec fastlane ios build config:Debug'
        }
      }
    }

    stage('部署项目') {
      steps {
        dir('./VerifyProject/fastlane') {
          sh 'bundle exec fastlane ios deploy config:Debug'
        }
      }
    }
  }

  post {
    failure {
      echo '构建失败,你可以调用远程通知，或者发送一个Emai'
    }

    success {
      echo '构建成功,你可以调用远程通知，或者发送一个Email'
    }
  }
}
