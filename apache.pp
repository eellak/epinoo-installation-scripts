class { 'apache':  
  mpm_module => 'prefork'
}

apache::listen { $listen_port: }

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
