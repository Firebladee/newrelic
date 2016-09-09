require 'spec_helper'
describe 'newrelic::repo' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      case facts[:osfamily]
      when 'RedHat'
        it { is_expected.to have_resource_count(1)}
        it { is_expected.to contain_yumrepo('newrelic').with(
          :ensure   => 'present',
          :baseurl  => 'http://yum.newrelic.com/pub/newrelic/el5/$basearch',
          :enabled  => 'true',
          :gpgcheck => '0',
        )}
      when 'Debian'
        it { is_expected.to have_resource_count(13)}
      end
    end
  end
end
