define newrelic::monitor (
  $ensure     = present,
  $key        = undef,
  $version    = undef,
  $app_root   = undef,
  $source     = undef,
  $type       = undef,
  $app_name   = undef,
){
  case $name {
    os: {
      newrelic::monitor::os { $name:
        ensure => $ensure,
        key    => $key,
    }}
    php: {
      newrelic::monitor::php { $name:
        ensure => $ensure,
        key    => $key,
    }}
    java: {
      newrelic::monitor::java { $name:
        ensure   => $ensure,
        key      => $key,
        version  => $version,
        app_root => $app_root,
        source   => $source,
        type     => $type,
        app_name => $app_name,
    }}
    nodejs: {
      newrelic::monitor::nodejs { $name:
        ensure     => $ensure,
        key        => $key,
        app_root   => $app_root,
        app_name   => $app_name,
    }}
    default: { notify{"Should not get here":}}
  }
}
