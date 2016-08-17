require 'spec_helper_acceptance'

describe 'newrelic class' do
  context 'default parameters' do
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'newrelic': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end
  end

#  it_behaves_like "a idempotent resource"
end
