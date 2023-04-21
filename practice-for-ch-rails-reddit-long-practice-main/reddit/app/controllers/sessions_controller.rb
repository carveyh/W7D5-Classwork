class SessionsController < ApplicationController
	before_action :require_logged_in, only: [:destroy]
	
	def new #log in
		@user = User.new
		render :new
	end
	
	def create
		username = params[:user][:username]
		password = params[:user][:password]
		@user = User.find_by(username: username) #such username exists
		if @user && @user.is_password?(password)
			login!(@user)
			redirect_to subs_url
		else
			@user = User.new(username: username)
			# flash.now[:errors] = @user.errors.full_messages #Can't do this if @user is nil due to no user by that username!
			flash.now[:errors] = ['Invalid username or password'] #must be array form
			render :new
		end
	end

	def destroy
		logout!
		redirect_to new_session_url
	end

end
