#
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2016, SymoCode
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'postfix::postfix'
include_recipe 'postfix::spamassassin'
include_recipe 'postfix::openvpn'
include_recipe 'postfix::iptables'
