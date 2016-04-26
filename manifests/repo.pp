class newrelic::repo {
  case $osfamily {
    'RedHat'           : { 
      yumrepo{ 'newrelic':
        ensure   => present,
        baseurl  => 'http://yum.newrelic.com/pub/newrelic/el5/$basearch',
        enabled  => true,
        gpgcheck => 0,
      }
    }
#    /^(Debian|Ubuntu)$/:

  }
}
