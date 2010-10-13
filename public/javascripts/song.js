var Song = {
  Editor: Class.create({
    initialize: function(target, songType, url) {
      songType.observe('change', this.updateTarget.bindAsEventListener(this));
      this.target = target;
      this.url = url;
    },

    updateTarget: function(e){
      var updater = new Ajax.Updater(this.target, this.url, {
        method: 'get',
        parameters: {
          song_type: e.element().value
        }
      });
    }
  })
};
