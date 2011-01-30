Screw.Unit(function() {

  var autocomplete = {};
  var input = $('auto_complete_input');
  var hidden = $('auto_complete_hidden');
  var completion = $('auto_complete_completion');
  var url = $('auto_complete_url').readAttribute('data-auto-complete-url');

  before(function(){
    Ajax.Autocompleter = function(input, completion, url, options) {
      autocomplete = {
        input: input,
        completion: completion,
        url: url,
        options: options
      };
    };
    AutoComplete.bindAutoComplete();
  });

  describe('AutoComplete.Wrapper', function() {
    it('should attach to autocomplete on page load', function() {
      expect(AutoComplete.Wrappers.length).to(equal, 1);
      expect(autocomplete).to_not(equal, null);
      expect(input).to(equal, autocomplete.input);
      expect(completion).to(equal, autocomplete.completion);
      expect(url).to(equal, autocomplete.url);
      autocomplete.options.afterUpdateElement("test", {id: "1"});
      expect(hidden.value).to(equal, "1");
    });

  });

});

