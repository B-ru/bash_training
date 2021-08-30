#!/bin/bash
# Boris Ischenko
# bo.ischenko@mail.ru
# config parsing and backup launching script, training
# ./parse_conf.sh
# ~/.backup.conf - config file
pattern='(.+);(.+);([1-9]{1})$'
while read line; do
	if [[ $line =~ $pattern ]];
	then
		target=${BASH_REMATCH[1]}
		destination=${BASH_REMATCH[2]}
		compression=${BASH_REMATCH[3]}
		/bin/bash ~/Documents/utils/backup.sh $compression $target $destination
	fi
done < ~/.backup.conf
