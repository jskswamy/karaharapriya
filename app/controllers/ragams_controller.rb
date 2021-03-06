class RagamsController < AuthenticatableController

  before_filter :remove_first_class_params, :only => [:create, :update]
  before_filter :load_ragam, :only => [:edit, :update, :show]

  def index
    @ragams = Ragam.includes(:parent).all
  end

  def show
  end

  def new
    @ragam = Ragam.new
  end

  def create
    ragam = Ragam.create(params[:ragam])
    render_custom_response RemoteResponse.new(ragam, ragams_path)
  end

  def update
    @ragam.update_attributes(params[:ragam])
    render_custom_response RemoteResponse.new(@ragam, ragams_path)
  end

  def suggest
    render :partial => "common/suggest", :locals => { :suggestions => Ragam.suggest_by_name(params[:name]), :name => "ragam"}
  end

  private

  def remove_first_class_params
    [:parent].each {|key| params[:ragam].delete(key)}
  end

  def load_ragam
    @ragam = Ragam.find_by_translated_field("name", params[:id])
  end

end
