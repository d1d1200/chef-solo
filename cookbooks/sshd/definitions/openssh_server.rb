#
# Cookbook Name:: sshd
# Definition:: openssh_server
#
# Copyright 2012, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

class Chef::Recipe
  include Sshd::Helpers
end

define :openssh_server, action: :create, cookbook: 'sshd', source: 'sshd_config.erb' do
  # remove attributes that are not sshd configuration
  filename = params.delete(:name)
  action   = params.delete(:action)
  cookbook = params.delete(:cookbook)
  source   = params.delete(:source)

  # generate sshd_config according to attributes
  # use default values, overwrite them with the ones in the definition
  settings = merge_settings(node['sshd']['sshd_config'], params)
  sshd_config = generate_sshd_config(settings)

  template filename do
    owner     'root'
    group     'root'
    mode      00644
    cookbook  cookbook
    source    source
    variables config: sshd_config
    action    action
  end

  service node['sshd']['service_name'] do
    # Due to a bug in Chef, we need to manually set the provider to Upstart for Ubuntu 13.10 and 14.04
    # This will probably be fixed in chef-client 11.14
    provider Chef::Provider::Service::Upstart if node['platform'] == 'ubuntu' && node['platform_version'] >= '13.10'
    supports status: true, restart: true, reload: true
    subscribes :restart, "template[#{filename}]"
  end
end
