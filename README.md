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

## Setup

### Setup Requirements

This module is assuming that the newrelic yum repo is installed.  If not then
see 'tests/hieradata/common.yaml' for example of how to set that up.

## Usage

Using this module is nice and simple, create a hash and pass that to the module.
For hiera
```puppet
newrelic::type:
  'os':
    key: 'insert key'
  'php': 
    key: 'insert key'
  'java':
    key: 'insert key'
    app_root: '/tmp'
    version: '2.10.0'
    app_name: 'fred'
  'nodejs':
    key: 'insert key'
    app_root: '/tmp'
    app_name: 'fred'
```

### Parameters

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

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
