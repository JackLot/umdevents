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

	def send_password_reset

		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		self.save

		UserMailer.password_reset(self).deliver

	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	private
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
	
end
