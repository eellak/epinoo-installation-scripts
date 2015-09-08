vcsrepo { '/root/moodle':
  ensure    => present,
  provider  => git,
  source    => 'git://git.moodle.org/moodle.git',
  revision  => 'MOODLE_29_STABLE',
}


mysql::db { 'moodle':
  user     => 'moodle',
  password => $moodle_db_pwd,
  host     => 'localhost',
  grant    => ['all privileges'],
}

$data_root = '/var/www/moodle-data'

file { $data_root:
  ensure  => 'directory',
  owner   => $www_user,
  mode    => '0644',
}

#file { $moodle_root:
#  ensure  => directory,
#  owner   => 'root',
#  recurse => true,
#  source  => '/root/moodle/',
#}

#Vcsrepo['/root/moodle/'] -> File[$moodle_root]

Mysql::Db['moodle'] -> File['/var/www/moodle-data']

#exec { 'install_moodle':
#  cwd       => '/root/moodle/admin/cli',
#  creates => '/root/moodle/config.php',
#  path      => '/usr/bin',
#  command   => "php install.php --chmod=0750 --lang=el --wwwroot=http://moodle.test.noc.ntua.gr --dataroot=/var/www/moodle-data --dbuser=moodle --dbpass=example_password_please_change --fullname=FullName --shortname=ShortName --non-interactive --agree-license --adminpass=xxxxx",
#  refreshonly => true,
#  user  => $www_user,
#}
