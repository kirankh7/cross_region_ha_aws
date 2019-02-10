#
# Cookbook:: configure-app
# Recipe:: default
#
# Copyright:: 2019, Kiran Haridas, All Rights Reserved.

file “/tmp/hello.txt” do
  content “Kiran ookbook recipe\n”
  action :create
end

# Install nginx package
package 'nginx' do
  action :install
end

# Enable service
service 'nginx' do
  action [ :enable, :start ]
end

# file with in cookbooks
# cookbook_file "/usr/share/nginx/www/index.html" do
#   source "index.html"
#   mode "0644"
# end

# generate template
template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  notifies :reload, "service[nginx]"
end
