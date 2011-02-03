// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//

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
      this.errorInfo.hide();
    },

    ajaxComplete: function(data) {
      response = data.memo.responseJSON;
      response.errors.each(function(error) {
        elementName = response.model_name + "[" + error.field + "]";
        inputElement = this.form.down("input[name='" + elementName + "']");
        inputElement.stopObserving("focus");
        inputElement.stopObserving("blur");
        if (error.errors.length) {
          this.errorInfo.show().update("Please review the highlighted fields");
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
    }

  }),

  isAttached: function() {
    return RemoteForm._attached;
  },

  bindResponders: function() {
    if(RemoteForm.isAttached()) { return; }
    $$("form[data-remote]").each(function(element) {
      RemoteForm.Responder.push(new RemoteForm.Responder(element));
    });
  }
};

//Unobtrusive
document.observe("dom:loaded", function() {
  Song.bindEditors();
  AutoComplete.bindAutoComplete();
  RemoteForm.bindResponders();
});
