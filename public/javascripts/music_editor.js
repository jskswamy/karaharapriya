var Music = {

  Editor: Class.create({

    initialize: function(target, talam) {
      this.domNode = $(target);
      this.talam = talam;
      this.talamLines = [];
      this._focusNextTalamLine();
    },

    _createNewTalamLine: function() {
      var talamLine = new Music.Talam(this.domNode, this.talam, {
        onLastAkshram: this._focusNextTalamLine.bindAsEventListener(this),
        onFirstAkshram: this._focusPreviousTalamLine.bindAsEventListener(this)
      });
      this.talamLines.push(talamLine);
      return talamLine;
    },

    _getTalamLine: function(talamDomNode) {
      var nextTalamLine;
      if (talamDomNode) {
        this.talamLines.each(function(talamLine) {
          if (talamLine.domNode == talamDomNode) {
            nextTalamLine = talamLine;
            throw $break;
          }
        });
      }
      return nextTalamLine;
    },

    _getNextTalamLine: function(current) {
      if (current) {
        return this._getTalamLine(current.domNode.next());
      }
    },

    _getPreviousTalamLine: function(current) {
      if (current) {
        return this._getTalamLine(current.domNode.previous());
      }
    },

    _focusNextTalamLine: function(current) {
      var nextTalamLine = this._getNextTalamLine(current);
      if (!nextTalamLine) {
        nextTalamLine = this._createNewTalamLine();
      }
      nextTalamLine.focus();
    },

    _focusPreviousTalamLine: function(current) {
      var previousTalamLine = this._getPreviousTalamLine(current);
      if (previousTalamLine) {
        previousTalamLine.focusLast();
      }
    }

  }),

  Talam: Class.create({

    initialize: function(target, talam, options) {
      this.target = target;
      this.talam = talam;
      this.domNode = new Element('div');
      this.akshramLength = 1;
      this.options = {
        onLastAkshram: Prototype.emptyFunction,
        onFirstAkshram: Prototype.emptyFunction
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

          inputForAkshram.observe('keypress', this._onKeyPressHook.bindAsEventListener(this));
          akshram.appendChild(inputForAkshram);
        }
        this.domNode.appendChild(akshram);
      }.bind(this));
      this.target.appendChild(this.domNode);
    },

    _onKeyPressHook: function(e) {
      var currentAkshram = e.element();
      if (e.charCode !== 0 ) {
        this._focusNext(currentAkshram);
      } else if(e.keyCode == 8) {
        this._focusPrevious(currentAkshram);
      }

    },

    _getNextLaguOrDrutham: function(currentAkshram) {
      return currentAkshram.up('span').next('span');
    },

    _getPreviousLaguOrDrutham: function(currentAkshram) {
      return currentAkshram.up('span').previous('span');
    },

    _getNextAkshram: function(currentAkshram) {
      var nextAkshram = currentAkshram.next('input[type="text"]');

      if(!nextAkshram) {
        var nextLaguOrDrutham = this._getNextLaguOrDrutham(currentAkshram);
        if (nextLaguOrDrutham) {
          nextAkshram = nextLaguOrDrutham.down('input[type="text"]:first-child');
        }
      }

      if (nextAkshram) {
        return nextAkshram;
      } else {
        this.options.onLastAkshram.apply(this, [this]);
      }
    },

    _getPreviousAkshram: function(currentAkshram) {
      var previousAkshram = currentAkshram.previous('input[type="text"]');

      if (!previousAkshram) {
        var previousLaguOrDrutham = this._getPreviousLaguOrDrutham(currentAkshram);
        if (previousLaguOrDrutham) {
          previousAkshram = previousLaguOrDrutham.down('input[type="text"]:last-child');
        }
      }

      if (previousAkshram) {
        return previousAkshram;
      } else {
        this.options.onFirstAkshram.apply(this, [this]);
      }

    },

    _focusNext: function(currentAkshram) {
      var nextAkshram = this._getNextAkshram(currentAkshram);

      if(nextAkshram) {
        nextAkshram.focus();
      }
    },

    _focusPrevious: function(currentAkshram) {
      var previousAkshram = this._getPreviousAkshram(currentAkshram);
      if (previousAkshram) {
        previousAkshram.focus();
      }
    },

    focus: function() {
      var akshram = this.domNode.down('span > input[type="text"]:first-child');
      akshram.focus();
    },

    focusLast: function() {
      var akshram = this.domNode.down('span:last-child > input[type="text"]:last-child');
      akshram.focus();
    }

  })
};
