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
  }

  exec { 'newrelic-install install':
    path => '/usr/bin',
    require => Package[$package_name],      

  }
}
