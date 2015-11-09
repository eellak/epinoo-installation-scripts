#!/bin/bash -

FFMPEG_VERSION=2.3.3

# install some prerequisites
puppet apply 00-essentials.pp

[ -d src/ ] || mkdir src

pushd src
bzr branch lp:~aduitsis/+junk/ffmpeg
pushd ffmpeg
bzr builddeb -- -us -uc
popd

popd
