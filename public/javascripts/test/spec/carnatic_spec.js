Screw.Unit(function() {
  describe('Carnatic Editor', function() {
    var talam = [4,2,2];
    var editor;

    before(function() {
      editor = new CarnaticEditor('editor', talam);
    });

    it('should display the specified aksharams as textboxes', function() {
      var textboxes = $('editor').select('input[type="text"]');
      expect(8).to(equal, textboxes.length);
    });

    it('aksharam textbox max lenght should be 1', function() {
      var textboxes = $('editor').select('input[type="text"]');
      textboxes.each(function(textbox) {
        expect(textbox).to(have_max_length_of, 1);
      });
    });

  });
});
