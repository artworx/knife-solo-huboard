name 'rails'
description 'This role configures a Rails stack using Unicorn'

run_list "role[base]", "recipe[apt]", "recipe[build-essential]", "recipe[rvm::system]", "recipe[nginx]", "recipe[nginx-site]"

default_attributes(
  "rvm" => {
    "default_ruby" => "ruby-2.0.0"
  }
)
