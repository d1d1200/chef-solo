#
# Cookbook Name:: unicorn-ng
# Resource:: service
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

actions        :create
default_action :create

attribute :rails_root,     kind_of: String, name_attribute: true
attribute :config,         kind_of: String, default: node['unicorn-ng']['service']['config']
attribute :pidfile,        kind_of: String, default: node['unicorn-ng']['service']['pidfile']
attribute :bundle_gemfile, kind_of: String, default: node['unicorn-ng']['service']['bundle_gemfile']
attribute :wrapper,        kind_of: String, default: node['unicorn-ng']['service']['wrapper']
attribute :wrapper_opts,   kind_of: String, default: node['unicorn-ng']['service']['wrapper_opts']
attribute :bundle,         kind_of: String, default: node['unicorn-ng']['service']['bundle']
attribute :environment,    kind_of: String, default: node['unicorn-ng']['service']['environment']
attribute :locale,         kind_of: String, default: node['unicorn-ng']['service']['locale']
attribute :user,           kind_of: String, default: node['unicorn-ng']['service']['user']

attribute :owner,          kind_of: String, default: node['unicorn-ng']['service']['owner']
attribute :group,          kind_of: String, default: node['unicorn-ng']['service']['group']
attribute :mode,           kind_of: String, default: node['unicorn-ng']['service']['mode']
attribute :cookbook,       kind_of: String, default: node['unicorn-ng']['service']['cookbook']
attribute :source,         kind_of: String, default: node['unicorn-ng']['service']['source']
attribute :variables,      kind_of: Hash,   default: node['unicorn-ng']['service']['variables']
attribute :service_name,   kind_of: String, default: node['unicorn-ng']['service']['name']
attribute :app_root,   	   kind_of: String, default: node['unicorn-ng']['service']['app_root']
attribute :set_env,    	   kind_of: String, default: node['unicorn-ng']['service']['set_env']
attribute :x_spree_client_token,    	   kind_of: String, default: node['unicorn-ng']['service']['x_spree_client_token']
attribute :x_spree_client_token2,    	   kind_of: String, default: node['unicorn-ng']['service']['x_spree_client_token2']
attribute :s3_bucket,	kind_of: String, default: node['unicorn-ng']['service']['s3_bucket']
attribute :cloudfront_url,	kind_of: String, default: node['unicorn-ng']['service']['cloudfront_url']
attribute :aws_access_key_id,	kind_of: String, default: node['unicorn-ng']['service']['aws_access_key_id']
attribute :aws_secret_access_key,	kind_of: String, default: node['unicorn-ng']['service']['aws_secret_access_key']
attribute :devise_secret_key, 	kind_of: String, default: node['unicorn-ng']['service']['devise_secret_key']
attribute :paperclip_hash_secret,	kind_of: String, default: node['unicorn-ng']['service']['paperclip_hash_secret']
attribute :asiapay_secure_hash_secret,	kind_of: String, default: node['unicorn-ng']['service']['asiapay_secure_hash_secret']
attribute :redis_password,	kind_of: String, default: node['unicorn-ng']['service']['redis_password']
attribute :adyen_notify_user,	kind_of: String, default: node['unicorn-ng']['service']['adyen_notify_user']
attribute :adyen_notify_passwd,	kind_of: String, default: node['unicorn-ng']['service']['adyen_notify_passwd']
attribute :elasticsearch_url,	kind_of: String, default: node['unicorn-ng']['service']['elasticsearch_url']
attribute :dropbox_token,	kind_of: String, default: node['unicorn-ng']['service']['dropbox_token']
attribute :dropbox_secret,	kind_of: String, default: node['unicorn-ng']['service']['dropbox_secret']
attribute :dropbox_app_key,	kind_of: String, default: node['unicorn-ng']['service']['dropbox_app_key']
attribute :dropbox_app_secret,	kind_of: String, default: node['unicorn-ng']['service']['dropbox_app_secret']
attribute :logentries_token,	kind_of: String, default: node['unicorn-ng']['service']['logentries_token']
attribute :smtp_password,	kind_of: String, default: node['unicorn-ng']['service']['smtp_password']
attribute :smtp_username,	kind_of: String, default: node['unicorn-ng']['service']['smtp_username']
attribute :smtp_address,	kind_of: String, default: node['unicorn-ng']['service']['smtp_address']
attribute :smtp_domain,	kind_of: String, default: node['unicorn-ng']['service']['smtp_domain']

