class CreateTimecards < ActiveRecord::Migration[5.2]
  def change
    create_table :timecards do |t|
      t.integer :year, limit: 2, null: false
      t.integer :month, limit: 1, null: false
      t.integer :day, limit: 1, null: false
      t.datetime :in_time
      t.datetime :out_time
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
