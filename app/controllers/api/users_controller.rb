class Api::UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		render json: @user
	end

	def index
		@users = User.all
		render json: @users
	end

end
