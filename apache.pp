class { 'apache':
  mpm_module => 'prefork'
}

apache::listen { $listen_port: }
apache::listen { $listen_ssl_port: }

class {'apache::mod::php': }
class {'apache::mod::rewrite': }
class {'apache::mod::shib':}

apache::vhost { $wordpress:
  ip              => $wordpress_ip,
  port            => 80,
  add_listen      => false,
  docroot         => $wordpress_root,
  docroot_owner   => $www_user,
  override        => ['All'],
  rewrites        => [{}],
  directories     => [
    {
    allow_override  => ['All'],
    path            => $wordpress_root,
    },
  ],
}

apache::vhost { "$wordpress-ssl":
  vhost_name      => $wordpress,
  ssl             => true,
  ssl_cert        => $wordpress_ssl_cert,
  ssl_key         => $wordpress_ssl_key,
  ip              => $wordpress_ip,
  port            => 443,
  add_listen      => false,
  docroot         => $wordpress_root,
  docroot_owner   => $www_user,
  override        => ['All'],
  rewrites        => [{}],
  directories     => [
    {
    allow_override        => ['All'],
    path                  => $wordpress_root,
    auth_type             => 'Shibboleth',
    #shib_request_settings => { 'requiresession' => 'On' },
    shib_use_headers      => 'On',
    require               => 'shibboleth',
    },
    {
    auth_type             => 'Shibboleth',
    allow_override        => ['All'],
    path                  => "$wordpress_root/secure/",
    shib_request_settings => { 'requiresession' => 'On' },
    shib_use_headers      => 'On',
    require               => 'valid-user',
    },
  ],
}

apache::vhost { $moodle:
  ip              => $moodle_ip,
  port            => 80,
  add_listen      => false,
  docroot         => $moodle_root,
  docroot_owner   => $www_user,
  directories     => {
    path => $moodle_root,
  }
}
#apache::vhost { "$moodle-ssl":
#  vhost_name      => $moodle,
#  ssl             => true,
#  ssl_cert        => $moodle_ssl_cert,
#  ssl_key         => $moodle_ssl_key,
#  ip              => $moodle_ip,
#  port            => 443,
#  add_listen      => false,
#  docroot         => $moodle_root,
#  docroot_owner   => $www_user,
#  override        => ['All'],
#  rewrites        => [{}],
#  directories     => {
#    path => $moodle_root,
#  }
#}

apache::vhost { "$moodle-ssl":
  vhost_name      => $moodle,
  ssl             => true,
  ssl_cert        => $moodle_ssl_cert,
  ssl_key         => $moodle_ssl_key,
  ip              => $moodle_ip,
  port            => 443,
  add_listen      => false,
  docroot         => $moodle_root,
  docroot_owner   => $www_user,
  override        => ['All'],
  rewrites        => [{}],
  directories     => [
    {
    allow_override  => ['All'],
    path            => $moodle_root,
    },
  ],
}

class { 'shibboleth':
  hostname  => $wordpress,
}

file { '/etc/shibboleth/attribute-map.xml':
  ensure  => present,
  content => template('attribute-map.xml.erb'),
}

# This is a small hack to make sure the attribute map was changed.
# Put the attribute-map.xml template after installing shibboleth, 
# to ensure that everything is there beforehand. But, after putting 
# attribute-map.xml in its place, notify the shibd service so as to 
# restart the shibd daemon. The Service['shibd'] is in  
# puppet-shibboleth/manifests/init.pp

File['shibboleth_conf_dir'] -> File['/etc/shibboleth/attribute-map.xml'] ~> Service['shibd']

shibboleth::metadata{ 'federation_metadata':
  provider_uri  => 'https://aai.grnet.gr/metadata.xml',
  cert_uri      => 'https://aai.grnet.gr/wayf.grnet.gr.crt',
}

shibboleth::sso { 'federation_sso':
  discoveryURL  => 'https://wayf.grnet.gr',
}

include shibboleth::backend_cert

