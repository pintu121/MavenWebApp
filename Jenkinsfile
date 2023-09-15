pipeline {
    agent {
        node {
            label 'slavenode'
        }
    }
    environment {     
    DOCKERHUB_CREDENTIALS= credentials('jenkins-cred')     
      } 
    tools {
        maven 'maven.3.94'
    }

    stages {
        stage('Code'){
             steps {
                 git branch: 'main', url: 'https://github.com/pintu121/MavenWebApp.git'
             }
         }
        stage('Maven Code build') {
            steps {
                echo "-----------build started-----------"
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
                echo "-----------build complted----------"
            }
        }
        stage ('Build Docker Image') {
            steps {
                sh 'docker build . -t pin2patra/webapp:latest'   
            }
        }
        stage('Login to Docker Hub') {         
           steps{                            
	          sh 'echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'                 
	          echo 'Login Completed'                
            }           
         }
         stage('Push Image to Docker Hub') {         
          steps {                            
	          sh 'sudo docker push pin2patra/webapp:latest'                 
	          echo 'Push Image Completed'       
            }           
        }  
         
        stage('Deployment') {
          steps {
            node('deployment') {
            sh 'docker run -itd --name pintuwap -p 8080:80 pin2patra/webapp:latest' 
            }
          
         }
       }
    }
}