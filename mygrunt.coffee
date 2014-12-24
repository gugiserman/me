module.exports = (pkg, custom = {}) ->
  throw new Error 'mygrunt: package.json is required!' if not pkg?

  clean:
    main: ['build', 'deploy']

  copy:
    main:
      files: [
        expand: true
        cwd: 'src/'
        src: ['**'
              '!views/**', '!partials/**', '!templates/**'
              '!**/*.coffee', '!**/*.less',
              '!**/*.pot', '!**/*.po']
        dest: "build/"
      ]

    deploy:
      files: [
        expand: true
        cwd: 'build/'
        src: ['**']
        dest: "deploy/"
      ]
    pkg:
      files: [
        src: ['package.json']
        dest: "build/package.json"
      ]

  coffee:
    main:
      files: [
        expand: true
        cwd: 'src/scripts'
        src: ['**/*.coffee']
        dest: "build/scripts/"
        ext: '.js'
      ]

  uglify:
    options:
      banner: "/* #{pkg.name} - v#{pkg.version} */"
      mangle: false

  less:
    main:
      files: [
        expand: true
        cwd: 'src/style'
        src: ['style.less', 'print.less']
        dest: "build/style/"
        ext: '.css'
      ]

  cssmin:
    options:
      banner: "/* #{pkg.name} - v#{pkg.version} */"

  ngtemplates:
    main:
      cwd: "build/"
      src: 'views/**/*.html',
      dest: "build/scripts/ng-templates.js"
      options:
        module: custom.module or 'giserman'
        htmlmin:  collapseWhitespace: true, collapseBooleanAttributes: true

  nggettext_extract:
    pot:
      files: 'src/i18n/template.pot': ['src/**/*.html']

  nggettext_compile:
    all:
      options: module: custom.module or 'giserman'
      files:
        'build/script/ng-translations.js': ['src/i18n/*.po']

  useminPrepare:
    html: "build/index.html"
    options:
      dest: 'build/'
      root: 'build/'

  usemin:
    html: ["build/index.html", "build/index.html"]

  connect:
    http:
      options:
        hostname: "*"
        port: custom.port or process.env.PORT
        base: 'build'
        livereload: true
    https:
      options:
        hostname: "*"
        port: 443
        protocol: 'https'
        base: 'build'

  watch:
    options: livereload: true
    main:
      files: ['src/i18n/**/*.json',
              'src/scripts/**/*.js',
              'src/img/**/*',
              'src/lib/**/*',
              'src/index.html']
      tasks: ['copy:main']
    coffee:
      files: ['src/scripts/**/*.coffee']
      tasks: ['coffee']
    less:
      options: livereload: false
      files: ['src/style/**/*.less']
      tasks: ['less']
    css:
      files: ['build/**/*.css']
    ngtemplates:
      files: ['src/views/**/*.html',
              'src/partials/**/*.html']
      tasks: ['nginclude', 'ngtemplates']
    ngtranslations:
      files: ['src/i18n/**/*.po']
      tasks: ['nggettext_compile']
