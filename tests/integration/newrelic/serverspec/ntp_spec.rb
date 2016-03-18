require 'serverspec'

set :backend, :exec
set :path, '$PATH:/sbin:/usr/sbin'

describe 'ntp' do
  describe package('ntp') do
    it {should be_installed}
  end

  describe service('ntp') do
    it {should be_running}
  end
end
