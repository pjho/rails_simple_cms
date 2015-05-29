class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }
  
  # Check if the current slug is not the cannonical one.
  def bad_slug?(object)
    params[:id] != object.to_param
  end

  # 301 redirect to canonical slug.
  def redirect_to_good_slug(object)
    redirect_to controller: controller_name, action: params[:action], id: object.to_param, status: 301
  end


  # Throw 404 page
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


  def after_sign_in_path_for(resource)
    cms_path
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def authenticate_admin!
    if admin_signed_in?
      super
    else
      redirect_to root_path, 
        notice: %Q[ You need to sign in to perform that action. #{view_context.link_to "Sign In", new_admin_session_path}.],
        flash: { html_safe: true }
    end
  end
end
