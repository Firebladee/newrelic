define newrelic::java (
  $version,
  $app_root,
  $app_name,

  $ensure        = present,
  $key           = undef,
  $source        = 'http://yum.newrelic.com/newrelic/java-agent',
  $type          = 'agent',
  $download_name = "${source}/newrelic-${type}/${version}/newrelic-java.zip",
  $default       = undef,
  $user          = 'root',
  $group         = 'root'
){

  download_uncompress { "newrelic_${type}${version}.zip":
    distribution_name => "${source}/newrelic-${type}/${version}/newrelic-java.zip",
    dest_folder       => $app_root,
    creates           => "${app_root}/newrelic/newrelic.jar",
    uncompress        => 'zip',
    user              => $user,
    group             => $group,
  }

  file_line { 'key':
    ensure  => present,
    path    => "${app_root}/newrelic/newrelic.yml",
    line    => "  license_key: '${key}'",
    match   => "^  license_key: '<%= license_key %>'",
    require => Download_uncompress["newrelic_${type}${version}.zip"],
  }

  file_line { 'app_name':
    ensure   => present,
    path     => "${app_root}/newrelic/newrelic.yml",
    line     => "  app_name: ${app_name}",
    match    => '  app_name:',
    multiple => true,
    require  => Download_uncompress["newrelic_${type}${version}.zip"],
  }
}
