// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//

var AutoComplete = {

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

  bindAutoComplete: function() {
    $$("div[data-auto-complete]").each(function(element) {
      var wrapper = new AutoComplete.Wrapper(element);
    });
  }
};

//Unobtrusive
document.observe("dom:loaded", function() {
  Song.bindEditors();
  AutoComplete.bindAutoComplete();
});
