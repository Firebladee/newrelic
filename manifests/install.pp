define newrelic::install (
  $ensure       = present,
  $repo_install = $::newrelic::repo_install,
){

  if $repo_install {
    case $::osfamily {
#      'Debian': { $require = Apt['newrelic']}
      default: { $require = Yumrepo['newrelic']}
    }
  }
  else {
    $require = undef
  }

  package { $name:
    ensure  => $ensure,
    require => $require,
  }
}
