require 'spec_helper'

describe Composer do

  it "should not create composer without name" do
    some_composer = Factory.build(:composer, :name => nil)
    some_composer.valid?.should == false
  end

  describe "named scope" do

    it "should get composer by name" do
      composer_ajay = Factory(:composer, :name => "Ajay")
      composer_athreya = Factory(:composer, :name => "Atherya")
      composer_balu = Factory(:composer, :name => "Balu")
      composer_babu = Factory(:composer, :name => "babu")
      suggested_composers = Composer.suggest_by_name("ba")
      suggested_composers.count.should == 2
      suggested_composers.should == [composer_balu, composer_babu]
    end

  end

end
