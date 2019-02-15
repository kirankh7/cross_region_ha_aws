#!/usr/bin/env bash

#set -ex

curl -L https://www.opscode.com/chef/install.sh | sudo bash

# Create chef directory
dir="/var/chef/cookbooks"
if [[ ! -e $dir ]]; then
    sudo mkdir -p $dir
elif [[ ! -d $dir ]]; then
    echo "$dir already exists but is not a directory" 1>&2
fi

echo "Provisioning an application node"
sudo chef-solo -c  /tmp/chef/solo.rb -j /tmp/chef/nginx.json