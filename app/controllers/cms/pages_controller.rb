class Cms::PagesController < CmsController
  before_action :set_page, only: [:edit, :update, :destroy]
  
  def index
    @pages = Page.all.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

      if @page.save
        redirect_to edit_cms_page_path(@page), notice: 'Page was successfully created.'
      else
        render :new
      end
  end

  def update
      if @page.update(page_params)
        redirect_to edit_cms_page_path(@page), notice: 'Page was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @page.destroy
      redirect_to cms_pages_url, notice: 'Page was successfully destroyed.'
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :slug, :content, :published)
    end
end
