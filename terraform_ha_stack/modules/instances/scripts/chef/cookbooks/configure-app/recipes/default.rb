#
# Cookbook:: configure-app
# Recipe:: default
#
# Copyright:: 2019, Kiran Haridas, All Rights Reserved.

# install setting for the machine

package 'python3' do
  action :install
end

# package 'centos-release-scl' do
#   action :remove
# end

# package 'rh-python36' do
#   action :remove
# end

package 'git' do
  action :install
end


execute 'install_supervisor_package' do
  command 'sh /tmp/chef/install_supervisor.sh'
end

# create directory for app installation
directory '/var/flask_app' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# pull your app from git.
git '/var/flask_app' do
  repository 'https://github.com/kirankh7/disaster_flask_app.git'
  revision 'master'
  action :sync
end

execute 'install_package' do
  command 'sudo pip3 install -r /var/flask_app/requirements.txt'
end

execute 'install_package' do
  command 'sudo cp -a /tmp/chef/terra_templates/config.json /var/flask_app/'
end


# Create dir for logging from supervisor
directory '/var/log/flaskblog/' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


# supervisor requirements
template '/etc/supervisor/conf.d/flask.conf' do
  source 'supervisor.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[supervisord]', :immediately
end

service 'supervisord' do
  action [:enable, :start ]
end



# create a virutal enviroment
# execute 'install_package' do
#   command 'virtualenv /var/flask_app/ && source'
# end
#
# execute 'apache_configtest' do
#   command 'sh /var/flask_app/run_gunicorn.sh &'
# end