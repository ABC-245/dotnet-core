timestamps {

node ('linuxslave') { 

	stage ('abc - Checkout') {
 	 checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '8d4da9bc-7e8e-4ecd-a3cd-ded741928fb8', url: 'https://github.com/ankyyyjst4u/dotnet-core.git']]]) 
	}
	stage ('abc - Build') {
 			// Shell build step
        withAWS(credentials:'ashok-aws-key'){
                sh 'eval $(aws ecr get-login --no-include-email --region us-east-2)'
                sh """
                docker build -t abc:$TAG_NAME .
                docker tag abc:$TAG_NAME 407769799504.dkr.ecr.us-east-2.amazonaws.com/abc:$TAG_NAME
                docker push 407769799511104.dkr.ecr.us-east-2.amazonaws.com/abc:$TAG_NAME
                """     
        }
	}
}
}
