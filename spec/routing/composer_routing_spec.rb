require "spec_helper"

describe "composer routes" do

  it "should route to index" do
     {:get => "/composers"}.should route_to(:controller => "composers", :action => "index")
  end

  it "should route to new" do
     {:get => "/composers/new"}.should route_to(:controller => "composers", :action => "new")
  end

  it "should route to create" do
     {:post => "/composers"}.should route_to(:controller => "composers", :action => "create")
  end

  it "should route to edit" do
     {:get => "/composers/1/edit"}.should route_to(:controller => "composers", :action => "edit", :id => "1")
  end

  it "should route to update" do
     {:put => "/composers/1"}.should route_to(:controller => "composers", :action => "update", :id => "1")
  end

  it "should route to show" do
    {:get => "/composers/1"}.should route_to(:controller => "composers", :action => "show", :id => "1")
  end

end
