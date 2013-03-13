class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email])

		if user && user.authenticate(params[:session][:password])
			sign_in(user)
			redirect_to root_path, :flash => {:success => "Successfully logged in!"}
		else
			render 'new'
		end

	end

	def destroy
	end

end
