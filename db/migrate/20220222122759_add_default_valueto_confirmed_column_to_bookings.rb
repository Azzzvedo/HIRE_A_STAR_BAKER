class AddDefaultValuetoConfirmedColumnToBookings < ActiveRecord::Migration[6.1]
  def change
    change_column_null :bookings, :confirmed, false
    change_column_default :bookings, :confirmed, from: true, to: false
  end
end
