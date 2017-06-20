require 'spec_helper'
describe 'newrelic::nodejs' do

  let(:title) {'nodejs'}
  let(:params) {{
    :key      => '8fb13cf1873e95f60045afe67fc3a6aba9e563da',
    :ensure   => 'present',
    :app_root => '/tmp',
    :app_name => 'testing',
  }}

  it { is_expected.to have_resource_count(5)}

  it { is_expected.to contain_package('newrelic').with(
    :ensure   => 'present',
    :provider => 'npm',
    :require  => 'Package[nodejs]',
  )}

  it { is_expected.to contain_exec('/tmp_exec').with(
    :command => 'cp /usr/lib/node_modules/newrelic/newrelic.js /tmp',
    :creates => '/tmp/newrelic.js',
    :path    => '/bin',
    :require => 'Package[newrelic]',
  )}

  it { is_expected.to contain_file_line('/tmp_key').with(
    :ensure  => 'present',
    :path    => '/tmp/newrelic.js',
    :line    => "  license_key: '8fb13cf1873e95f60045afe67fc3a6aba9e563da'",
    :match   => "^  license_key:",
    :require => 'Exec[/tmp_exec]',
  )}
  
  it { is_expected.to contain_file_line('/tmp_app_name').with(
    :ensure   => 'present',
    :path     => '/tmp/newrelic.js',
    :line     => "  app_name: ['testing']",
    :match    => '  app_name:',
    :require  => 'Exec[/tmp_exec]',
  )}

end
