define newrelic::monitor::php (
  $ensure = $ensure,
  $key    = $key,
){
  case $osfamily {
    'RedHat', 'Debian': { $package_name = 'newrelic-php5'}
    default: { notify{"os $osfamily not yet supported":}}
  }

  package { $package_name:
    ensure => $ensure,
    require => Yumrepo['newrelic'],
  }

  file { '/usr/bin/newrelic-install':
  #  ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('newrelic/newrelic-install.erb'),
  }

  exec { '/usr/bin/newrelic-install install':
#    path    => '/usr/bin',
    require => Package[$package_name],      

  }
}
