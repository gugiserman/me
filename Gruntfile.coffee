module.exports = (grunt) ->
  pkg = grunt.file.readJSON 'package.json'

  config = require('./mygrunt.coffee')(pkg, port: 80, module: 'giserman')

  extraConfig =
    'gh-pages':
      options: base: 'deploy'
      src: ['**']

  tasks =
    build: ['clean', 'copy:pkg', 'copy:main', 'coffee', 'less', 'ngtemplates']
    default: ['build', 'connect:http', 'watch']
    deploy: ['build', 'useminPrepare', 'concat', 'cssmin', 'uglify', 'usemin', 'copy:deploy']
    'git-deploy': ['deploy', 'gh-pages']

  grunt.config.init config
  grunt.config.merge extraConfig
  grunt.loadNpmTasks name for name of pkg.devDependencies when name[0..5] is 'grunt-'
  grunt.registerTask name, arr for name, arr of tasks
