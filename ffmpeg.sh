#!/bin/bash -

FFMPEG_VERSION=$(FACTER_FFMPEG_VERSION)

[ -d src/ ] || mkdir src

pushd src
bzr branch lp:~aduitsis/+junk/ffmpeg
pushd ffmpeg
bzr builddeb -- -us -uc
popd

popd
