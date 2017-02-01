class skeleton {
  file { '/etc/skel':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
  }
  
  file { '/etc/skel/.bashrc':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/skeleton/bashrc',
  }
}
