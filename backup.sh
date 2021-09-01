#!/bin/bash
# Boris Ischenko
# bo.ischenko@mail.ru
# backup script, training
# ./backup.sh [OPTIONS] [TARGET] [DESTINATION]
# OPTION	[1..9] compression
# TARGET	target directory 
# DESTINATION 	destination directory
if [ $# = 3 ];
then	
	if [[ $1 =~ ^[1-9]$ ]];
	then
		compression=$1
		target=$2
		destination=$3
	else
		printf "compression\tout of range [1..9]\n==>\t\tcheck compression option\n"
		exit
	fi
else
	if [ $# = 2 ]
	then		
		compression=5
		target=$1
		destination=$2
	else
		printf "unkown arguments signature: $# arguments\n==>\t\tcheck arguments\n"
		exit
	fi
fi	
if [ -s "$target" ];
then
	printf "target\t\tok\n"
	if [ -s $destination ];
	then
		printf "destination\tok\ncompression\t$compression\n"
		aname=${target%/}-`date +%H%M%S%d%m%y`
		printf "rolling tarball\t$aname.tar\n"
		tar -cf "$aname.tar" "$target"
		printf  "gzipping\t--//--.gz\n"
		gzip -$compression "$aname.tar"
		printf "moving to\t$destination\n"
		mv "$aname.tar.gz" "$destination"
	else
		printf "destination\tno go\n==>\t\tcheck 2nd argument\n"
	fi
else
	printf "target\t\tno go\n==>\t\tcheck 1st argument\n"
	exit
fi
