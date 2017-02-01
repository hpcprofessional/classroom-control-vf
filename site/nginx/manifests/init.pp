class nginx {
  $docroot  = '/var/www'
  $confdir  = '/etc/nginx'
  $blockdir = '/etc/nginx/conf.d'
  $package  = 'nginx'
  
  package { $package:
    ensure => present,
    before => [ File['nginx.conf'], File['default.conf'] ],
  }
  
  File {
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0664',
  }
  
  file { $docroot:
    ensure => directory,
  }
  
  file { 'index.html':
    path   => "${docroot}/index.html",
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { 'nginx.conf':
    path   => "${confdir}/nginx.conf",
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  
  file { 'default.conf':
    path   => "${blockdir}/default.conf",
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [ File['nginx.conf'], File['default.conf'] ],
  }

}
