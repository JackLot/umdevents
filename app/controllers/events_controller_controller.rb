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

		@firstEvent = @cal.first.events.first

		#This works but on every refresh it creates a new event instance. Also if any field
		#is incorrect then the whole event doesnt insert
		Event.create(
			:name => @firstEvent.summary, 
			:description => "Mens Basketball", 
			:start_time => @firstEvent.dtstart, 
			:end_time => @firstEvent.dtend, 
			:organization => "UMD Athletics")


	end

  	def show
  	end

end
