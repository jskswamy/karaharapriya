class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
    @song_types = SongType.all
  end

  def create
    song_params = params[:song]
    [:composer,:ragam,:talam].each {|key| song_params.delete(key)}
    @song = Song.create(song_params)
    render :json => RemoteResponse.new(@song, songs_path)
  end

  def editor
    render :partial => "editor", :locals => {:index => params[:index]}
  end

end
