class nginx{

case $::osfamily {
  'RedHat' : {
    $package  = 'nginx'
    $owner    = 'root'
    $group    = 'root'
    $docroot  = '/var/www'
    $confdir  = '/etc/nginx'
    $blockdir = '/etc/nginx/conf.d'
    $logdir   = '/var/log/nginx'
    $service  = 'nginx'
    $user     = 'nginx'
  }
  'Debian' : {
    $package  = 'nginx'
    $owner    = 'root'
    $group    = 'root'
    $docroot  = '/var/www'
    $confdir  = '/etc/nginx'
    $blockdir = '/etc/nginx/conf.d'
    $logdir   = '/var/log/nginx'
    $service  = 'nginx'
    $user     = 'www-data'
  }
  'windows' : {
    $package  = 'nginx-service'
    $owner    = 'Administrator'
    $group    = 'Administrators'
    $docroot  = 'C:/ProgramData/nginx/html'
    $confdir  = 'C:/ProgramData/nginx'
    $blockdir = 'C:/ProgramData/nginx/conf.d'
    $logdir   = 'C:/ProgramData/nginx/logs'
    $service  = 'nginx'
    $user     = 'nobody'
  }
  default : {
    fail { "Get a suppported Operating System, friend.": }
  }
}

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
