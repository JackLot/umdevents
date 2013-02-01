class EventsControllerController < ApplicationController

	def new

	end
	
	def index

		# Read the mens basketball schedule
		require 'open-uri'
		require 'net/http'
		uri = URI('http://www.umterps.com/ot/2012_MD_MBB.ics')
		@file = Net::HTTP.get(uri).to_s
		@cal = Icalendar.parse(@file)

		#This works but on every refresh it creates a new event instance. Also if any field
		#is incorrect then the whole event doesnt insert

		@cal.first.events.each do |event|

			Event.create(
				:name => event.summary,
				:description => "Mens Basketball",
				:start_time => event.dtstart,
				:end_time => event.dtend,
				:organization => "UMD Athletics",
				:location => event.location
			)

		end

	end

  	def show

  		

  	end

end
