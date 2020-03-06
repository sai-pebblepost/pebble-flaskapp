String version
String awsRegion = "us-east-1"
String branchName = env.BRANCH_NAME

pipeline {
    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '30'))
        disableConcurrentBuilds()
        timeout(time: 6, unit: 'HOURS')
    }

    stages {
        
		stage('flaskapp') {
            steps {
                    sh"""
                    rm -r pebble-terraform
					git clone https://github.com/sai-pebblepost/pebble-terraform.git
					cd pebble-terraform/ec2-instances/app-server-blue/
					terraform init
					terraform plan
					terraform apply --auto-approve
                        """
                }
            }
            
            
        stage('Deploy Approval'){
             when  {
                expression { branchName == 'master' }
            }
            agent none
            steps{
                timeout(time: 1, unit: 'DAYS'){
                    input('do you want to make the changes ?')
                }

            }
        }
        
        stage('flaskapp-deploy') {
            steps {
                    sh"""
					terraform apply --auto-approve
                        """
                }
            }
            
        
        }
}
