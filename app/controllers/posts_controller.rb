class PagesController < ApplicationController
  before_action :set_post, only: [:show]
  # layout "public"
  
  def home
    @post = Post.find(1)
    render :show
  end

  def show
    not_found if @post.published == false && !admin_signed_in?
    redirect_to_good_slug(@post) and return if bad_slug?(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end
end
