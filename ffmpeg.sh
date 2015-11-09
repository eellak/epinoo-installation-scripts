#!/bin/sh -

FFMPEG_VERSION=2.3.3

mkdir src

pushd src
bzr branch lp:~aduitsis/+junk/ffmpeg
pushd ffmpeg
bzr builddeb -- -us -uc
popd

popd
