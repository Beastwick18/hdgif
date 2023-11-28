#!/bin/sh

palette="./palette.png"
filters="fps=40,scale=-1:-1:flags=lanczos"
input="$1"

if [ -z "$1" ]; then
	echo "Must specify input video file!"
	exit 1
fi
if [ -z "$2" ]; then
	output="${input%.*}.gif"
else
	output="$2"
fi
echo $input
echo $output
ffmpeg -v warning -i $input -pix_fmt rgb24 -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -i $input -i $palette -loop 0 -lavfi "$filters [x]; [x][1:v] paletteuse" -y $output
