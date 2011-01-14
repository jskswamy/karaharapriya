require 'spec_helper'

describe Ragam do

  it "should not have duplicate name" do
    mohana_ragam = Factory(:ragam, :name => "mohanam")
    another_mohana_ragam = Factory.build(:ragam, :name => "mohanam", :arohana => "sa re2 ga2 ma1 pa")
    another_mohana_ragam.valid?.should be_false
    another_mohana_ragam.errors.full_messages.to_sentence.should == "Name has already been taken"
  end

  it "should not create a ragam without a name" do
    random_ragam = Factory.build(:ragam, :name => nil)
    random_ragam.valid?.should be_false
    random_ragam.errors.full_messages.to_sentence.should == "Name can't be blank"
  end

  it "should not create a ragam with out arohana" do
    mohana_ragam = Factory.build(:ragam, :name => "Mohanam", :arohana => nil)
    mohana_ragam.valid?.should be_false
    mohana_ragam.errors.full_messages.to_sentence.should == "Arohana can't be blank"
  end

  it "should not create a ragam with our avarohana" do
    mohana_ragam = Factory.build(:ragam, :name => "Mohanam", :avarohana => nil)
    mohana_ragam.valid?.should be_false
    mohana_ragam.errors.full_messages.to_sentence.should == "Avarohana can't be blank"
  end

  it "two ragam should not have same arohana and avarohana" do
    mohana_ragam = Factory.create(:ragam,
                                  :name => "Mohanam",
                                  :arohana => "sa re2 ga2 pa th2 sa^",
                                  :avarohana => "sa^ th2 pa ga2 re2 sa")
    fake_mohana_ragam = Factory.build(:ragam,
                                       :name => "Fake Mohanam",
                                       :arohana => "sa re2 ga2 pa th2 sa^",
                                       :avarohana => "sa^ th2 pa ga2 re2 sa")
    fake_mohana_ragam.valid?.should be_false
    fake_mohana_ragam.errors.full_messages.to_sentence.should == "Arohana and Avarohana already defined for another ragam"
  end

  it "arohana should have a minimum length of five" do
    invalid_arohana_ragam = Factory.build(:ragam, :arohana => "sa re ga ma")
    invalid_arohana_ragam.valid?.should be_false
    invalid_arohana_ragam.errors.full_messages.to_sentence.should == "Arohana should have atleast 5 swaras"
  end

  it "avarohana should have a minimum length of five" do
    invalid_avarohana_ragam = Factory.build(:ragam, :avarohana => "ma ga re sa")
    invalid_avarohana_ragam.valid?.should be_false
    invalid_avarohana_ragam.errors.full_messages.to_sentence.should == "Avarohana should have atleast 5 swaras"
  end

  describe "named scope" do

    before(:each) do
      @a_ragam = Factory(:ragam, :name => "a", :arohana => "a b c d e f")
      @aa_ragam = Factory(:ragam, :name => "aa", :arohana => "b a c d e f")
      @b_ragam = Factory(:ragam, :name => "b", :arohana => "c a b d e f")
      @bb_ragam = Factory(:ragam, :name => "bb", :arohana => "d a b c e f")
    end

    it "should suggest all" do
      suggested_ragam = Ragam.suggest_by_name("")
      suggested_ragam.count.should == 4
      suggested_ragam.should == [@a_ragam, @aa_ragam, @b_ragam, @bb_ragam]
    end

    it "should suggest by name" do
      suggested_ragam = Ragam.suggest_by_name("a")
      suggested_ragam.count.should == 2
      suggested_ragam.should == [@a_ragam, @aa_ragam]
    end

  end

end
