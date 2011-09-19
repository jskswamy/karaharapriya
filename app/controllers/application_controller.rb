class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_user_navigation

  private

  def load_user_navigation
    @user_menu_items = []
    load_logged_in_user_menu_items unless current_user.nil?
  end

  def render_custom_response remote_response
    has_errors = remote_response.errors.present?
    render :json => {:redirect_url => remote_response.redirect_url} and return unless has_errors
    head :bad_request, "X-JSON" => {:model_name => remote_response.model_name, :errors => remote_response.errors}.to_json
  end

  def load_logged_in_user_menu_items
    @user_menu_items << {:key => :user, :name => current_user.name, :url => "/#{current_user.name}", :highlight_on => /\/#{current_user.name}/}
    @user_menu_items << {:key => :dashboard, :name => "Dashboard", :url => root_path, :highlight_on => /\//}
    @user_menu_items << {:key => :account_settings, :name => "Account Settings", :url => edit_user_registration_path, :highlight_on => /\/users\/edit/}
    @user_menu_items << {:key => :translate, :name => "Translate", :url => "/translate", :highlight_on => /\/users\/edit/}
    @user_menu_items << {:key => :logout, :name => "Logout", :url => destroy_user_session_path}
    @user_menu_items.last.merge!(:options => {:class => "last"})
  end

end
