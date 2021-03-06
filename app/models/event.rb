class Event < ActiveRecord::Base
	
	belongs_to :user
	has_and_belongs_to_many :calendars
	acts_as_taggable
	scope :by_join_date, order("created_at DESC")

	validates :name, :presence => true
=begin
	validates :start_time, :presence => true
	validates :end_time, :presence => true
=end
	validates :description, :presence => true
	validates :organization, :presence => true
	validates :location, :presence => true

	validates :name, :uniqueness => true #{:scope => :start_time}

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

	def self.search(search)

		if search
			where('name LIKE ?', "%#{search}%").order("start_time DESC")
		else
			find(:all)
		end

	end

end
