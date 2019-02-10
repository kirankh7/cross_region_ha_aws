#!/usr/bin/env bash
curl -L https://www.opscode.com/chef/install.sh | sudo bash

echo "Provisioning an application node"
sudo chef-solo -c chef/solo.rb -o configure-app


# if [[ "$1" == "app" ]]; then
# 	echo "Provisioning an application node"
# 	sudo chef-solo -c chef/solo.rb -o example_app
#
# elif [[ "$1" == "lb" ]]; then
# 	echo "Provisioning a load balancer node, app nodes: $APP_NODES"
# 	# we need -E to pass the environment to chef-solo; namely $APP_NODES
# 	sudo -E chef-solo -c chef/solo.rb -o example_web
# fi
