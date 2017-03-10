class LikesController < ApplicationController
	before_action :authenticate_user!

  def create
  	@post = Post.find(params[:post_id])
    current_user.like(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end
end
