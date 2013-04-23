class Reminder < ActiveRecord::Base

	attr_accessible :type_of, :send_to, :event_id, :user_id, :date_to_send

	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[\w+\-.]+\.[a-z]+\z/i

	#validates :send_to, :presence => true, :format => { :with => VALID_EMAIL_REGEX }, 
	#	:uniqueness => { :case_sensitive => false}

	validates :type_of, :presence => true
	validates :date_to_send, :presence => true
	validates :event_id, :presence => true

end
