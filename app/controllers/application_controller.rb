class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # Check if the current slug is not the cannonical one.
  def bad_slug?(object)
    params[:id] != object.to_param
  end

  ##
  # 301 redirect to canonical slug.
  def redirect_to_good_slug(object)
    redirect_to controller: controller_name, action: params[:action], id: object.to_param, status: 301
  end

  protect_from_forgery with: :exception
end
