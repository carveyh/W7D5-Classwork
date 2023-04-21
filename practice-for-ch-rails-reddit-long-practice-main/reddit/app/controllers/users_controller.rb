class UsersController < ApplicationController
	before_action :require_logged_in, only: [:show]
	
	def new
		@user = User.new
		render :new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			login!(@user)
			redirect_to 
			# redirect_to "https://google.com", allow_other_host: true
		else
			flash.now[:errors] = @user.errors.full_messages
			# @user = User.new()
			render :new
		end
	end

	# def show
	# end

	private
	
	def user_params
		params.require(:user).permit(:username, :password)
	end

end
