# DataCenter Enviroment 1
Terraform Module that will create the AWS Networking Stack with FGT, FMG and an Apache Server and utilize AWS Route53 for DNS. 

The module will create the below resources:

- Networking Stack (VPC, Subnets, Route Tables, Security Groups and Internet Gateway) - Please refer to the diagram below. 
- FortiGate with 2 interfaces (one in the Public and one in the Private subnets)
- FortiManager in the public subnet
- Ubunutu Server with Apache installed on it.  (username: user / password: fortinet123)
- 2 x Route53 DNS Hosted Zones (one public and one Private)


// The DNS Hosted Zones must be sub-zones for a domain that is registered or managed by AWS Route53 //

// i.e xyz.com is the domain name and you will create the subzone Lab1.xyz.com // 


![image](https://user-images.githubusercontent.com/83562796/117002411-87a72880-acb1-11eb-911c-6f48d8bfaf74.png)
