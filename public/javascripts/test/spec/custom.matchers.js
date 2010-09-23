Screw.Matchers["have_max_length"] = {
  match: function(expected, actual) {
    var maxlength = jQuery(actual).attr("maxlength");
    return maxlength == expected;
  },
  failure_message: function(expected, actual, not) {
    return 'expected textbox max length' + (not ? 'not' : '') + ' to be ' + jQuery.print(expected);
  }
}

Screw.Matchers["have_sum"] = {
  match: function(expected, actual) {
    var sum = 0;
    for(var index = 0; index < actual.length; index++)
      sum += actual[index];
    return sum === expected;
  },
  failure_message: function(expected, actual, not) {
    return 'expected sum of ' + jQuery.print(actual) + (not ? 'not' : '') + ' to be ' + jQuery.print(expected);
  }
}
