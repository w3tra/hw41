class PostsController < ApplicationController
	before_action :authenticate_user!
	def new
		@post = Post.new
	end

	def create
		@user = current_user
		@post = @user.posts.build(post_params)
		if @post.save
			redirect_to @user
		else
			render 'new'
		end
	end
	
	private
	def post_params
		params.require(:post).permit(:description, :image)
	end
end
