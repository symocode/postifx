#
# Cookbook Name:: postfix
# Recipe:: openvpn
#
# Copyright 2016, SymoCode
#
# All rights reserved - Do Not Redistribute
#

package 'openvpn'

service 'openvpn' do
	action [:start, :enable]
end

template '/etc/openvpn/static.key' do
	source 'static.key.erb'
	owner 'root'
	group 'root'
	mode '0400'
	notifies :restart, 'service[openvpn]', :immediately
end

template '/etc/openvpn/vpn.conf' do
	source 'vpn.conf.erb'
	owner 'root'
	group 'root'
	mode '0600'
	notifies :restart, 'service[openvpn]', :immediately
end
