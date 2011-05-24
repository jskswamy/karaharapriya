class ComposerController < ApplicationController

  def suggest
    render :partial => "common/suggest", :locals => { :suggestions => Composer.suggest_by_name(params[:name]), :name => "composer" }
  end

end
