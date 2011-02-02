class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def new
    @song_types = SongType.ascending
  end

  def create
    song_contents = params["song_contents"].blank? ? [] : params["song_contents"].values
    @song = Song.new(params["song"])
    @song.save_with_contents(song_contents)
    render :json => RemoteResponse.new(@song, songs_path)
  end

  def editor
    @song_type = SongType.includes(:song_compositions => [:song_content_type]).find_by_id(params[:song_type_id])
    @song_compositions = @song_type.song_compositions unless @song_type.nil?
    unless @song_compositions.blank?
      render :partial => "editor", :locals => { :song_type => @song_type.name, :song_compositions => @song_compositions }
    else
      render :partial => "create_instruction"
    end
  end

end
