class newrelic::repo {
  case $::osfamily {
    'RedHat'           : {
      yumrepo{ 'newrelic':
        ensure   => present,
        baseurl  => 'http://yum.newrelic.com/pub/newrelic/el5/$basearch',
        enabled  => true,
        gpgcheck => 0,
      }
    }
    /^(Debian|Ubuntu)$/: {
      include apt
      apt::source { 'newrelic':
        location => 'http://apt.newrelic.com/debian/',
        repos    => 'non-free',
        key      => {
          id     => '548C16BF',
          server => 'keyserver.ubuntu.com'
        },
        release  => 'newrelic',
      }
    }
    default: {}
  }
}
