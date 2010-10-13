class RagamController < ApplicationController

  def create
    Ragam.create!(:name => params[:name], :arohana => params[:arohana], :avarohana => params[:avarohana])
  end

end
