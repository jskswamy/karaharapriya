require 'spec_helper'

describe "ragam routes" do

  it "should route to index" do
     {:get => "/ragams"}.should route_to(:controller => "ragams", :action => "index")
  end

  it "should route to new" do
     {:get => "/ragams/new"}.should route_to(:controller => "ragams", :action => "new")
  end

  it "should route to create" do
     {:post => "/ragams"}.should route_to(:controller => "ragams", :action => "create")
  end

  it "should route to edit" do
     {:get => "/ragams/1/edit"}.should route_to(:controller => "ragams", :action => "edit", :id => "1")
  end

  it "should route to update" do
     {:put => "/ragams/1"}.should route_to(:controller => "ragams", :action => "update", :id => "1")
  end

  it "should route to show" do
    {:get => "/ragams/1"}.should route_to(:controller => "ragams", :action => "show", :id => "1")
  end

end
