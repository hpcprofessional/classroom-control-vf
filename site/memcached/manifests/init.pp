class memcached {

  package { 'memcached':
    ensure => present,
    #before => File['memcached-config'],
  }
  
  file { 'memcached-config':
    ensure => file,
    path => '/etc/sysconfig/memcached',
    require => Package['memcached'],
    #notify => Service['memcached'],
  }
  
  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['memcached-config'],
  }

}
