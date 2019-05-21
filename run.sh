echo "Production stacks"
echo "================="
aws cloudformation deploy --template prod/prod-network.json --stack-name prod-network
aws cloudformation deploy --template prod/prod-route-table.json --stack-name prod-route-table
aws cloudformation deploy --template prod/prod-network-acl.json --stack-name prod-network-acl
aws cloudformation deploy --template prod/prod-network-acl-server-ingress-rules.json --stack-name prod-network-acl-server-ingress-rules
aws cloudformation deploy --template prod/prod-network-acl-server-egress-rules.json --stack-name prod-network-acl-server-egress-rules
aws cloudformation deploy --template prod/prod-network-acl-data-ingress-rules.json --stack-name prod-network-acl-data-ingress-rules
aws cloudformation deploy --template prod/prod-network-acl-data-egress-rules.json --stack-name prod-network-acl-data-egress-rules
aws cloudformation deploy --template prod/prod-security-group-server.json --stack-name prod-security-group-server
aws cloudformation deploy --template prod/prod-security-group-data.json --stack-name prod-security-group-data

echo ""
echo "Update Prod Sec Group (because of cyclic dependencies)"
echo "================="
aws cloudformation deploy --template prod/prod-security-group-server-UPDATE.json --stack-name prod-security-group-server

""
echo "DevStaging Stacks"
echo "================="
aws cloudformation deploy --template dev-staging/dev-staging-network.json --stack-name dev-staging-network
aws cloudformation deploy --template dev-staging/dev-staging-route-table.json --stack-name dev-staging-route-table
aws cloudformation deploy --template dev-staging/dev-staging-network-acl.json --stack-name dev-staging-network-acl
aws cloudformation deploy --template dev-staging/dev-staging-network-acl-server-ingress-rules.json --stack-name dev-staging-network-acl-server-ingress-rules
aws cloudformation deploy --template dev-staging/dev-staging-network-acl-server-egress-rules.json --stack-name dev-staging-network-acl-server-egress-rules
aws cloudformation deploy --template dev-staging/dev-staging-network-acl-data-ingress-rules.json --stack-name dev-staging-network-acl-data-ingress-rules
aws cloudformation deploy --template dev-staging/dev-staging-network-acl-data-egress-rules.json --stack-name dev-staging-network-acl-data-egress-rules
aws cloudformation deploy --template dev-staging/dev-staging-security-group-server.json --stack-name dev-staging-security-group-server
aws cloudformation deploy --template dev-staging/dev-staging-security-group-data.json --stack-name dev-staging-security-group-data

echo ""
echo "Update Prod Sec Group (because of cyclic dependencies)"
echo "================="
aws cloudformation deploy --template dev-staging/dev-staging-security-group-server-UPDATE.json --stack-name dev-staging-security-group-server
