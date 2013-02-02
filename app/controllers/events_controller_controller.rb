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

  		@event = Event.find(params[:id])
  		User.create(:username => "JackLot", :email => "echoninja110@gmail.com", :password => "Devteam1")
  		@u = User.where(:email => "echoninja110@gmail.com")
  		Calendar.create(:name => "JCal", :user_id => @u)

  		@currentCal = Calendar.first

  		if @currentCal.events.where(:name => @event.name, :start_time => @event.start_time).size == 0	
  			@currentCal.events << @event
  		end

  		@cEvents = @currentCal.events

  	end

end
