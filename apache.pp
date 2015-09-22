class { 'apache':  
  mpm_module => 'prefork'
}

apache::listen { $listen_port: }
apache::listen { $listen_ssl_port: }

class {'apache::mod::php': } 
class {'apache::mod::rewrite': } 
class {'apache::mod::shib':}

apache::vhost { $epinoo:
  ip              => $epinoo_ip,
  port            => 80,
  add_listen      => false,
  docroot         => $epinoo_root,
  docroot_owner   => $www_user,
  override        => ['All'],
  rewrites        => [{}],
  directories     => [
    { 
    allow_override  => ['All'],
    path            => $epinoo_root,
    },
  ],
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
  override        => ['All'],
  rewrites        => [{}],
  directories     => [ 
    { 
    allow_override  => ['All'],
    path            => $epinoo_root,
    },
#    { 
#    auth_type             => 'Shibboleth',
#    allow_override        => ['All'],
#    path                  => "$epinoo_root/secure/",
#    shib_request_settings => { 'requiresession' => 'On' },
#    shib_use_headers      => 'On',
#    },
  ],
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


class { 'shibboleth': 
  hostname  => $epinoo,
}

shibboleth::metadata{'federation_metadata':
  provider_uri  => 'https://aai.grnet.gr/metadata.xml',
  cert_uri      => 'https://aai.grnet.gr/wayf.grnet.gr.crt',
}

shibboleth::sso { 'federation_sso':
  discoveryURL  => 'https://wayf.grnet.gr',
}
include shibboleth::backend_cert

