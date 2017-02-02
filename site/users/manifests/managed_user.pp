#The user.
#The user's home directory.
#The user's group, .ssh directory, or any other useful resources.


define users::managed_user (
  $username = $title,
  $group = $title,
  $home  = "/home/${username}",
  ) {

  user { $username :
    ensure     => present,
    gid        => $group,
    home       => $home,
    managehome => true,
  }

  group { $group :
    ensure => present,
  }

  file { "${home}/.ssh" :
    ensure  => directory,
    owner   => $username,
    group   => $group,
    mode    => '0700',
    require => User[$username],
  }

}
