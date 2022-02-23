class AddDateToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :date, :date
    remove_column :bookings, :time
  end
end
