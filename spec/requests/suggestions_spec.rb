require 'spec_helper'

describe "Suggestions" do

  before(:each) do
    @names = ["a", "aa", "b", "bb", "c", "cc"]
  end

  describe "ragam" do

    before(:each) do
      @ragams = []
      @names.each { |ragam_name| @ragams << Factory(:ragam, :name => ragam_name) }
    end

    it "should suggest all the ragams" do
      get suggest_ragam_path
      @ragams.each do |ragam|
        response.should have_selector("ul > li[id='#{ragam.id}'] > a", :content => ragam.name)
      end
    end

    it "should suggest ragams with character 'a' in it" do
      get suggest_ragam_path, :name => "a"
      @ragams.each do |ragam|
        if ragam.name.include?("a")
          response.should have_selector("ul > li[id='#{ragam.id}'] > a", :content => ragam.name)
        else
          response.should_not have_selector("ul > li[id='#{ragam.id}'] > a", :content => ragam.name)
        end
      end
    end

  end

  describe "talam" do

    before(:each) do
      @talams = []
      @names.each { |talam_name| @talams << Factory(:talam, :name => talam_name) }
    end

    it "should suggest all the talams" do
      get suggest_talam_path
      @talams.each do |talam|
        response.should have_selector("ul > li[id='#{talam.id}'] > a", :content => talam.name)
      end
    end

    it "should suggest ragams with character 'b' in it" do
      get suggest_talam_path, :name => "b"
      @talams.each do |talam|
        if talam.name.include?("b")
          response.should have_selector("ul > li[id='#{talam.id}'] > a", :content => talam.name)
        else
          response.should_not have_selector("ul > li[id='#{talam.id}'] > a", :content => talam.name)
        end
      end
    end

  end

  describe "composer" do

    before(:each) do
      @composers = []
      @names.each { |composer_name| @composers << Factory(:composer, :name => composer_name) }
    end

    it "should suggest all the composers" do
      get suggest_composer_path
      @composers.each do |composer|
        response.should have_selector("ul > li[id='#{composer.id}'] > a", :content => composer.name)
      end
    end

    it "should suggest ragams with character 'b' in it" do
      get suggest_composer_path, :name => "c"
      @composers.each do |composer|
        if composer.name.include?("c")
          response.should have_selector("ul > li[id='#{composer.id}'] > a", :content => composer.name)
        else
          response.should_not have_selector("ul > li[id='#{composer.id}'] > a", :content => composer.name)
        end
      end
    end

  end

end
