#!/bin/bash

## Convert *.mkv files with DTS-encoded audio to AC3 
## This assures proper playback on raspberry pi
## See http://raspberrypi.stackexchange.com/questions/4349/difference-between-h-264-and-x264-and-how-to-play-it


IFS='
'
mkdir -f out

for k in *.mkv
do
/usr/bin/ffmpeg -i ${k}  -map 0 -codec:v copy -codec:s copy -codec:a ac3 out/${k}
done