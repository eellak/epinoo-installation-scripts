
apt::key { 'ajenti-key':
  id      => '425E018E23944B4B42814EE0BDC3FBAA53029759',
  server  => 'keyserver.ubuntu.com',
}
->
apt::source { 'ajenti-repo':
  location => 'http://repo.ajenti.org/ng/debian',
  release  => 'main',
  repos    => 'main ubuntu',
  include  => {
    'deb' => true,
  },
}
->
package { 'ajenti':
  ensure  => installed,
}
