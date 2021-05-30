class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.date :date
      t.string :start_time
      t.string :end_time
      t.string :availability
      t.integer :schedules_id

      t.timestamps null: false
    end
  end
end
