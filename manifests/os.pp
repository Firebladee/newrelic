define newrelic::os (
  $key,

  $ensure    = present,
  $default   = undef,

  $log_level = 'info',
  $logfile   = '/var/log/newrelic/nrsysmond.log',

  $collector_host     = '',
  $hostname           = '',
  $ignore_reclaimable = '',
  $labels             = '',
  $pidfile            = '',
  $proxy              = '',
  $ssl                = '',
  $ssl_ca_bundle      = '',
  $ssl_ca_path        = '',
  $timeout            = '',
  $disable_nfs        = '',
  $disable_docker     = '',
  $docker_connection  = '',
  $docker_cert_path   = '',
  $docker_cert        = '',
  $docker_key         = '',
  $docker_cacert      = '',
){
  case $::osfamily {
    'RedHat', 'Debian': { $package_name = 'newrelic-sysmond'}
    default: { notify{"os ${::osfamily} not yet supported":}}
  }

  if $::newrelic::repo_install {
    case $::osfamily {
#      'Debian': { $require = Apt['newrelic']}
      default: { $require = Yumrepo['newrelic']}
    }
  }
  else {
    $require = undef
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
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => File['/etc/newrelic/nrsysmond.cfg'],
    subscribe  => File['/etc/newrelic/nrsysmond.cfg'],
  }
}
