require 'spec_helper'
describe 'newrelic::java' do

  let(:title) {'java'}
  let(:params) {{
    :key      => '8fb13cf1873e95f60045afe67fc3a6aba9e563da',
    :ensure   => 'present',
    :version  => '3.27.0',
    :app_root => '/tmp',
    :app_name => 'testing',
    :type     => 'agent',
    :source   => 'http://yum.newrelic.com/newrelic/java-agent',
  }}

  it { is_expected.to have_resource_count(6)}

  it { is_expected.to contain_download_uncompress('newrelic_agent3.27.0.zip').with(
    :distribution_name => 'http://yum.newrelic.com/newrelic/java-agent/newrelic-agent/3.27.0/newrelic-java.zip',
    :dest_folder       => '/tmp',
    :creates           => '/tmp/newrelic/newrelic.jar',
    :uncompress        => 'zip',
    :user              => 'root',
    :group             => 'root',
  )}

  it { is_expected.to contain_file_line('key').with(
    :ensure  => 'present',
    :path    => '/tmp/newrelic/newrelic.yml',
    :line    => "  license_key: '8fb13cf1873e95f60045afe67fc3a6aba9e563da'",
    :match   => "^  license_key: '<%= license_key %>'",
    :require => 'Download_uncompress[newrelic_agent3.27.0.zip]',
  )}
  
  it { is_expected.to contain_file_line('app_name').with(
    :ensure   => 'present',
    :path     => '/tmp/newrelic/newrelic.yml',
    :line     => '  app_name: testing',
    :match    => '  app_name:',
    :multiple => 'true',
    :require  => 'Download_uncompress[newrelic_agent3.27.0.zip]',
  )}

end
