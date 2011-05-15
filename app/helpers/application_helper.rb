module ApplicationHelper

  def auto_complete options
    render :partial => 'common/auto_complete', :locals => {:label => options[:label], :field_name => options[:field_name], :name => options[:name], :url => options[:url]}
  end

end
