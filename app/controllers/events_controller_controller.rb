class EventsControllerController < ApplicationController

	def search
		@events = Event.search(params[:search])
	end

	def new
		@event = Event.new
	end

	def create
		#raise
	    #@event = Event.new(params[:user])

	    params[:event].parse_time_select! :start_time
	    params[:event].parse_time_select! :end_time

	    s_time = Time.local(
	    	params[:date][:start_date_year],
	    	params[:date][:start_date_month],
	    	params[:date][:start_date_day],
	    	params[:event][:start_time].hour,
	    	params[:event][:start_time].min,
	    	params[:event][:start_time].sec
	    )

	    e_time = Time.local(
	    	params[:date][:end_date_year],
	    	params[:date][:end_date_month],
	    	params[:date][:end_date_day],
	    	params[:event][:end_time].hour,
	    	params[:event][:end_time].min,
	    	params[:event][:end_time].sec
	    )

	    @event = Event.new(
	    	:name => params[:event][:name],
			:description => params[:event][:description],
			:start_time => s_time,
			:end_time => e_time,
			:organization => params[:event][:organization],
			:location => params[:event][:location]
	    )

	    if @event.save
	      redirect_to root_path, :flash => {:success => "Successfully created event!"}
	    else
	      render 'new', :flash => {:error => "Could not create event"}
	    end
	    
	  end
	
	def index

		@homepage = true

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

=begin
		Event.create(
				:name => "SEE Presents: Spring Comedy Show ft. John Oliver",
				:description => "SEE is excited to announce our annual Spring Comedy Show, featuring John Oliver, a British comedian who has been a writer and correspondent for 'The Daily Show With Jon Stewart' since 2006. Since then he has done everything from interviewing UN Ambassadors to breaking his nose fighting for the Confederate army.",
				:start_time => Time.now+12.hour,
				:end_time => Time.now+13.hour,
				:organization => "SEE",
				:location => "Richie Collisieum"
			)
=end

		#@feed = Feedzirra::Feed.fetch_and_parse("http://www.cs.umd.edu/webcal/online/rss/rss2.0.php?cal=department&cpath=&rssview=month")

=begin
		feed.entries.each do |event|

			Event.create(
				:name => event.title,
				:description => event.description,
				:start_time => event.ev:startdate,
				:end_time => event.ev:enddate,
				:organization => "Computer Science",
				:location => event.ev:location
			)

		end
=end

	end

  	def show

		@event = Event.find(params[:id])
=begin
  		
  		User.create(:username => "JackLot", :email => "echoninja110@gmail.com", :password => "Devteam1")
  		@u = User.where(:email => "echoninja110@gmail.com")
  		Calendar.create(:name => "JCal", :user_id => @u)

  		@currentCal = Calendar.first

  		if @currentCal.events.where(:name => @event.name, :start_time => @event.start_time).size == 0	
  			@currentCal.events << @event
  		end

  		@cEvents = @currentCal.events

=end

  	end

end
