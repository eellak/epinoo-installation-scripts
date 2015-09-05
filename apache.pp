
if ! $epinoo {
	$epinoo_vhost =  'epinoo.test.noc.ntua.gr'
}
else { 
	$epinoo_vhost = $epinoo
}

if ! $moodle {
	$moodle_vhost =  'moodle.test.noc.ntua.gr'
}
else { 
	$moodle_vhost = $moodle
}

$default_ip = '83.212.119.95'

$epinoo_ip = $default_ip
$moodle_ip = $default_ip

$listen_port = 80


$prefix = "/var/www"
$epinoo_root = "$prefix/$epinoo_vhost"
$moodle_root = "$prefix/$moodle_vhost"


class { 'apache':  
  mpm_module => 'prefork'
}

apache::listen { $listen_port: }

class {'apache::mod::php': } 

apache::vhost { $epinoo_vhost:
  ip          => $epinoo_ip,
  port        => 80,
  add_listen  => false,
  docroot     => "/var/www/$epinoo_vhost",
  directories => { 
    path => $epinoo_root,
  }
}


apache::vhost { $moodle_vhost:
  ip          => $moodle_ip,
  port        => 80,
  add_listen  => false,
  docroot     => "/var/www/$moodle_vhost",
  directories => { 
    path => $moodle_root,
  }
}
