#!/bin/bash
# Boris Ischenko
# bo.ischenko@mail.ru
# backup script, training
# ./backup.sh [OPTIONS] [TARGET] [DESTINATION]
# OPTION	[1..9] compression
# TARGET	target directory 
# DESTINATION 	destination directory
if [ $# = 3 ] && [[ $1 =~ ^[1-9]$  ]];
then	
	if [ -s $2 ];
	then
		printf "target\t\tok\n"
		if [ -s $3 ];
		then
			printf "destination\tok\ncompression\t$1\n"
			compression=$1
			target=$2
			destination=$3
		else
			printf "destination\tno go\n==> check 2nd argument\n"
			exit
		fi
	else
		printf "target\t\tno go\n==> check 1st argument\n"
		exit
	fi
else
	if [ $# = 2 ];
	then
		if [ -s $1 ];
		then
			printf "target\t\tok\n"
			if [ -s $2 ];
			then
				printf "destination\tok\ncompression\tdefault\n"
				compression=5
				target=$1
				destination=$2
			else
				printf "destination\tno go\n==> check 2nd argument\n"
				exit
			fi
		else
			printf "target\t\tno go\n==> check 1st argument\n"
			exit
		fi
	else
		printf "unkown arguments signature: $# arguments\n==> check arguments\n"
		exit
	fi
fi			
aname=${target%/}-`date +%H%M%S%d%m%y`
printf "rolling tarball\t$aname.tar\n"
tar -cf $aname.tar $target &>/dev/null
printf  "gzipping\t--//--.gz\n"
gzip -$compression $aname.tar
printf "moving to\t$destination\n"
mv $aname.tar.gz $destination
