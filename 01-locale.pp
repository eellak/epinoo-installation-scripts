

package { 'language-pack-en':
  ensure => present,
}

exec{ 'set_locale':
  command     => 'update-locale LANG=en_US.UTF-8',
  path        => '/usr/sbin',
  refreshonly => true,
} 

Package['language-pack-en'] ~> Exec['set_locale'] 

