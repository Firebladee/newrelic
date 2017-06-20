require 'spec_helper'
describe 'newrelic::install' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:title) {'newrelic-sysmond'}
      let(:params) {{
        ensure: 'present',
        repo_install: false,
      }}

      it { is_expected.to have_resource_count(3)}

      case facts[:osfamily]
      when 'RedHat'

        it { is_expected.to contain_package('newrelic-sysmond').with(
          ensure:  'present',
          require: nil,
        )}
      end
    end
  end

  # let(:facts) {{ :repo_install => false }}

  on_supported_os.each do |os, facts|
    context "on #{os} with repo_install => false" do
      let(:facts) do
        facts
      end

      let(:title) {'newrelic-sysmond'}
      let(:params) {{
        ensure:       'present',
        repo_install: false,
      }}

      it { is_expected.to have_resource_count(3)}

      case facts[:osfamily]
      when 'RedHat'

        it { is_expected.to contain_package('newrelic-sysmond').with(
          ensure:  'present',
          require: nil,
        )}

      end
    end
  end
end
