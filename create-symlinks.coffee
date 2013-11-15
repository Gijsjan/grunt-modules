fs = require 'fs'

module.exports = (grunt, options={}) ->
	grunt.registerMultiTask 'createSymlinks', 'Creates a symlink', ->
		for own index, config of this.data
			src = if config.src[0] isnt '/' then process.cwd() + '/' + config.src else config.src
			dest = if config.dest[0] isnt '/' then process.cwd() + '/' + config.dest else config.dest

			grunt.log.writeln 'ERROR: source dir does not exist!' if not fs.existsSync(src) # Without a source, all is lost.

			if fs.existsSync(dest)
				stats = fs.lstatSync dest
				
				if stats? and stats.isSymbolicLink()
					fs.unlinkSync dest

			fs.symlinkSync src, dest