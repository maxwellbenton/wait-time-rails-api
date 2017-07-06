class CreateWaitTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :wait_times do |t|
      t.integer :wait_time
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
