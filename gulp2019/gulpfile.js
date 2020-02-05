var gulp = require('gulp');
var concat = require('gulp-concat');
var terser = require('gulp-terser');

gulp.task('CrudBase', function () {
	gulp.src('../app/webroot/js/CrudBase/*.js')
	.pipe(concat('CrudBase.min.js'))
	.pipe(terser())
	.pipe(gulp.dest('../app/webroot/js/CrudBase/dist'));
});

