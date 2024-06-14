pipeline {
    agent any

  
    stages {
       stage('Clean Workspace') {
            steps {
                // Clean the workspace
                cleanWs()
            }
        } 
      stage('Clone Repository') {
            steps {
                // Clone your GitHub repository
                git branch: 'main', url: 'https://github.com/Prathamesh78/AWS-Data_Pipeline.git'
            }
        }
      stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }
    }
}
