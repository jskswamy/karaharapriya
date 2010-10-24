class SongsController < ApplicationController

  def new
    @song_types = SongType.all
    @composers = Composer.all
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
    @song_compositions = SongType.find(params["song_type_id"]).song_compositions
    render :partial => "editor"
  end

  private

  def load_data
  end

end
