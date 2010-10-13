class SongsController < ApplicationController

  def new
    @song_types = ["Basic Lesson", "Geetham", "Varnam", "Swarajathi", "Keerthanai"].sort #SongType.all.collect(&:name)
  end

  def editor
    @song_compositions = SongType.find_by_name(params[:song_type]).song_compositions
  end

end
