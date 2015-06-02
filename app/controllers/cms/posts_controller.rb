class Cms::PostsController < CmsController
  before_action :set_post, only: [:edit, :update, :destroy]
#  before_action :authenticate_admin!
  # layout "cms"
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

      if @post.save
        redirect_to edit_cms_post_path(@post), notice: 'Post was successfully created.'
      else
        render :new
      end
  end

  def update
      if @post.update(post_params)
        redirect_to edit_cms_post_path(@post), notice: 'Post was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @post.destroy
      redirect_to cms_posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :slug, :content, :published)
    end
end
