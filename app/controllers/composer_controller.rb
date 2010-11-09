class ComposerController < ApplicationController

  def suggest
    @composers = Composer.find(:all, :conditions => ['name like ?', "%#{params[:name]}%"]);
    render :partial => "suggest"
  end

end
