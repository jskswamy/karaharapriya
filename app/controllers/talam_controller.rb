class TalamController < ApplicationController

  def suggest
    @talams = Talam.find(:all, :conditions => ['name like ?', "%#{params[:name]}%"]);
    render :partial => "suggest"
  end

end
