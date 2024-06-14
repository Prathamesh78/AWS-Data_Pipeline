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
      stage('Terraform Apply All Resources') {
            steps {
                dir('terraform') {
                    sh '''
                    terraform apply -auto-approve \
                        -var="aws_access_key_id=${AWS_ACCESS_KEY_ID}" \
                        -var="aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" \
                        -var="rds_db_name=${RDS_DB_NAME}" \
                        -var="rds_username=${RDS_USERNAME}" \
                        -var="rds_password=${RDS_PASSWORD}"
                    '''
                }
            }
        }
    }
}
