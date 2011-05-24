module ApplicationHelper

  def auto_complete options
    render :partial => 'common/auto_complete', :locals => options
  end

end
