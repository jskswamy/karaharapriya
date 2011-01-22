module SongsHelper

  def editor options, &block
    render :partial => 'common/song_editor', :locals => {:url => options[:url], :song_type => options[:song_type], :body => capture(&block), :class_name => options[:class]}
  end

end
