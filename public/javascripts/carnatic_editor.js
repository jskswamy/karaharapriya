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
      var nextAkshram = this._getNextAkshram(currentAkshram);

      if(nextAkshram) {
        nextAkshram.focus();
      }
    }
  },

  _getNextLaguOrDrutham: function(akshram) {
    return akshram.up('span').next('span');
  },

  _getNextAkshram: function(akshram) {
    var nextAkshram = akshram.next('input[type="text"]');

    if(!nextAkshram) {
      var nextLaguOrDrutham = this._getNextLaguOrDrutham(akshram)
      if (nextLaguOrDrutham)
        nextAkshram = nextLaguOrDrutham.select('input[type="text"]:first-child');
    }

    return nextAkshram;
  },

});
