class PagesController < ApplicationController
  before_action :set_page, only: [:show]
  # layout "public"
  
  def home
    @page = Page.find(1)
    render :show
  end

  def show
    not_found if @page.published == false &&  !admin_signed_in?
    redirect_to_good_slug(@page) and return if bad_slug?(@page)
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

end
