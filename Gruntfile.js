module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    less: {
      development: {
        options: {
          paths: ["css"]
        },
        files: {
          "css/main.css": "css/main.less"
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-less');
};
