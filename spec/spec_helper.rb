require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'coveralls'
include RspecPuppetFacts

RSpec.configure do |config|
  config.formatter = :documentation
end

Coveralls.wear!

at_exit { RSpec::Puppet::Coverage.report! }
