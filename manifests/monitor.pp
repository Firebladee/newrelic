define newrelic::monitor (
  $ensure,
  $key = undef,
){
  notify{"name = ${name}":}
  notify{"monitor_${name} = ${ensure}":}

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
