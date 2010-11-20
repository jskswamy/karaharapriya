require 'spec_helper'

describe "common/suggest.html.erb" do

  before(:each) do
    @suggestions = []
    3.times.each do |index|
      @suggestions << OpenStruct.new({ :id => index, :name => "suggestion#{index}" })
    end
  end

  it "should render the ragam as list" do
    render :partial => "suggest", :locals => {:suggestions => @suggestions}
    @suggestions.each do |suggestion|
      rendered.should have_selector("ul > li[id='#{suggestion.id}'] > a", :content => suggestion.name)
    end
  end

end
