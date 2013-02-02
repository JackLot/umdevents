class Event < ActiveRecord::Base
	
	belongs_to :user
	has_and_belongs_to_many :calendars

	validates :name, :presence => true
	validates :start_time, :presence => true
	validates :end_time, :presence => true
	validates :description, :presence => true
	validates :organization, :presence => true

	validates :name, :uniqueness => {:scope => :start_time}

	def parse_ICal(url)

		# Read the mens basketball schedule
		require 'open-uri'
		require 'net/http'
		uri = URI(url)
		file = Net::HTTP.get(uri).to_s

		return Icalendar.parse(@file)

	end

	def create_event(name, description, start_time, end_time, organization, location)
		Event.create(
				:name => name,
				:description => description,
				:start_time => start_time,
				:end_time => end_time,
				:organization => organizagtion,
				:location => location
			)
	end

end
