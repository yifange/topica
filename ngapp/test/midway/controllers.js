//Ensure that our controllers have scopes
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
      expect(scope).not.to.eql(null);
      done();
    });
  });

  it('should load the MainController controller properly when / route is accessed', function(done) {
    tester.visit('/', function() {
      expect(tester.path()).to.equal('/');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      var scope = current.scope;
      expect(controller).to.eql('MainController');
      expect(scope).not.to.eql(null);
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
      expect(scope).not.to.eql(null);
      done();
    });
  });

  it('should load the ProfileController controller properly when /profile route is accessed', function(done) {
    tester.visit('/profile/1', function() {
      expect(tester.path()).to.equal('/profile/1');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      var scope = current.scope;
      expect(controller).to.eql('ProfileTopicsController');
      expect(scope).not.to.eql(null);
      done();
    });
  });

  it('should load the ProfileController controller properly when /profile route is accessed', function(done) {
    tester.visit('/profile/1/topics', function() {
      expect(tester.path()).to.equal('/profile/1/topics');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      var scope = current.scope;
      expect(controller).to.eql('ProfileTopicsController');
      expect(scope).not.to.eql(null);
      done();
    });
  });

  it('should load the ProfileController controller properly when /profile route is accessed', function(done) {
    tester.visit('/profile/1/posts', function() {
      expect(tester.path()).to.equal('/profile/1/posts');
      var current = tester.inject('$route').current;
      var controller = current.controller;
      var scope = current.scope;
      expect(controller).to.eql('ProfilePostsController');
      expect(scope).not.to.eql(null);
      done();
    });
  });

});
