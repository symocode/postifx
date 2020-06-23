#
# Attributes
#

# Postfix Attributes
# main.cf
default['postfix']['relay_domains'] = "symocode.com, apgroupinternational.com, voggano.com, lamania.ca, simplenet.ca, aphorizoninc.com, aboutthefashion.com"
# transport.db
default['postfix']['domains'] = 'symocode.com'

if node[:hostname] == 'mx1'
	default['openvpn']['ifconfig'] = '10.10.10.1 10.10.10.2'
else
	default['openvpn']['ifconfig'] = '10.10.11.1 10.10.11.2'
end

if node[:hostname] == 'mx1'
	default['openvpn']['ifconfig_mx'] = '10.10.10.2'
else
	default['openvpn']['ifconfig_mx'] = '10.10.11.2'
end

# OpenVPN Attributes
default['openvpn']['dev'] = 'tun'
default['openvpn']['proto'] = 'tcp-server'

if node[:hostname] == 'mx1'
	default['openvpn']['port'] = '1994'
else
	default['openvpn']['port'] = '1995'
end

default['openvpn']['secret'] = '/etc/openvpn/static.key'
