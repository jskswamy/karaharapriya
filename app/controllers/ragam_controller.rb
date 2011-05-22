class RagamController < ApplicationController

  def create
    Ragam.create!(:name => params[:name], :arohana => params[:arohana], :avarohana => params[:avarohana])
  end

  def suggest
    render :partial => "common/suggest", :locals => { :suggestions => Ragam.suggest_by_name(params[:name]), :name => "ragam"}
  end

end
