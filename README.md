# Multi-Environment-Infrastructure-using-Terraform

         ___        ______     ____ _                 _  ___  
        / \ \      / / ___|   / ___| | ___  _   _  __| |/ _ \ 
       / _ \ \ /\ / /\___ \  | |   | |/ _ \| | | |/ _` | (_) |
      / ___ \ V  V /  ___) | | |___| | (_) | |_| | (_| |\__, |
     /_/   \_\_/\_/  |____/   \____|_|\___/ \__,_|\__,_|  /_/ 
 ----------------------------------------------------------------- 


Hi there! Welcome to AWS Cloud9!

In the Code I have created the 2 VPC and connection in between them all the servers are on Private Network that are only accessiable by the Public device (Bastion) which is connected to the internet.

This code have Infrastructure and Modules.
Modules have all the basic Config. of network and global variables.
Infrastructure contains the Prod and Non prod Enviornment 

In order to run this code you need to follow the following steps:
1) Run the Code Nonprod>>01-NonProd-Network
2) Run the Code Nonprod>>02-NonProd-Webserver
3) Run the Code Nonprod>>01-Prod-Network
4) Run the Code Nonprod>>02-Prod-Webserver
5) Run the Code Peering

After this SSH the Bastion public IP
After this copy the Both  Assignment1-nonprod and Assignment1-prod private keys on the bastion server then you can do SSH on both Servers in nonprod and prod vpc and you use curl command to check the webserver  connectivity of the servers in nonprod VPC

Note*
 If anything happend with permission or unable to  ssh then kinldy look into keys  access perform the "chmod 600 keyname" to assing the rw access to the keys.

In order to destroy you follow the following steps:

a) Destroy the Code Peering
b) Destroy the Code Nonprod>>02-Prod-Webserver
c) Destroy the Code Nonprod>>01-Prod-Network
d) Destroy the Code Nonprod>>02-NonProd-Webserver
e) Destroy the Code Nonprod>>01-NonProd-Network

 
 
 If anything happend with the key kinldy look its access 


Happy coding!
