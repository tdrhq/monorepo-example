#!/bin/bash
set -e
set -x

cd `dirname $0`

mkdir screenshots || true
MAGICK=""
env

if [ `git rev-parse --abbrev-ref HEAD` = master ] ; then
    sleep 0

fi

if magick --help ; then
    MAGICK=magick
fi

echo Before convert call

$MAGICK convert --version

$MAGICK convert -size 360x360 xc:white -font "FreeMono" -pointsize 12 -fill black -stroke black -draw @ascii.txt -strip screenshots/image.png

echo After convert call
