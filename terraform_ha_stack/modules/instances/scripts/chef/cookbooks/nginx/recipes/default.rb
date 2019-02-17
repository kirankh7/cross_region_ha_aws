#c
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Update repo at specific interval


execute 'install_package' do
  command 'cp -a /tmp/chef/terra_templates/nginx.conf.erb.tpl /tmp/chef/cookbooks/nginx/templates/nginx.conf.erb'
end

execute 'sudo yum -y update' do
  action :run
end

execute 'install_nginx_package' do
  command 'sudo amazon-linux-extras install nginx1.12'
end

service 'nginx' do
  action [:enable, :start ]
end

directory '/etc/nginx/conf.d/' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end


template '/etc/nginx/conf.d/flaskapp.conf' do
  source 'flaskapp.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[nginx]', :immediately
  variables(iplist: node['nginx']['flaskips'])
end



# package 'Install Apache' do
#   case node[:platform]
#     when 'redhat', 'centos'
#       package_name 'httpd'
#     when 'ubuntu', 'debian'
#       package_name 'apache2'
#   end
# end
