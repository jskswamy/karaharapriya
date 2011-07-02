require 'spec_helper'

describe "talam routes" do

  it "should route to index" do
     {:get => "/talams"}.should route_to(:controller => "talams", :action => "index")
  end

  it "should route to new" do
     {:get => "/talams/new"}.should route_to(:controller => "talams", :action => "new")
  end

  it "should route to create" do
     {:post => "/talams"}.should route_to(:controller => "talams", :action => "create")
  end

  it "should route to edit" do
     {:get => "/talams/1/edit"}.should route_to(:controller => "talams", :action => "edit", :id => "1")
  end

  it "should route to update" do
     {:put => "/talams/1"}.should route_to(:controller => "talams", :action => "update", :id => "1")
  end

  it "should route to show" do
    {:get => "/talams/1"}.should route_to(:controller => "talams", :action => "show", :id => "1")
  end

end
