class SongsController < ApplicationController

  def new
    @song_types = SongType.all.collect(&:name).sort
    @composers = Composer.all.collect(&:name).sort
  end

  def editor
    @song_compositions = SongType.find_by_name(params[:song_type]).song_compositions
    render :partial => "editor"
  end

end
