class { '::mysql::server':
  create_root_user        => true,
  create_root_my_cnf      => true,
  root_password           => $db_root_passwd,
  remove_default_accounts => true,
}
