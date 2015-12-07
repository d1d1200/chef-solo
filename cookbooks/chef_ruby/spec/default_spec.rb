require 'chefspec'

describe 'chef_ruby::default' do
  let(:runner) { ChefSpec::ChefRunner.new }
  let(:chef_run) { runner.converge 'chef_ruby::default' }

  before do
    Chef::Recipe.any_instance.stub(:load_recipe).and_return do |arg|
      runner.node.run_state[:seen_recipes][arg] = true
    end
  end

  %w( git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev ).each do |package|
    it "installs package #{package}" do
      chef_run.should install_package package
    end
  end

  it "downloads ruby" do
    chef_run.should create_remote_file "#{Chef::Config[:file_cache_path]}/ruby-#{chef_run.node[:chef_ruby][:version]}.tar.bz2"
  end

  it "creates a gemrc" do
    chef_run.should create_file_with_content '/usr/local/etc/gemrc', "install: --no-rdoc --no-ri\nupdate:  --no-rdoc --no-ri\n"
    chef_run.file('/usr/local/etc/gemrc').should be_owned_by('root', 'root')
  end

  it "downloads rubygems" do
    chef_run.should create_remote_file "#{Chef::Config[:file_cache_path]}/rubygems-#{chef_run.node[:chef_ruby][:rubygems][:version]}.tgz"
  end

  it "gem installs bundler" do
    chef_run.should install_gem_package 'bundler'
  end
end
