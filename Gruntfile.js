module.exports = function (grunt) {

    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        requirejs: {
            compile: {
                options: grunt.file.readJSON('source/js/build-config.json')
            }
        },
        copy: {
            main: {
                files: [
                    {
                        expand: true,
                        cwd: 'source/partials/',
                        src: ['**/*'],
                        dest: 'build/partials'
                    },
                    {
                        expand: true,
                        cwd: 'source/',
                        src: ['index.html'],
                        dest: 'build/'
                     },
                    {
                        expand: true,
                        cwd: 'source/js/libs/',
                        src: ['**/*'],
                        dest: 'build/js/libs/'
                     }
                ]
            }
        },
        uglify: {
            main: {
                options: {
                    sourceMappingURL: './source-map.js',
                    sourceMap: 'build/js/source-map.js',
                    mangle: false
                },
                files: {
                    'build/js/main.js': ['build/js/main-src.js']
                }
            }
        },
        compass: {
            main: {
              options: {
                  config: 'config.rb'
              }
            }
        },
        karma: {
            ci: { // runs tests one time in PhantomJS, good for continuous integration
                configFile: 'tests/karma-compiled.conf.js'
            },
            unit: { // start testing server that listens for code updates
                configFile: 'tests/karma.conf.js',
                singleRun: false,
                browsers: ['PhantomJS']
            }
        },
        connect: {
          options: {
            port: 9000,
            // Change this to '0.0.0.0' to access the server from outside.
            hostname: 'localhost',
            livereload: 35729
          },
          livereload: {
            options: {
              open: true,
              base: [
                '.tmp',
                'source'
              ]
            }
          },
          test: {
            options: {
              port: 9001,
              base: [
                '.tmp',
                'tests',
                'source'
              ]
            }
          },
          dist: {
            options: {
              base: 'build'
            }
          }
        },
        watch: {
          // coffee: {
          //   files: ['<%= yeoman.app %>/scripts/{,*/}*.coffee'],
          //   tasks: ['coffee:dist']
          // },
          // coffeeTest: {
          //   files: ['test/spec/{,*/}*.coffee'],
          //   tasks: ['coffee:test']
          // },
          compass: {
            files: ['source/scss/{,*/}*.{scss,sass}'],
            tasks: ['compass:main']
          },
          // styles: {
          //   files: ['<%= yeoman.app %>/styles/{,*/}*.css'],
          //   tasks: ['copy:styles', 'autoprefixer']
          // },
          livereload: {
            options: {
              livereload: '<%= connect.options.livereload %>'
            },
            files: [
              'source/{,*/}*.html',
              '.tmp/styles/{,*/}*.css',
              '{.tmp, source/js/{,*/}*.js',
              'source/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
            ]
          }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-requirejs');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-compass');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-karma');

    grunt.registerTask('build-js', ['copy', 'requirejs', 'uglify']);
    grunt.registerTask('build-css', ['compass']);
    grunt.registerTask('build', ['build-js', 'build-css']);
    grunt.registerTask('server', ['build', 'connect:livereload', 'watch']);

    grunt.registerTask('default', ['build']);

};