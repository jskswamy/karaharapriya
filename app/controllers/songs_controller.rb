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
    song_params[:composer] = Composer.find(:first, :conditions => {:id => get_objectId(params[:composer_id])})
    song_params[:ragam] = Ragam.find(:first, :conditions => {:id => get_objectId(params[:ragam_id])})
    song_params[:talam] = Talam.find(:first, :conditions => {:id => get_objectId(params[:talam_id])})
    @song = Song.create(song_params)
    render :json => RemoteResponse.new(@song, songs_path)
  end

  def editor
    render :partial => "editor", :locals => {:index => params[:index]}
  end

end
