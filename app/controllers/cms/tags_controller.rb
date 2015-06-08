class Cms::TagsController < CmsController
  before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all.order('name').paginate(:page => params[:page], :per_page => 20)
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.js
    end
  end


  def css
    respond_to do |format|
      if Tag.generateTagCss
        format.json { render json: nil, status: :ok }
      else
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end


  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name,:color)
    end
end
