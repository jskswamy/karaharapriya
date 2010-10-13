Screw.Unit(function() {
  var song;
  var editor = $('song_editor');
  var songType = $('song_type');
  var url = '/song/editor';

  before(function(){

    song = new Song.Editor(editor, songType, url);
    Ajax.Updater = function(target, url, options) {
      target.update().update(options.parameters.song_type);
    };
  });

  describe('Editor', function() {
    it('should update the target with the ajax response', function() {
      songType.selectedIndex = 2;
      songType.simulate('change');
      expect(editor.innerHTML).to(equal, songType.value);
    });
  });
});
