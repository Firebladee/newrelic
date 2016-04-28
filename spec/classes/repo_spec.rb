require 'spec_helper'
describe 'newrelic::repo' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to have_resource_count(1)}

      case facts[:osfamily]
      when 'RedHat'

        it { is_expected.to contain_yumrepo('newrelic').with(
          :ensure   => 'present',
          :baseurl  => 'http://yum.newrelic.com/pub/newrelic/el5/$basearch',
          :enabled  => 'true',
          :gpgcheck => '0',
        )}

      end
    end
  end
end
