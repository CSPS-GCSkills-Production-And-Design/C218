#!/bin/bash

. ./tools/utils.sh

devPath=\\\\skynet\\dev\\_framework\\dev

main() {
	readConfigs
	backupDev
	copyFiles
	build
}

backupDev() {
	echoDate
	echo
	echo -en '\E[33m'"\033[1mBackup Dev\033[0m"
	echo
	
	#if the folder name renamed doesn't exist, rename it
	if [ ! -d $devPath\\${version}_bak ]; then
	
		read -r -p "Are you sure you want to rename `echo $'\n '` $devPath\\$version `echo $'\n '` to `echo $'\n '` $devPath\\${version}_bak? `echo $'\n '` [y/N] " response
		if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
		then
			mv -v $devPath\\$version $devPath\\${version}_bak
		else
			echo -en '\E[31m'"\033[1mA backup must be created in order to continue.\033[0m"
			echo
			echo Aborting...
			exit 0
		fi
	else
		echo -en '\E[31m'"\033[1mDirectory $devPath\\${version}_bak already exists\033[0m"
		echo
		echo Aborting...
		exit 0
	fi
}

copyFiles() {
	echoDate
	echo
	echo -en '\E[33m'"\033[1mCopying Files\033[0m"
	echo
	cp -avr ../../$version $devPath
	echo Done
	echo
}

readConfigs() {
	echoDate
	echo
	echo -en '\E[33m'"\033[1mConfigs\033[0m"
	echo 
	source ./settings.conf

	#to lowercase
	env=${environment,,}
	
	echo "Environment: $env"
	echo "Version: $version"
	echo
}

build() {
	echo -en '\E[33m'"\033[1mBuilding dev...\033[0m"
	echo
	#build skynet dev files
	$devPath/$version/build/build.sh
}

main