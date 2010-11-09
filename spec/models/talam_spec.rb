require 'spec_helper'

describe Talam do

  it "should calculate the aksharam length based on avartanam and default laghu length" do
    aathi_talam = Factory(:talam, :avartanam => "1 0 0", :laghu_length => 4)
    aathi_talam.total_aksharam_length.should == 8
  end

  it "should not create if avartanam does not contain a valid character" do
    random_talam = Factory.build(:talam, :avartanam => "1 U N 0", :laghu_length => 4)
    random_talam.valid?.should be_false
  end

  it "should not create if the talam name already exists" do
    random_talam = Factory(:talam, :name => "some talam")
    another_talam = Factory.build(:talam, :name => "some talam", :avartanam => "0 1")
    another_talam.valid?.should be_false
    another_talam.errors.full_messages.to_sentence.should == "Name has already been taken"
  end

  pending "shoult not create if the avartanam and length are already assigned to another talam" do
    random_talam = Factory(:talam, :name => "random talam", :avartanam => "1 0 0", :laghu_length => 4)
    duplicate_random_talam = Factory.build(:talam, :name => "another random talam", :avartanam => "1 0 0", :laghu_length => 4)
    someother_random_talam = Factory.build(:talam, :name => "someother random talam", :avartanam => "1 0 0", :laghu_length => 3)
    duplicate_random_talam.valid?.should be_false
    someother_random_talam.valid?.should be_true
  end

end
