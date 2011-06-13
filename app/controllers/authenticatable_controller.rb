class AuthenticatableController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :suggest]

end
