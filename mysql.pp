class { '::mysql::server':
  root_password           => $db_root_passwd,
  remove_default_accounts => true,
}
