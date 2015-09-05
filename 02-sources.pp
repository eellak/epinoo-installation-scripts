$mirror = 'gr'

#lsbdistcodename => trusty
#lsbdistdescription => Ubuntu 14.04.2 LTS
#lsbdistid => Ubuntu
#lsbdistrelease => 14.04
#lsbmajdistrelease => 14

#TODO : Most of these entries many be already in /etc/apt/sources.list. Consider removing that file?

apt::source { $lsbdistcodename:
  location => "http://${mirror}.archive.ubuntu.com/ubuntu",
  release  => $lsbdistcodename,
  repos    => 'main restricted universe multiverse',
  include  => {
    'src' => true,
    'deb' => true,
  },
}

apt::source { "$lsbdistcodename-updates":
  location => "http://${mirror}.archive.ubuntu.com/ubuntu",
  release  => "$lsbdistcodename-updates",
  repos    => 'main restricted universe multiverse',
  include  => {
    'src' => true,
    'deb' => true,
  },
}

apt::source { "$lsbdistcodename-backports":
  location => "http://${mirror}.archive.ubuntu.com/ubuntu",
  release  => "$lsbdistcodename-backports",
  repos    => 'main restricted universe multiverse',
  include  => {
    'src' => true,
    'deb' => true,
  },
}

apt::source { "$lsbdistcodename-security":
  location => "http://${mirror}.archive.ubuntu.com/ubuntu",
  release  => "$lsbdistcodename-security",
  repos    => 'main restricted universe multiverse',
  include  => {
    'src' => false,
    'deb' => true,
  },
}

apt::ppa { "ppa:libreoffice/libreoffice-4-4":
  ensure  => present,
}

apt::key { 'bbb-key':
  id  => 'DFE4E8943405D215EDDD6D5C705F9EED328BD16D',
}

apt::source { 'bbb-apt-source':
  location => "http://ubuntu.bigbluebutton.org/trusty-090/",
  release  => "bigbluebutton-$lsbdistcodename",
  repos    => 'main',
  include  => {
    'src' => false,
    'deb' => true,
  },
}
  
#apt::source { 'ffmpeg-apt-source':
#  location => "http://ppa.launchpad.net/mc3man/trusty-media/ubuntu",
#  release  => "$lsbdistcodename",
#  repos    => 'main',
#  include  => {
#    'src' => true,
#    'deb' => true,
#  },
#}

apt::ppa { "ppa:mc3man/trusty-media":
  ensure  => present,
}
