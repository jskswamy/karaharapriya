var Song = {
  Editor: Class.create({
    initialize: function(target, songType, url) {
      songType.observe('change', this.updateTarget.bindAsEventListener(this));
      this.target = target;
      this.url = url;
    },

    updateTarget: function(e){
      var request = new Ajax.Request(this.url, {
        method: 'get',
        parameters: {
          song_type_id: e.element().value
        },
        onSuccess: function(response) {
          this.target.innerHTML = response.responseText;
          $$('.rich_editor').each(function(item){
            var editor = new nicEditor({fullPanel: true, iconsPath: '/images/nicEditorIcons.gif'});
            editor.panelInstance(item.id);
          });
        }.bind(this)
      });
    }
  }),

  bindEditors: function() {
    $$("div[data-song-editor]").each(function(element) {
      songType = $(element.readAttribute("data-song-type"));
      url = element.readAttribute("data-song-editor-url");
      song_editor = new Song.Editor(element, songType, url);
    });
  }
};

//Unobtrusive
document.observe("dom:loaded", function() {
  Song.bindEditors();
});
