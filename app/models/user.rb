class User < ActiveRecord::Base

	has_many :events
	has_one :calendar, :foreign_key => 'user_id'

	validates :username, :presence => true
	validates :email, :presence => true
	validates :password, :presence => true
	
	validates :email, :uniqueness => true


	def create_user(username, email, password)
		User.create(
			:username => username, 
			:email => email, 
			:password => password
		)
	end
end
