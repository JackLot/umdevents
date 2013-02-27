class UsersControllerController < ApplicationController

  def new
  	@user = User.new
  end

  def create

  	@user = User.new(params[:user])

  	if @user.save
  		redirect_to root_path
  	else
  		redirect_to '/signup'
      #render new
  	end

  end

  def login

  end

end
