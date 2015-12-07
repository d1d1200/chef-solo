#
# Cookbook Name:: swapfile
# Recipe:: default
#
# Copyright 2014, Sasanadi Ruka
#
# All rights reserved
#

swapfile = node[:swapfile][:name]
block_size_mb = 1
# block_count = ((node[:swapfile][:gb_size] * 1024) / block_size_mb).round
block_count = ((node[:swapfile][:mb_size] * 1) / block_size_mb).round


bash "add_swap" do
  user 'root'
  not_if { File.exists?(swapfile) }
  code <<-EOT
	dd if=/dev/zero of="#{swapfile}" \
		bs="#{block_size_mb}M" count="#{block_count}" &&
	chmod 0600 "#{swapfile}" &&
	mkswap "#{swapfile}"
EOT
end

mount '/dev/null' do
  action :enable
  device "#{swapfile}"
  fstype 'swap'
end

bash "activate_swap" do
  user 'root'
  only_if { File.exists?(swapfile) }
  code 'swapon -a'
end