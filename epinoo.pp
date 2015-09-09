$epinoo_source = '/var/tmp/epinoo'

vcsrepo { $epinoo_source:
  ensure    => present,
  provider  => svn,
  source    => 'https://core.svn.wordpress.org/tags/4.3/',
#  revision  => '33946',
}

mysql::db { 'epinoo':
  user     => 'epinoo',
  password => $epinoo_db_pwd,
  host     => 'localhost',
  grant    => ['all'],
}

file { "$epinoo_root/wp-config.php":
  ensure => present,
  content => template('wp-config.php.erb')
  mode    => '0600',
}

file { $epinoo_root:
  ensure  => directory,
  owner   => $www_user,
  recurse => true,
  source  => $epinoo_source,
}

Vcsrepo[$epinoo_source] -> File[$epinoo_root] -> File["$epinoo_root/wp-config.php"] 
