[![Build Status](https://travis-ci.org/Firebladee/newrelic.svg?branch=master)](https://travis-ci.org/Firebladee/newrelic)
# newrelic

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with newrelic](#setup)
    * [What newrelic affects](#what-newrelic-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with newrelic](#beginning-with-newrelic)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module is to add the newrelic agent's to your machine/application.
What can this modulle setup.
* os
* node.js
* php
* java

## Usage

### I want to monitor the os.
For hiera
```puppet
newrelic::os:
  'os':
    key: 'insert key'
```

### I need to add labels.
```puppet
newrelic::os:
  'os':
    key: 'insert key'
    labels:
      - 'os:linux'
      - 'environment:dev'
```
Labels can also be done as a string if there is only one.
```puppet
newrelic::os:
  'os':
    key: 'insert key'
    labels: 'os:linux'
```

### I need to monitor a java app.
```puppet
newrelic::java:
  'java':
    key: 'insert key'
    app_root: '/tmp'
    version: '3.27.0'
    app_name: 'fred'
```

### I am feed up repeating my key.
Then you are in luck.  The global key variable will take car of that.
```Puppet
newrelic::global_key: 'insert key'
```

### I need the new relic repo installed.
```puppet
newrelic::repo_install: true
```

### Parameters

#### `global_key`

This is used as the global key for the hash's.  Saves having to type the key in for each hash.

#### `repo_install`

This will add the repo to allow the newrelic packages to be installed.  Default value: false

#### `ensure`

This is used to install or remove the agent.  Default is `present`.

#### `key`

This is the key for your newrelic account.  If left blank then the agent will
be setup but nothing will be sent to the newrelic web site.

#### `version`

Used to specify the version of java plugin you want.  Defaults to `undef`.
This will cause the module to fail.

#### `app_root`

This is the root of the application that is going to be monitored by Newrelic.
Default is `undef`.

#### `source`

Source of the java agent.  Default is `http://yum.newrelic.com/newrelic/java-agent/`.

#### `type`

The type of java agent.  Default is `agent`.

#### `app_name`

This is used by node.js to identify the application.  Default is `undef`.

## Limitations

For the Redhat family, this has been tested on Centos.  So we have a baisc assumption that this will work on Redhat.

## Development

Just the standard, i.e. fork, make change add rspec/beaker tests and then push request.
If you are not ofay with rspec and beaker then still make the push request and we will help you with that.
