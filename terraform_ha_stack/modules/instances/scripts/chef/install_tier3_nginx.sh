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

export IP_LIST=$(cat /var/iplist)
sed -i 's/\(=\)\(.*\)/\1'%w\("$IP_LIST"\)'/' /tmp/chef/cookbooks/nginx/attributes/nginx.rb
echo "Coping rendered template to location
      Planning to all looping with terrafrom"
#cp -a /tmp/chef/terra_templates/nginx.conf.erb.tpl /tmp/chef/cookbooks/nginx/templates/nginx.conf.erb

echo "Provisioning an application node"
sudo chef-solo -c  /tmp/chef/solo.rb -j /tmp/chef/nginx.json