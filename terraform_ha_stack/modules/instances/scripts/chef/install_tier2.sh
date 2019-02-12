#!/usr/bin/env bash
curl -L https://www.opscode.com/chef/install.sh | sudo bash

# Create chef directory
dir="/var/chef/cookbooks"
if [[ ! -e $dir ]]; then
    mkdir -p $dir
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi
#
#cp -a /tmp/chef/cookbooks/configure-app $dir/
#cp -a /tmp/chef/node.json /var/chef

echo "Provisioning an application node"
sudo chef-solo -c  /tmp/chef/solo.rb -j /tmp/chef/node.json


# if [[ "$1" == "app" ]]; then
# 	echo "Provisioning an application node"
# 	sudo chef-solo -c chef/solo.rb -o example_app
#
# elif [[ "$1" == "lb" ]]; then
# 	echo "Provisioning a load balancer node, app nodes: $APP_NODES"
# 	# we need -E to pass the environment to chef-solo; namely $APP_NODES
# 	sudo -E chef-solo -c chef/solo.rb -o example_web
# fi
