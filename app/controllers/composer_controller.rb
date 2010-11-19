class ComposerController < ApplicationController

  def suggest
    @composers = Composer.suggest_by_name(params[:name]);
    render :partial => "suggest"
  end

end
