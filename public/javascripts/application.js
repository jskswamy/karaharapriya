var AutoComplete = {
  _attached: false,
  Wrappers: [],

  Wrapper: Class.create({
    initialize: function(element) {
      this.options = {
        url: element.down("div[data-auto-complete-url]").readAttribute("data-auto-complete-url"),
        input: element.down("input[data-auto-complete-input]"),
        hidden: element.down("input[data-auto-complete-hidden]"),
        completion: element.down("div[data-auto-complete-completion]")
      };
      this.autoComplete = new Ajax.Autocompleter(this.options.input, this.options.completion, this.options.url, this.getAutoCompleteOptions());
    },
    getAutoCompleteOptions: function() {
      return  {
        method: "get",
        paramName: "name",
        afterUpdateElement: function(text, li) {
          this.options.hidden.value = li.id;
        }.bind(this)
      };
    }
  }),

  isAttached: function() {
    return AutoComplete._attached;
  },

  bindAutoComplete: function() {
    if (AutoComplete.isAttached()) { return; }
    $$("div[data-auto-complete]").each(function(element) {
      AutoComplete.Wrappers.push(new AutoComplete.Wrapper(element));
    });
    AutoComplete._attached = true;
  }
};

var RemoteForm = {
  _attached: false,
  Responders: [],

  Responder: Class.create({
    initialize: function(element) {
      this.form = $(element);
      this.form.observe("ajax:complete", this.ajaxComplete.bindAsEventListener(this));
      this.errorDisplay = this.form.down("div[data-error-display]");
      this.errorInfo = this.form.down("div[data-error-info]");
      this.reset();
    },

    ajaxComplete: function(data) {
      this.reset();
      response = data.memo.responseJSON;
      if (response.errors.length === 0) {
        this.redirect(response.redirect_url);
      } else {
        this.processError(response.errors);
      }
    },

    processError: function(errors) {
      errors.each(function(error) {
        htmlElementId = error.field;
        inputElement = this.form.down("input[id='" + htmlElementId + "']");
        labelElement = this.form.down("label[for='" + htmlElementId + "']");
          if (error.errors.length) {
            this.errorInfo.show().update("Please review the highlighted fields");
            labelElement.addClassName("error");
            inputElement.observe("focus", this.showError.bindAsEventListener(this, error.errors));
            inputElement.observe("blur", this.clearError.bindAsEventListener(this));
          }
      }.bind(this));
    },

    showError: function(event, errors) {
      this.errorDisplay.update(errors[0]);
    },

    clearError: function() {
      this.errorDisplay.update();
    },

    reset: function() {
      this.errorInfo.hide();
      this.form.select("input").each(function(inputElement) {
        inputElement.stopObserving("focus");
        inputElement.stopObserving("blur");
      }.bind(this));
      this.form.select("label").each(function(labelElement) {
        labelElement.removeClassName("error");
      }.bind(this));
    },

    redirect: function(url) {
      window.location = url;
    }

  }),

  isAttached: function() {
    return RemoteForm._attached;
  },

  bindResponders: function() {
    if(RemoteForm.isAttached()) { return; }
    $$("form[data-remote]").each(function(element) {
      RemoteForm.Responders.push(new RemoteForm.Responder(element));
    });
  }
};

function transLiteration() {
  var options = {
    sourceLanguage: 'en',
    destinationLanguage: ['ta'],
    shortcutKey: 'ctrl+g',
    transliterationEnabled: true
  };
  var inputElements = $$("input","textarea");
  var control = new google.elements.transliteration.TransliterationControl(options);
  control.makeTransliteratable(inputElements);
}

//Unobtrusive
document.observe("dom:loaded", function() {
  Song.bindEditors();
  AutoComplete.bindAutoComplete();
  RemoteForm.bindResponders();
  transLiteration();
});
