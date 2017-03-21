require 'spec_helper_acceptance'

describe 'newrelic nodejs' do
  context 'default parameters' do
    it 'fail with defaults' do
      pp = <<-EOS
        include nodejs
        class { 'newrelic':
          nodejs => {
            beaker => {
              key => '6480d639145b23574cf21d70defb5de536a38b8a',
              app_root => '/tmp',
              app_name => 'nodejs',
            }
          },
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end
  end
end
