var SimulateKeyboardEvent = Class.create({
  initialize: function(target) {
    this.target = $(target);
  },

  perform: function(keyCode, charCode) {
    var event = document.createEvent("KeyboardEvent");
    event.initKeyEvent("keypress", true, true, null, false, false, false, false, keyCode, charCode);
    this.target.focus();
    this.target.dispatchEvent(event);
  }

});
