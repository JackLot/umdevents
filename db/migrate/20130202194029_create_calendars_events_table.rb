class CreateCalendarsEventsTable < ActiveRecord::Migration
  def up
  	create_table :calendars_events, :id => false do |t|
  		t.references :calendar
  		t.references :event
  	end
  	add_index :calendars_events, [:calendar_id, :event_id]
  	add_index :calendars_events, [:event_id, :calendar_id]
  end

  def down
  	drop_table :calendars_events
  end
end
