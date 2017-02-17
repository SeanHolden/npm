#
# Cookbook:: npm
# Spec:: default
#
# Copyright:: 2017, Sean Holden, All Rights Reserved.

require 'spec_helper'

describe 'npm::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:platform) { 'centos' }
    let(:version) { '7.2.1511' }
    let(:chef_run) {
      ChefSpec::SoloRunner.new(platform: platform, version: version).
        converge(described_recipe)
    }

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    describe 'epel-release' do
      it 'installs package' do
        expect(chef_run).to install_package('epel-release')
      end
    end

    describe 'nodejs' do
      it 'installs package' do
        expect(chef_run).to install_package('nodejs')
      end
    end

    describe 'npm' do
      it 'installs package' do
        expect(chef_run).to install_package('npm')
      end
    end
  end
end
