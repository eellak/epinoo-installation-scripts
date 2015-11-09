#!/bin/bash -

FFMPEG_VERSION=2.3.3

[ -f src/ ] || mkdir src

pushd src
bzr branch lp:~aduitsis/+junk/ffmpeg
pushd ffmpeg
bzr builddeb -- -us -uc
popd

popd
