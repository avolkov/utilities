#!/bin/bash

## http://superuser.com/questions/785528/how-to-generate-an-mp4-with-h-265-codec-using-ffmpeg
IFS='
'
mkdir -p out

for k in *.mkv
do
    /usr/bin/ffmpeg -i ${k} -c:a copy -x265-params crf=25 out/${k}
done