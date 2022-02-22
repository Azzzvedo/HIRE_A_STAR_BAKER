class RemoveDateColumnFromBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :confirmed, :boolean
    remove_column :bookings, :date
  end
end
