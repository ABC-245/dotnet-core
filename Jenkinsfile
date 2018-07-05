timestamps {

node ('linuxslave') { 

	stage ('IR-ProdMaintSer - Checkout') {
 	 checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '8d4da9bc-7e8e-4ecd-a3cd-ded741928fb8', url: 'https://git-codecommit.us-east-2.amazonaws.com/v1/repos/ProductMaintenanceService']]]) 
	}
	stage ('IR-ProdMaintSer - Build') {
 			// Shell build step
        withAWS(credentials:'ashok-aws-key'){
                sh 'eval $(aws ecr get-login --no-include-email --region us-east-2)'
                sh """
                docker build -t tsmt-prodmaintservice-ecr:$TAG_NAME .
                docker tag tsmt-prodmaintservice-ecr:$TAG_NAME 407769799504.dkr.ecr.us-east-2.amazonaws.com/tsmt-prodmaintservice-ecr:$TAG_NAME
                docker push 407769799504.dkr.ecr.us-east-2.amazonaws.com/tsmt-prodmaintservice-ecr:$TAG_NAME
                """
        }
	}
}
}