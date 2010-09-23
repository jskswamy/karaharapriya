Screw.Unit(function() {
  describe('Carnatic Editor', function() {
    var talam = [4,2,2];
    var editor;

    before(function() {
      $('editor').update();
      editor = new CarnaticEditor('editor', talam);
    });

    describe('Layout', function() {

      it('should display the specified aksharams as textboxes', function() {
        var akshrams = $('editor').select('input[type="text"]');
        expect(talam).to(have_sum, 8);
      });

      it('aksharam textbox max lenght should be 1 by default', function() {
        var akshrams = $('editor').select('input[type="text"]');
        akshrams.each(function(akshram) {
          expect(akshram).to(have_max_length, 1);
        });
      });

      it('should correctly group the akshram based on lagu and drutham', function() {
        var oneCompleteTalam = $('editor').select('div:nth-child(1)');
        var laguAndDrutham = $('editor').select('div:nth-child(1) > span');
        expect(talam.length).to(equal, laguAndDrutham.length);
        for(var index = 0; index < laguAndDrutham.length; index++) {
          var akshrams = laguAndDrutham[index].select('input[type="text"]');
          expect(talam[index]).to(equal, akshrams.length);
        }
      });

    });

    describe('Focus', function() {

      it('next akshram only when char key is pressed', function() {
        expect('').to(equal, 'pending');
      });
    });


  });
});
