const gulp = require('gulp');
const browserSync = require('browser-sync');

gulp.task('default',['server']);

gulp.task('server',()=>{
    browserSync.init({
        server:{
            baseDir:'./',
            index:'index.html'
        },
        // 设置文件除外
        watchOptions:{
            ignoreInitial:true,
            ignored:['*.log','*.lock','node_modules/**/*.*']
        },
        // 监听修改的文件
        files:['./**/*.*'],
        port:8080
    },()=>{
        console.log("the browser refreshed!");
    })
})