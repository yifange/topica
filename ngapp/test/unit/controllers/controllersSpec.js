//
// test/unit/controllers/controllersSpec.js
//
describe("Unit: Testing Controllers", function() {

  beforeEach(angular.mock.module('topicaApp'));

  it('should have a CardNewPost controller', function() {
    expect(app.CardNewPost).not.to.equal(null);
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

  it('should have a ProfileController controller', function() {
    expect(app.ProfileController).not.to.equal(null);
  });

  it('should have a SignupController controller', function() {
    expect(app.SignupController).not.to.equal(null);
  });

  it('should have a properly working SignupController controller', inject(function($rootScope, $controller) {
    var scope = $rootScope.$new();
    var credential = {email:"test_email@gmail.com",username:"test_username",password:"123123",passwordConfirmation:"123123"};
    scope.credential = credential;
    var ctrl = $controller('SignupController', {
      $scope : scope
    });
  }));

});

