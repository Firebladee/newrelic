require 'spec_helper_acceptance'

describe 'newrelic nodejs' do
  context 'default parameters' do
    it 'should fail with defaults' do
      pp = <<-EOS
        include nodejs
        class { 'newrelic':
          nodejs => {
            beaker => {
              key => '8fb13cf1873e95f60045afe67fc3a6aba9e563da',
              app_root => '/tmp',
              app_name => 'nodejs',
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
