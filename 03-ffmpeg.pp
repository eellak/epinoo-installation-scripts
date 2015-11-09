exec { 'ffmpeg_sh':
  timeout => 0,
  command => '/root/epinoo-installation-scripts/ffmpeg.sh',
  creates => 'src/ffmpeg_2.3.3-1_amd64.deb',
}

package { "ffmpeg":
 provider => dpkg,
 ensure   => installed,
 source   => "src/ffmpeg_2.3.3-1_amd64.deb",
}
