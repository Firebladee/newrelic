require 'spec_helper_acceptance'

describe 'newrelic os' do
  context 'default parameters' do
    it 'fail with defaults' do
      pp = <<-EOS
        class { 'newrelic':
          os => { os => { key => '6480d639145b23574cf21d70defb5de536a38b8a' }},
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, accept_all_exit_codes: true)
      expect(apply_manifest(pp, accept_all_exit_codes: true).exit_code).to eq 0
    end
  end

  context 'with repo => true' do
    it 'repo => true' do
      pp = <<-EOS
        class { 'newrelic':
          os           => { os => { key => '6480d639145b23574cf21d70defb5de536a38b8a' }},
          repo_install => true,
        }
      EOS

      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end

    describe package('newrelic-sysmond') do
      it { is_expected.to be_installed }
    end
    describe file('/etc/newrelic/nrsysmond.cfg') do
      it { is_expected.to be_file }
      it { is_expected.to exist }
    end
  end
end
