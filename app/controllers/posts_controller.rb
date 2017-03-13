class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :show]
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

	def show
		@post = Post.find(params[:id])
		@comment = Comment.new
	end
	
	def feed
		if user_signed_in?
			user = current_user
			@posts = Post.where("user_id IN (?) OR user_id = ?", 
													user.following_ids, user.id).order('created_at DESC')
		else
			@posts = Post.all.sort_by{rand}.slice(0,20)
		end
		respond_to do |format|
      format.html
      format.js
    end
	end

	def recommended
		@posts = Post.all.sort_by{rand}.slice(0,20)
	end

	private
	def post_params
		params.require(:post).permit(:description, :image)
	end
end
