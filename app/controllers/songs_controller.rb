class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def new
    @song_types = SongType.all
    @composers = Composer.all
    @ragams = Ragam.all
    @talams = Talam.all
  end

  def create
    song_contents = params["song_contents"].values.collect{|song_content| SongContent.new(song_content)} unless params["song_contents"].blank?
    song = Song.new(params["song"])
    if song.save
      song.song_contents << song_contents
      render :text => "Successfully saved"
    else
      response.headers['ResponseType'] = "validationErrors"
      render :text => song.errors.full_messages.to_sentence
    end
  end

  def editor
    song_type = SongType.find_by_id(params["song_type_id"])
    unless song_type.nil?
      @song_compositions = song_type.song_compositions
      render :partial => "editor"
    else
      render :partial => "create_instruction"
    end
  end

end
