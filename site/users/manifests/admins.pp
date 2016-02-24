class users::admins {

  users::managed_users { 'paul': 
    $home_base = '/tmp',
  }
  users::managed_users { 'jose': }
  users::managed_users { 'alice': 
    $group = 'devops',
  }
  users::managed_users { 'chen': 
    $group = 'appdev',
    $home_base = '/appdev'
  }

  file { "/appdev":
    ensure => directory,
  }

}
