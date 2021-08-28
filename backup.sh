#!/bin/bash
# 27.08.2021, Boris Ischenko
# bo.ischenko@mail.ru
# backup script, training
# $1 - target directory
# $2 - destination directory
if [ ! -z $1 ] && [ -s $1 ];
then
	printf "target\t\tok\n"
	if [ ! -z $2 ] && [ -s $2 ];
	then
		printf "destination\tok\n"
		aname=${1%/}-`date +%H%M%S%d%m%y`
		printf "rolling tarball\t$aname.tar\n"
		tar -cf $aname.tar $1
		printf  "gzipping gzip\t$aname.tar.gz\n"
		gzip -9 $aname.tar
		printf "moving\t\t$2\n"
		mv $aname.tar.gz $2
	else
		printf "destination\tno go\n==> check 2nd argument\n"
	fi
else
	printf "target\t\tno go\n==> check 1st argument\n"
fi
