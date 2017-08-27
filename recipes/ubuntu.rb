#
# Cookbook:: npm
# Recipe:: ubuntu
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

package 'nodejs'
package 'npm'

directory "/home/#{node['npm']['user']}/.npm-global" do
  owner(node['npm']['user'])
  group(node['npm']['user'])
  mode('755')
end

# Without this, you receive an EACCES error when you try to install a package globally.
execute 'set npm prefix' do
  user(node['npm']['user'])
  cwd("/home/#{node['npm']['user']}")
  environment({ 'HOME' => "/home/#{node['npm']['user']}", 'USER' => node['npm']['user'] })

  command "npm config set prefix '/home/#{node['npm']['user']}/.npm-global'"

  already_set = "npm config get prefix | grep -c '/home/#{node['npm']['user']}/.npm-global'"
  not_if already_set
end


# Libraries to install, if any. To be set in Vagrantfile.
libraries = node['npm']['libraries']
libraries.each do |library|
  execute 'install npm libraries' do
    user node['npm']['user']
    cwd "/home/#{node['npm']['user']}"
    environment({ 'HOME' => "/home/#{node['npm']['user']}", 'USER' => node['npm']['user'] })

    command "npm install -g #{library}"

    already_exists = "npm list -g | grep #{library}"
    not_if already_exists
  end
end
