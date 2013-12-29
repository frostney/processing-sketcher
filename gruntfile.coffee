module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    date: grunt.template.today 'dd-mm-yyyy'
    clean:
      dist: ['dist'],
      test: ['test/**/*.js']
    amd_tamer:
      combine:
        options:
          base: 'src/'
          namespace: '<%= pkg.name %>'
        files:
          'dist/<%= pkg.name %>.coffee': 'src/**/*.coffee'
    coffee:
      app:
        files:
          'dist/<%= pkg.name %>.js': ['udefine/*.coffee', 'dist/<%= pkg.name %>.coffee']
      test:
        files: [{
          expand: true,
          cwd: 'test/',
          src: ['**/*.coffee'],
          dest: 'test/',
          ext: '.js'
        }]
    uglify:
      options:
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= date %> */\n'
        report: 'gzip'
      dist:
        files:
          'dist/<%= pkg.name %>.min.js': 'dist/<%= pkg.name %>.js'
    mocha:
      options:
        reporter: 'Spec'
        run: true
      all: ['test/browser/*.html']
    coffeelint:
      options: grunt.file.readJSON 'coffeelint.json'
      app: ['src/*.coffee']
      tests: ['test/**/*.coffee']
      grunt: ['gruntfile.coffee']
        

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)
  
  grunt.registerTask 'test', [
    'coffeelint'
  ]
  
  grunt.registerTask 'default', 'Default task',
    ['amd_tamer', 'coffee', 'test', 'uglify']