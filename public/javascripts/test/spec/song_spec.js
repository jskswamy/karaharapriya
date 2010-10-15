Screw.Unit(function() {
  var song;
  var editor = $('song_editor');
  var songType = $('song_type');
  var url = '/song/editor';
  var nicEditorPanelAdded;

  before(function(){

    song = new Song.Editor(editor, songType, url);
    Ajax.Updater = function(target, url, options) {
      target.update().update(options.parameters.song_type);
    };

    Ajax.Request = function(url, options) {
      options.onSuccess({
        responseText:'<div class="rich_editor">' + options.parameters.song_type + '</div>'
      });
    };

    nicEditor = function(options) {};

    nicEditor.prototype.panelInstance = function(id) {
      nicEditorPanelAdded = true;
    };

    nicEditorPanelAdded = false;

  });

  describe('Editor', function() {
    it('should update the target with the ajax response', function() {
      songType.selectedIndex = 2;
      songType.simulate('change');
      expect(editor.down('div').innerHTML).to(equal, songType.value);
    });

    it('should add rich text editor to the text areas in the response', function(){
      songType.selectedIndex = 1;
      songType.simulate('change');
      expect(nicEditorPanelAdded).to(equal, true);
    });
  });
});
