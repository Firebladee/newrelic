define newrelic::install (
  $ensure       = present,
  $repo_install = $::newrelic::repo_install,
){

  if $repo_install {
    case $::osfamily {
      'Debian': { $require = [Apt::Source['newrelic'], Class['apt::update']]}
      default: { $require = Yumrepo['newrelic']}
    }
  }
  else {
    $require = undef
    notify{"undef repo_install = ${repo_install}":}
  }

  package { $name:
    ensure  => $ensure,
    require => $require,
  }
}
