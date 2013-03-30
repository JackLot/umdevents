class CalendarController < ApplicationController

  #Show the users calendar
  def show

  	@cal = current_user.calendar

  end

  def addtocal

  	event = Event.find(params[:calendar][:event_id]);
  	currentCal = current_user.calendar
  	
  	if currentCal.events.where(:name => event.name, :start_time => event.start_time).size == 0	
		currentCal.events << event
	end

	redirect_to root_path

  end

end
