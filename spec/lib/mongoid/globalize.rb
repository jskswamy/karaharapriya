require 'spec_helper'

describe Mongoid::Globalize do

  class DummyGlobalizeModuleIncludedClass
    include Mongoid::Document
    include Mongoid::Globalize

    field :name
    field :age
    field :std
    field :school
    validates_uniqueness_of :name, :age
    validates_uniqueness_of :std
    translate :name, :std, :school
  end

  it "should respond to translated_fields" do
    expected_fields = {:name => {:unique => true}, :school => {:unique => false}, :std => {:unique => true}}
    DummyGlobalizeModuleIncludedClass.respond_to?(:translated_fields).should be_true
    translated_fields = DummyGlobalizeModuleIncludedClass.translated_fields
    translated_fields.count.should == 3
    translated_fields.each do |field|
      field_name = field[:name]
      expected_fields.keys.include?(field_name.to_sym).should be_true
      field[:unique].should == expected_fields[field_name.to_sym][:unique]
    end
  end

  it "should respond to find_by_translated_field" do
    DummyGlobalizeModuleIncludedClass.respond_to?(:find_by_translated_field).should be_true
  end

  it "should add translation to the underlying field" do
    globalize = DummyGlobalizeModuleIncludedClass.new
    globalize.name = "tom"
    field_value = globalize.attributes["name"]
    field_value.should_not be_nil
    field_value.should == {"en" => "tom"}
  end

  it "should retrive the translation value from the underlying field" do
    globalize = DummyGlobalizeModuleIncludedClass.new(:name => "tom")
    globalize.name.should_not be_nil
    globalize.name.should == "tom"
  end

  it "should override the transaltion" do
    globalize = DummyGlobalizeModuleIncludedClass.new(:name => "tom")
    globalize.name = "jerry"
    field_value = globalize.attributes["name"]
    field_value.should_not be_nil
    field_value.should == {"en" => "jerry"}
  end

  describe "add translation" do

    it "should add text to the specified language" do
      globalize = DummyGlobalizeModuleIncludedClass.new
      globalize.add_translation("name", "jerry", "ta")
      field_value = globalize.attributes["name"]
      field_value.should_not be_nil
      field_value.should == {"ta" => "jerry"}
    end

    it "should not add text if the field is not set for translation" do
      globalize = DummyGlobalizeModuleIncludedClass.new
      globalize.add_translation("age", 21)
      field_value = globalize.attributes["age"]
      field_value.should be_nil
    end

    pending "should retain the old value" do
      globalize = DummyGlobalizeModuleIncludedClass.create(:name => "tom", :age => 45, :std => "fourth", :school => "SMMS")
      globalize.name = "jerry"
      globalize.name_was.should == "tom"
    end

  end

  describe "get translation" do

    it "should get the text for the specified language" do
      globalize = DummyGlobalizeModuleIncludedClass.new(:name => "tom", :age => 45)
      globalize.add_translation("name","jerry","ta")
      globalize.get_translation("name").should == "tom"
      globalize.get_translation("name","ta").should == "jerry"
    end

    it "should be nil if the translation is not enabled for the field" do
      globalize = DummyGlobalizeModuleIncludedClass.new(:name => "tom", :age => 45)
      globalize.get_translation("age").should be_nil
    end

  end

  describe "find by translation" do

    it "should find the documnet by translation field" do
      globalize = DummyGlobalizeModuleIncludedClass.create(:name => "tom", :age => 45, :std => "fourth", :school => "SMMS")
      globalize = DummyGlobalizeModuleIncludedClass.create(:name => "jerry", :age => 44, :std => "fifth", :school => "School")
      actual_globalize = DummyGlobalizeModuleIncludedClass.find_by_translated_field("name", "jerry")
      actual_globalize.should_not be_nil
      actual_globalize.should == globalize
    end

  end

  describe "uniqueness" do

    it "should remove the mongoid uniqueness validation on the translation fields" do
      uniqueness_validators = DummyGlobalizeModuleIncludedClass.validators.select{|validator| validator.kind_of?(Mongoid::Validations::UniquenessValidator)}
      uniqueness_validators.count.should == 2
      unique_validator = uniqueness_validators.first
      unique_validator.attributes.should_not include :name
      unique_validator.attributes.should include :age
    end

    it "should be invalid if the translated field is not unique" do
      globalize = DummyGlobalizeModuleIncludedClass.create(:name => "tom", :age => 45, :std => "fourth", :school => "SMMS")
      duplicate_globalize = DummyGlobalizeModuleIncludedClass.new(:name => "tom", :age => 50, :std => "fifth", :school => "MHHS")
      duplicate_globalize.save.should be_false
      duplicate_globalize.valid?.should be_false
      duplicate_globalize.errors.full_messages.to_sentence.should == "Name is already taken"
    end

    it "should be able to update the own record without uniqueness constraint" do
      globalize = DummyGlobalizeModuleIncludedClass.create(:name => "tom", :age => 45, :std => "fourth", :school => "SMMS")
      globalize.update_attributes(:age => 50)
      globalize.save.should be_true
      globalize.valid?.should be_true
      globalize.errors.should be_blank
      actual_globalize = DummyGlobalizeModuleIncludedClass.find_by_translated_field("name","tom")
      actual_globalize.age.should == 50
    end

  end

end
