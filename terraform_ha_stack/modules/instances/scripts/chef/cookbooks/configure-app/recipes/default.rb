#
# Cookbook:: configure-app
# Recipe:: default
#
# Copyright:: 2019, Kiran Haridas, All Rights Reserved.

package 'python3' do
 action :install
end

package 'git' do
  action :install
end

directory '/var/flask_app' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

git '/var/flask_app' do
  repository 'https://github.com/kirankh7/disaster_flask_app.git'
  revision 'master'
  action :sync
end

execute 'apache_configtest' do
  command 'sudo pip3 install -r /var/flask_app/requirements.txt'
end

execute 'apache_configtest' do
  command 'sh /var/flask_app/run_gunicorn.sh &'
end