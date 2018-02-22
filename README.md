#Prerequisites

*) A standalone instance (t2.micro) where all your code/templates reside. (in this case, the current logged in instance)

*) Download the Terraform zip file and install, post which put it in the right path and check the version (terraform --version)

*) Creation Of Access and Secret keys for user "akshay" via the aws console in order to access via CLI 


#Writing Of Terraform Templates

*) There are 2 modules and 3 sub-modules written as the assignment state.

*) 3 folders are created (alb-formation, ec2-launch, my-service)

*) The above 3 can be considered as as 1 module, each written to do a specific task i;e

  1) Alb-formation folder holds (main.tf, variable.tf) which specify the entire set of resources and variables in order to 	
    a) Create an alb
    b) Create an alb-target-group
    c) Create Listeners for the ALB
    d) Specify the 2 different AZ's for the target nodes

 Note : I have written the template for attaching created ec2 nodes to target group targets,  but due to a tree dependency i couldnt fit it in (a lot of changes would be needed which i just realised post work on Ansible as well). Hence once the main function is run and all built, we will just have to add the 2 nodes to the targets within the alb's target group and hit the ALB endpoint in order to get nginx.

  2) Ec2-Launch folder holds (main.tf, variable.tf) which specifies all the EC2 node details to be launched, as well as Ansible details which i implemented using provisioners for loca-execution of commands in order to do a remote configuration management (in our case, installation of nginx and starting of the service)


  3) My-service folder is the main folder from where we should run "terraform apply". This has the all the sub-folders condensed into 3 different "module calls".


*) There is another folder called "Ansible" which does the following  : 

   a) Have written a playbook for installion of nginx and starting of the service
   b) This playbook would be run during the formation of the infra via the "ec2-launch" module which i have written.

This will basically help in capturing of the newly created ec2 host ip's and put them into a "/etc/ansible/hosts" file which would be cleaned after every run (this agian is handled by the ec2-launch module), this would call the playbook with the desired command, point to the private key which is needed by ansible in order to ssh into the newly created hosts and so on.


#Conclusion 

Altogether the setup has  : 

1 module for ALB setup : "alb-formation" module

1 Module which is divided into 2 (in order to show the different variable passing scenarios which can be handled via the same module) : "instance-1" and "instance-2" modules.
This also has new keypair creation on the fly in order to help us ssh into the newly created instances by terraform stack

Ansible setup and playbook which will be loaded on the fly during formation of the infra is also handled. 

*Can give a quick walkthrough (15 mins) on the entire flow if needed.I would be sharing 2 keys, one called "akshay-terra" for logging into (current) host and other "terra-foramtion-1" to ssh into any instance launched or created via this terraform setup.
