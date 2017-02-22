# # encoding: utf-8

# Inspec test for recipe npm::default

describe package('nodejs') do
  it { should be_installed }
end

describe package('npm') do
  it { should be_installed }
end

describe directory('/home/vagrant/.npm-global') do
  it { should exist }
end
