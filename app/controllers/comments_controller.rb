class CommentsController < ApplicationController
	before_action :authenticate_user!
	def new
		@post = Post.new
	end

	def create
	  @post = Post.find(params[:post_id])
	  @comment = @post.comments.create(comment_params)
	  @comment.user_id = current_user.id #or whatever is you session name
	  if @comment.save
	    respond_to do |format|
	      format.html { redirect_to @post }
	      format.js
    	end
	  else
	    flash.now[:danger] = "error"
	  end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
