class User < ActiveRecord::Base

	has_many :events

	validates :username, :presence => true
	validates :email, :presence => true
	validates :password, :presence => true
	
end
