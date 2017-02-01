class memcached {
  package { 'memcached':
    ensure => present,
    before => File['memcached'],
  }
  
  file { 'memcached':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
    path   => '/etc/sysconfig/memcached',
    source => 'puppet:///modules/memcached/memcached',
  }
  
  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['memcached'],
  }
}
