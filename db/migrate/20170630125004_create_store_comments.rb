class CreateStoreComments < ActiveRecord::Migration[5.1]
  def change
    create_table :store_comments do |t|
      t.references :store, foreign_key: true
      t.references :user, foreign_key: true
      t.references :wait_time, foreign_key: true
      t.references :comment, foreign_key: true

      t.timestamps
    end
  end
end
