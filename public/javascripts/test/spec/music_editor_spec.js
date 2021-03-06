//Todo: Create seperate test suite for TalamLine and TalamBlock.
Screw.Unit(function() {
  var SampleTalams = {
    SangeernaJathiBhuvana: [9,2,9,9],
    Adi: [4,2,2],
    Rupagam: [2,4],
    TisraJathiSutha: [3]
  };

  var talam;

  describe('Music', function() {

    describe('TalamLine', function() {

      var talamDom = $('editor');
      var sampleTalam;

      before(function() {
        talamDom.update();
        talam = SampleTalams.Adi;
        sampleTalam = new Music.TalamLine(talamDom, talam);
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

        it('should use the custom classname', function() {
          talamDom.update();
          sampleTalam = new Music.TalamLine(talamDom, talam, {
            className: 'sample'
          });
          var line = talamDom.down('.sample');
          expect(line.hasClassName('sample')).to(equal, true);
        });

        describe('Multiple Characters', function() {

          var akshramLength = 2;

          before(function() {
            talamDom.update();
            sampleTalam = new Music.TalamLine(talamDom, talam, {
              akshramLength: akshramLength
            });
          });

          it('should be able to override the default maxlength of an akshram', function() {
            var akshrams = talamDom.select('input[type="text"]');
            akshrams.each(function(akshram) {
              expect(akshram).to(have_max_length, akshramLength);
            });
          });

          it('should be able to updated the default maxlength of akshram at anytime', function() {
            sampleTalam.update({
              akshramLength: akshramLength
            });
            var akshrams = talamDom.select('input[type="text"]');
            akshrams.each(function(akshram) {
              expect(akshram).to(have_max_length, akshramLength);
            });
          });

        });

      });

      describe('Focus', function() {
        var akshrams;
        var firstAkshram;
        var secondAkshram;
        var keyEvent;

        before(function() {
          akshrams = talamDom.select('div:first-child > span:first-child > input[type="text"]');
          firstAkshram = akshrams[0];
          secondAkshram = akshrams[1];
        });

        it('should focus next akshram only when char key is pressed', function() {
          keyEvent = new SimulateKeyboardEvent(firstAkshram);
          keyEvent.perform(0, 65);
          expect(secondAkshram).to(equal, document.activeElement);
        });

        it('should not focus next akshram if char key is not pressed', function() {
          keyEvent = new SimulateKeyboardEvent(firstAkshram);
          keyEvent.perform(8, 0);
          expect(firstAkshram).to(equal, document.activeElement);
          expect(secondAkshram).to_not(equal, document.activeElement);
        });

        it('should focus akshram in next lagu or drutham when the last akshram in lagu or drutham is enterted', function() {
          var lastAkshramInFirstDrutham = talamDom.select('div:firt-child > span:first-child > input[type="text"]:last-child')[0];
          var firstAkshramInFirstLagu = talamDom.select('div:first-child > span:nth-child(2) > input[type="text"]:first-child')[0];

          keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstDrutham);
          keyEvent.perform(0, 65);
          expect(firstAkshramInFirstLagu).to(equal, document.activeElement);
        });

        it('should focus the previous akshram on backspace', function() {
          var keyEvent = new SimulateKeyboardEvent(secondAkshram);
          keyEvent.perform(8, 0);
          expect(firstAkshram).to(equal, document.activeElement);
        });

        it('should clear the current akshram and focus the previous one on backspace', function() {
          keyEvent = new SimulateKeyboardEvent(secondAkshram);
          keyEvent.perform(0, 65);

          keyEvent = new SimulateKeyboardEvent(secondAkshram);
          keyEvent.perform(8, 0);

          expect(firstAkshram).to(equal, document.activeElement);
          expect(secondAkshram.value).to(equal, "");
        });

        it('should focus akshram in previous lagu or drutham on backspace from the first akshram in lagu or drutham', function() {
          var lastAkshramInFirstDrutham = talamDom.select('div:firt-child > span:first-child > input[type="text"]:last-child')[0];
          var firstAkshramInFirstLagu = talamDom.select('div:first-child > span:nth-child(2) > input[type="text"]:first-child')[0];
          keyEvent = new SimulateKeyboardEvent(firstAkshramInFirstLagu);

          keyEvent.perform(8, 0);
          expect(lastAkshramInFirstDrutham).to(equal, document.activeElement);
        });

        it('should focus the last akshram when the focusLast method is invoked', function() {
          var lastAkshram = talamDom.select('div:firt-child > span:last-child > input[type="text"]:last-child')[0];

          sampleTalam.focusLastAkshram();
          expect(lastAkshram).to(equal, document.activeElement);
        });

        describe('Multiple Characters', function() {

          var akshramLength = 2;

          before(function() {
            talamDom.update();
            sampleTalam = new Music.TalamLine(talamDom, talam, {
              akshramLength: akshramLength
            });
            akshrams = talamDom.select('div:first-child > span:first-child > input[type="text"]');
            firstAkshram = akshrams[0];
            secondAkshram = akshrams[1];
          });

          it('should not focus next akshram until maxlength is reached on current akshram', function() {
            var eventCountIndex;
            keyEvent = new SimulateKeyboardEvent(firstAkshram);
            firstAkshram.focus();

            for(eventCountIndex = 0; eventCountIndex < akshramLength; eventCountIndex++) {
              expect(firstAkshram).to(equal, document.activeElement);
              keyEvent.perform(0, 65);
            }

            expect(secondAkshram).to(equal, document.activeElement);
          });

          it('should not focus previous akshram until the current akshram is cleared out on backspace', function() {
            keyEvent = new SimulateKeyboardEvent(secondAkshram);
            for(eventCountIndex = 0; eventCountIndex < akshramLength; eventCountIndex++) {
              keyEvent.perform(0, 65);
            }
            secondAkshram.focus();

            for(eventCountIndex = 0; eventCountIndex < akshramLength; eventCountIndex++) {
              expect(secondAkshram).to(equal, document.activeElement);
              keyEvent.perform(8, 0);
            }
            expect(firstAkshram).to(equal, document.activeElement);
          });

          it('should respect the new akshram length and focus the next akshram when the new maxlength is reached', function() {
            var newAkshramLength = 4;
            keyEvent = new SimulateKeyboardEvent(firstAkshram);
            sampleTalam.update({
              akshramLength: newAkshramLength
            });

            for(eventCountIndex = 0; eventCountIndex < newAkshramLength; eventCountIndex++) {
              keyEvent.perform(0, 65);
            }
            expect(secondAkshram).to(equal, document.activeElement);
          });

          it('should respect the new akshram length and focus the previous talam after clearing out on backspace', function() {
            var newAkshramLength = 4;
            keyEvent = new SimulateKeyboardEvent(secondAkshram);

            sampleTalam.update({
              akshramLength: newAkshramLength
            });
            secondAkshram.focus();
            for(eventCountIndex = 0; eventCountIndex < newAkshramLength; eventCountIndex++) {
              keyEvent.perform(0, 65);
            }

            secondAkshram.focus();
            for(eventCountIndex = 0; eventCountIndex < newAkshramLength; eventCountIndex++) {
              keyEvent.perform(8, 0);
            }

            expect(firstAkshram).to(equal, document.activeElement);
          });

        });

      });

      describe('Callback', function() {

        var lastAkshramCalled;
        var firstAkshramCalled;

        before(function() {
          talamDom.update();
          lastAkshramCalled = false;
          firstAkshramCalled = false;
          sampleTalam = new Music.TalamLine(talamDom, talam, {
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

    describe('TalamBlock', function() {
      var talamBlock;
      var talamBlockDom = $('editor');

      before(function() {
        talamBlockDom.update();
        talam = SampleTalams.Adi;
        talamBlock = new Music.TalamBlock('editor', talam);
      });

      describe('Layout', function() {
        var lastAkshramInFirstTalamLine;
        var keyEvent;

        before(function() {
          lastAkshramInFirstTalamLine = talamBlockDom.select('div:first-child > span:last-child > input[type="text"]:last-child')[0];
          keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);
        });

        it('should create new talam line when the last akshram in previous talam line is entered', function() {
          keyEvent.perform(0, 65);
          var talamLines = talamBlockDom.select('div.swaram');
          var firstAkshramInSecondTalamLine = talamLines[1].down('span:first-child > input[type="text"]:first-child');
          expect(talamLines.length).to(equal, 2);
          expect(firstAkshramInSecondTalamLine).to_not(be_undefined);
        });

        it('should not create new talam line if the talam line is already available when the last akshram in previous talam line is entered', function() {
          keyEvent.perform(0, 65);
          lastAkshramInFirstTalamLine.value = "";
          keyEvent.perform(0, 66);
          var talamLines = talamBlockDom.select('div.swaram');
          expect(talamLines.length).to(equal, 2);
        });

        it('should use custom classname', function() {
          talamBlockDom.update();
          talamBlock = new Music.TalamBlock('editor', talam, {
            className: {
              swaramLine: 'swaram'
            }
          });
          var talamLines = talamBlockDom.down('div.swaram');
          expect(talamLines.hasClassName('swaram')).to(equal, true);
        });

        it('should not create swaram line if disabled', function() {
          talamBlockDom.update();
          TalamBlock = new Music.TalamBlock('editor', talam, {
            swaramLine: {
              disabled: true
            }
          });
          var talamLines = talamBlockDom.select('div.swaram');
          expect(talamLines.length).to(equal, 0);
        });

        it('should create sahidyam line if enabled', function() {
          talamBlockDom.update();
          TalamBlock = new Music.TalamBlock('editor', talam, {
            sahidyamLine: {
              akshramLength: 1,
              className: 'sahidyam',
              disabled: false
            }
          });

          var sahidyamLines = talamBlockDom.select('div.sahidyam');
          expect(sahidyamLines.length).to(equal, 1);
        });

        it('should be able to create talam block only with sahidyam line', function() {
          talamBlockDom.update();
          TalamBlock = new Music.TalamBlock('editor', talam, {
            sahidyamLine: {
              akshramLength: 1,
              className: 'sahidyam',
              disabled: false
            },
            swaramLine: {
              akshramLength: 1,
              className: 'swaram',
              disabled: true
            }
          });

          var sahidyamLines = talamBlockDom.select('div.sahidyam');
          var swaramLines = talamBlockDom.select('div.swaram');
          expect(sahidyamLines.length).to(equal, 1);
          expect(swaramLines.length).to(equal, 0);
        });

        it('should be able to create talam block only with swaram line', function() {
          talamBlockDom.update();
          TalamBlock = new Music.TalamBlock('editor', talam, {
            sahidyamLine: {
              akshramLength: 1,
              className: 'sahidyam',
              disabled: true
            },
            swaramLine: {
              akshramLength: 1,
              className: 'swaram',
              disabled: false
            }
          });

          var sahidyamLines = talamBlockDom.select('div.sahidyam');
          var swaramLines = talamBlockDom.select('div.swaram');
          expect(sahidyamLines.length).to(equal, 0);
          expect(swaramLines.length).to(equal, 1);
        });

        describe('Multiple Characters', function() {

          before(function() {
            talamBlockDom.update();
            talamBlock = new Music.TalamBlock('editor', talam, {
              swaramLine: {
                akshramLength: 2,
                className: 'swaram'
              }
            });
          });

          it('should override the default akshram length for swaram line', function() {
            var akshrams = talamBlockDom.select('div.swaram > input[type="text"]');
            akshrams.each(function(akshram) {
              expect(akshram).to(have_max_length, 2);
            });
          });

          it('should use the new akshram length', function() {
            var newAkshramLength = 4;
            talamBlock.update({
              swaramLine: {
                akshramLength: newAkshramLength,
                className: 'swaram'
              }
            });

            var akshrams = talamBlockDom.select('input[type="text"]');
            akshrams.each(function(akshram) {
              expect(akshram).to(have_max_length, newAkshramLength);
            });
          });

        });

      });

      describe('Focus', function() {
        var keyEvent;

        it('should focus the first akshram when the editor is loaded', function() {
          var firstAkshram = talamBlockDom.select('div:firt-child > span:first-child > input[type="text"]:first-child')[0];
          expect(firstAkshram).to(equal, document.activeElement);
        });

        it('should focus the first akshram of next talam line when the last akshram in the current talam line is entered', function() {
          var swaramLines = talamBlockDom.select('div.swaram');
          var lastAkshramInFirstTalamLine = swaramLines[0].down('span:last-child > input[type="text"]:last-child');
          keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);
          keyEvent.perform(0, 65);

          swaramLines = talamBlockDom.select('div.swaram');
          var firstAkshramInSecondTalamLine = swaramLines[1].down('span:first-child > input[type="text"]:first-child');
          expect(firstAkshramInSecondTalamLine).to(equal, document.activeElement);
        });

        it('should focus the last akshram of previous talam line when backspaced from first akshram in the current talam line', function() {
          var swaramLines = talamBlockDom.select('div.swaram');
          var lastAkshramInFirstTalamLine = swaramLines[0].down('span:last-child > input[type="text"]:last-child');
          keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);
          keyEvent.perform(0, 65);

          swaramLines = talamBlockDom.select('div.swaram');
          var firstAkshramInSecondTalamLine = swaramLines[1].down('span:first-child > input[type="text"]:first-child');
          keyEvent = new SimulateKeyboardEvent(firstAkshramInSecondTalamLine);
          keyEvent.perform(8, 0);
          expect(lastAkshramInFirstTalamLine).to(equal, document.activeElement);
        });

        it('should focus the first akshram of next sahidyam line when the last akshram in previous sahiydam line is entered', function() {
          talamBlockDom.update();
          talamBlock = new Music.TalamBlock('editor', talam, {
            sahidyamLine: {
              akshramLength: 1,
              className: 'sahidyam',
              disabled: false
            }
          });

          var sahidyamLines = talamBlockDom.select('div.sahidyam');
          var lastAkshramInFirstSahidyamLine = sahidyamLines[0].down('span:last-child > input[type="text"]:last-child');
          keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstSahidyamLine);
          keyEvent.perform(0, 65);

          sahidyamLines = talamBlockDom.select('div.sahidyam');
          var firstAkshramInNextSahidyamLine = sahidyamLines[1].down('span:first-child > input[type="text"]:first-child');
          expect(firstAkshramInNextSahidyamLine).to(equal, document.activeElement);
        });

        describe('Multiple Characters', function() {
          var akshramLength = 3;

          before(function() {
            talamBlockDom.update();
            talamBlock = new Music.TalamBlock('editor', talam, {
              swaramLine: {
                akshramLength: akshramLength,
                className: 'swaram'
              }
            });
          });

          it('should focus first akshram of next talam line only when the last akshram of current line is filled', function() {

          var swaramLines = talamBlockDom.select('div.swaram');
          var lastAkshramInFirstTalamLine = swaramLines[0].down('span:last-child > input[type="text"]:last-child');
          lastAkshramInFirstTalamLine.focus();
          keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);

          for(var index = 0; index < akshramLength; index++) {
            expect(lastAkshramInFirstTalamLine).to(equal, document.activeElement);
            keyEvent.perform(0, 65);
          }

          swaramLines = talamBlockDom.select('div.swaram');
          var firstAkshramInSecondTalamLine = swaramLines[1].down('span:first-child > input[type="text"]:first-child');
          expect(firstAkshramInSecondTalamLine).to(equal, document.activeElement);

          });

          it('should focus the last akshram of previous talam line only when the first akshram is cleared out on backspace', function() {
            var swaramLines = talamBlockDom.select('div.swaram');
            var lastAkshramInFirstTalamLine = swaramLines[0].down('span:last-child > input[type="text"]:last-child');
            lastAkshramInFirstTalamLine.focus();
            keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);
            var eventCountIndex;

            for(eventCountIndex = 0; eventCountIndex < akshramLength; eventCountIndex++) {
              expect(lastAkshramInFirstTalamLine).to(equal, document.activeElement);
              keyEvent.perform(0, 65);
            }

            swaramLines = talamBlockDom.select('div.swaram');
            var firstAkshramInSecondTalamLine = swaramLines[1].down('span:first-child > input[type="text"]:first-child');

            keyEvent = new SimulateKeyboardEvent(firstAkshramInSecondTalamLine);
            for(eventCountIndex = 0; eventCountIndex < akshramLength; eventCountIndex++) {
              keyEvent.perform(0, 65);
            }
            firstAkshramInSecondTalamLine.focus();

            for(eventCountIndex = 0; eventCountIndex < talamBlock.options.swaramLine.akshramLength; eventCountIndex++) {
              expect(firstAkshramInSecondTalamLine).to(equal, document.activeElement);
              keyEvent.perform(8, 0);
            }

            expect(lastAkshramInFirstTalamLine).to(equal, document.activeElement);
          });

          it('should respect the new akshram length and focus the first akshram in the next talam line when the last akshram in current line is filled', function() {
            var newAkshramLength = 4;
            talamBlock.update({
              akshramLength: {
                swaramLine: newAkshramLength,
                className: 'swaram'
              }
            });

            var swaramLines = talamBlockDom.select('div.swaram');
            var lastAkshramInFirstTalamLine = swaramLines[0].down('span:last-child > input[type="text"]:last-child');
            keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);
            var eventCountIndex;

            for(eventCountIndex = 0; eventCountIndex < newAkshramLength; eventCountIndex++) {
              keyEvent.perform(0, 65);
            }

            swaramLines = talamBlockDom.select('div.swaram');
            var firstAkshramInSecondTalamLine = swaramLines[1].down('span:first-child > input[type="text"]:first-child');
            expect(firstAkshramInSecondTalamLine).to(equal, document.activeElement);

          });

          it('should respect the new akshram lengh and focus the last akshram in the previous talam line when the first akshram is cleared out on backspace', function() {
            var newAkshramLength = 4;
            talamBlock.update({
              swaramLine: {
                akshramLength: newAkshramLength,
                className: 'swaram'
              }
            });

            var swaramLines = talamBlockDom.select('div.swaram');
            var lastAkshramInFirstTalamLine = swaramLines[0].down('span:last-child > input[type="text"]:last-child');
            keyEvent = new SimulateKeyboardEvent(lastAkshramInFirstTalamLine);
            var eventCountIndex;

            for(eventCountIndex = 0; eventCountIndex < newAkshramLength; eventCountIndex++) {
              keyEvent.perform(0, 65);
            }

            swaramLines = talamBlockDom.select('div.swaram');
            var firstAkshramInSecondTalamLine = swaramLines[1].down('span:first-child > input[type="text"]:first-child');
            keyEvent = new SimulateKeyboardEvent(firstAkshramInSecondTalamLine);
            for(eventCountIndex = 0; eventCountIndex < newAkshramLength; eventCountIndex++) {
              keyEvent.perform(0, 65);
            }

            firstAkshramInSecondTalamLine.focus();
            for(eventCountIndex = 0; eventCountIndex < newAkshramLength; eventCountIndex++) {
              keyEvent.perform(8, 0);
            }
            expect(lastAkshramInFirstTalamLine).to(equal, document.activeElement);

          });

        });

      });

    });

    describe('Editor', function() {

      var editorDom = $('editor');
      var carnaticEditor;
      var defaultTalamBlock = {
        swaramLine: {
          disabled: false,
          className: 'swaram',
          akshramLength: 1
        },
        sahidyamLine: {
          disabled: false,
          className: 'sahidyam',
          akshramLength: 1
        }
      };

      before(function() {
        talam = SampleTalams.Rupagam;
        editorDom.update();
        carnaticEditor = new Music.Editor(editorDom, talam);
      });

      it('should create a editor', function() {
        var editor = editorDom.down('div.editor');
        expect(editor).to_not(be_undefined);
      });

      it('should add talam block', function() {
        carnaticEditor.addTalamBlock(defaultTalamBlock);
        var swaramLine = editor.down('div.editor > div > div > div.swaram');
        var sahidyamLine = editor.down('div.editor > div > div > div.sahidyam');
        var blocks = editor.select('div.editor > div');

        expect(blocks.length).to(equal, 1);
        expect(swaramLine).to_not(be_undefined);
        expect(sahidyamLine).to_not(be_undefined);
      });

      it('should be able to add more than one talam block', function() {
        carnaticEditor.addTalamBlock(defaultTalamBlock);
        carnaticEditor.addTalamBlock(defaultTalamBlock);
        var blocks = editor.select('div.editor > div');

        expect(blocks.length).to(equal, 2);
      });

    });

  });

});
