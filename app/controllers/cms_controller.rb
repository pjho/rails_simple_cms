class CmsController < ApplicationController
  before_action :authenticate_admin!
  layout "cms"

  def index
    
  end
end
