#!/bin/bash

LINE_COUNT=0
is_code () {
	ABS_PATH=$1
	
	# check it's text file
	FILE_TYPE=$(file --exclude text $ABS_PATH | cut -d " " -f 2)
	if [ $FILE_TYPE = "data" ]; then
		NEW_COUNT=$(wc -l $ABS_PATH | cut -d " " -f 1)
		LINE_COUNT=$(($LINE_COUNT + $NEW_COUNT))
	fi
}

parse_dir () {
	# loop through files and directories in path
	for name in "$1"/*; do
		if [ -d "$name" ]; then
			parse_dir "$name"
		else
			is_code "$name"
		fi
	done
}

parse_dir "$1"

echo $LINE_COUNT
