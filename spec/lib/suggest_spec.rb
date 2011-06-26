require 'spec_helper'

class DummySuggestModuleIncludedClass

  def self.scope *args
    @@scope ||= []
    @@scope << {:method_name => args[0], :block => args[1]}
  end

  include Suggest

  def self.get_scope method_name
    @@scope.find { |scope| scope[:method_name] == method_name }
  end

end

describe Suggest do

  it "should add suggest_by_name as named scope" do
    DummySuggestModuleIncludedClass.should_receive(:where).with({"name" => /matching text/i})
    scope = DummySuggestModuleIncludedClass.get_scope :suggest_by_name

    scope.should_not be_nil
    scope[:method_name].should == :suggest_by_name
    scope[:block].call("matching text")
  end

end
