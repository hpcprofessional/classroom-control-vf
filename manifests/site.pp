# Disable filebucket by default for all File resources:
File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  include role::classroom
  #include examples::fundamentals
  
  # Exercise 7.1
  #file { 'motd':
  #  ensure  => file,
  #  owner   => 'root',
  #  group   => 'root',
  #  mode    => '0644',
  #  path    => '/etc/motd',
  #  content => "Think before you type!\n",
  #}
  
  # Exercise 7.2
  #exec { "cowsay 'Welcome to ${::fqdn}!' > /etc/motd":
  #  creates => '/etc/motd',
  #  path    => '/bin:/usr/bin:/usr/local/bin',
  #}
  
  # Exercise 7.3 (Homework)
  host { 'josephoaks.puppetlabs.vm':
    ensure => present,
    ip     => '127.0.0.1',
  }
  
  # Exercise 9.2
  include users
  
  # Exercise 9.3
  include skeleton
}
