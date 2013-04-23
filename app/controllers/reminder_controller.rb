class ReminderController < ApplicationController

  def new
  	@reminder = Reminder.new
  end

  def create

    event = Event.find(params[:event_id])
    t = params[:type_of]

=begin
  1 = 1 day - 1d
  2 = 2 days - 2d
  3 = 4 days - 4d
  4 = 1 week - 1w
  5 = 2 weeks - 2w
  6 = 1 month - 1m
=end

    whentoremind = event.start_time - 1.day
    ts = "1d"

    if t == 1
      ts = "1d"
      whentoremind = event.start_time - 1.day
    elsif t == 2
      ts = "2d"
      whentoremind = event.start_time - 2.days
    elsif t == 3
      ts = "4d"
      whentoremind = event.start_time - 4.days
    elsif t == 4
      ts = "1w"
      whentoremind = event.start_time - 1.week
    elsif t == 5
      ts = "2w"
      whentoremind = event.start_time - 1.week
    elsif t == 6
      ts = "1m"
      whentoremind = event.start_time - 1.month
    end

    if current_user
      cu = current_user.id
    else
      cu = nil
    end

  	@reminder = Reminder.new(
  		:type_of => params[:type_of],
      :date_to_send => whentoremind,
  		:send_to => params[:send_to],
  		:event_id => event.id,
  		:user_id => cu
  	)

    if @reminder.save
      redirect_to event, :flash => {:success => "Successfully created reminder!"}
    else
      redirect_to event, :flash => {:error => "Could not create reminder"}
    end

  end

end
