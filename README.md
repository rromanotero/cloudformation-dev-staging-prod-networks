# Cloudformation Dev-Staging and Production VPCs (subnets, network ACLs, route tables, and security groups)
Cloudformation templates to set up a dev-staging and a production network in AWS. Both dev-staging and production have public server subnets and private data subnets, both public and private also have an A and B versions on different AZs (A is one AZ, B is a different AZ). So you have public subnet A, public subnet B, private subnet A, private subnet B, for each VPC. For each VPC there's also in spare network in each AZ (Spare A and Spare B) for unforeseen adjustments in the future.

<p align="center">
  <img src="https://github.com/rromanotero/cloudformation-dev-staging-prod-networks/blob/master/architecture.png" width="540"/>
  <p align="center">So, an empty pair of VPCs with 4 subnets each (2 public and 2 private). Spare subnets are not shown.</p>
</p>

This is a sample architecture that I recently set up with this template:

<p align="center">
  <img src="https://github.com/rromanotero/cloudformation-dev-staging-prod-networks/blob/master/sample_architecture.png" width="540"/>
  <p align="center">The EC2s in autoscaling are replicated across two different AZs. The DB is MultiAZ as well.</p>
</p>

The CIDR reanges are from... I can't remember I did this over a year ago, but there's over 4k per subnet. prod and dev-staging do not have repeating IPs. 


## Instructions
(If needed edit the region on the template. It's currently set up to ca-central)
1. git clone https://github.com/rromanotero/cloudformation-dev-staging-prod-networks.git
2. cd cloudformation-dev-staging-prod-networks
2. chmod +x run.sh
3. ./run.sh (if this fails you can do it manually from CloudFormatoin UI, see Manual Instructions below)
4. Manually remove the outbond rule from Prod Data Security Group
   that allows out ALL TRAFFIC ON ALL PORTS (CloudFormation somehow interprets empty list as let all traffic out).
	 
Note you'll need a tunnel (bastion) ec2 to access databases in the private data. That's it. 

If everything went well, you should see the following:

<p align="center">
  <img src="https://github.com/rromanotero/cloudformation-dev-staging-prod-networks/blob/master/subnets-screenshot.png" width="540"/>
  <p align="center">Results</p>
</p>


## Manual Instructions
1. Edit the region on the template. It's currently set up to ca-central
2. Bring up all the stacks in /prod in this order and WITH THIS SAME STACK NAMES:

   - prod-network
   - prod-route-table
   - prod-network-acl
   - prod-network-acl-server-ingress-rules
   - prod-network-acl-server-egress-rules
   - prod-network-acl-data-ingress-rules
   - prod-network-acl-data-egress-rules
   - prod-security-group-server
   - prod-security-group-data

3. Repeat step 2 for dev-staging (see run.sh for reference)
4. Update/replace prod-security-group-server with prod-security-group-server-UPDATE
   (prod-security-group-server-UPDATE has one extra rule that references prod-security-group-data. We do it this way to avoid cyclic dependencies)
5. Repeat step 4 for dev-staging


