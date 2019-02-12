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
sudo chef-solo -c  /tmp/chef/solo.rb -j /tmp/chef/nginx.json