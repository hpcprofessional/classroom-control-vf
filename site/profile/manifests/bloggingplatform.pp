class profile::bloggingplatform (
  $docroot = '/var/www/wordpress',
){
  
  # Manage Wordpress
  class { 'wordpress':
    install_dir => $docroot,
    db_name     => 'wordpress',
    db_host     => 'localhost',
    db_user     => 'wordpress',
    db_password => 'insecure password',
  }
  
  # Manage Apache
  include apache
  
  # Mange Mysql
  class { 'mysql::server':
    root_password => 'insecure password',
  }
  
  class { 'mysql::bindings':
    php_enable => true,
  }
  
  # Manage PHP
  include apache::mod::php
  
  apache::vhost { $fqdn:
    docroot => $docroot,
    manage_docroot => false,
  }

}
