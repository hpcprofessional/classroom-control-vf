class nginx (
  $confdir  = $nginx::params::confdir,
  $blockdir = $nginx::params::blockdir,
  $logdir   = $nginx::params::logdir,
  $docroot  = $nginx::params::docroot,
  $user     = $nginx::params::user,
  $owner    = $nginx::params::owner,
  $group    = $nginx::params::group,
) inherits nginx::params {

  File {
    owner => $owner,
    group => $group,
    mode => '0664',
  }

  package { 'nginx':
    ensure => present,
    before => [File['config'],File['block']],
  }
  
  file { 'docroot':
    ensure => directory,
    path => $docroot,
  }
  
  file { 'index':
    ensure => file,
    path => "${docroot}/index.html",
    content => template('nginx/index.html.erb'),
  }
    
  file { 'config':
    ensure => file,
    path => "${confdir}/nginx.conf",
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  
  file { 'block':
    ensure => file,
    path => "${blockdir}/default.conf",
    content => template('nginx/default.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    name => $service,
    require => [File['docroot'],File['index']],
    subscribe => [File['config'],File['block']],
  }

}
