class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
