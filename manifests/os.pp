define newrelic::os (
  $ensure    = present,
  $key       = undef,
  $host_name = $host_name,
){
  case $::osfamily {
    'RedHat', 'Debian': { $package_name = 'newrelic-sysmond'}
    default: { notify{"os ${::osfamily} not yet supported":}}
  }

  case $::osfamily {
#    'Debian': { $require = Apt['newrelic']}
    default: { $require = Yumrepo['newrelic']}
  }

  package { $package_name:
    ensure  => $ensure,
    require => $require,
  }

  file { '/etc/newrelic/nrsysmond.cfg':
    ensure  => 'present',
    mode    => '0640',
    owner   => 'root',
    group   => 'newrelic',
    content => template('newrelic/nrsysmond.cfg.erb'),
    require => Package[$package_name],
  }

  service { 'newrelic-sysmond':
    ensure  => running,
    enable  => true,
    require => File['/etc/newrelic/nrsysmond.cfg']
  }
}
