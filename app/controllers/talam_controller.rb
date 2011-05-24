class TalamController < ApplicationController

  def suggest
    render :partial => "common/suggest", :locals => { :suggestions => Talam.suggest_by_name(params[:name]), :name => "talam" }
  end

end
