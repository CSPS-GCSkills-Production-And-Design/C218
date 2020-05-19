({
    //from the current folder (build)
    appDir: "../../",
    //from the appDir
    baseUrl: "./core/js",
    //from the current folder (build)
    dir: "../../dist",

    modules: [{
        name: 'main',
        //Do not package 'interactions-custom' as it contains a fallback path. 
        //url of main config file will be used.
        //For paths fallback issues, see: 
        //https://github.com/requirejs/requirejs/issues/791
        //
        //Do not package "wet-boew" as it is self executing, 
        //and weirdly checking for it's script tag to do stuff.
        //Since we are injecting the script when needed, 
        //keep it out of the main file to avoid errors.
        exclude: ['interactions-custom', 'wet-boew']
    }],

    //find all the css under dir, and minify them
    optimizeCss: 'standard.keepLines',

    optimize: 'uglify2',

    removeCombined: true,

    findNestedDependencies: true,
	
	//do not include in the dist folder these folders-files
    fileExclusionRegExp: /^(r|build)\.js|.sass-cache|node_modules|package|watch-css|bin|scss|release_notes.txt|version_doc.txt$/,

    mainConfigFile: "../../core/js/require-configs.js",
	
	//r.js will not write a build.txt file in the
    //"dir" directory when doing a full project optimization.
	writeBuildTxt: false,

    paths: {
        //build will take the require-configs interactions-custom instead
        'interactions-custom': "empty:"
    }
})