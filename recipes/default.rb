#
# Cookbook:: npm
# Recipe:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

package 'epel-release'
package 'nodejs'
package 'npm'

directory "/home/#{node['npm']['user']}/.npm-global" do
  owner node['npm']['user']
  group node['npm']['user']
  mode '755'
end

execute 'set npm prefix' do
  already_set = "npm config get prefix | grep -c '/home/#{node['npm']['user']}/.npm-global'"
  user node['npm']['user']
  cwd "/home/#{node['npm']['user']}"
  environment ({ 'HOME' => "/home/#{node['npm']['user']}", 'USER' => node['npm']['user'] })

  command "npm config set prefix '/home/#{node['npm']['user']}/.npm-global'"
  not_if already_set
end
