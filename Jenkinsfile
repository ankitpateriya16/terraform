  pipeline {
  agent any

  environment {
    TF_DIR = 'terraform'
    PEM_PATH = 'pem/my-key.pem'
  }

  stages {
      stage('Clean Workspace') {
      steps {
        cleanWs()
      }
    }

    stage('Checkout Code') {
      steps {
         sh 'git clone https://github.com/ankitpateriya16/terraform'
      }
    }
  
    stage('Terraform Apply') {
       steps {
         withCredentials([string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY'), string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_KEY')]) {
                sh '''
                  export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
                  export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
                  export AWS_REGION=us-east-1
                  cd terraform
                  terraform init
                  terraform plan
                  terraform apply -auto-approve
                 
                '''
    }
  }
    }
    
    stage('Fetch Private Key') {
      steps {
        sh '''
          mkdir -p pem
          cd terraform
          terraform output -raw private_key_pem > ../pem/my-key.pem
          chmod 400 ../pem/my-key.pem
    '''
  }
}
    stage('Generate Ansible Inventory') {
      steps {
          sh '''
            mkdir -p ansible
            cd terraform
 
            # Get all IPs as a list and store them
            terraform output -json public_ips | jq -r '.[]' > public_ips.txt
 
            cd ..
            echo "[jenkins-servers]" > ansible/hosts.ini
 
            while read ip; do
                echo "$ip ansible_user=ubuntu ansible_ssh_private_key_file=$WORKSPACE/pem/my-key.pem" >> ansible/hosts.ini
            done < terraform/public_ips.txt
        '''
      }
    }
    stage('Run Ansible Playbook') {
      steps {
        sh '''
          ansible-playbook -i ansible/hosts.ini  terraform/install-jenkins.yaml
        '''
      }
    }
  }
  post {
    always {
      // Clean up key from workspace
      sh 'rm -rf pem'
    }
  }
}
