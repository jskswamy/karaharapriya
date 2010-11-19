class TalamController < ApplicationController

  def suggest
    @talams = Talam.suggest_by_name(params[:name]);
    render :partial => "suggest"
  end

end
