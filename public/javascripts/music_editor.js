var Music = {

  Editor: Class.create({

    initialize: function(target, talam, options) {
      this.domNode = $(target);
      this.talam = talam;
      this.swaramLines = [];
      this.options = {
        className: {
          swaramLine: 'swaram'
        }
      };
      Object.extend(this.options, options);
      this._focusNextTalamLine();
    },

    _createNewTalamLine: function() {
      var talamLine = new Music.TalamLine(this.domNode, this.talam, {
        className: this.options.className.swaramLine,
        onLastAkshram: this._focusNextTalamLine.bindAsEventListener(this, this.options.className.swaramLine),
        onFirstAkshram: this._focusPreviousTalamLine.bindAsEventListener(this, this.options.className.swaramLine)
      });
      this.swaramLines.push(talamLine);
      return talamLine;
    },

    _getTalamLine: function(talamDomNode) {
      var nextTalamLine;
      if (talamDomNode) {
        this.swaramLines.each(function(talamLine) {
          if (talamLine.domNode == talamDomNode) {
            nextTalamLine = talamLine;
            throw $break;
          }
        });
      }
      return nextTalamLine;
    },

    _getNextTalamLine: function(current, selector) {
      if (current) {
        return this._getTalamLine(current.domNode.next("div." + selector));
      }
    },

    _getPreviousTalamLine: function(current, selector) {
      if (current) {
        return this._getTalamLine(current.domNode.previous("div." + selector));
      }
    },

    _focusNextTalamLine: function(current, selector) {
      var nextTalamLine = this._getNextTalamLine(current, selector);
      if (!nextTalamLine) {
        nextTalamLine = this._createNewTalamLine();
      }
      nextTalamLine.focusFirstAkshram();
    },

    _focusPreviousTalamLine: function(current, selector) {
      var previousTalamLine = this._getPreviousTalamLine(current, selector);
      if (previousTalamLine) {
        previousTalamLine.focusLastAkshram();
      }
    }

  }),

  TalamLine: Class.create({

    initialize: function(target, talam, options) {
      this.target = target;
      this.talam = talam;
      this.akshramLength = 1;
      this.options = {
        className: 'talam',
        onLastAkshram: Prototype.emptyFunction,
        onFirstAkshram: Prototype.emptyFunction
      };
      Object.extend(this.options, options);
      this.domNode = new Element('div', {
        'className': this.options.className
      });
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
        this._focus(currentAkshram, this._getNextAkshram.bindAsEventListener(this));
      } else if(e.keyCode == 8) {
        this._focus(currentAkshram, this._getPreviousAkshram.bindAsEventListener(this));
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

    _focus: function(currentAkshram, fn) {
      var akshram = fn(currentAkshram);
      if(akshram) {
        akshram.focus();
      }
    },

    _focusAkshram: function(selector) {
      var akshram = this.domNode.down(selector);
      akshram.focus();
    },

    focusFirstAkshram: function() {
      this._focusAkshram('span > input[type="text"]:first-child');
    },

    focusLastAkshram: function() {
      this._focusAkshram('span:last-child > input[type="text"]:last-child');
    }

  })
};
