class Changetypetotypeof < ActiveRecord::Migration
  def up
  	rename_column :reminders, :type, :type_of
  end

  def down
  end
end
