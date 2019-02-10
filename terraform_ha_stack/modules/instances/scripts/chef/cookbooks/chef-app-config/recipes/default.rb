#
# Cookbook:: configure-app
# Recipe:: default
#
# Copyright:: 2019, Kiran Haridas, All Rights Reserved.

file “/home/user/hello.txt” do
  content “Hello, this is my first cookbook recipe\n”
  action :create
end

