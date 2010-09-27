Screw.Unit(function() {
  var SampleTalams = {
    SangeernaJathiBhuvana: [9,2,9,9],
    Adi: [4,2,2],
    Rupagam: [2,4],
    TisraJathiSutha: [3]
  };

  var talam;

  describe('Music', function() {

    describe('Talam', function() {

      var talamDom = $('editor');
      var sampleTalam;

      before(function() {
        talamDom.update();
        talam = SampleTalams.Adi;
        sampleTalam = new Music.Talam(talamDom, talam);
      });

      describe('Layout', function() {
        it('should display the specified akshrams as textboxes', function() {
          var akshrams = talamDom.select('input[type="text"]');
          var sum = 0;
          talam.each(function(value) {
            sum += value;
          });
          expect(talam).to(have_sum, sum);
        });

        it('aksharam textbox max lenght should be 1 by default', function() {
          var akshrams = talamDom.select('input[type="text"]');
          akshrams.each(function(akshram) {
            expect(akshram).to(have_max_length, 1);
         });
        });

        it('should correctly group the akshram based on lagu and drutham', function() {
          var oneCompleteTalam = talamDom.select('div:first-child');
          var laguAndDrutham = talamDom.select('div:first-child > span');
          expect(talam.length).to(equal, laguAndDrutham.length);
          for(var index = 0; index < laguAndDrutham.length; index++) {
            var akshrams = laguAndDrutham[index].select('input[type="text"]');
            expect(talam[index]).to(equal, akshrams.length);
          }
        });
      });

      describe('Focus', function() {
        var akshrams;
        var firstAkshram;
        var secondAkshram;

        before(function() {
          akshrams = talamDom.select('div:first-child > span:first-child > input[type="text"]');
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

        it('should focus akshram in next lagu or drutham when the last akshram in lagu or drutham is enterted', function() {
          var lastAkshramInFirstDrutham = talamDom.select('div:firt-child > span:first-child > input[type="text"]:last-child')[0];
          var firstAkshramInFirstLagu = talamDom.select('div:first-child > span:nth-child(2) > input[type="text"]:first-child')[0];

          var keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstDrutham);
          keyEvent.perform(0, 65);
          expect(firstAkshramInFirstLagu).to(equal, document.activeElement);
        });

        it('should focus the previous akshram on backspace', function() {
          var keyEvent = new SimulateKeyboardEvent(secondAkshram);
          keyEvent.perform(8, 0);
          expect(firstAkshram).to(equal, document.activeElement);
        });

        it('should clear the current akshram and focus the previous one on backspace', function() {
          var keyEvent = new SimulateKeyboardEvent(secondAkshram);
          keyEvent.perform(0, 65);

          keyEvent = new SimulateKeyboardEvent(secondAkshram);
          keyEvent.perform(8, 0);

          expect(firstAkshram).to(equal, document.activeElement);
          expect(secondAkshram.value).to(equal, "");
        });

        it('should focus akshram in previous lagu or drutham on backspace from the first akshram in lagu or drutham', function() {
          var lastAkshramInFirstDrutham = talamDom.select('div:firt-child > span:first-child > input[type="text"]:last-child')[0];
          var firstAkshramInFirstLagu = talamDom.select('div:first-child > span:nth-child(2) > input[type="text"]:first-child')[0];
          var keyEvent = new SimulateKeyboardEvent(firstAkshramInFirstLagu);

          keyEvent.perform(8, 0);
          expect(lastAkshramInFirstDrutham).to(equal, document.activeElement);
        });

        it('should focus the last akshram when the focusLast method is invoked', function() {
          var lastAkshram = talamDom.select('div:firt-child > span:last-child > input[type="text"]:last-child')[0];

          sampleTalam.focusLast();
          expect(lastAkshram).to(equal, document.activeElement);
        });


      });

      describe('Callback', function() {

        var lastAkshramCalled;
        var firstAkshramCalled;

        before(function() {
          talamDom.update();
          lastAkshramCalled = false;
          firstAkshramCalled = false;
          sampleTalam = new Music.Talam(talamDom, talam, {
            onLastAkshram: function() {
              lastAkshramCalled = true;
            },
            onFirstAkshram: function() {
              firstAkshramCalled = true;
            }
          });
        });

        it('should callback when the last akshram is entered', function() {
          var lastAkshram = talamDom.select('div:first-child > span:last-child > input[type="text"]:last-child')[0];
          var keyEvent = new SimulateKeyboardEvent(lastAkshram);
          keyEvent.perform(0, 65);
          expect(lastAkshramCalled).to(equal, true);
        });

        it('should callback when the first akshram is encounters a backspace', function() {
          var firstAkshram = talamDom.select('div:first-child > span:first-child > input[type="text"]:first-child')[0];
          var keyEvent = new SimulateKeyboardEvent(firstAkshram);
          keyEvent.perform(8, 0);
          expect(firstAkshramCalled).to(equal, true);
        });

        it('should not callback when the char key is pressed on first akshram', function() {
          var firstAkshram = talamDom.select('div:first-child > span:first-child > input[type="text"]:first-child')[0];
          var keyEvent = new SimulateKeyboardEvent(firstAkshram);
          keyEvent.perform(0, 65);
          expect(firstAkshramCalled).to(equal, false);
        });

      });

    });

    describe('Editor', function() {

      var editor;
      var editorDom = $('editor');

      before(function() {
        editorDom.update();
        talam = SampleTalams.Adi;
        editor = new Music.Editor('editor', talam);
      });

      describe('Layout', function() {
        var lastAkshramInFirstTalamLine;
        var keyEvent;

        before(function() {
          lastAkshramInFirstTalamLine = editorDom.select('div:first-child > span:last-child > input[type="text"]:last-child')[0];
          keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);
        });

        it('should create new talam line when the last akshram in previous talam line is entered', function() {
          keyEvent.perform(0, 65);
          var talamLines = editorDom.select('div');
          var firstAkshramInSecondTalamLine = editorDom.select('div:nth-child(2) > span:first-child > input[type="text"]:first-child')[0];
          expect(talamLines.length).to(equal, 2);
          expect(firstAkshramInSecondTalamLine).to_not(be_undefined);
        });

        it('should not create new talam line if the talam line is already available when the last akshram in previous talam line is entered', function() {
          keyEvent.perform(0, 65);
          lastAkshramInFirstTalamLine.value = "";
          keyEvent.perform(0, 66);
          var talamLines = editorDom.select('div');
          expect(talamLines.length).to(equal, 2);
        });

      });

      describe('Focus', function() {
        var keyEvent;

        it('should focus the first akshram when the editor is loaded', function() {
          var firstAkshram = editorDom.select('div:firt-child > span:first-child > input[type="text"]:first-child')[0];
          expect(firstAkshram).to(equal, document.activeElement);
        });

        it('should focus the first akshram of next talam line when the last akshram in the current talam line is entered', function() {
          var lastAkshramInFirstTalamLine = editorDom.select('div:firt-child > span:last-child > input[type="text"]:last-child')[0];
          keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);
          keyEvent.perform(0, 65);

          var firstAkshramInSecondTalamLine = editorDom.select('div:nth-child(2) > span:first-child > input[type="text"]:first-child')[0];
          expect(firstAkshramInSecondTalamLine).to(equal, document.activeElement);
        });

        it('should focus the last akshram of previous talam line when backspaced from first akshram in the current talam line', function() {
          var lastAkshramInFirstTalamLine = editorDom.select('div:firt-child > span:last-child > input[type="text"]:last-child')[0];
          keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);
          keyEvent.perform(0, 65);

          var firstAkshramInSecondTalamLine = editorDom.select('div:nth-child(2) > span:first-child > input[type="text"]:first-child')[0];
          keyEvent = new SimulateKeyboardEvent(firstAkshramInSecondTalamLine);
          keyEvent.perform(8, 0);
          expect(lastAkshramInFirstTalamLine).to(equal, document.activeElement);
        });

      });

    });

  });
});
