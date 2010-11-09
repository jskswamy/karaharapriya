require 'spec_helper'

describe Composer do

  it "should not create composer without name" do
    some_composer = Factory.build(:composer, :name => nil)
    some_composer.valid?.should == false
  end

end
