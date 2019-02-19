# cross_zone_ha_aws



![Alt text](aws-ha-app.png?raw=true "AWS_HA")


Steps to start cross-region & cross-az high availability server  

create a shell script that takes $1 ->eu-west-1 & $2 -> us-east1

For demo purpose workspaces are already created

To deploy app run below command, this will provision 3-tier app on 
eu-west-1(primary) & us-east-1(secondary)

sh terraform_ha_stack/run_deploy.sh

