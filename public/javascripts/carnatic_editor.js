var CarnaticEditor = Class.create({

  initialize: function(target, talam) {
    this.domNode = {
      target: $(target)
    };
    this.options = {
      maxLength: 1
    };
    this.talam = talam;
    this._render();
  },

  _render: function() {
    var oneCompleteTalam = Element('div');
    this.domNode.target.appendChild(oneCompleteTalam);

    this.talam.each(function(noOfAkshram) {
      var akshram = new Element('span');
      for (index = 0; index < noOfAkshram; index++) {
        var inputForAkshram = new Element('input', {
          type: 'text',
          maxlength: this.options.maxLength
        });

        inputForAkshram.observe('keypress', this._focusNext.bindAsEventListener(this));
        akshram.appendChild(inputForAkshram);
      }
      oneCompleteTalam.appendChild(akshram);
    }.bind(this));
  },

  _focusNext: function(e) {
    if (e.charCode !=0 ) {
      var currentAkshram = e.element();
      var nextAkshram = currentAkshram.next('input[type="text"]');
      if(nextAkshram)
        nextAkshram.focus();
    }
  }
});
