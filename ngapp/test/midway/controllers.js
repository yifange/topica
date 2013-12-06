describe("Midway Testing for Controllers", function() {

  var tester;
  beforeEach(function() {
    if(tester) {
      tester.destroy();
    }
    tester = ngMidwayTester('topicaApp');
  });

  it('should load the SignupController controller properly when /signup route is accessed', function(done) {
    tester.visit('/signup', function() {
      expect(tester.path()).to.equal('/signup');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      var scope = current.scope;
      expect(controller).to.eql('SignupController');
      done();
    });
  });

  it('should load the MainController controller properly when /main route is accessed', function(done) {
    tester.visit('/main', function() {
      expect(tester.path()).to.equal('/');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      var scope = current.scope;
      expect(controller).to.eql('MainController');
      done();
    });
  });

  it('should load the LoginController controller properly when /login route is accessed', function(done) {
    tester.visit('/login', function() {
      expect(tester.path()).to.equal('/login');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      var scope = current.scope;
      expect(controller).to.eql('LoginController');
      done();
    });
  });

  it('should load the ProfileController controller properly when /profile route is accessed', function(done) {
    tester.visit('/profile', function() {
      expect(tester.path()).to.equal('/profile');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      var scope = current.scope;
      expect(controller).to.eql('ProfileController');
      done();
    });
  });

});
