var CarnaticEditor = Class.create({
  initialize: function(target, talam) {
    this.domNode = {
      target: $(target)
    };
    this.options = {
      maxLength: 1
    };
    this.talam = talam;
    this.render();
  },
  render: function() {
    this.talam.each(function(noOfAkshram) {
      var akshram = new Element('div');
      for (index = 0; index < noOfAkshram; index++) {
        var inputForAkshram = new Element('input', {
          type: 'text',
          maxlength: this.options.maxLength
        });
        akshram.appendChild(inputForAkshram);
      }
      this.domNode.target.appendChild(akshram);
    }.bind(this));
  }
});
