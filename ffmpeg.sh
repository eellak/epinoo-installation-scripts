#!/bin/sh -

sudo apt-get install -qq build-essential git-core checkinstall yasm texi2html libvorbis-dev libx11-dev libvpx-dev libxfixes-dev zlib1g-dev pkg-config netcat libncurses5-dev dh-make bzr-builddeb yasm autotools-dev

FFMPEG_VERSION=2.3.3

mkdir src
cd src
#if [ ! -d "ffmpeg-${FFMPEG_VERSION}" ]; then
#  sudo wget "http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2"
#  sudo tar -xjf "ffmpeg-${FFMPEG_VERSION}.tar.bz2"
#fi
#
#cd "ffmpeg-${FFMPEG_VERSION}"
#sudo ./configure --enable-version3 --enable-postproc --enable-libvorbis --enable-libvpx
#sudo make
#sudo checkinstall --pkgname=ffmpeg --pkgversion="5:${FFMPEG_VERSION}" --backup=no --deldoc=yes --default

bzr branch lp:~aduitsis/+junk/ffmpeg
cd ffmpeg
bzr builddeb -- -us -uc
