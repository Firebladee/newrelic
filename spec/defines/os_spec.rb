require 'spec_helper'
describe 'newrelic::os' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:title) {'os'}
      let(:params) {{
        key:    '8fb13cf1873e95f60045afe67fc3a6aba9e563da',
        ensure: 'present',
      }}

      it { is_expected.to have_resource_count(5)}

      it { is_expected.to contain_package('newrelic-sysmond').with(
        repo_install: false,
      )}

      it 'generate valid content for nrsysmond.cfg' do
        content = catalogue.resource('file', '/etc/newrelic/nrsysmond.cfg').send(:parameters)[:content]
        expect(content).not_to be_empty
      end

      it { is_expected.to contain_service('newrelic-sysmond').with(
        ensure:     'running',
        enable:     'true',
        hasrestart: 'true',
        hasstatus:  'true',
        require:    'File[/etc/newrelic/nrsysmond.cfg]',
        subscribe:  'File[/etc/newrelic/nrsysmond.cfg]',
      )}

      it { is_expected.to contain_file('/etc/newrelic/nrsysmond.cfg').with(
        ensure:  'present',
        mode:    '0640',
        owner:   'root',
        group:   'newrelic',
        require: 'Package[newrelic-sysmond]',
      )}
    end
  end
end
