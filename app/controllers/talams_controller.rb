class TalamsController < ApplicationController

  before_filter :load_talam, :only => [:edit, :update]

  def index
    @talams = Talam.all
  end

  def new
    @talam = Talam.new
  end

  def create
    talam = Talam.create(params[:talam])
    render_custom_response RemoteResponse.new(talam, talams_path)
  end

  def update
    @talam.update_attributes(params[:talam])
    render_custom_response RemoteResponse.new(@talam, talams_path)
  end

  def suggest
    render :partial => "common/suggest", :locals => { :suggestions => Talam.suggest_by_name(params[:name]), :name => "talam" }
  end

  private

  def load_talam
    @talam = Talam.first(:conditions => {:name => params[:id]})
  end

end
