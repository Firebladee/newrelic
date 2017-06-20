define newrelic::nodejs (
  $key,
  $app_root,
  $app_name,

  $ensure  = present,
  $default = undef,
){
  package { 'newrelic':
    ensure   => $ensure,
    provider => 'npm',
    require  => Package['nodejs'],
  }

  exec { "${app_root}_exec":
    command => "cp /usr/lib/node_modules/newrelic/newrelic.js ${app_root}",
    creates => "${app_root}/newrelic.js",
    path    => '/bin',
    require => Package['newrelic'],
  }

  file_line { "${app_root}_key":
    ensure  => $ensure,
    path    => "${app_root}/newrelic.js",
    line    => "  license_key: '${key}'",
    match   => '^  license_key:',
    require => Exec["${app_root}_exec"],
  }

  file_line { "${app_root}_app_name":
    ensure  => $ensure,
    path    => "${app_root}/newrelic.js",
    line    => "  app_name: ['${app_name}']",
    match   => '  app_name:',
    require => Exec["${app_root}_exec"],
  }
}
