class Event < ActiveRecord::Base
	
	belongs_to :user

	validates :name, :presence => true
	validates :start_time, :presence => true
	validates :end_time, :presence => true
	validates :description, :presence => true
	validates :organization, :presence => true

end
