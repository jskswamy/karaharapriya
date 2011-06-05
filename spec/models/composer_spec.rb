require 'spec_helper'

describe Composer do

  describe "validations" do

    it "should not create composer without name" do
      some_composer = Factory.build(:composer, :name => nil)
      some_composer.valid?.should == false
      some_composer.errors.full_messages.to_sentence.should == "Name can't be blank"
    end

    it "should not create composer with duplicate name" do
      some_composer = Factory(:composer, :name => "Thyagarajar")
      duplicate_some_composer = Factory.build(:composer, :name => "Thyagarajar")
      duplicate_some_composer.valid?.should == false
      duplicate_some_composer.errors.full_messages.to_sentence.should == "Name is already taken"
    end

    it "should not create composer without info" do
      some_composer = Factory.build(:composer, :info => nil)
      some_composer.valid?.should == false
      some_composer.errors.full_messages.to_sentence.should == "Info can't be blank"
    end

  end

  it "to_param should return name" do
    composer = Factory(:composer, :name => "Composer")
    composer.to_param.should == "Composer"
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
