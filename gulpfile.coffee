# Gulp deployment file
#
# custom cli args are
#   sourcemaps boolean - boolean whether to add sourcemaps to js files


argv = require("yargs").argv
batch = require "gulp-batch"
coffee = require "gulp-coffee"
del = require 'del'
flatten = require 'gulp-flatten'
gulp = require "gulp"
gulpif = require "gulp-if"
gutil = require 'gulp-util'
minifyHtml = require 'gulp-minify-html'
minifyCss = require 'gulp-minify-css'
ngAnnotate = require 'gulp-ng-annotate'
path = require "path"
plumber = require "gulp-plumber"
rev = require 'gulp-rev'
sequence = require "run-sequence"
sourcemaps = require "gulp-sourcemaps"
templateCache = require 'gulp-angular-templatecache'
usemin = require 'gulp-usemin'
uglify = require 'gulp-uglify'
watch = require "gulp-watch"


# cli args
hasSourcemaps = argv.sourcemaps

# common variables
srcDir = "src/"
tmpDir = "tmp/"
buildDir = "build/"

# Tasks

# cleans tmp directory
gulp.task "clean", () ->
  del buildDir


gulp.task "copy", ["copy:css", "copy:scripts", "copy:partials", "copy:fonts", "copy:images"]

gulp.task "copy:index", () ->
  gulp.src(path.join(srcDir, "index.html"))
    .pipe(gulp.dest(tmpDir))

gulp.task "copy:templates", () ->
  gulp.src(path.join(srcDir, "**/*.tpl.html"))
    .pipe(gulp.dest(tmpDir))


gulp.task "copy:partials", () ->
  sequence "copy:templates", "copy:index", "ng-templates"

gulp.task "copy:css", () ->
  gulp.src(path.join(srcDir, "**/*.css"))
    .pipe(gulp.dest(tmpDir))

gulp.task "copy:fonts", () ->
  gulp.src(path.join(srcDir, "**/*.{ttf,woff,woff2,eot,svg}"))
    .pipe(gulp.dest(tmpDir))

gulp.task "copy:images", () ->
  gulp.src(path.join(srcDir, "**/*.{png,jpg}"))
    .pipe(gulp.dest(tmpDir))

gulp.task "copy:scripts", () ->
  gulp.src(path.join(srcDir, "**/*.js"))
    .pipe(gulp.dest(tmpDir))

# compile coffee
gulp.task "coffee", () ->
  gulp.src(path.join(srcDir, "**/*.coffee"))
    .pipe(plumber())
    .pipe(gulpif(hasSourcemaps, sourcemaps.init()))
    .pipe(coffee())
    .pipe(ngAnnotate())
    .pipe(gulpif(hasSourcemaps, sourcemaps.write()))
    .pipe(gulp.dest(tmpDir))

gulp.task "min", () ->
  p = path.join(tmpDir, '*.html')
  gulp.src(p)
    .pipe(usemin({
      css: [minifyCss(), 'concat'],
      html: [minifyHtml()],
      js: [uglify()],
      js1: [ngAnnotate(), uglify()],
    }))
    .pipe(gulp.dest(buildDir));

    #  uglify() minifyHtml({empty: true})

gulp.task "dist-fonts", () ->
  gulp.src(path.join(tmpDir, "**/*.{ttf,woff,woff2,eot,otf}"))
  .pipe(flatten())
  .pipe(gulp.dest(path.join(buildDir, 'fonts')));

gulp.task 'ng-templates', () ->
  p = path.join(tmpDir, '/**/*.html')
  gulp.src(p)
    .pipe(minifyHtml())
    .pipe(templateCache({module:"patrol"}))
    .pipe(gulp.dest(path.join(tmpDir, "/scripts")));

gulp.task "watch:coffee", () ->
  gulp.watch path.join(srcDir, "**/*.coffee"), ["coffee"]

gulp.task "watch:partials", () ->
  gulp.watch path.join(srcDir, "**/*.html"), ["copy:partials"]

gulp.task "watch:css", () ->
  gulp.watch path.join(srcDir, "**/*.css"), ["copy:css"]

gulp.task "build", (callback) ->
  sequence "clean", "coffee", "copy", "ng-templates"

gulp.task "dist", (callback) ->
  sequence "clean", "coffee", "copy", "ng-templates", "min", 'dist-fonts'

# dev task
gulp.task "dev", (callback) ->
  sequence "clean", "coffee", "copy", ["watch:coffee", "watch:partials", "watch:css"]
