class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :send_to
      t.datetime :date_to_send
      t.string :type

      t.timestamps
    end
  end
end
