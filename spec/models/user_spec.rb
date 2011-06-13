require 'spec_helper'

describe User do

  describe "Validations" do

    it "should validate the presence of name" do
      user = Factory.build(:user, :name => nil)
      user.valid?.should be_false
      user.errors.full_messages.to_sentence.should == "Name can't be blank"
    end

    it "should not create user with duplicate name" do
      user = Factory(:user, :name => "someone")
      another_user = Factory.build(:user, :name => "someone")
      another_user.valid?.should be_false
      another_user.errors.full_messages.to_sentence.should == "Name is already taken"
    end

  end

end
