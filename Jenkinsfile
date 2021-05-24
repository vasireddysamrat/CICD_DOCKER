node{
      def dockerImageName= 'vasireddysamrat/javadedockerapp_$JOB_NAME:$BUILD_NUMBER'
      stage('SCM Checkout'){
         git 'https://github.com/vasireddysamrat/CICD_DOCKER'
      }
      stage('Build'){
         // Get maven home path and build
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'   
         sh "${mvnHome}/bin/mvn package -Dmaven.test.skip=true"
      }       
     
     stage ('Test'){
         def mvnHome =  tool name: 'Maven 3.5.4', type: 'maven'    
         sh "${mvnHome}/bin/mvn verify; sleep 3"
      }
      
     stage('Build Docker Image'){         
           sh "docker build -t ${dockerImageName} ."
      }  
   
      stage('Publish Docker Image'){
         withCredentials([string(credentialsId: 'Tarmas@238', variable: 'dockerPWD')]) {
              sh "docker login -u vasireddysamrat -p ${dockerPWD}"
         }
        sh "docker push ${dockerImageName}"
      }
      
    stage('Run Docker Image'){
            def dockerContainerName = 'javadockerapp_$JOB_NAME_$BUILD_NUMBER'
            def changingPermission='sudo chmod +x stopscript.sh'
            def scriptRunner='sudo ./stopscript.sh'           
            def dockerRun= "sudo docker run -p 8082:8080 -d --name ${dockerContainerName} ${dockerImageName}" 
            withCredentials([string(credentialsId: 'deploymentserverpwd', variable: 'dpPWD')]) {
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ubuntu@35.174.113.149" 
                  sh "sshpass -p ${dpPWD} scp -r stopscript.sh jenkins@35.174.113.149:/home/ubuntu" 
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ubuntu@35.174.113.149 ${changingPermission}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ubuntu@35.174.113.149 ${scriptRunner}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ubuntu@35.174.113.149 ${dockerRun}"
            }
            
      
      }
      
         
  }
      
