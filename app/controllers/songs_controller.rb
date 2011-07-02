class SongsController < AuthenticatableController

  before_filter :load_song_types, :only => [:new, :edit]
  before_filter :load_song, :only => [:edit, :update, :show]
  before_filter :remove_first_class_params, :only => [:create, :update]

  def index
    @songs = Song.includes(:ragam, :talam, :composer).all
  end

  def new
    @song = Song.new
  end

  def create
    song = Song.create(params[:song])
    render_custom_response RemoteResponse.new(song, songs_path)
  end

  def update
    @song.update_attributes(params[:song])
    render_custom_response RemoteResponse.new(@song, songs_path)
  end

  private

  def remove_first_class_params
    [:composer,:ragam,:talam].each {|key| params[:song].delete(key)}
  end

  def load_song_types
    @song_types = SongType.all
  end

  def load_song
    @song = Song.find_by_translated_field("name", params[:id])
  end

end
