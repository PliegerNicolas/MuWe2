class CreateJams < ActiveRecord::Migration[6.0]
  def change
    create_table :jams do |t|
      t.references :user, null: false, foreign_key: true
      t.references :music_style, null: false, foreign_key: true
      t.text :description
      t.integer :max_participants
      t.integer :status, default: 0
      t.date :start_date
      t.time :start_time
      t.time :duration
      t.time :end_time
      t.boolean :privacy, default: false

      t.timestamps
    end
  end
end
