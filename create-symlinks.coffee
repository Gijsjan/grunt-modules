fs = require 'fs'

module.exports = (grunt, options={}) ->
	grunt.registerMultiTask 'createSymlinks', 'Creates a symlink', ->
		for own index, config of this.data

			src = config.src
			dest = config.dest

			src = process.env.HOME + src.substr(1) if src[0] is '~'
			dest = process.env.HOME + dest.substr(1) if dest[0] is '~'

			src = process.cwd() + '/' + src if src[0] isnt '/'
			dest = process.cwd() + '/' + dest if dest[0] isnt '/'

			grunt.log.writeln 'ERROR: source dir does not exist!', src if not fs.existsSync(src) # Without a source, all is lost.

			# We have to put lstatSync in a try, because it gives an error when dest isn't found. We can use fs.lstat, but
			# we would have to change the for loop to a function call.			
			try 
				stats = fs.lstatSync dest
				fs.unlinkSync(dest) if stats.isSymbolicLink()

			fs.symlinkSync src, dest
