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
			  agent { label 'master' }
            steps {
                    sh"""
					git clone https://github.com/sai-pebblepost/pebble-terraform.git
					cd pebble-terraform/ec2-instances/app-server-blue/
					terraform init
					terraform plan
					terraform apply --auto-approve
                        """
                }
            }
            
            
        stage('Deploy Approval'){
            agent none
            steps{
                timeout(time: 1, unit: 'DAYS'){
                    input('do you want to make the changes ?')
                }

            }
        }
        
        stage('flaskapp-deploy') {
		  agent { label 'master' }
            steps {
                    sh"""
					terraform apply --auto-approve
                        """
                }
            }
            
        
        }
}
