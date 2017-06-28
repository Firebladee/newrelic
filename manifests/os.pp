define newrelic::os (
  $key,

  $ensure       = present,
  $default      = undef,
  $repo_install = $::newrelic::repo_install,

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
  $cgroup_root        = '',
  $cgroup_style       = '',
){
  case $::osfamily {
    'RedHat', 'Debian': { $package_name = 'newrelic-sysmond'}
    default: { notify{"os ${::osfamily} not yet supported":}}
  }

  newrelic::install { $package_name:
    ensure => $ensure,
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
