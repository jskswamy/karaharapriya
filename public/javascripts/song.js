var Song = {
  Editor: Class.create({
    initialize: function(target, addLink, url) {
      addLink.observe('click', this.addSection.bindAsEventListener(this));
      this.target = target;
      this.url = url;
    },

    addSection: function(e){
      var sectionIndex = this.target.select("div[data-section-index]:last-child")[0].readAttribute("data-section-index");
      var request = new Ajax.Request(this.url, {
        method: 'get',
        parameters: {index: ++sectionIndex},
        onSuccess: function(response) {
          this.target.insert(response.responseText);
        }.bind(this)
      });
    }
  }),

  bindEditors: function() {
    $$("div[data-song-editor]").each(function(element) {
      addLink = element.down("a[data-song-add-section]");
      url = element.readAttribute("data-song-editor-url");
      songEditor = new Song.Editor(element, addLink, url);
    });
  }
};
