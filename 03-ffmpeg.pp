package { "ffmpeg":
 provider => dpkg,
 ensure   => installed,
 source   => "ffmpeg_2.3.3-1_amd64.deb",
}
