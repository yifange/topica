//Ensure that our top-level module exists and has its dependencies
describe("Midway Testing for Modules", function() {
  describe("topicaApp Module:", function() {

    var module;
    before(function() {
      module = angular.module("topicaApp");
    });

    it("should be registered", function() {
      expect(module).not.to.equal(null);
    });

    //also test the module's dependencies

    describe("topicaApp Dependencies:", function() {

      var deps;
      var hasModule = function(m) {
        return deps.indexOf(m) >= 0;
      };
      before(function() {
        deps = module.value('topicaApp').requires;
      });

      it("should have topicaApp.directives.pluspicker as a dependency", function() {
        expect(hasModule('topicaApp.directives.pluspicker')).to.equal(true);
      });

      it("should have topicaApp.directives.ngFocus as a dependency", function() {
        expect(hasModule('topicaApp.directives.ngFocus')).to.equal(true);
      });

      it("should have topicaApp.directives.newscard as a dependency", function() {
        expect(hasModule('topicaApp.directives.newscard')).to.equal(true);
      });

      it("should have topicaApp.filters.linebreak as a dependency", function() {
        expect(hasModule('topicaApp.filters.linebreak')).to.equal(true);
      });

      it("should have topicaApp.directives.buttonDropdown as a dependency", function() {
        expect(hasModule('topicaApp.directives.buttonDropdown')).to.equal(true);
      });

    });

  });
});
