# Class: newrelic
# ===========================
#
# Full description of class newrelic here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'newrelic':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class newrelic (
  $os     = undef,
  $php    = undef,
  $java   = undef,
  $nodejs = undef,
  $ruby   = undef,
  $net    = undef,
  $python = undef,

  $global_key   = undef,
  $repo_install = false
){

  if $repo_install {
    include newrelic::repo
  }

  if $global_key != undef {
    $default = {
      key => $global_key,
    }
  }
  else {
    $default = {
      'default' => undef,
    }
  }

  if $os != undef {
    validate_hash($os)
    create_resources(newrelic::os, $os, $default)
  }

  if $php != undef {
    validate_hash($php)
    create_resources(newrelic::php, $php, $default)
  }

  if $java != undef {
    validate_hash($java)
    create_resources(newrelic::java, $java, $default)
  }

  if $nodejs != undef {
    validate_hash($nodejs)
    create_resources(newrelic::nodejs, $nodejs, $default)
  }

  if $ruby != undef {
    validate_hash($ruby)
    create_resources(newrelic::ruby, $ruby, $default)
  }

  if $net != undef {
    validate_hash($net)
    create_resources(newrelic::net, $net, $default)
  }

  if $python != undef {
    validate_hash($python)
    create_resources(newrelic::python, $python, $default)
  }
}
