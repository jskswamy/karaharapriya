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

end
