require 'spec_helper'

describe "song routes" do

  it "should route to index" do
     {:get => "/songs"}.should route_to(:controller => "songs", :action => "index")
  end

  it "should route to new" do
     {:get => "/songs/new"}.should route_to(:controller => "songs", :action => "new")
  end

  it "should route to create" do
     {:post => "/songs"}.should route_to(:controller => "songs", :action => "create")
  end

  it "should route to edit" do
     {:get => "/songs/1/edit"}.should route_to(:controller => "songs", :action => "edit", :id => "1")
  end

  it "should route to update" do
     {:put => "/songs/1"}.should route_to(:controller => "songs", :action => "update", :id => "1")
  end

end
