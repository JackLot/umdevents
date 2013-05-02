class CalendarController < ApplicationController

  #Show the users calendar
  def show

  	@cal = current_user.calendar

  end

  def addtocal
    
  	event = Event.find_by_id(params[:calendar][:event_id])
  	currentCal = current_user.calendar
  	
    if !params[:calendar][:addremove]

      	if currentCal.events.where(:name => event.name, :start_time => event.start_time).size == 0	
    		  currentCal.events << event
    	  end

        message = "Event successfully added to your calendar!"

    else

      currentCal.events.destroy(params[:calendar][:event_id])

      message = "Event removed from your calendar"

    end


    if params[:calendar][:rd].to_i == 1
      redirect_to root_path, :flash => {:success => message}
    elsif params[:calendar][:rd].to_i == 2
      redirect_to event, :flash => {:success => message}
    else
      redirect_to '/mycalendar', :flash => {:success => message}
    end

  end

end
