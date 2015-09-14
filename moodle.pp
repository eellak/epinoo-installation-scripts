
$moodle_source = '/var/tmp/moodle'
$data_root = '/var/www/moodle-data'

vcsrepo { $moodle_source:
  
  ensure    => present,
  provider  => git,
  source    => 'git://git.moodle.org/moodle.git',
  revision  => 'MOODLE_29_STABLE',
}

mysql::db { 'moodle':
  user     => 'moodle',
  password => $moodle_db_pwd,
  host     => 'localhost',
  grant    => ['all'],
}

file { $data_root:
  ensure  => 'directory',
  owner   => $www_user,
  mode    => '0644',
}

#exec { 'copy_moodle_to_apache':
#  cwd         => $moodle_source,
#  command     => 'cp -Rp $moodle_source/* $moodle_root/',
#  path        => '/bin',
#  creates     => "$moodle_root/README.txt",
#  refreshonly => true,
#}
#Vcsrepo[$moodle_source] ~> Exec['copy_moodle_to_apache']

file { $moodle_root:
  ensure  => directory,
  owner   => 'root',
  recurse => true,
  source  => $moodle_source,
}
Vcsrepo[$moodle_source] -> File[$moodle_root]

Vcsrepo[$moodle_source] -> Mysql::Db['moodle'] -> File[$data_root] -> Exec['install_moodle']

exec { 'install_moodle':
  cwd       => "$moodle_root/admin/cli",
  creates   => "$moodle_root/config.php",
  path      => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
  command   => "php install.php --chmod=0750 --lang=el --wwwroot=$moodle_url --dataroot=$data_root --dbuser=moodle --dbpass='$moodle_db_pwd' --fullname='$moodle_fullname' --shortname='$moodle_shortname' --non-interactive --agree-license --adminpass='$moodle_adminpass'",
  user      => 'www-data',
}
