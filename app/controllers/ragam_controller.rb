class RagamController < ApplicationController

  def create
    Ragam.create!(:name => params[:name], :arohana => params[:arohana], :avarohana => params[:avarohana])
  end

  def suggest
    @ragams = Ragam.suggest_by_name(params[:name])
    render :partial => "suggest"
  end

end
