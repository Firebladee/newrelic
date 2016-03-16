define newrelic::monitor (
  $ensure,
  $key = undef,
){
  case $name {
    os: {
      newrelic::monitor::os { $name:
        ensure => $ensure,
        key    => $key,
    }}
    php: {
      newrelic::monitor::php {
        $name: ensure => $ensure,
    }}
    default: { notify{"Should not get here":}}
  }
}
