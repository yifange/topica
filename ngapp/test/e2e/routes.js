//Ensure that routes aren't redirected or not found
describe("E2E Testing for Routes", function() {

  beforeEach(function() {
    browser().navigateTo('/');
  });

  it('should have a working / route', function() {
    browser().navigateTo('/');
    expect(browser().window().path()).toBe("/");
  });

  it('should have a working /profile/1 route', function() {
    browser().navigateTo('/profile/1');
    expect(browser().window().path()).toBe("/profile/1");
  });

  it('should have a working /profile/1/topics/1 route', function() {
    browser().navigateTo('/profile/1/topics/1');
    expect(browser().window().path()).toBe("/profile/1/topics/1");
  });

  it('should have a working /profile/1/topics route', function() {
    browser().navigateTo('/profile/1/topics');
    expect(browser().window().path()).toBe("/profile/1/topics");
  });

  it('should have a working /profile/1/posts route', function() {
    browser().navigateTo('/profile/1/posts');
    expect(browser().window().path()).toBe("/profile/1/posts");
  });

  it('should have a working /profile/1/feeds route', function() {
    browser().navigateTo('/profile/1/feeds');
    expect(browser().window().path()).toBe("/profile/1/feeds");
  });

  it('should have a working /signup route', function() {
    browser().navigateTo('/signup');
    expect(browser().window().path()).toBe("/signup");
  });

  it('should have a working /login route', function() {
    browser().navigateTo('/login');
    expect(browser().window().path()).toBe("/login");
  });

});
