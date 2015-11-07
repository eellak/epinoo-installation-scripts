$wordpress_source = '/var/tmp/wordpress'

vcsrepo { $wordpress_source:
  ensure    => present,
  provider  => svn,
  source    => 'https://core.svn.wordpress.org/tags/4.3/',
#  revision  => '33946',
}

mysql::db { 'wordpress':
  user     => 'epinoo',
  password => $wordpress_db_pwd,
  host     => 'localhost',
  grant    => ['all'],
}

file { "$wordpress_root/wp-config.php":
  ensure => present,
  content => template('wp-config.php.erb'),
  mode    => '0600',
}

file { $wordpress_root:
  ensure  => directory,
  owner   => $www_user,
  recurse => true,
  source  => $wordpress_source,
}

Vcsrepo[$wordpress_source] -> File[$wordpress_root] -> File["$wordpress_root/wp-config.php"]
