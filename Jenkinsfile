node{
      def dockerImageName= 'vasireddysamrat/javadedockerapp_$JOB_NAME:$BUILD_NUMBER'
      stage('SCM Checkout'){
         git 'https://github.com/vasireddysamrat/CICD_DOCKER'
      }
      stage('Build'){
         // Get maven home path and build
         def mvnHome =  tool name: 'Maven_Jenkins', type: 'maven'   
         sh "${mvnHome}/bin/mvn package -Dmaven.test.skip=true"
      }       
     
     stage ('Test'){
         def mvnHome =  tool name: 'Maven_Jenkins', type: 'maven'    
         sh "${mvnHome}/bin/mvn verify; sleep 3"
      }
      
     stage('Build Docker Image'){         
           sh "docker build -t ${dockerImageName} ."
      }  
   
      stage('Publish Docker Image'){
            
        
              sh "docker login -u vasireddysamrat -p ${dockerPWD}"
       
        sh "docker push ${dockerImageName}"
     
      
      }         
    stage('Run Docker Image'){
            def dockerContainerName = 'javadockerapp_$JOB_NAME_$BUILD_NUMBER'
            def changingPermission='sudo chmod +x stopscript.sh'
            def scriptRunner='sudo ./stopscript.sh'           
            def dockerRun= "sudo docker run -p 8082:8080 -d --name ${dockerContainerName} ${dockerImageName}" 
              
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ubuntu@54.147.82.150" 
                  sh "sshpass -p ${dpPWD} scp -r stopscript.sh ubuntu@54.147.82.150:/home/ubuntu" 
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ubuntu@54.147.82.150 ${changingPermission}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ubuntu@54.147.82.150 ${scriptRunner}"
                  sh "sshpass -p ${dpPWD} ssh -o StrictHostKeyChecking=no ubuntu@54.147.82.150 ${dockerRun}"
           
              }
      
      
      
         
  }
      
