include_recipe "apt"
include_recipe "build-essential"

ruby_installed_check = "ruby -v | grep #{ node[:chef_ruby][:version].gsub( '-', '' ) }"

%w( git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libpq-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties nodejs graphviz imagemagick openjdk-7-jre-headless).each do |pkg|
  package pkg do
    action :install
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/ruby-#{node[:chef_ruby][:version]}.tar.bz2" do
  source "http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-#{node[:chef_ruby][:version]}.tar.bz2" 
  not_if ruby_installed_check
end

bash "unpack ruby-#{ node[:chef_ruby][:version] }.tar.bz2 and build" do
  user "#{node[:chef_ruby][:user]}"
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar -xjf ruby-#{ node[:chef_ruby][:version] }.tar.bz2 -C /tmp
    cd /tmp/ruby-#{ node[:chef_ruby][:version] } && ./configure --prefix=$HOME/ruby --enable-shared --enable-debug-env && make && make install
    sudo ln -s /home/ubuntu/ruby/lib/* /usr/lib/
    sudo ln -s /home/ubuntu/ruby/bin/* /usr/bin/
    sudo ln -s /home/ubuntu/ruby/share/* /usr/share/
    sudo ln -s /home/ubuntu/ruby/include/* /usr/include/
  EOH
  not_if ruby_installed_check
end

# %w( openssl readline ).each do |ext|
#   bash "configure & make #{ node[:chef_ruby][:version] } #{ext} support" do
#     user "root"
#     cwd "#{Chef::Config[:file_cache_path]}/ruby-#{ node[:chef_ruby][:version] }/ext/#{ext}"
#     code <<-EOH
#       ruby extconf.rb && make && make install
#       sudo ln -s /home/ubuntu/ruby/lib/* /usr/lib/
#       sudo ln -s /home/ubuntu/ruby/bin/* /usr/bin/
#       sudo ln -s /home/ubuntu/ruby/share/* /usr/share/
#       sudo ln -s /home/ubuntu/ruby/include/* /usr/include/
#     EOH
#     not_if ruby_installed_check
#   end
# end

# file "/usr/local/etc/gemrc" do
#   action :create
#   owner "root"
#   group "root"
#   mode 0644

file "/home/#{node[:chef_ruby][:user]}/.gemrc" do
  action :create
  owner "ubuntu"
  group "ubuntu"
  mode 0644
  content "install: --no-rdoc --no-ri\nupdate:  --no-rdoc --no-ri\n"
end

rubygems_installed_check = "gem -v | grep #{node[:chef_ruby][:rubygems][:version]}"

remote_file "#{Chef::Config[:file_cache_path]}/rubygems-#{node[:chef_ruby][:rubygems][:version]}.tgz" do
  source "http://production.cf.rubygems.org/rubygems/rubygems-#{node[:chef_ruby][:rubygems][:version]}.tgz"

  not_if rubygems_installed_check
end

execute "extract and install rubygems" do
  cwd Chef::Config[:file_cache_path]
  command "tar zxf rubygems-#{node[:chef_ruby][:rubygems][:version]}.tgz && cd rubygems-#{node[:chef_ruby][:rubygems][:version]} && ruby setup.rb --no-format-executable"
  not_if rubygems_installed_check
end

gem_package "bundler"

bash "Add more symlinks" do
  user 'root'
  ignore_failure true
  code <<-EOT
  ln -s /home/ubuntu/ruby/lib/* /usr/lib/
  ln -s /home/ubuntu/ruby/bin/* /usr/bin/
  ln -s /home/ubuntu/ruby/share/* /usr/share/
  ln -s /home/ubuntu/ruby/include/* /usr/include/
  EOT
end

ohai "reload" do
  action :reload
end
