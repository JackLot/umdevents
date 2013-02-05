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

		Event.create(
				:name => "Join Maryland Images Spring 2013",
				:description => "Do you love Maryland?
Do you love to hear yourself talk?
Do you love making new friends?
Do you love when people laugh at your punny jokes?
Do you want to know lots of interesting Maryland Facts?

If you answered yes to any one of these questions, then you are meant to be a member of Maryland Images, an Official University of Maryland Tour Guide! 

JOIN MARYLAND IMAGES!

APPLICATIONS ARE DUE FEBRUARY 14TH AT 5:00PM Eastern Standard Time

APPLY HERE: https://docs.google.com/spreadsheet/viewform?formkey=dEVDTmRFdF91RnFlc2xha29PUFFNTFE6MQ#gid=0 

Stop by StampFest on Thursday, February 7th anytime from 10am to 4pm! Find our table (it will be the one with the TOUR-ific poster and tons of cool people behind it) and find out more about what it means to be a tour guide at Maryland!

Want even more info and fun? Come to our 'Images, Ice Cream, and Information' sessions! Attend either one of these meetings to get filled in on more of the awesomeness that is Maryland Images. ",
				:start_time => Time.new,
				:end_time => Time.new,
				:organization => "UMD Stamp",
				:location => "Cambridge Community Center Room 1111"
			)

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
