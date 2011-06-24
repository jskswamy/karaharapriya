class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def render_custom_response remote_response
    has_errors = remote_response.errors.present?
    render :json => {:redirect_url => remote_response.redirect_url} and return unless has_errors
    head :bad_request, "X-JSON" => {:model_name => remote_response.model_name, :errors => remote_response.errors}.to_json
  end

end
