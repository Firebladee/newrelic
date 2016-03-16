define newrelic::monitor::java (
  $version,
  $app_root,
  $app_name,

  $ensure = $ensure,
  $key    = $key,
  $source = 'http://yum.newrelic.com/newrelic/java-agent/',
  $type   = 'agent',
){

  download_uncompress { "newrelic_${type}${version}.zip":
    distribution_name => "${source}/newrelic-${type}/${version}/newrelic_${type}${version}.zip",
    dest_folder       => "${app_root}",
    creates           => "${app_root}/newrelic/newrelic.jar",
    uncompress        => 'zip',
    user              => root,
    group             => root,
  }

  file_line { 'key':
    ensure => present,
    path   => "${app_root}/newrelic/newrelic.yml",
    line   => "  license_key: '<%= ${key} %>'",
    match  => "^  license_key: '<%= license_key %>'",
  }

  file_line { 'app_name':
    ensure => present,
    path   => "${app_root}/newrelic/newrelic.yml",
    line   => "  app_name: ${app_name}",
    match  => '  app_name:',
    multiple => true,
  }
}
