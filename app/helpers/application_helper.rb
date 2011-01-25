module ApplicationHelper

  def auto_complete options
    render :partial => 'common/auto_complete', :locals => {:label => options[:label], :name => options[:name], :url => options[:url]}
  end

end
