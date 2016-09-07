require 'spec_helper_acceptance'

describe 'newrelic php' do
  context 'default parameters' do
    it 'should fail with defaults' do
      pp = <<-EOS
        class { 'newrelic':
          php => { beaker => { key => '8fb13cf1873e95f60045afe67fc3a6aba9e563da' }},
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :accept_all_exit_codes => true)
      expect(apply_manifest(pp, :accept_all_exit_codes => true).exit_code).to eq 0
    end
  end

  context 'with repo => true' do
    it 'should work with repo => true' do
      pp = <<-EOS
        class { 'newrelic':
          php          => { beaker => { key => '8fb13cf1873e95f60045afe67fc3a6aba9e563da' }},
          repo_install => true,
        }
      EOS

      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to eq 0
    end

    describe package('newrelic-php5') do
      it { should be_installed }
    end
    describe file('/usr/bin/newrelic-install') do
      it { should be_file }
      it { should exist }
    end
  end
end
