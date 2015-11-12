#!/bin/bash

IFS='
'
mkdir -f out

for k in $(find . -maxdepth 0 -type f)
do
    /usr/bin/ffmpeg -i ${k} -an -x265-params crf=25  out/${k}
done