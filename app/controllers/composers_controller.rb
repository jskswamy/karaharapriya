class ComposersController < AuthenticatableController

  before_filter :load_composer, :only => [:edit, :update, :show]

  def index
    @composers = Composer.all
  end

  def new
    @composer = Composer.new
  end

  def create
    composer = Composer.create(params[:composer])
    render_custom_response RemoteResponse.new(composer, composers_path)
  end

  def update
    @composer.update_attributes(params[:composer])
    render_custom_response RemoteResponse.new(@composer, composers_path)
  end

  def suggest
    render :partial => "common/suggest", :locals => { :suggestions => Composer.suggest_by_name(params[:name]), :name => "composer" }
  end

  private

  def load_composer
    @composer = Composer.find_by_translated_field("name", params[:id])
  end

end
