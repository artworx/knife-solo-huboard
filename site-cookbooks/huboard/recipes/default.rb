#
# Cookbook Name:: huboard
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "sudo"
include_recipe "couchdb"
include_recipe "memcached"
include_recipe "nginx-site"
include_recipe "rvm::system"

#group "rvm" do
  #action :modify
  #members "huboard"
  #append true
#end

git "/home/huboard/current" do
  repository "https://github.com/rauhryan/huboard.git"
  reference '9d75cc0d722c21c68c3aac507d6c3fa3f7ff6ec4'
  action :sync
  user 'huboard'
  group 'huboard'
end

bash "bundle install" do
  code <<-EOH
    su -l huboard -c "cd /home/huboard/current && \
    bundle install --path vendor/bundle && \
    sudo gem install foreman && \
    sudo foreman export upstart -a huboard -u huboard /etc/init && \
    sudo /sbin/restart huboard || sudo /sbin/start huboard"
  EOH
end

template '/home/huboard/current/Procfile' do
  source 'Procfile.erb'
end

template '/home/huboard/current/config/unicorn.rb' do
  source 'unicorn.erb'
end

template '/home/huboard/current/.settings' do
  source 'settings.erb'
  variables({
    session_secret: node[:huboard][:session_secret],
    secret_key: node[:huboard][:secret_key],
    socket_backend: node[:huboard][:socket_backend],
    secret: node[:huboard][:secret],
    client_id: node[:huboard][:client_id],
  })
end

