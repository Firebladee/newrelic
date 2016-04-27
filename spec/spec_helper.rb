require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

RSpec.configure do |config|
  config.formatter = :documentation
end

begin
  require 'simplecov'
  require 'coveralls'
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter '/spec/'
  end
  Coveralls.wear!
rescue Exception => e
  warn "Coveralls disabled"
end

at_exit { RSpec::Puppet::Coverage.report! }
