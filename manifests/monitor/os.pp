define newrelic::monitor::os (
  $ensure = $ensure,
  $key    = $key,
){
  case $osfamily {
    'RedHat', 'Debian': { $package_name = 'newrelic-sysmond'}
    default: { notify{"os $osfamily not yet supported":}}
  }

  package { $package_name:
    ensure => $ensure,
  }

  file { '/etc/newrelic/nrsysmond.cfg':
    ensure  => 'present',
    mode    => '0640',
    owner   => 'root',
    group   => 'newrelic',
    content => template('newrelic/nrsysmond.cfg.erb'),
  }

  service { 'newrelic-sysmond':
    ensure  => running,
    enable  => true,
    require => File['/etc/newrelic/nrsysmond.cfg']
  }
}
