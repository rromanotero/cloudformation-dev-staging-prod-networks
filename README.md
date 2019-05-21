# cloudformation-dev-staging-prod-networks
Cloudformation templates to set up a dev-staging and a production network in AWS. Both dev-staging and production have public server subnets and private data subnets, both public and private also have an A and B versions on different AZs (so you have public subnet A, public subnet B, private subnet A, private subnet B). 

<p align="center">
  <img src="https://github.com/rromanotero/cloudformation-dev-staging-prod-networks/blob/master/architecture.png" width="460"/>
  <p align="center">So, an empty pair of networks</p>
</p>

The CIDR reanges are from... I can't remember I did this over a year ago, but you can look them up in the templates! (there's plenty of IPs)

## Instructions


## Manual Instructions
1. Edit the region on the template. It's curently set up to ca-central
2. Bring up all the stacks in /prod in this order and WITH THIS SAME STACK NAMES:

   a) prod-network
   b) prod-route-table
   c) prod-network-acl
   d) prod-network-acl-server-ingress-rules
   e) prod-network-acl-server-egress-rules
   f) prod-network-acl-data-ingress-rules
   g) prod-network-acl-data-egress-rules
   h) prod-security-group-server
   i) prod-security-group-data

4. Update/replace prod-security-group-server with prod-security-group-server-UPDATE
   (prod-security-group-server-UPDATE has one extra rule that references prod-security-group-data. We do it this way to avoid cyclic dependencies)

3. Manually remove the outbond rule from Prod Data Security Group
   that allows out ALL TRAFFIC ON ALL PORTS (CloudFormation somehow interprets empty list as let all traffic out).
	 
Note you'll need a tunnel (bastion) ec2 to access databases in the private data. That's it. 


