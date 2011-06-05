require 'spec_helper'

describe Talam do

  describe "Validations" do

    it "should calculate the aksharam length based on avartanam and default laghu length" do
      aathi_talam = Factory(:talam, :avartanam => "1 0 0", :laghu_length => 4)
      aathi_talam.total_aksharam_length.should == 8
    end

    it "should not create talam without name" do
      talam = Factory.build(:talam, :name => nil)
      talam.save
      talam.valid?.should be_false
      talam.errors.full_messages.to_sentence.should == "Name can't be blank"
    end

    it "should not create talam without avartanam" do
      talam = Factory.build(:talam, :avartanam => nil)
      talam.save
      talam.valid?.should be_false
      talam.errors.full_messages.to_sentence.should == "Avartanam can't be blank"
    end

    it "should not create talam without laghu_length" do
      talam = Factory.build(:talam, :laghu_length => nil)
      talam.save
      talam.valid?.should be_false
      talam.errors.full_messages.to_sentence.should == "Laghu length can't be blank"
    end

    it "should not create talam without description" do
      talam = Factory.build(:talam, :description => nil)
      talam.save
      talam.valid?.should be_false
      talam.errors.full_messages.to_sentence.should == "Description can't be blank"
    end

    it "should not create if the talam name already exists" do
      random_talam = Factory(:talam, :name => "some talam")
      another_talam = Factory.build(:talam, :name => "some talam")
      another_talam.save
      another_talam.valid?.should be_false
      another_talam.errors.full_messages.to_sentence.should == "Name is already taken"
    end

    it "shoult not create if the avartanam and length are already assigned to another talam" do
      random_talam = Factory(:talam, :name => "random talam", :avartanam => "1 0 0", :laghu_length => 4)
      duplicate_random_talam = Factory.build(:talam, :name => "another random talam", :avartanam => "1 0 0", :laghu_length => 4)
      someother_random_talam = Factory.build(:talam, :name => "someother random talam", :avartanam => "1 0 0", :laghu_length => 3)
      duplicate_random_talam.valid?.should be_false
      duplicate_random_talam.errors.full_messages.to_sentence.should == "Laghu length is already taken"
      someother_random_talam.valid?.should be_true
    end

    it "should not create if the avartam has invalid characters" do
      talam = Factory.build(:talam, :avartanam => "1 U N M")
      talam.save
      talam.errors.full_messages.to_sentence.should == "Avartanam has invalid character"
    end
  end

  it "to_param should return name" do
    talam = Factory(:talam, :name => "Adi")
    talam.to_param.should == "Adi"
  end

  describe "named scope" do

    before(:each) do
      @a_talam = Factory(:talam, :name => "a")
      @aa_talam = Factory(:talam, :name => "aa")
      @b_talam = Factory(:talam, :name => "b")
      @bb_talam = Factory(:talam, :name => "bb")
    end

    it "should get all the talams" do
      all_talam = [@a_talam, @aa_talam, @b_talam, @bb_talam]
      suggested_talam = Talam.suggest_by_name("").to_a
      suggested_talam.count.should == 4
      suggested_talam.each {|talam| all_talam.include?(talam).should be_true}
    end

    it "should find talam by name" do
      suggested_talam = Talam.suggest_by_name("a")
      suggested_talam.count.should == 2
      suggested_talam.should == [@a_talam, @aa_talam]
    end

  end

end
