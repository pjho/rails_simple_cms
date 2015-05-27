class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all
  end


  def home
    @page = Page.find(1)
    render :show
  end

  def show
    # @page = Page.find(params[:id])
    redirect_to_good_slug(@page) and return if bad_slug?(@page)
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

      if @page.save
        redirect_to @page, notice: 'Page was successfully created.'
      else
        render :new
      end
  end

  def update
      if @page.update(page_params)
        redirect_to @page, notice: 'Page was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @page.destroy
      redirect_to pages_url, notice: 'Page was successfully destroyed.'
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :slug, :content, :published)
    end
end