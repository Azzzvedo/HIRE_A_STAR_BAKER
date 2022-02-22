class AddDefaultPaidFalseToBookings < ActiveRecord::Migration[6.1]
  def change
    change_column_null :bookings, :paid, false
    change_column_default :bookings, :paid, from: true, to: false
  end
end
