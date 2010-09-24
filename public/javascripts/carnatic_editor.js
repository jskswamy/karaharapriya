var Carnatic = {

  Editor: Class.create({

    initialize: function(target, talam) {
      this.domNode = $(target);
      this.talam = talam;
      this.talamLines = [];
      this._createNewTalamLine();
    },

    _createNewTalamLine: function() {
      var talamLine = new Carnatic.Talam(this.talam, {
        onLastAksrham: this._focusNextTalamLine.bindAsEventListener(this)
      });
      this.domNode.appendChild(talamLine.domNode);
      this.talamLines.push(talamLine);
      return talamLine;
    },

    _getNextTalamLine: function(current) {

      if (!current)
        return;

      var nextTalamDomNode = current.domNode.next();
      var nextTalamLine;

      if (nextTalamDomNode) {
        this.talamLines.each(function(talamLine) {
          if (talamLine.domNode == nextTalamDomNode) {
            nextTalamLine = talamLine;
            throw $break;
          }
        });
      }

      return nextTalamLine;
    },

    _focusNextTalamLine: function(current) {
      nextTalamLine = this._getNextTalamLine(current);
      if (!nextTalamLine)
        nextTalamLine = this._createNewTalamLine();
      nextTalamLine.focus();
    },

  }),

  Talam: Class.create({

    initialize: function(talam, options) {
      this.talam = talam;
      this.domNode = new Element('div');
      this.akshramLength = 1;
      this.options = {
        onLastAksrham: Prototype.emptyFunction
      };
      Object.extend(this.options, options);
      this._render();
    },

    _render: function() {
      this.talam.each(function(noOfAkshram) {
        var akshram = new Element('span');
        for (index = 0; index < noOfAkshram; index++) {
          var inputForAkshram = new Element('input', {
            type: 'text',
            maxlength: this.akshramLength
          });

          inputForAkshram.observe('keypress', this._focusNext.bindAsEventListener(this));
          akshram.appendChild(inputForAkshram);
        }
        this.domNode.appendChild(akshram);
      }.bind(this));
    },

    _getNextLaguOrDrutham: function(akshram) {
      return akshram.up('span').next('span');
    },

    _getNextAkshram: function(akshram) {
      var nextAkshram = akshram.next('input[type="text"]');

      if(!nextAkshram) {
        var nextLaguOrDrutham = this._getNextLaguOrDrutham(akshram)
        if (nextLaguOrDrutham) {
          nextAkshram = nextLaguOrDrutham.down('input[type="text"]:first-child');
        }
      }

      if (nextAkshram) {
        return nextAkshram;
      }
      else {
        this.options.onLastAksrham.apply(this, [this]);
      }
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

    focus: function() {
      this.domNode.down('span > input[type="text]:first-child').focus();
    }

  })
}
