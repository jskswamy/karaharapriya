class RagamController < ApplicationController

  def create
    Ragam.create!(:name => params[:name], :arohana => params[:arohana], :avarohana => params[:avarohana])
  end

  def suggest
    @ragams = Ragam.find(:all, :conditions => ['name like %?%', ""])
    render :partial => "suggest"
  end

end
