require 'spec_helper'
describe 'newrelic::php' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:title) {'os'}
      let(:params) {{
          :key    => '8fb13cf1873e95f60045afe67fc3a6aba9e563da',
          :ensure => 'present',
        }}

      it { is_expected.to have_resource_count(5)}

      it 'should generate valid content for newrelic-install' do
        content = catalogue.resource('file', '/usr/bin/newrelic-install').send(:parameters)[:content]
        expect(content).not_to be_empty
      end

      it { is_expected.to contain_exec('/usr/bin/newrelic-install install').with(
        :creates => '/usr/bin/newrelic-install',
        :require => 'Package[newrelic-php5]',
      )}

      case facts[:osfamily]
      when 'RedHat'
        it { is_expected.to contain_file('/usr/bin/newrelic-install').with(
          :ensure  => 'present',
          :mode    => '0755',
          :owner   => 'root',
          :group   => 'root',
        )}
      end
    end
  end
end
