require 'spec_helper'

describe Ragam do

  it "should not have duplicate name" do
    mohana_ragam = Factory(:ragam, :name => "mohanam")
    another_mohana_ragam = Factory.build(:ragam, :name => "mohanam", :arohana => "sa re2 ga2 ma")
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

end
