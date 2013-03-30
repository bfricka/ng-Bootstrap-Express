#global module:false
karma = require 'karma'

module.exports = (grunt) ->

  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-coffee"

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    meta:
      # Build the JS banner based on pkg file data
      banner: do ->
        banner = "/* <%= pkg.name %> - v<%= pkg.version %> - <%= pkg.homepage %>\n"
        banner += "* Copyright (c) <%= grunt.template.today('yyyy') %> <%= pkg.author %>. All rights reserved.\n"
        banner += "* Licensed <%= _.pluck(pkg.licenses, 'type')[0] %> - <%= _.pluck(pkg.licenses, 'url')[0] %> */\n"
        banner

    paths:
      # Ref common paths so we can use built-in lodash templating.
      coffee : "./public/coffeescripts"
      tmp    : "./tmp"
      js     : "./public/javascripts"

    concat:
      # Concat app into temp dir. So it can be wrapped in a single
      # SEAF, since coffee-contrib doesn't have this option.
      app:
        src: [
          "<%= paths.coffee %>/app.coffee"
          "<%= paths.coffee %>/controllers/MainAppCtrl.coffee"
          "<%= paths.coffee %>/directives/fadeShow.coffee"
          "<%= paths.coffee %>/directives/focusBlur.coffee"
          "<%= paths.coffee %>/filters/startFrom.coffee"
          # "<%= paths.coffee %>/services/*.coffee"
        ]
        dest: "<%= paths.tmp %>/app.coffee"

      # Build to add banners to JS
      build:
        options:
          banner: "<%= meta.banner %>"
        files:
          "<%= paths.js %>/app.js": [ "<%= paths.js %>/app.js" ]
          "<%= paths.js %>/app.min.js": [ "<%= paths.js %>/app.min.js" ]

    coffee:
      # Note: concat needs to be run in order to gen tmp directory and file
      # for app.
      compile:
        options:
          bare: false
        files:
          "<%= paths.js %>/app.js": "<%= paths.tmp %>/app.coffee"
          "server.js": "server.coffee"

    watch:
      coffee:
        files: [
          "<%= paths.coffee %>**/*.coffee"
          "server.coffee"
        ]
        tasks: [ "concat:app", "coffee" ]

      js:
        files: [ "<%= paths.js %>/app.js" ]
        tasks: [ "jshint", "uglify", "test" ]

      tests:
        files: [ "./test/**/*.spec.coffee" ]
        tasks: [ "test" ]

    uglify:
      app:
        options:
          # Default compress options. Listed for reference.
          compress:
            conditionals : true
            comparisons  : true
            properties   : true
            hoist_funs   : true
            hoist_vars   : false
            sequences    : true
            if_return    : true
            join_vars    : true
            dead_code    : true
            evaluate     : true
            booleans     : true
            warnings     : true
            cascade      : true
            unsafe       : true
            unused       : true
            loops        : true

          mangle:
            except: [
              "angular"
              "amplify"
              "jQuery"
              "$"
              "_"
            ]

        files:
          "<%= paths.js %>/app.min.js": [
            "<%= paths.js %>/app.js"
            "<banner:meta.banner>"
          ]

    jshint:
      options:
        "sub"      : true
        "boss"     : true
        "devel"    : true
        "curly"    : false
        "immed"    : true
        "noarg"    : true
        "undef"    : true
        "shadow"   : true
        "newcap"   : false
        "eqnull"   : true
        "eqeqeq"   : true
        "browser"  : true
        "latedef"  : true
        "laxcomma" : true
        "laxbreak" : true

        "globals":
          "angular"    : true
          "amplify"    : true
          "jQuery"     : true
          "$"          : true
          "_"          : true

      all: ["<%= paths.js %>/app.js"]

  # Default task.

  grunt.registerTask "default", [
    "concat:app"
    "coffee"
    "jshint"
    "uglify"
    "concat:build"
    "test"
  ]

  grunt.registerTask "testserver", "start karma server", ->
    #Mark the task as async but never call done, so the server stays up
    done = @async()
    karma.server.start configFile: "test/karma.conf.js"

  # Invoke tests on karma server.
  grunt.registerTask "test", "run tests (make sure server task is run first)", ->
    done = @async()

    grunt.util.spawn
      cmd: (if process.platform is "win32" then "karma.cmd" else "karma")
      args: ["run"]
    , (error, result, code) ->
      if error
        grunt.warn
        "Make sure the karma server is online: run `grunt server`.\n" +
        "Also make sure you have a browser open to http://localhost:8080/.\n" +
        error.stdout + error.stderr

        #the karma runner somehow modifies the files if it errors(??).
        #this causes grunt's watch task to re-fire itself constantly,
        #unless we wait for a sec
        setTimeout done, 1000
      else
        grunt.log.write result.stdout
        done()
