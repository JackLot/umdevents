class User < ActiveRecord::Base

	has_many :events
	has_one :calendar, :foreign_key => 'user_id'

	attr_accessible :email, :username, :password, :password_confirmation
	has_secure_password

	before_save { |user| user.email = user.email.downcase }
	before_save :create_remember_token


	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[\w+\-.]+\.[a-z]+\z/i

	validates :username, :presence => true, :length => { maximum: 50 }

	validates :email, :presence => true, :format => { :with => VALID_EMAIL_REGEX }, 
		:uniqueness => { :case_sensitive => false}

	validates :password, :presence => true
	validates :password_confirmation, :presence => true


	private
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
	
end
