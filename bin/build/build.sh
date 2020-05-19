#!/bin/bash

. ./tools/onexit.sh
. ./tools/utils.sh

#used in order to know the time the build has taken to complete
start=`date +%s`

main() {
	buildStart
	readConfigs
	buildCSS
	buildRequire
# 	copyCustomFiles
	replaceVersions
	buildEnd
	echo Last Build date: $(echoDate) > build.log
}

buildStart() {
	echoDate
	echo -en '\E[36m'"\033[1m-----------------------------\033[0m"
	echo
	echo -en '\E[36m'"\033[1m---------BUILD START---------\033[0m"
	echo
	echo -en '\E[36m'"\033[1m-----------------------------\033[0m"
	echo
}

readConfigs() {
	echo -en '\E[33m'"\033[1mConfigs\033[0m"
	echo 
	source ./settings.conf

	#to lowercase
	env=${environment,,}
	
	echo "Environment: $env"
	echo "Version: $version"
	echo
}
buildCSS() {
	echoDate
	echo -en '\E[33m'"\033[1mSASS minimification\033[0m"
	echo 
	echo Building CSS...
	npm run build-css
	echo Done
	echo
}
buildRequire() {
	echoDate
	echo -en '\E[33m'"\033[1mJavascript and CSS optimization\033[0m"
	echo 
	node ..\\..\\core\\js\\lib\\r.js -o build_$env.js
	echo
}

# copyCustomFiles() {
# 	#there are some files that we do not want to minify and compress 
# 	#while in dev environemt
	
# 	if [[ "$env" == "dev" ]]
#     then
# 		echoDate
	
# 		echo -en '\E[33m'"\033[1mCopying custom files\033[0m"
# 		echo 
# 		echo Copying general.js to dist/settings
# 		cp ..\\settings\\general.js ..\\dist\\settings
# 		echo Done
# 		echo Copying general_default.js to dist/settings
# 		cp ..\\settings\\general_default.js ..\\dist\\settings
# 		echo Done
# 		echo Copying labels.js to dist/settings
# 		cp ..\\settings\\labels.js ..\\dist\\settings
# 		echo Done
# 		echo Copying interactions.js to dist/content/scripts
# 		cp ..\\content\\scripts\\interactions.js ..\\dist\\content\\scripts
# 		echo Done
# 		echo
# 	fi
# }

replaceVersions() {
	echoDate
	echo -en '\E[33m'"\033[1mReplacing versions\033[0m"
	echo 
	. ./tools/replaceVersions.sh
	echo
}

buildEnd() {
	echoDate
	end=`date +%s`
	echo $(getTotalBuildTime start end)
}


main

onexit