class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :time_zone, default: "Central Time (US & Canada)"
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :scheduled_at
      t.timestamps
    end
  end
end
