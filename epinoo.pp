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




