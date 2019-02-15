#c
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Update repo at specific interval

execute 'sudo yum -y update' do
  action :run
end

execute 'install_supervisor_package' do
  command 'sudo amazon-linux-extras install nginx1.12'
end

service 'nginx' do
  action [:enable, :start ]
end

execute 'install_package' do
  command 'cp -a /tmp/instance_config/nginx.conf.erb.tpl /tmp/chef/cookbooks/nginx/templates/nginx.conf.erb'
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[nginx]', :immediately
end

# package 'Install Apache' do
#   case node[:platform]
#     when 'redhat', 'centos'
#       package_name 'httpd'
#     when 'ubuntu', 'debian'
#       package_name 'apache2'
#   end
# end
