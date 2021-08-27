#!/bin/bash
# 27.08.2021, Boris Ischenko
# bo.ischenko@mail.ru
# backup script, training
# $1 - target directory
# $2 - destination directory
if [ ! -z $1 ] && [ ! -z $2 ];
then
	if [ -s $1 ];
	then
		printf "target\t\tok\n"
		if [ -s $2 ];
		then
			printf "destination\tok\n"
			timestamp=`date +%H%M%S%d%m%y`
			aname=${1%/}-$timestamp
			printf "rolling tarball\t$aname.tar\n"
			tar -cf $aname.tar $1
			printf  "gzipping gzip\t$aname.tar.gz\n"
			gzip -9 $aname.tar
			printf "moving\t\t$2\n"
			mv $aname.tar.gz $2
		else
			echo "destination... no go"
			echo "==> check 2nd argument"
		fi
	else
		echo "target... no go"
		echo "==> check 1st argument"
	fi
fi
