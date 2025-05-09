# Project to create AWS resoures using terraform and install jenkins using ansible

install terraform and ansible 

install AWS CLI 

curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

aws --version 

AWS configure   --- # add access key, sectret key and region 

git clone https://github.com/ankitpateriya16/terraform

cd terraform

terraform init

terraform plan

terraform apply --auto-approve

# check the output you must got public and private ip of EC2 instance and .pem file, save public ip in nodepad

terraform output -raw private_key_pem > jenkins_key.pem    ---   #copy the output pem file in local pem file

chmod 400 jenkins_key.pem   ---  # change the permissions

# edit the ansible hosts file and add the host with below code

sudo vi /etc/ansible/hosts

[jenkins_servers]

server1 ansible_host= public ip of server1  --- # put public ip here

server2 ansible_host=public ip of server2
 
[all:vars]

ansible_user=ubuntu

ansible_ssh_private_key_file=path/to/your/pemfile-    ---- # add path of public key

ansible_python_interpreter=/usr/bin/python3

# run ansible play book 

ansible jenkins-servers -m ping  ---- # check if host are reachable 

ansible-playbook -t /etc/ansible/hosts install-jenkins.yaml

# ssh the server using below cmd and check jenkins install or not

ssh -i jenkins_key.pem ubuntu@publicip

jenkins --version

 



