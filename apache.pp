class { 'apache':  
  mpm_module => 'prefork'
}

apache::listen { $listen_port: }
apache::listen { $listen_ssl_port: }

class {'apache::mod::php': } 

apache::vhost { $epinoo:
  ip              => $epinoo_ip,
  port            => 80,
  add_listen      => false,
  docroot         => $epinoo_root,
  docroot_owner  => $www_user,
  directories     => { 
    path => $epinoo_root,
  }
}

apache::vhost { "$epinoo-ssl":
  vhost_name      => $epinoo,
  ssl             => true,
  ssl_cert        => $moodle_ssl_cert,
  ssl_key         => $moodle_ssl_key,
  ip              => $epinoo_ip,
  port            => 443,
  add_listen      => false,
  docroot         => $epinoo_root,
  docroot_owner  => $www_user,
  directories     => { 
    path => $epinoo_root,
  }
}

apache::vhost { $moodle:
  ip              => $moodle_ip,
  port            => 80,
  add_listen      => false,
  docroot         => $moodle_root,
  docroot_owner  => 'root',
  directories     => { 
    path => $moodle_root,
  }
}
