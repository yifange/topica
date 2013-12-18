module.exports = function() {  
  return {
    basePath: '../',
    frameworks: ['mocha'],
    reporters: ['progress'],
    browsers: ['Chrome'],
    autoWatch: true,

    // these are default values anyway
    singleRun: false,
    colors: true,
    
    files : [      
      //3rd Party Code     
      'app/bower_components/angular/angular.js',      
      'app/bower_components/angular-route/angular-route.js',
      'app/bower_components/angular-mocks/angular-mocks.js',
      'app/bower_components/lodash/dist/lodash.js',
      'app/bower_components/restangular/src/restangular.js',
      'app/bower_components/angular-http-auth/src/http-auth-interceptor.js',
      'app/bower_components/angular-bootstrap/ui-bootstrap.js',
      'app/bower_components/angular-animate/angular-animate.js',
      'app/bower_components/angular-sanitize/angular-sanitize.js',
      'app/bower_components/angular-cookies/angular-cookies.js',
      'app/bower_components/angular-elastic/elastic.js',
      'app/bower_components/angular-moment/angular-moment.js',
      'app/bower_components/angularjs-gravatar/src/gravatar-directive.js',
      'app/bower_components/angularjs-gravatar/src/md5-service.js',
      'node_modules/expect.js/expect.js',    

      //App-specific Code      
      'app/scripts/app.js.coffee',
      'app/scripts/controllers/*.js.coffee',
      'app/scripts/directives/*.js.coffee',
      'app/scripts/filters/*.js.coffee',
      'app/scripts/services/*.js.coffee',
    ]
  }
};
