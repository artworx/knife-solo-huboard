default[:nginx_site][:sites] = [app_name: 'huboard']
default[:rvm][:default_ruby] = "ruby-2.0.0"

default['nginx']['default_site_enabled'] = false
default['authorization']['sudo']['users']             = ['huboard']
default['authorization']['sudo']['passwordless']      = true

default[:huboard][:session_secret] = "sadfasdfsaf"
default[:huboard][:secret_key] = "asdfaffaf"
default[:huboard][:socket_backend] = "http://localhost"
default[:huboard][:secret] = ""
default[:huboard][:client_id] = ""
