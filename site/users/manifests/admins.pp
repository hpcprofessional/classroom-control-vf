class users::admins {

  users::managed_user { 'paul': 
    home_base => '/tmp',
  }
  users::managed_user { 'jose': }
  users::managed_user { 'alice': 
    group => 'devops',
  }
  users::managed_user { 'chen': 
    group => 'appdev',
    home_base => '/appdev',
  }

  file { "/appdev":
    ensure => directory,
  }

}
