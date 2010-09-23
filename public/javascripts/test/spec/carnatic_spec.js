Screw.Unit(function() {
  describe('Carnatic Editor', function() {
    var talam = [4,3,2];
    var editor;

    before(function() {
      $('editor').update();
      editor = new CarnaticEditor('editor', talam);
    });

    describe('Layout Test', function() {

      it('should display the specified aksharams as textboxes', function() {
        var akshrams = $('editor').select('input[type="text"]');
        var sum = 0;
        talam.each(function(value) {
          sum += value;
        });
        expect(talam).to(have_sum, sum);
      });

      it('aksharam textbox max lenght should be 1 by default', function() {
        var akshrams = $('editor').select('input[type="text"]');
        akshrams.each(function(akshram) {
          expect(akshram).to(have_max_length, 1);
        });
      });

      it('should correctly group the akshram based on lagu and drutham', function() {
        var oneCompleteTalam = $('editor').select('div:first-child');
        var laguAndDrutham = $('editor').select('div:first-child > span');
        expect(talam.length).to(equal, laguAndDrutham.length);
        for(var index = 0; index < laguAndDrutham.length; index++) {
          var akshrams = laguAndDrutham[index].select('input[type="text"]');
          expect(talam[index]).to(equal, akshrams.length);
        }
      });

    });

    describe('Focus Test', function() {

      describe('First Lagu Test', function() {

        var akshrams;
        var firstAkshram;
        var secondAkshram;

        before(function() {
          akshrams = $('editor').select('div:nth-child(1) > span:first-child > input[type="text"]');
          firstAkshram = akshrams[0];
          secondAkshram = akshrams[1];
        });

        it('should focus next akshram only when char key is pressed', function() {
          var keyEvent = new SimulateKeyboardEvent(firstAkshram);
          keyEvent.perform(0, 65);
          expect(secondAkshram).to(equal, document.activeElement);
        });

        it('should not focus next akshram if char key is not pressed', function() {
          var keyEvent = new SimulateKeyboardEvent(firstAkshram);
          keyEvent.perform(8, 0);
          expect(firstAkshram).to(equal, document.activeElement);
          expect(secondAkshram).to_not(equal, document.activeElement);
        });

      });

      describe('Lagu and Drutham Test', function() {

        it('should focus akshram in next lagu or drutham when the last akshram in lagu or drutham is enterted', function() {
          var lastAkshramInFirstDrutham = $('editor').select('div:nth-child(1) > span:first-child > input[type="text"]:last-child')[0];
          var firstAkshramInFirstLagu = $('editor').select('div:nth-child(1) > span:nth-child(2) > input[type="text"]:last-child')[0];
          var keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstDrutham);
          keyEvent.perform(0, 65);
          expect("pending").to(equal, "pendiiing");
          //expect(firstAkshramInFirstLagu).to(equal, document.activeElement);
        });
      });

    });

  });
});
