Screw.Matchers["have_max_length_of"] = {
  match: function(expected, actual) {
    var maxlength = jQuery(actual).attr("maxlength");
    return maxlength == expected;
  },
  failure_message: function(expected, actual, not) {
    return 'expected textbox max length' + (not ? 'not' : '') + ' to be ' + jQuery.print(expected);
  }
}
