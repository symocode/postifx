#
# Cookbook Name:: postfix
# Recipe:: spamassassin
#
# Copyright 2016, SymoCode
#
# All rights reserved - Do Not Redistribute
#

package 'spamassassin'

service 'spamassassin' do
	action [ :start, :enable ]
end

template '/etc/mail/spamassassin/local.cf' do
	source 'local.cf.erb'
	owner 'root'
	group 'root'
	mode '0644'
end

user 'spamd' do
	uid '800'
	shell '/bin/false'
end

directory '/var/log/spamassassin' do
	owner 'spamd'
	group 'spamd'
	mode '0750'
	action :create
end

file '/var/log/spamassassin/spamd.log' do
	owner 'spamd'
	group 'spamd'
	mode '750'
	action :create
end

execute 'sa-update' do
	command 'sa-update && service spamassassin restart '
	not_if { ::File.exists?('/etc/mail/spamassassin/sa-update-keys/pubring.gpg')}
end

#execute 'aide_spamassassin' do
#  command 'sed -i "41i \!/etc/mail/spamassassin/sa-update-keys/*~" /etc/aide.conf'
#end
