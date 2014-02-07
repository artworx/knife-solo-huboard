#
# Cookbook Name:: nginx-site
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "nginx"

node[:nginx_site][:sites].each do |attr|
  app_name = attr[:app_name]

  user app_name do
    action :create
    home "/home/#{app_name}"
    supports manage_home: true
    shell '/bin/bash'
  end

  template "/etc/nginx/sites-available/#{app_name}" do
    source 'nginx/app.conf.erb'
    variables(app_name: app_name)
  end

  nginx_site app_name do
    action :enable
  end
end
