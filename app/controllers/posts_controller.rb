class PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
    not_found if @post.published == false && !admin_signed_in?
    redirect_to_good_slug(@post) and return if bad_slug?(@post)
  end
  
  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    else
      @posts = Post.where( published: true ).order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    end
  end
end
