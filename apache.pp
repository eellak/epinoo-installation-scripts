
class { 'apache':  
  mpm_module => 'prefork'
}

apache::listen { $listen_port: }

class {'apache::mod::php': } 

apache::vhost { $epinoo:
  ip              => $epinoo_ip,
  port            => 80,
  add_listen      => false,
  docroot         => "/var/www/$epinoo",
  docroot_owner  => $www_user,
  directories     => { 
    path => $epinoo_root,
  }
}


apache::vhost { $moodle:
  ip              => $moodle_ip,
  port            => 80,
  add_listen      => false,
  docroot         => "/var/www/$moodle",
  docroot_owner  => 'root',
  directories     => { 
    path => $moodle_root,
  }
}


#exec { 'fetch_moodle':
#  command     => 'wget https://download.moodle.org/download.php/stable29/moodle-latest-29.tgz',
#  path        => '/usr/bin',
#  cwd         => '/root',
#  creates     => '/root/moodle-latest-29.tgz',
#}
#
