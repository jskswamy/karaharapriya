Screw.Unit(function() {
  var song;
  var editor = $('song_editor');
  var songType = $('song_type');
  var url = '/song/editor';
  var nicEditorPanelAdded;
  var editorAttached;

  before(function(){
    Ajax.Updater = function(target, url, options) {
      target.update().update(options.parameters.song_type);
    };

    Ajax.Request = function(url, options) {
      options.onSuccess({
        responseText:'<div class="rich_editor">' + options.parameters.song_type_id + '</div>'
      });
    };

    nicEditor = function(options) {};

    nicEditor.prototype.panelInstance = function(id) {
      nicEditorPanelAdded = true;
    };

    nicEditorPanelAdded = false;

  });

  describe('Editor', function() {

    it('should attach the editor on page load', function() {
      editor_constructor = Song.Editor.prototype.initialize;
      var editor_created_count = 0;
      Song.Editor.prototype.initialize = function() {
        editor_created_count++;
      };
      document.observe("dom:loaded", function() {
        expect(editor_created_count).to(equal, 1);
      });
      Song.Editor.prototype.initialize = editor_constructor;
    });

    it('should update the target with the ajax response', function() {
      song = new Song.Editor(editor, songType, url);
      songType.selectedIndex = 2;
      songType.simulate('change');
      expect(editor.down('div').innerHTML).to(equal, songType.value);
    });

    it('should add rich text editor to the text areas in the response', function(){
      song = new Song.Editor(editor, songType, url);
      songType.selectedIndex = 1;
      songType.simulate('change');
      expect(nicEditorPanelAdded).to(equal, true);
    });

  });

});
