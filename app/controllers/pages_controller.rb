class PagesController < ApplicationController
    
  def show
    @page = Page.find(params[:id])
    not_found if @page.published == false &&  !admin_signed_in?
    redirect_to_good_slug(@page) and return if bad_slug?(@page)
  end

end
