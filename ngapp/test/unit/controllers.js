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

  it('should have a ProfileFeedsController controller', function() {
    expect(app.ProfileFeedsController).not.to.equal(null);
  });

  it('should have a ProfileFollowingController controller', function() {
    expect(app.ProfileFollowingController).not.to.equal(null);
  });

  it('should have a properly working SignupController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var credential = {email: "test_email@gmail.com", username: "test_username", password: "123123", passwordConfirmation: "123123"};
    scope.credential = credential;
    var ctrl = $controller('SignupController', {
      $scope : scope
    });
  }));

  it('should have a properly working LoginController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var credential = {email: "test_email@gmail.com", "password": "123123", "rememberMe": false};
    scope.credential = credential;
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

  it('should have a properly working ProfileFeedsController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var ctrl = $controller('ProfileFeedsController', {
      $scope : scope
    });
  }));

  it('should have a properly working ProfileFollowingController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var ctrl = $controller('ProfileFollowingController', {
      $scope : scope
    });
  }));

});

