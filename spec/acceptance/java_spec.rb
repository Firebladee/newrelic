require 'spec_helper_acceptance'

describe 'newrelic java' do
  context 'default parameters' do
    it 'should work with defaults' do
      pp = <<-EOS
        class { 'newrelic':
          java => {
            beaker => {
              key => '8fb13cf1873e95f60045afe67fc3a6aba9e563da',
              version => '3.27.0',
              app_root => '/tmp',
              app_name => 'beaker',
            }
          },
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end
  end
end
