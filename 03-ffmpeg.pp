exec { 'ffmpeg_sh':
  timeout => 0,
  command => '/root/epinoo-installation-scripts/ffmpeg.sh',
  creates => "/root/spinoo-installation-scripts/src/ffmpeg_${ffmpeg_version}-1_amd64.deb"
}

package { "ffmpeg":
  provider => dpkg,
  ensure   => present,
  source   => "/root/epinoo-installation-scripts/src/ffmpeg_${ffmpeg_version}-1_amd64.deb",
}
