require 'beaker-rspec'
require 'beaker/puppet_install_helper'

git_repos = [
  { mod: 'yumrepo', repo: 'https://github.com/Firebladee/yumrepos.git' }
]

# Install Puppet on all hosts
run_puppet_install_helper

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    # Install module to all hosts
    puppet_module_install(source: module_root, module_name: 'newrelic')

    hosts.each do |host|
      # Install dependencies
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))
      on(host, puppet('module', 'install', 'puppetlabs-nodejs'))
      on(host, puppet('module', 'install', 'treydock-gpg_key'))
      on(host, puppet('module', 'install', 'dsestero/download_uncompress'))
      on(host, puppet('module', 'install', 'puppetlabs/apt'))

      install_package host, 'git'

      git_repos.each do |g|
        step "Installing puppet module \'#{g[:repo]}\'"
        shell("git clone #{g[:repo]} #{default['puppetpath']}/modules/#{g[:mod]}")
      end
      # Add more setup code as needed
    end
  end
end
