var Music = {

  TalamBlockType: {
  },

  Editor: Class.create({

    initialize: function(target, talam) {
      this.target = $(target);
      this.options = { className: 'editor' }
      this.domNode = new Element('div', { 'class': this.options.className });
      this.talamBlocks = [];
      this.target.appendChild(this.domNode);
      this.talam = talam;
    },

    addTalamBlock: function(talamBlockOption, className) {
      var talamBlockDom = new Element('div', {'class' : className ? className : 'block'});
      var talamBlock = new Music.TalamBlock(talamBlockDom, this.talam, talamBlockOption);
      this.domNode.appendChild(talamBlockDom);
    }

  }),

  TalamBlock: Class.create({

    initialize: function(target, talam, options) {
      this.domNode = $(target);
      this.talam = talam;
      this.swaramLines = [];
      this.sahidyamLines = [];
      this.options = {
        swaramLine: {
          akshramLength: 1,
          className: 'swaram',
          disabled: false
        },
        sahidyamLine: {
          akshramLength: 1,
          className: 'sahidyam',
          disabled: true
        }
      };
      this.talamLinesCount = 1;
      Object.extend(this.options, options);
      this._focusNextTalamLine();
    },

    _createTalamLine: function(target, talamLines, option) {
      if (!option.disabled) {
        var talamLine = new Music.TalamLine(target, this.talam, {
          akshramLength: option.akshramLength,
          className: option.className,
          onLastAkshram: this._focusNextTalamLine.bindAsEventListener(this, talamLines, option.className),
          onFirstAkshram: this._focusPreviousTalamLine.bindAsEventListener(this, talamLines, option.className)
        });
        talamLines.push(talamLine);
        return talamLine;
      }
    },

    _createTalamLines: function(selector) {
      var newBlock = new Element('div', {'class': this.talamLinesCount % 2 === 0 ? 'even' : 'odd'});
      var swaramLine = this._createTalamLine(newBlock, this.swaramLines, this.options.swaramLine);
      var sahidyamLine = this._createTalamLine(newBlock, this.sahidyamLines, this.options.sahidyamLine);

      this.talamLinesCount++;
      this.domNode.appendChild(newBlock);
      this._insertClearElement(this.domNode);
      return (selector == this.options.sahidyamLine.className ? sahidyamLine : swaramLine);
    },

    _insertClearElement: function(target) {
      var clearElement = target.down('div.clear');
      if (clearElement) {
        clearElement.remove();
      }
      target.insert(new Element('div', {'class': 'clear'}));
    },

    _getTalamLine: function(talamLines, talamDomNode) {
      var nextTalamLine;
      if (talamDomNode) {
        talamLines.each(function(talamLine) {
          if (talamLine.domNode == talamDomNode) {
            nextTalamLine = talamLine;
            throw $break;
          }
        });
      }
      return nextTalamLine;
    },

    //TODO: Merge _getNextTalamLine and _getPreviousTalamLine into one.
    _getNextTalamLine: function(current, talamLines, selector) {
      var nextParent;
      if (current && (nextParent = current.target.next('div'))) {
        return this._getTalamLine(talamLines, nextParent.down("div." + selector));
      }
    },

    _getPreviousTalamLine: function(current, talamLines, selector) {
      var previousParent;
      if (current && (previousParent = current.target.previous('div'))) {
        return this._getTalamLine(talamLines, previousParent.down("div." + selector));
      }
    },

    _focusNextTalamLine: function(current, talamLines, selector) {
      var nextTalamLine = this._getNextTalamLine(current, talamLines, selector);
      if (!nextTalamLine) {
        nextTalamLine = this._createTalamLines(selector);
      }
      if (nextTalamLine) {
        nextTalamLine.focusFirstAkshram();
      }
    },

    _focusPreviousTalamLine: function(current, talamLines, selector) {
      var previousTalamLine = this._getPreviousTalamLine(current, talamLines, selector);
      if (previousTalamLine) {
        previousTalamLine.focusLastAkshram();
      }
    },

    _reAssignAkshramLength: function(talamLines, newAkshramLength) {
      talamLines.each(function(talamLine) {
        talamLine.update({
          akshramLength: newAkshramLength
        });
      }.bind(this));
    },

    //TODO: No proper test coverage for reassign of akshram length for sahidyam line
    update: function(options) {
      Object.extend(this.options, options);
      this._reAssignAkshramLength(this.swaramLines, this.options.swaramLine.akshramLength);
      this._reAssignAkshramLength(this.sahidyamLines, this.options.sahidyamLine.akshramLength);
    }

  }),

  TalamLine: Class.create({

    initialize: function(target, talam, options) {
      this.target = target;
      this.talam = talam;
      this.options = {
        akshramLength: 1,
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
            maxlength: this.options.akshramLength
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
      if (e.charCode !== 0 && this._isFull(currentAkshram)) {
        this._focus(currentAkshram, this._getAdjacentAkshram.bindAsEventListener(this, Element.next, 'input[type="text"]:first-child', this.options.onLastAkshram));
      } else if(e.keyCode == 8 && this._isEmpty(currentAkshram)) {
        this._focus(currentAkshram, this._getAdjacentAkshram.bindAsEventListener(this, Element.previous, 'input[type="text"]:last-child', this.options.onFirstAkshram));
      }
    },

    _isEmpty: function(akshram) {
      //consider the current key stroke for computing length
      return (akshram.value.length - 1) <= 0 ? true: false;
    },

    _isFull: function(akshram) {
      //consider the current key stroke for computing length
      return (akshram.value.length + 1) >= this.options.akshramLength ? true: false;
    },

    _getAdjacentAkshram: function(akshram, adjFn, childSelector, callbackFn) {
      var adjacentAkshram = adjFn(akshram, 'input[type="text"]');
      if (!adjacentAkshram) {
        var adjacentLaguOrDrutham = adjFn(akshram.up('span'), 'span');
        if (adjacentLaguOrDrutham) {
          adjacentAkshram = adjacentLaguOrDrutham.down(childSelector);
        }
      }

      if(adjacentAkshram) {
        return adjacentAkshram;
      } else {
        callbackFn.apply(this, [this]);
      }
    },

    _focus: function(currentAkshram, adjAkshramfn) {
        var akshram = adjAkshramfn(currentAkshram);
        if(akshram) {
          akshram.focus();
        }
    },

    _focusAkshram: function(selector) {
      var akshram = this.domNode.down(selector);
      akshram.focus();
    },

    _reAssignAkshramLength: function() {
      var akshrams = this.domNode.select('input[type="text"]');
      akshrams.each(function(akshram) {
        akshram.writeAttribute('maxlength', this.options.akshramLength);
      }.bind(this));
    },

    focusFirstAkshram: function() {
      this._focusAkshram('span > input[type="text"]:first-child');
    },

    focusLastAkshram: function() {
      this._focusAkshram('span:last-child > input[type="text"]:last-child');
    },

    update: function(options) {
      Object.extend(this.options, options);
      this._reAssignAkshramLength();
    }

  })
};
