#!/bin/bash

#since this script can be launch from the build, we need to get the path of the first script that was executed
currentDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $currentDir/utils.sh

source $currentDir/../settings.conf

main() {
	replace_versions
}

validate_input() {
	semver_regex="^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(\-[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?(\+[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?$"
	
	if [[ "$version" =~ $semver_regex ]]
    then
		echo -en '\E[32m'"\033[1mversion follow semver standard\033[0m"
		echo
        return 0
    else
        errcho "version $version does not follow semver standard"
		return 1
    fi
}

replace_versions() {
	if validate_input
	then
		echo version = $version
		
		# replace first line of release_notes.txt
		echo Replacing release_notes.txt ...
		sed -i "1s/.*/build $version/" $currentDir/../../../release_notes.txt
		echo Done
		
		# find and replace line "version": of package.json
		echo Replacing package.json ...
		sed -i "s/\"version\":.*/\"version\": \""$version"\",/" $currentDir/../../../package.json
		echo Done
		
		# replace line this.version = of app.js
		echo Replacing app.js ...
		sed -i "s/this.version =.*/this.version = "\"$version\"";/" $currentDir/../../../core/js/app.js
		echo Done
	fi
}

main