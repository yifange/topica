//Ensure that controllers are executing properly
describe("Unit Tests for Controllers", function() {

  beforeEach(angular.mock.module('topicaApp'));

  it('should have a SignupController controller', function() {
    expect(app.SignupController).not.to.equal(null);
  });

  it('should have a LoginController controller', function() {
    expect(app.LoginController).not.to.equal(null);
  });

  it('should have a MainController controller', function() {
    expect(app.MainController).not.to.equal(null);
  });

  it('should have a NavbarController controller', function() {
    expect(app.NavbarController).not.to.equal(null);
  });

  it('should have a NewPostController controller', function() {
    expect(app.NewPostController).not.to.equal(null);
  });

  it('should have a ProfileAboutController controller', function() {
    expect(app.ProfileAboutController).not.to.equal(null);
  });

  it('should have a ProfilePostsController controller', function() {
    expect(app.ProfilePostsController).not.to.equal(null);
  });

  it('should have a ProfileTopicsController controller', function() {
    expect(app.ProfileTopicsController).not.to.equal(null);
  });

  it('should have a properly working SignupController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var ctrl = $controller('SignupController', {
      $scope : scope
    });
  }));

  it('should have a properly working LoginController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var ctrl = $controller('LoginController', {
      $scope : scope
    });
  }));

  it('should have a properly working NavbarController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var ctrl = $controller('NavbarController', {
      $scope : scope
    });
  }));

  it('should have a properly working ProfileAboutController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var ctrl = $controller('ProfileAboutController', {
      $scope : scope
    });
  }));

  it('should have a properly working ProfileTopicsController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var ctrl = $controller('ProfileTopicsController', {
      $scope : scope
    });
  }));

});

