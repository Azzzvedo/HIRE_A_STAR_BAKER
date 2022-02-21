class CreateCakes < ActiveRecord::Migration[6.1]
  def change
    create_table :cakes do |t|
      t.string :name
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
