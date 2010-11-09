class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def new
    @song_types = SongType.ascending
    @ragams = Ragam.all
    @talams = Talam.all
  end

  def create
    song_contents = params["song_contents"].values.collect{|song_content| SongContent.new(song_content)} unless params["song_contents"].blank?
    @song = Song.new(params["song"])
    if @song.save
      @song.song_contents << song_contents
      render :text => "Song saved successfully"
    else
      response.headers['ResponseType'] = 'ValidationErrors'
      render :text => @song.errors.full_messages.to_sentence
    end
  end

  def editor
    song_type = SongType.find_by_id(params["song_type_id"])
    p song_type.inspect
    unless song_type.nil?
      @song_compositions = song_type.song_compositions
      render :partial => "editor"
    else
      render :partial => "create_instruction"
    end
  end

end
