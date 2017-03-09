class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def edit
	end

	def update
	end

	def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render '_show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render '_show_follow'
  end

	private
	def user_params
		params.require(:user).permit(:name, :avatar)
	end
end