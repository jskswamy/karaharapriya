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

var YUILibrary = {
  _attached: false,
  Editors: [],

  Editor: Class.create({
    initialize: function(element) {
      this.element = $(element);
      var elementDimension = element.getDimensions();
      this._editor = new YAHOO.widget.Editor(element, {
        autoHeight: true,
        height: elementDimension.height + 'px',
        width: elementDimension.width + 'px',
        animate: true //Animates the opening, closing and moving of Editor windows
      });
      this._editor.render();
    },
    getEditorHandle: function() {
      return this._editor;
    }

  }),


  isAttached: function() {
    return YUILibrary._attached;
  },

  bindEditors: function() {
    if(YUILibrary.isAttached()) { return; }
    $$("textarea.rich_editor").each(function(element) {
      YUILibrary.Editors[element] = new YUILibrary.Editor(element);
    });
  },

  getEditor: function(editor_name) {
    editor = YUILibrary.Editors[$(element)];
    return editor.getEditorHandle();
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
      response = data.memo;
      this.reset();
      if (response.status == 200) {
        success_data = response.responseJSON;
        this.redirect(success_data.redirect_url);
      } else {
        errors = data.memo.getResponseHeader("Errors").evalJSON(true);
        this.processError(errors);
      }
    },

    processError: function(error_info) {
      model_name = error_info.model_name;
      errors = error_info.errors;
      if (errors.length) {
        this.errorInfo.show().update("Please review the highlighted fields");
        errors.each(function(error) {
          htmlElementId = model_name + "_" + error.field;
          inputElement = this.form.down("#" + htmlElementId);
          labelElement = this.form.down("label[for='" + htmlElementId + "']");
            if (error.errors.length && inputElement && labelElement) {
              labelElement.addClassName("error");
              labelElement.title = error.errors[0];
              inputElement.observe("focus", this.showError.bindAsEventListener(this, error.errors));
              inputElement.observe("blur", this.clearError.bindAsEventListener(this));
            }
        }.bind(this));
      }
    },

    showError: function(event, errors) {
      this.errorDisplay.update(errors[0]);
    },

    clearError: function() {
      this.errorDisplay.update();
    },

    reset: function() {
      this.errorInfo.hide();
      this.form.select("input, textarea, select").each(function(inputElement) {
        inputElement.stopObserving("focus");
        inputElement.stopObserving("blur");
      }.bind(this));
      this.form.select("label").each(function(labelElement) {
        labelElement.removeClassName("error");
        labelElement.title = " ";
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
  AutoComplete.bindAutoComplete();
  RemoteForm.bindResponders();
  YUILibrary.bindEditors();
  //transLiteration();
});
