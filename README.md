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

## Setup

### What newrelic affects

If it's obvious what your module touches, you can skip this section. For
example, folks can probably figure out that your mysql_instance module affects
their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you might want to include an additional "Upgrading" section
here.

### Beginning with newrelic

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

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

## Reference

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
