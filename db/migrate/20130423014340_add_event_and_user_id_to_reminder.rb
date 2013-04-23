class AddEventAndUserIdToReminder < ActiveRecord::Migration
  def change

    add_column :reminders, :event_id, :int
    add_column :reminders, :user_id, :int

  end
end
