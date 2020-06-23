#
# Cookbook Name:: postfix
# Recipe:: postfix
#
# Copyright 2016, SymoCode
#
# All rights reserved - Do Not Redistribute
#

package [ 'postfix', 'cyrus-sasl-plain' ]

service 'postfix' do
	action [ :start, :enable ]
end

template '/etc/postfix/main.cf' do
	source 'main.cf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

template '/etc/postfix/master.cf' do
	source 'master.cf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

execute 'transport' do
	command 'postmap /etc/postfix/transport'
	action :nothing
end

template '/etc/postfix/transport' do
	source 'transport.erb'
	owner 'root'
	group 'root'
	mode '0644'
	notifies :run, 'execute[transport]'
end

directory '/etc/postfix/certs' do
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

execute 'postfix_certs' do
	cwd '/etc/postfix/certs'
	command 'echo -e "CA\nOntario\nToronto\nSymoCode\nSymoCode\n*\n\n" | openssl req -new -x509 -days 3650 -nodes -out postfix.pem -keyout postfix.key'
	not_if { ::File.exists?('/etc/postfix/certs/postfix.pem') }
end
