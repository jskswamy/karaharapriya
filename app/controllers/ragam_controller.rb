class RagamController < ApplicationController

  def create
    Ragam.create!(:name => params[:name])
  end

end
