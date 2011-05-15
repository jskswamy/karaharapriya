class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def get_objectId param
    param.blank? ? param : BSON::ObjectId(param)
  end

end
