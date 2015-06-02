class PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
    not_found if @post.published == false && !admin_signed_in?
    redirect_to_good_slug(@post) and return if bad_slug?(@post)
  end
  
  def index
    @posts = Post.where( published: true )
  end
end
