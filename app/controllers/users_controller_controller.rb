class UsersControllerController < ApplicationController

  def new
  	@user = User.new
  end

  def create

    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      redirect_to root_path, :flash => {:success => "Successfully created acount!"}
    else
      render 'new', :flash => {:error => "Problems"}
    end
    
  end

  def show
    @user = User.find(params[:id])
  end

end
