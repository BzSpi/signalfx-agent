#
# Cookbook:: signalfx_agent
# Recipe:: default
#
# Copyright:: 2018, SignalFx, Inc., All Rights Reserved.

case node['platform_family']
when 'windows'
  # User/group don't need to be created on Windows
else
  group 'signalfx-agent' do
    system true
  end

  user 'signalfx-agent' do
    system true
    manage_home false
    group 'signalfx-agent'
    shell '/sbin/nologin'
  end
end

directory ::File.dirname(node['signalfx_agent']['conf_file_path']) do
  owner node['signalfx_agent']['user']
  group node['signalfx_agent']['group']
end

if platform_family?('debian')
  include_recipe 'signalfx_agent::deb_repo'
elsif platform_family?('rhel', 'amazon', 'fedora')
  include_recipe 'signalfx_agent::yum_repo'
end

case node['platform_family']
when 'windows'
  include_recipe 'signalfx_agent::win'
else
  package 'signalfx-agent' do  # ~FC009
    action :install
    version node['signalfx_agent']['package_version'] if !node['signalfx_agent']['package_version'].nil?
    options '--allow-downgrades' if platform_family?('debian') \
      && node['packages']['apt'] \
      && Gem::Version.new(node['packages']['apt']['version']) >= Gem::Version.new('1.1.0')
    allow_downgrade true if platform_family?('rhel', 'amazon', 'fedora')
    notifies :restart, "service[signalfx-agent]", :delayed
  end
end

template node['signalfx_agent']['conf_file_path'] do
  source 'agent.yaml.erb'
  owner node['signalfx_agent']['user']
  group node['signalfx_agent']['group']
  mode '0600'
  notifies :restart, "service[#{node['signalfx_agent']['service_name']}]", :delayed
end

service node['signalfx_agent']['service_name'] do
  action [:enable, :start]
end
