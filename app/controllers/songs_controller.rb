class SongsController < ApplicationController

  def index
    @songs = Song.all
  end

  def new
    @song_types = SongType.ascending
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
    @song_compositions = SongComposition.includes(:song_content_type).find_all_by_song_type_id(params["song_type_id"])
    unless @song_compositions.empty?
      render :partial => "editor", :locals => { :song_compositions => @song_compositions }
    else
      render :partial => "create_instruction"
    end
  end

end
