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
          song_type: e.element().value
        },
        onSuccess: function(response) {
          this.target.innerHTML = response.responseText;
          $$('.rich_editor').each(function(item){
            var editor = new nicEditor({fullPanel: true, iconsPath: '/images/nicEditorIcons.gif'});
            editor.panelInstance(item.id);
          });
          this.target.highlight({ startcolor: '#ffff99', endcolor: '#ffffff' });
        }.bind(this)
      });
    }
  })
};
