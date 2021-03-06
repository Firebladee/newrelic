define newrelic::php (
  $key,

  $ensure       = present,
  $default      = undef,
  $repo_install = $::newrelic::repo_install,
){
  case $::osfamily {
    'RedHat', 'Debian': { $package_name = 'newrelic-php5'}
    default: { notify{"os ${::osfamily} not yet supported":}}
  }

  newrelic::install { $package_name:
    ensure  => $ensure,
  }

  file { '/usr/bin/newrelic-install':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('newrelic/newrelic-install.erb'),
  }

  exec { '/usr/bin/newrelic-install install':
    creates => '/usr/bin/newrelic-install',
    require => Package[$package_name],

  }
}
