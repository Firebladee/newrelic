require 'spec_helper'
describe 'newrelic::monitor::os' do
#  let(:params) { {:type => {'os' => {'key' => '8fb13cf1873e95f60045afe67fc3a6aba9e563da'}}}}
  let(:params) {{:package_name => 'newrelic-sysmond'}}
  let(:params) {{:ensure => 'present' }}
  let(:title) {'os'}

#  it { is_expected.to have_resource_count(1) }

end
