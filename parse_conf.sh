#!/bin/bash
# Boris Ischenko
# bo.ischenko@mail.ru
# config parse script, training
# ./parse_conf.sh
# ~/.backup.conf - config file
while read line; do
	echo $line
	pattern='(.+);(.+);([1-9]{1})$'
	if [[ $line =~ $pattern ]];
	then
		target=${BASH_REMATCH[1]}
		destination=${BASH_REMATCH[2]}
		compression=${BASH_REMATCH[3]}
		/bin/bash ~/Documents/utils/backup.sh $compression $target $destination
	fi
done < ~/.backup.conf
